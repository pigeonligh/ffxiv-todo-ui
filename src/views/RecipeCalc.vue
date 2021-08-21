<template>
  <div class="recipe">
    <div class="p-grid p-jc-center">
      <div class="p-col-12 p-sm-10 p-md-8 p-lg-4">
        <RecipeEdit
          :productList="productList"
          :inventoryList="inventoryList"
          @setProduct="setProduct"
          @setInventory="setInventory"
          @startCalc="startCalc"
        />
      </div>
      <div class="p-col-12 p-sm-10 p-md-8 p-lg-8">
        <RecipeReport v-model="report" @setInventory="setInventory" />
      </div>
    </div>
  </div>
</template>

<script>
import { defineComponent, ref } from "vue";
import axios from "../plugins/axios.js";

import RecipeEdit from "../components/recipe/edit.vue";
import RecipeReport from "../components/recipe/report.vue";

const data = {
  productList: ref([]),
  inventoryList: ref([]),
  productAmount: {},
  inventoryAmount: {},
  report: ref({}),
};

export default defineComponent({
  name: "RecileCalc",
  data() {
    return data;
  },
  components: {
    RecipeEdit,
    RecipeReport,
  },
  methods: {
    setAmount(origin, item, number) {
      if (number == 0 && Object.prototype.hasOwnProperty.call(origin, item)) {
        delete origin[item];
      } else {
        origin[item] = number;
      }
      return origin;
    },
    genList(amounts) {
      var ret = [];
      for (var item in amounts) {
        ret.push({ name: item, number: amounts[item] });
      }
      return ret;
    },

    setProduct(item, number) {
      data.productAmount = this.setAmount(data.productAmount, item, number);
      data.productList.value = this.genList(data.productAmount);
    },
    setInventory(item, number) {
      data.inventoryAmount = this.setAmount(data.inventoryAmount, item, number);
      data.inventoryList.value = this.genList(data.inventoryAmount);
    },
    startCalc() {
      var packdata = {
        products: data.productAmount,
        inventories: data.inventoryAmount,
      };
      axios.post("/calc", packdata).then((response) => {
        var resdata = response.data;
        if (resdata["errcode"] === 0) {
          data.report.value = resdata["report"];
        }
      });
    },
  },
});
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}

#recipe {
  width: auto;
  height: auto;
  max-width: 100%;
  max-height: 100%;
}
</style>
