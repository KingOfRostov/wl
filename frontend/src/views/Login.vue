<template>
  <div class="container">
    <div class="row">
      <div class="col s6 offset-s3 page-content">
        <div class="row">
          <div class="col s12">
            <h4> Login </h4>
          </div>
        </div>
        <div class="row">
          <div class="col s12" v-on:keydown.enter="sendLoginData">
            <div class="row">
              <div class="input-field col s12">
                <i class="material-icons prefix">account_box</i>
                <input class="validate" id="username" type="text" v-model="username">
                <label for="username" data-error="wrong" data-success="right">Username</label>
              </div>
            </div>

            <div class="row">
              <div class="input-field col s12">
                <i class="material-icons prefix">lock_outline</i>
                <input id="password" type="password" v-model="password">
                <label for="password">Password</label>
              </div>
            </div>

            <div class="row">
              <div class="input-field col s12">
                <button class="btn waves-effect waves-light col s12" v-on:click.prevent="sendLoginData">Login</button>
              </div>
              <div class="input-field col s12">
                <a href="#" class="btn waves-effect waves-light col s12">Register</a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data () {
    return {
      username: '',
      password: ''
    }
  },
  methods: {
    async sendLoginData() {
      await axios({
        method: 'post',
        url: 'session',
        data: {
          username: this.username,
          password: this.password
        }
      }).then((response) => {
        const status =
          JSON.parse(response.status);

        //redirect logic
        if (status == '200') {
          this.username = '';
          this.password = '';
          const username = response.data.user.username
          localStorage.setItem('token', response.data.token);
          localStorage.setItem('username', username);
          localStorage.setItem('currentUserId', response.data.user.id);
          this.$router.push({name: 'showUser', params: {username: username}});
        }


        console.log(response);
      }).catch((error) => {
        console.log(error);
      })
    }
  }
}
</script>

<style scoped>
.page-content{
  border:2px solid #2f2c2c;
  margin-top:20px;
}
</style>
