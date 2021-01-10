<template>
  <div class="main-information">
    <div>
      <h2 class="username-text">{{ user.username }}</h2>
    </div>
    <div>
      <h3 class="fulle-name-text">{{ user.name + ' ' + user.surname }}</h3>
    </div>
    <div>
      <h3 class="fulle-name-text">Followers: {{ user.followers_number }}</h3>
    </div>
    <div>
      <h3 class="fulle-name-text">Followed: {{ user.followed_number }}</h3>
    </div>
    <div>
      <h3 class="fulle-name-text">Wishes: {{ user.wishes_number }}</h3>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data() {
    return {
      user: {},
      username: null
    }
  },
  created() {
    this.getUser()
  },
  methods: {
    getUser() {
      this.setUsernameFromRoute()
      axios
      .get(`/users/${this.username}`)
      .then(response => (
        this.user = response.data
        ));
    },
    setUsernameFromRoute(){
      this.username = this.$route.params.username
    }
  },
  watch: {
    $route() {
      this.getUser()
    }
  },
  name: 'ShowUser'
};
</script>

<style scoped>

</style>
