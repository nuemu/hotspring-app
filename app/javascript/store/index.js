import { createStore } from 'vuex'
import users_module from './modules/users.js'

const store = createStore({
  modules:{
    users: users_module,
  }
})

export default store