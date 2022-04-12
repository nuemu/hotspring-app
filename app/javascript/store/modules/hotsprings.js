import axios from '../../plugins/axios.js'
import {cluster} from '../../ol/cluster.js'
import status from '../../ol/hotspring_status.js'

const hotsprings_module = {
  namespaced: true,
  state(){
    return{
      hotsprings: [],
      hotspring: false,
      comments: [],
      status: [0,0,0,0],
      posts: [],
      articles: [],
    }
  },
  getters:{
    hotsprings(state){
      return state.hotsprings
    },
    hotspring(state){
      return state.hotspring
    },
    hotspring_icons(state){
      return cluster(state.hotsprings)
    },
    comments(state){
      return state.comments
    },
    status(state){
      const array = JSON.parse(JSON.stringify(state.status))
      const max = Math.max(...array)
      return Object.keys(status)[array.indexOf(max)]
    },
    articles(state){
      return state.articles
    },
  },
  mutations:{
    setHotsprings(state, data){
      state.hotsprings = data
    },
    addHotspring(state, data){
      let hotsprings = state.hotsprings
      hotsprings.push(data)
      state.hotpsrings = hotsprings
    },
    setHotspring(state, data){
      state.hotspring = data
    },
    setComment(state, comment){
      state.comments.push(comment)
    },
    deleteComment(state, id){
      const index = state.comments.findIndex(element => element.id==id)
      state.comments.splice(index, 1)
    },
    setArticle(state, article){
      state.articles.push(article)
    },
    deleteArticle(state, id){
      const index = state.articles.findIndex(element => element.id==id)
      state.articles.splice(index, 1)
    },
    setStatus(state, post){
      const index = Object.keys(status).findIndex(element => element == post.status)
      if(index !== 0) state.status[index] += 1
    },
  },
  actions:{
    async fetchHotsprings({commit}, status){
      const response = await axios.get('hotsprings',{ params: {'status': status}})
      axios.defaults.headers.common['X-CSRF-Token'] = response.headers['x-csrf-token']
      commit('setHotsprings', response.data)
    },
    async fetchHotspring({commit}, lonlat){
      const lon = lonlat.split(',')[0]
      const lat = lonlat.split(',')[1]
      const response = await axios.get('hotspring' ,{ params: {'lat': lat, 'lon': lon}})
      axios.defaults.headers.common['X-CSRF-Token'] = response.headers['x-csrf-token']
      commit('setHotspring', response.data.data.attributes)
      response.data.included.forEach(element => {
        switch(element.type){
          case 'comment':
            commit('setComment', element)
            break
          case 'post':
            commit('setStatus', element.attributes)
            break
          case 'article':
            commit('setArticle', element)
            break
        }
      })
      return response.data.data.attributes
    },
    async postHotspring({commit}, params){
      const response = await axios.post('hotsprings', params)
      commit('addHotspring', response.data)
    },
    async updateHotspring({commit}, params){
      const response = await axios.patch('hotsprings/'+params.id, params)
    },
    async uploadImage({commit}, params){
      const response = await axios.patch('hotsprings/'+params.id, params.image, { "content-type": "multipart/form-data" })
    },
    async postComment({commit},params){
      const response = await axios.post('comments', {'hotspring_id':params.hotspring_id, 'comment':params.comment})
      commit('setComment', response.data.data)
    },
    async deleteComment({commit}, id){
      const response = await axios.delete('comments/'+id)
      commit('deleteComment',response.data.id)
    },
    async postArticle({commit}, params){
      const response = await axios.post('articles', params)
      commit('setArticle', response.data.data)
    },
    async deleteArticle({commit}, id){
      const response = await axios.delete('articles/'+id)
      commit('deleteArticle',response.data.data.id)
    },
    async postPost({commit}, params){
      const response = await axios.post('posts', params)
      return response.data.id
    },
    async updatePost({commit}, params){
      const response = await axios.patch('posts/'+ params.id, params)
    }
  }
}

export default hotsprings_module