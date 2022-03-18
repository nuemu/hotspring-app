import axios from '../../plugins/axios.js'

const users_module = {
  namespaced: true,
  state(){
    return{
      user_name: '',
    }
  },
  getters:{
    user_name(state){
      return state.user_name
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
    logout(state){
      state.user_name = '',
      axios.defaults.headers['Authorization']='Bearer ',
      localStorage.removeItem('token')
    }
  },
  actions:{
    async login({commit}, user){
      const response = await axios.post('sessions',user)
      commit('set_user', response.data)
      commit('set_token', response.headers['authtoken'])
    },
    async register({commit}, user){
      const response = await axios.post('registers',user)
      commit('set_user', response.data)
      commit('set_token', response.headers['authtoken'])
    },
    async fetchAuthUser({ commit, state }) {
      if (!localStorage.token) return null
      if (state.user_name) return state.user_name

      commit('set_token', localStorage.token)

      const response = await axios.get('me')
      commit('set_user', response.data)

      return state.user_name
    },
    async postComment({commit},params){
      console.log(params)
      const response = await axios.post('comments', {'hotspring_id':params.hotspring_id, 'comment':params.comment})
      commit('hotsprings/setComment', response.data, {root: true})
    },
    async fetchUsers(){
      const response = await axios.get('users')
      return response.data
    }
  }
}

export default users_module