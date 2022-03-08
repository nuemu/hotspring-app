import axios from '../../plugins/axios.js'
import {create_icon} from '../../plugins/openlayer.js'

const map_module = {
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
      const icons = state.hotsprings.map(element => {
        return create_icon(element.name, element.latitude, element.longtitude)
      })
      return icons
    },
  },
  mutations:{
    setHotsprings(state, data){
      state.hotsprings = data
    },
    setHotspring(state, data){
      state.hotspring = data
    }
  },
  actions:{
    async fetchHotsprings({commit}, status){
      const response = await axios.get('hotsprings',{ params: {'status': status}})
      commit('setHotsprings', response.data)
    },
    async fetchHotspring({commit}, name){
      const response = await axios.get('hotspring',{ params: {'name': name}})
      commit('setHotspring', response.data)
    }
  }
}

export default map_module