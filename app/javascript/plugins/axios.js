import axios from 'axios'

export default{
  install(app){
    const axiosInstance = axios.create({
      baseURL: 'api'
    })
    app.config.globalProperties.$axios = axiosInstance
  }
}