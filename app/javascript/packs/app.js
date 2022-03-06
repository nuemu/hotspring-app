import { createApp } from "vue";
import App from "../app.vue";
import router from '../router/router.js'
import axios from '../plugins/axios.js'
import store from '../store/index.js'

const app = createApp(App);
app.use(router);
app.use(axios);
app.use(store);
app.mount("#app");