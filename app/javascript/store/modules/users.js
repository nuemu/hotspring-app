import axios from '../../plugins/axios.js'

const users_module = {
  namespaced: true,
  state(){
    return{
      user_name: '',
      favorites: [],
    }
  },
  getters:{
    user_name(state){
      return state.user_name
    },
    favorites(state){
      return state.favorites
    }
  },
  mutations:{
    set_user(state, user_name){
      state.user_name = user_name
    },
    set_token(state, token){
      axios.defaults.headers['Authorization']='Bearer '+token
      localStorage.setItem('token', token)
    },
    set_favorites(state, favorites){
      state.favorites = favorites
    },
    logout(state){
      state.user_name = '',
      axios.defaults.headers['Authorization']='Bearer ',
      localStorage.removeItem('token')
    },
  },
  actions:{
    async login({commit}, user){
      const response = await axios.post('sessions',user)
      commit('set_user', response.data.data.attributes.name)
      commit('set_token', response.headers['authtoken'])
    },
    async register({commit}, user){
      const response = await axios.post('registers',user)
      commit('set_user', response.data.data.attributes.name)
      commit('set_token', response.headers['authtoken'])
    },
    async fetchAuthUser({ commit, state }) {
      if (!localStorage.token) return null
      if (state.user_name) return state.user_name

      commit('set_token', localStorage.token)

      const response = await axios.get('me')
      commit('set_favorites', response.data.included)
      commit('set_user', response.data.data.attributes.name)

      return state.user_name
    },
    async Fav({commit}, hotspring_id){
      const response = await axios.post('favorites', {'hotspring_id': hotspring_id})
    },
    async unFav({commit}, id){
      const response = await axios.delete('favorites/'+id)
    },
    async fetchUsers(){
      const response = await axios.get('users')
      return response.data
    },
  }
}

export default users_module