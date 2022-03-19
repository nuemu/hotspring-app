import axios from '../../plugins/axios.js'
import {cluster} from '../../ol/cluster.js'

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
      return array.indexOf(max)
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
    setArticle(state, article){
      state.articles.push(article)
    },
    setStatus(state, post){
      state.status[post.status] += 1
    },
  },
  actions:{
    async fetchHotsprings({commit}, status){
      const response = await axios.get('hotsprings',{ params: {'status': status}})
      commit('setHotsprings', response.data)
    },
    async fetchHotspring({commit}, lonlat){
      const lon = lonlat.split(',')[0]
      const lat = lonlat.split(',')[1]
      const response = await axios.get('hotspring' ,{ params: {'lat': lat, 'lon': lon}})
      commit('setHotspring', response.data.data.attributes)
      response.data.included.forEach(element => {
        switch(element.type){
          case 'comment':
            commit('setComment', element.attributes)
            break
          case 'post':
            commit('setStatus', element.attributes)
            break
          case 'article':
            commit('setArticle', element.attributes)
            break
        }
      })
      return response.data.data.attributes
    },
    async postHotspring({commit}, params){
      const response = await axios.post('hotsprings', params)
      commit('addHotspring', response.data)
    },
    async postComment({commit},params){
      const response = await axios.post('comments', {'hotspring_id':params.hotspring_id, 'comment':params.comment})
      commit('setComment', response.data.data.attributes)
    },
    async postArticle({commit}, params){
      const response = await axios.post('articles', params)
      commit('setArticle', response.data.data.attributes)
    },
    async postPost({commit}, params){
      const response = await axios.post('posts', params)
    },
    async updatePost({commit}, params){
      const response = await axios.patch('posts/'+ params.id, params)
      console.log(response)
    }
  }
}

export default hotsprings_module