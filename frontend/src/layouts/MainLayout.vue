<template>
  <div class="app-main-layout">
    <nav class="navbar blue lighten-1">
      <div class="nav-wrapper">
        <div class="left">
          <router-link :to="{name: 'home'}">
            <img alt="Wish List logo" class="brand-logo wl-logo left" src="@/assets/logo.png">
          </router-link>
        </div>
        <ul id="nav-mobile" class="right hide-on-med-and-down">
          <li v-if="loggedIn()">
            <router-link :to="{name: 'login'}">
              <span class="nav-text"> Log In </span>
            </router-link>
          </li>
          <li v-else>
            <a type="button" v-on:click.prevent="logOut">
              <span class="nav-text"> Log Out </span>
            </a>
          </li>
        </ul>
      </div>
    </nav>
    <main class="app-content">
      <div class="app-page">
        <router-view />
      </div>
    </main>
  </div>
</template>

<script>
export default {
  methods: {
    loggedIn () {
      return (localStorage.getItem('token') == null);
    },
    logOut () {
      localStorage.clear();
      this.$router.push({name: 'login'});
    }
  }
}
</script>
<style>
  .wl-logo{
    width: 50px;
    margin: 10px;
  }
  .nav-text{
    font-size: 20px;
  }
</style>
