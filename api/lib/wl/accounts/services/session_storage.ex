defmodule Wl.Accounts.Services.SessionStorage do
  use GenServer
  @user_sessions :user_sessions
  def start_link(initial_state \\ {}) do
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  ## GenServer callbacks
  def init(state) do
    :ets.new(@user_sessions, [
      :set,
      :public,
      :named_table,
      read_concurrency: true,
      write_concurrency: true
    ])

    {:ok, state}
  end

  ## API callbacks
  def create_session(user) do
    GenServer.call(__MODULE__, {:create_session, user.id})
  end

  def check_token(user_id, token) do
    GenServer.call(__MODULE__, {:check_token, user_id, token})
  end

  def get_user_id_by_token(token) do
    GenServer.call(__MODULE__, {:get_user_id_by_token, token})
  end

  def drop_session(user_id) do
    GenServer.call(__MODULE__, {:drop_session, user_id})
  end

  def handle_call({:create_session, user_id}, _from, state) do
    token = _generate_token()
    {encrypted_token, aes_256_key, init_vec} = _encrypt(token)
    :ets.insert(@user_sessions, {user_id, encrypted_token, aes_256_key, init_vec})
    {:reply, {:ok, token}, state}
  end

  def handle_call({:drop_session, user_id}, _from, state) do
    :ets.delete(@user_sessions, user_id)
    {:reply, :ok, state}
  end

  def handle_call({:check_token, user_id, token}, _from, state) do
    response = _check_token(user_id, token)

    {:reply, response, state}
  end

  def handle_call({:get_user_id_by_token, user_id}, _from, state) do
    response = _get_user_id_by_token(user_id)

    {:reply, response, state}
  end

  defp _check_token(user_id, token) do
    case :ets.lookup(@user_sessions, user_id) do
      [] ->
        :error

      [{_, encrypted_token, aes_256_key, init_vec}] ->
        case _decrypt(encrypted_token, aes_256_key, init_vec) do
          ^token ->
            :ok

          _ ->
            :error
        end
    end
  end

  defp _get_user_id_by_token(token) do
    :ets.foldl(
      fn {user_id, encrypted_token, aes_256_key, init_vec}, acc ->
        case _decrypt(encrypted_token, aes_256_key, init_vec) do
          ^token -> user_id
          _ -> acc
        end
      end,
      nil,
      @user_sessions
    )
  end

  defp _generate_token do
    16
    |> :crypto.strong_rand_bytes()
    |> :base64.encode()
  end

  defp _encrypt(token) do
    {:ok, aes_256_key} = ExCrypto.generate_aes_key(:aes_256, :bytes)
    {:ok, {init_vec, encrypted_token}} = ExCrypto.encrypt(aes_256_key, token)
    encrypted_token = :base64.encode(encrypted_token)
    {encrypted_token, aes_256_key, init_vec}
  end

  defp _decrypt(encrypted_token, aes_256_key, init_vec) do
    encrypted_token = :base64.decode(encrypted_token)
    {:ok, token} = ExCrypto.decrypt(aes_256_key, init_vec, encrypted_token)
    token
  end
end
