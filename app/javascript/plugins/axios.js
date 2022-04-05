import axios from 'axios'

console.log(process.env.VUE_APP_BASE_URL)

const axiosInstance = axios.create({
  baseURL: process.env.VUE_APP_BASE_URL
})

export default axiosInstance