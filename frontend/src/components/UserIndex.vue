<template>
  <div class="row">
    <div class="col s6 offset-s3">
      <div class="card">
        <div class="card-content">
          <div class="align-right">
            <router-link :to="{name: 'showUser', params: {username: user.username}}">
              <img :src="getProfilePhotoPath(user)" class="profile-photo-index-avatar"/>
            </router-link>
          </div>
          <div>
            <router-link :to="{name: 'showUser', params: {username: user.username}}">
              {{ `@${user.username}` }}
            </router-link>

          </div>
          <div>
            <router-link :to="{name: 'showUser', params: {username: user.username}}">
              <h5> {{ `${user.name} ${user.surname}` }} </h5>
            </router-link>
          </div>
          <div>
            <p> <span class="font-italic"> Followed: </span> {{user.followed_number}} </p>
            <p> <span class="font-italic"> Followers: </span> {{user.followers_number}} </p>
            <p> <span class="font-italic"> Wishes: </span> {{user.wishes_number}} </p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>

export default {
  props: ['user'],
  methods: {
    getProfilePhotoPath(user) {
      if (user.profile_photo_path) {
        return(user.profile_photo_path)
      }
      else{
        return(require("@/assets/default_user_avatar.jpg"))
      }
    }
  }
}
</script>
<style scoped>
.profile-photo-index-avatar {
    width: 125px;
    height: 125px;
    border-radius: 50%;
    object-fit: cover;
}
</style>
