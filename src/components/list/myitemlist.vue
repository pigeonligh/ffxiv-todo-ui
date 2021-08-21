<template>
  <div class="my-item-list">
    <DataTable
      :value="items"
      :scrollable="true"
      scrollHeight="300px"
      selectionMode="single"
      @row-select="select"
      class="p-datatable-gridlines p-datatable-sm"
    >
      <template #header>
        {{ header }}
      </template>
      <Column field="name" header="物品"></Column>
      <Column field="number" header="数量"></Column>
    </DataTable>
  </div>
</template>

<script>
import { defineComponent, onMounted } from "vue";

import DataTable from "primevue/datatable";
import Column from "primevue/column";

export default defineComponent({
  emits: ["selecteItem"],
  setup() {
    onMounted(() => {});
  },
  components: {
    DataTable,
    Column,
  },
  props: {
    header: String,
    items: Object,
  },
  methods: {
    select(x) {
      this.$emit("selecteItem", x.data);
    },
  },
});
</script>
