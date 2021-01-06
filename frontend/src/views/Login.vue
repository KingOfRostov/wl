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
          <div class="col s12">
            <div class="row">
              <div class="input-field col s12">
                <i class="material-icons prefix">account_box</i>
                <input class="validate" id="username" type="text">
                <label for="username" data-error="wrong" data-success="right">Username</label>
              </div>
            </div>

            <div class="row">
              <div class="input-field col s12">
                <i class="material-icons prefix">lock_outline</i>
                <input id="password" type="password">
                <label for="password">Password</label>
              </div>
            </div>

            <div class="row">
              <div class="input-field col s12">
                <a href="#" class="btn waves-effect waves-light col s12">Login</a>
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

<style scoped>
.page-content{
  border:2px solid #2f2c2c;
  margin-top:20px;
}
</style>
