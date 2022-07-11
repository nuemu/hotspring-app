import axios from '../../plugins/axios.js'

const person = require('person.svg')

const users_module = {
  namespaced: true,
  state(){
    return{
      user_name: 'Guest',
      avatar: person,
      posts: [],
      favorites: [],
    }
  },
  getters:{
    user_name(state){
      return state.user_name
    },
    avatar(state){
      return state.avatar
    },
    favorites(state){
      return state.favorites
    },
    posts(state){
      return state.posts
    }
  },
  mutations:{
    set_user(state, user_name){
      state.user_name = user_name
    },
    set_avatar(state, avatar){
      state.avatar = avatar
    },
    set_token(state, token){
      axios.defaults.headers['Authorization']='Bearer '+token
      localStorage.setItem('token', token)
    },
    set_favorites(state, favorite){
      state.favorites.push(favorite)
    },
    unFav(state, id){
      const index = state.favorites.findIndex(element => element.id == id)
      state.favorites.splice(index, 1)
    },
    setPosts(state, post){
      state.posts.push(post)
    },
    logout(state){
      state.user_name = 'Guest',
      axios.defaults.headers['Authorization']='Bearer ',
      localStorage.removeItem('token')
    },
  },
  actions:{
    async login({commit}, user){
      const response = await axios.post('sessions',user)
      if(response.data=='failed'){
        return false
      }
      commit('set_user', response.data.data.attributes.name)
      commit('set_token', response.headers['authtoken'])
      return true
    },
    async register({commit}, user){
      const response = await axios.post('registers',user)
      if(response.data=='failed'){
        return false
      }
      commit('set_user', response.data.data.attributes.name)
      commit('set_token', response.headers['authtoken'])
      return true
    },
    async fetchAuthUser({ commit, state }) {
      if (!localStorage.token) return null
      if (state.user_name !== 'Guest') return state.user_name

      commit('set_token', localStorage.token)

      const response = await axios.get('me')
      response.data.included.forEach(element => {
        switch(element.type){
          case 'favorite':
            commit('set_favorites', element)
            break
          case 'post':
            commit('setPosts', element)
            break
        }
      })
      
      commit('set_user', response.data.data.attributes.name)
      commit('set_avatar', response.data.data.attributes.image_url)

      return state.user_name
    },
    async Fav({commit}, hotspring_id){
      const response = await axios.post('favorites', {'hotspring_id': hotspring_id})
      commit('set_favorites',response.data.data[0])
      return true
    },
    async unFav({commit}, id){
      const response = await axios.delete('favorites/'+id)
      commit('unFav',response.data.id)
    },
    async fetchUser({commit}, param){
      const response = await axios.get('users/'+param)
      console.log(response.data)
      return response.data
    },
    async updateUser({commit}, params){
      const response = await axios.patch('users/'+params.id, params.data,  { "content-type": "multipart/form-data" })
      commit('set_user', response.data.data.attributes.name)
      return response.data.data.attributes.name
    },
    async csrf(){
      const response = await axios.get('csrf')
      axios.defaults.headers.common['X-CSRF-Token'] = response.headers['x-csrf-token']
    },
    async postPost({commit}, params){
      const response = await axios.post('posts', params)
      //return response.data.id
    },
    async updatePost({commit}, params){
      const response = await axios.patch('posts/'+ params.id, params, { "content-type": "multipart/form-data" })
    },
  }
}

export default users_module