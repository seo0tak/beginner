<template>
  <div id="app">
    <div class="form-group">
      <h1><span class="vue">Vue</span>Board
        <small>Restful</small>
      </h1><br>
      <!-- <form role="form">
        <input type="text" class="form-control" placeholder="해야 할 일"
            v-model="title"
		        v-on:keyup.enter="addTodo(title)">
      </form>
      <button type="button" v-on:click="addTodo(title)" class="btn btn btn-primary">Add</button> -->
      <!-- <router-view :key="$route.fullPath"/> -->
      <router-view />
    </div>
  </div>
</template>

<script>
export default {
  name: 'App'
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
.vue {
    color: #009900;
}
.form-group {
    text-align: center;
    margin-top: 10em;
    padding-bottom: 25px;
}
.todoApp {
    margin: auto;
    width: 500px;
}
form {
    display: inline-block;
}
a:hover
{
	text-decoration: none;
}
</style>
