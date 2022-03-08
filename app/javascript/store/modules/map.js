import axios from '../../plugins/axios.js'
import {create_icon} from '../../plugins/openlayer.js'

const map_module = {
  namespaced: true,
  state(){
    return{
      hotsprings:[],
    }
  },
  getters:{
    hotsprings(state){
      return state.hotsprings
    },
    hotspring_icons(state){
      console.log("called")
      const icons = state.hotsprings.map(element => {
        console.log(element)
        return create_icon(element.name, element.lat, element.lon)
      })
      return icons
    }
  },
  mutations:{
    setHotsprings(state, data){
      const processed_data = data.map(element => {
        return {'name': element.name, 'lat': element.latitude, 'lon': element.longtitude, 'status': element.status}
      })
      state.hotsprings = processed_data
    }
  },
  actions:{
    async fetchHotsprings({commit}){
      const response = await axios.get('hotsprings',{ params: {'status': 2}})
      commit('setHotsprings', response.data)
    }
  }
}

export default map_module