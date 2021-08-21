<template>
  <div class="recipe-report">
    <h1>计算结果</h1>

    <Panel v-for="(val, key) in stages" :key="key">
      <template #header>
        <strong>Stage {{ key + 1 }}</strong>
      </template>

      <Button
        v-for="(item, key) in val"
        :key="key"
        :label="items[item.item] + ` * ` + item.amount"
        class="p-button-outlined p-button-secondary p-mr-2 p-mb-2"
        @click="click($event, item.item)"
      />
    </Panel>

    <OverlayPanel ref="op" :dismissable="false" :showCloseIcon="true">
      <div class="p-grid p-jc-center">
        <div class="p-col-12">
          采集：
          <br />
          合成：
          <br />
        </div>
        <div class="p-col-6">
          <div class="p-inputgroup" width="100%">
            <span class="p-inputgroup-addon">查询</span>
            <InputText disabled :modelValue="'/isearch ' + items[toggleItem]" />
            <Button label="复制" @click="copy" />
          </div>
        </div>
        <div class="p-col-6">
          <div class="p-inputgroup">
            <span class="p-inputgroup-addon">库存</span>
            <InputNumber
              v-model="inputnumber"
              showButtons
              :min="0"
              :max="999999"
              :step="1"
            />
            <Button label="设置" @click="setInventory" />
          </div>
        </div>
      </div>
    </OverlayPanel>
  </div>
</template>

<script>
import { defineComponent, ref } from "vue";
import useClipboard from "vue-clipboard3";

import Button from "primevue/button";
import Panel from "primevue/panel";
import OverlayPanel from "primevue/overlaypanel";
import InputText from "primevue/inputtext";
import InputNumber from "primevue/inputnumber";

const data = {
  items: ref({}),
  gathering: ref({}),
  recipes: ref({}),
  stages: ref([]),
  toggleItem: ref(0),
  inputnumber: ref(0),
};

const methods = {
  show(report) {
    data.items.value = report.items;
    data.gathering.value = report.gathering;
    data.recipes.value = report.recipes;

    var stages = [];
    var size = Object.keys(report.stages).length;
    for (var i = size; i > 0; i--) {
      stages.push(report.stages[i + ""]);
    }
    data.stages.value = stages;
    data.inputnumber.value = 0;
  },
};

export default defineComponent({
  emits: ["setInventory"],
  props: {
    modelValue: Object,
  },
  components: { Button, Panel, OverlayPanel, InputText, InputNumber },
  data() {
    return data;
  },
  setup() {},
  methods: {
    async copy() {
      const { toClipboard } = useClipboard();
      await toClipboard("/isearch " + data.items.value[data.toggleItem.value]);
    },
    click(event, item) {
      this.$refs.op.toggle(event);
      data.toggleItem.value = item;
    },
    setInventory() {
      this.$emit(
        "setInventory",
        data.items.value[data.toggleItem.value],
        data.inputnumber.value
      );
    },
  },
  watch: {
    modelValue() {
      methods.show(this.modelValue);
    },
  },
});
</script>
