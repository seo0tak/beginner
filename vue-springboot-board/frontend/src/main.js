// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import VModal from 'vue-js-modal'
/* import axios from 'axios' */


import VueMomentLib from 'vue-moment-lib'
Vue.use(VueMomentLib)
Vue.use(VModal)

Vue.config.productionTip = false
/* Vue.prototype.$http = axios */

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  components: { App },
  template: '<App/>'
})
