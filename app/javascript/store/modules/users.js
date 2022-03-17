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
    async who_is_me({commit}){
      const response = await axios.get('me')
      commit('set_user', response.data)
    },
    async postComment({commit},params){
      console.log(params)
      const response = await axios.post('comments', {'hotspring_id':params.hotspring_id, 'comment':params.comment})
      commit('hotsprings/setComment', response.data, {root: true})
    }
  }
}

export default users_module