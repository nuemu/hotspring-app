import axios from 'axios'

const axiosInstance = axios.create({
  //baseURL: 'http://localhost:3000/api/'
  baseURL: 'https://polar-scrubland-90297.herokuapp.com/api/'
})

export default axiosInstance