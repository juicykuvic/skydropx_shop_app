<template>
  <transition-group
    name="fade"
    tag="div"
    @beforeEnter="beforeEnter"
    @enter="enter"
    @leave="leave"
  >
    <div
      class="row d-flex mb-3 align-items-center"
      v-for="(item, index) in filteredProducts"
      :key="item.id"
      :data-index="index"
    >
      <div class="col-1 m-auto">
        <button class="btn btn-info" @click="$parent.$emit('add', item)">
          +
        </button>
      </div>
      <div class="col-4">
        <img class="img-fluid d-block" :src="item.image" :alt="item.name" />
      </div>
      <div class="col">
        <h3 class="text-info">{{ item.name }}</h3>
        <p class="mb-0">{{ item.description }}</p>
        <div class="h5 float-right">
          <item-price :value="Number(item.price)"></item-price>
        </div>
      </div>
    </div>
  </transition-group>
</template>

<script>
import ItemPrice from "./ItemPrice.vue";

export default {
  name: "product-list",
  components: { ItemPrice },
  props: ["products", "maximum"],
  computed: {
    filteredProducts: function () {
      return this.products.filter((item) => item.price <= Number(this.maximum));
    },
  },
  methods: {
    beforeEnter: function (el) {
      el.className = "d-none";
    },
    enter: function (el) {
      var delay = el.dataset.index * 100;
      setTimeout(function () {
        el.className =
          "row d-flex mb-3 align-items-center animated fadeInRight";
      }, delay);
    },
    leave: function (el) {
      var delay = el.dataset.index * 100;
      setTimeout(function () {
        el.className =
          "row d-flex mb-3 align-items-center animated fadeOutRight";
      }, delay);
    },
  },
};
</script>
