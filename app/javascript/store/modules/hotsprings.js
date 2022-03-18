import axios from '../../plugins/axios.js'
import {cluster} from '../../ol/cluster.js'

const hotsprings_module = {
  namespaced: true,
  state(){
    return{
      hotsprings: [],
      hotspring: false,
      comments: [],
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
    posts(state){
      return state.posts
    },
    articles(state){
      return state.articles
    }
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
    }
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
            break
          case 'article':
            commit('setArticle', element.attributes)
            break
        }
      })
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
      commit('setArticle', response.data)
    }
  }
}

export default hotsprings_module