<template>
  <div class="recipe-edit">
    <h1>编辑物品</h1>

    <div class="p-grid p-jc-center">
      <div class="p-col-12">
        <div class="p-inputgroup">
          <span class="p-inputgroup-addon">物品</span>
          <InputText v-model="inputname" />
        </div>
      </div>
      <div class="p-col-12">
        <div class="p-inputgroup">
          <span class="p-inputgroup-addon">数量</span>
          <InputNumber
            v-model="inputnumber"
            showButtons
            :min="0"
            :max="999999"
            :step="1"
          />
          <Button icon="pi pi-times" @click="clear" class="p-button-danger" />
        </div>
      </div>
      <div class="p-col-12">
        <div class="p-inputgroup p-jc-center">
          <Button label="加入清单" @click="setProduct" />
          <Button label="加入库存" @click="setInventory" />
          <Button label="计算" @click="start" class="p-button-success" />
        </div>
      </div>
    </div>

    <MyItemList header="制作清单" :items="productList" @selecteItem="setItem" />

    <br />

    <MyItemList header="库存" :items="inventoryList" @selecteItem="setItem" />
  </div>
</template>

<script>
import { defineComponent, ref } from "vue";

import InputText from "primevue/inputtext";
import InputNumber from "primevue/inputnumber";
import Button from "primevue/button";

import MyItemList from "../list/myitemlist.vue";

const data = {
  inputname: ref("金币"),
  inputnumber: ref(1),
};

export default defineComponent({
  emits: ["setProduct", "setInventory", "startCalc"],
  data() {
    return data;
  },
  setup() {},
  components: {
    InputText,
    InputNumber,
    Button,

    MyItemList,
  },
  props: {
    productList: Object,
    inventoryList: Object,
  },
  methods: {
    setItem(item) {
      data.inputname.value = item.name;
      data.inputnumber.value = item.number;
    },
    clear() {
      data.inputnumber.value = 0;
    },

    setProduct() {
      this.$emit("setProduct", data.inputname.value, data.inputnumber.value);
    },
    setInventory() {
      this.$emit("setInventory", data.inputname.value, data.inputnumber.value);
    },
    start() {
      this.$emit("startCalc");
    },
  },
});
</script>
