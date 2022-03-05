import Vue from "vue";
import VueRouter from "vue-router";

import App from "./App.vue";
import axios from "axios";
import VueAxios from "vue-axios";
import "bootstrap";
import { library } from "@fortawesome/fontawesome-svg-core";

import "bootstrap/dist/css/bootstrap.css";
import "animate.css/animate.css";

import {
  faShoppingCart,
  faDollarSign,
  faPlus,
} from "@fortawesome/free-solid-svg-icons";

library.add(faShoppingCart, faDollarSign, faPlus);

import ProductItems from "./components/ProductItems.vue";
import CheckoutPage from "./components/CheckoutPage.vue";
import AddItem from "./components/AddItem.vue";

Vue.use(VueRouter);
Vue.use(VueAxios, axios);
Vue.config.productionTip = false;

const router = new VueRouter({
  routes: [
    {
      path: "*",
      component: ProductItems,
    },
    {
      path: "/checkout",
      component: CheckoutPage,
    },
    {
      path: "/newitem",
      component: AddItem,
    },
  ],
});

new Vue({
  render: (h) => h(App),
  router,
}).$mount("#app");
