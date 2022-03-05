<template>
  <div>
    <h1>My Shop</h1>
    <nav-bar :cart="cart" :cartQty="cartQty" :cartTotal="cartTotal"></nav-bar>
    <price-slider
      :sliderStatus="sliderStatus"
      :maximum="maximum"
    ></price-slider>
    <product-list :maximum="maximum" :products="products"></product-list>
  </div>
</template>
<script>
import NavBar from "./NavBar.vue";
import PriceSlider from "./PriceSlider.vue";
import ProductList from "./ProductList.vue";

export default {
  name: "product-items",
  props: [
    "products",
    "maximum",
    "cart",
    "cartQty",
    "cartTotal",
    "sliderStatus",
    "sliderState",
  ],
  components: {
    NavBar,
    PriceSlider,
    ProductList,
  },
};
</script>
