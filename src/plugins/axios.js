import axios from 'axios'; // 引入axios

const service = axios.create({
  baseURL: process.env.VUE_APP_BASE_API,
  timeout: 99999
})

export default service
