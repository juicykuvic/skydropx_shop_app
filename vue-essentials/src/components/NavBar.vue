<template>
  <nav class="navbar navbar-light fixed-top">
    <div class="navbar-text ml-auto d-flex">
      <button
        class="btn btn-sm btn-outline-success"
        @click="$parent.$emit('toggle')"
      >
        <i class="fas fa-dollar-sign"></i>
        <font-awesome-icon icon="dollar-sign"></font-awesome-icon>
      </button>
      <div class="dropdown ml-2" v-if="cart.length > 0">
        <button
          class="btn btn-success btn-sm dropdown-toggle"
          id="cartDropdown"
          data-toggle="dropdown"
          aria-haspopup="true"
          aria-expanded="false"
        >
          <span class="badge badge-pill badge-light">{{ cartQty }}</span>
          <i class="fas fa-shopping-cart mx-2"></i>
          <item-price :value="Number(cartTotal)"></item-price>
        </button>
        <div
          class="dropdown-menu dropdown-menu-right"
          aria-labelledby="cartDropdown"
        >
          <div v-for="(item, index) in cart" :key="index">
            <div class="dropdown-item-text text-nowrap text-right">
              <span
                class="badge badge-pill badge-warning align-text-top mr-1"
                >{{ item.qty }}</span
              >
              {{ item.product.name }}
              <b>
                <item-price
                  :value="Number(item.qty * item.product.price)"
                ></item-price>
              </b>
              <a
                href="#"
                @click.stop="$parent.$emit('delete', index)"
                class="badge badge-danger text-white"
                >-</a
              >
            </div>
          </div>
          <router-link
            class="btn btn-sm btn-outline-info text-dark float-right mr-4"
            to="/checkout"
            >Checkout</router-link
          >
        </div>
      </div>
    </div>
  </nav>
</template>

<script>
import ItemPrice from "./ItemPrice.vue";
// eslint-disable-next-line
import VueRouter from "vue-router";

import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";

export default {
  name: "nav-bar",
  props: ["cart", "cartQty", "cartTotal"],
  components: {
    FontAwesomeIcon,
    ItemPrice,
  },
};
</script>
