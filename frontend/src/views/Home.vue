<template>
  <div class="main-information">
    <div>
      <h2 class="username-text">{{ username }}</h2>
    </div>
    <div>
      <h3 class="fulle-name-text">{{ name + ' ' + surname }}</h3>
    </div>
    <div>
      <h3 class="fulle-name-text">Followers: {{ followers_number }}</h3>
    </div>
    <div>
      <h3 class="fulle-name-text">Followed: {{ followed_number }}</h3>
    </div>
    <div>
      <h3 class="fulle-name-text">Wishes: {{ wishes_number }}</h3>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      username: localStorage.getItem('username'),
      name: localStorage.getItem('name'),
      surname: localStorage.getItem('surname'),
      followers_number: localStorage.getItem('followers_number'),
      followed_number: localStorage.getItem('followed_number'),
      wishes_number: localStorage.getItem('wishes_number'),
    };
  },
  name: 'Home'
};
</script>

<style scoped>

</style>
