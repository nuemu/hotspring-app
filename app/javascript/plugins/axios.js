import axios from 'axios'

const axiosInstance = axios.create({
  //baseURL: 'http://localhost:3000/api/'
  //baseURL: 'http://127.0.0.1:1234/api/'
  baseURL: 'https://noyu-hub.herokuapp.com//api/'
})

export default axiosInstance