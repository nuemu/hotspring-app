import { createStore } from 'vuex'
import users_module from './modules/users.js'
import hotsprings_module from './modules/hotsprings.js'

const store = createStore({
  modules:{
    users: users_module,
    hotsprings: hotsprings_module
  }
})

export default store