import axios from 'axios'

const axiosInstance = axios.create({
  baseURL: 'https://polar-scrubland-90297.herokuapp.com/api/'
})

export default axiosInstance