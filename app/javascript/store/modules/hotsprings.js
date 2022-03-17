import axios from '../../plugins/axios.js'
import {cluster} from '../../ol/cluster.js'

const hotsprings_module = {
  namespaced: true,
  state(){
    return{
      hotsprings:[],
      hotspring:{},
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
    }
  },
  mutations:{
    setHotsprings(state, data){
      state.hotsprings = data
    },
    addHotspring(state, data){
      let hotsprings = state.hotsprings
      console.log(hotsprings)
      hotsprings.push(data)
      state.hotpsrings = hotsprings
    },
    setHotspring(state, data){
      state.hotspring = data
    },
    setComment(state, comment){
      state.hotspring.comments.data.push(comment.data)
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
    },
    async postHotspring({commit}, params){
      const response = await axios.post('hotsprings', params)
      commit('addHotspring', response.data)
    },
    async postArticle({commit}, params){
      const response = await axios.post('articles', params)
      console.log(response)
    }
  }
}

export default hotsprings_module