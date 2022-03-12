import { createStore } from 'vuex'
import users_module from './modules/users.js'
import map_module from './modules/map.js'

const store = createStore({
  modules:{
    users: users_module,
    map: map_module
  }
})

export default store