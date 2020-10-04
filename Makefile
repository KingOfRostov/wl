.PHONY: start deps migrate server default test

default: test

start: deps migrate server

deps:
	mix deps.get

migrate:
	mix ecto.migrate

server:
	iex -S mix phx.server

test:
	mix test --stale --max-failures 1
