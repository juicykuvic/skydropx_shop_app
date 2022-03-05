import Vue from "vue";
import VueRouter from "vue-router";

import App from "./App.vue";
import "bootstrap";
import { library } from "@fortawesome/fontawesome-svg-core";

import "bootstrap/dist/css/bootstrap.css";
import "animate.css/animate.css";

import {
  faShoppingCart,
  faDollarSign,
} from "@fortawesome/free-solid-svg-icons";

library.add(faShoppingCart, faDollarSign);

import ProductItems from "./components/ProductItems.vue";
import CheckoutPage from "./components/CheckoutPage.vue";

Vue.use(VueRouter);
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
  ],
});

new Vue({
  render: (h) => h(App),
  router,
}).$mount("#app");
