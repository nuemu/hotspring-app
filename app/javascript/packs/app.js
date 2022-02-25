import { createApp } from "vue";
import App from "../app.vue";
import router from '../router/router.js'
import axios from '../plugins/axios.js'
import createmap_mixin from '../mixin/map.js'

const app = createApp(App);
app.use(router);
app.use(axios);
app.mixin(createmap_mixin);
app.mount("#app");