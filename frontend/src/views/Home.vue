<template>
  <div class="right-side-buttons">
    <button class="btn btn-primary mx-1">Add wish</button>
    <button class="btn btn-warning mx-1">Edit</button>
  </div>
  <div class="main-information">
    Image
  </div>
  <div class="main-information">
    <div>
      <h2 class="username-text">{{ username }}</h2>
    </div>
    <div>
      <h3 class="fulle-name-text">{{ name + ' ' + surname }}</h3>
    </div>
    <div>
      <h3 class="fulle-name-text">Followers: {{ followers }}</h3>
    </div>
    <div>
      <h3 class="fulle-name-text">Followed: {{ followed }}</h3>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      username: '@king_of_rostov',
      name: 'Сергей',
      surname: 'Мкртчян',
      followers: 0,
      followed: 4,
      wishes_number: 1
    };
  },
  name: 'Home'
};
</script>

<style scoped>

</style>
