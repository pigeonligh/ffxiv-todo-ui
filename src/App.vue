<template>
  <div id="nav">
    <SelectButton
      v-model="selected"
      :options="views"
      optionLabel="name"
      @click="click(selected.path)"
    />
  </div>
  <div id="main">
    <router-view />
  </div>
</template>

<script>
import { defineComponent, onMounted, getCurrentInstance, ref } from "vue";

import SelectButton from "primevue/selectbutton";

const data = {
  selected: ref(null),
  views: [
    { name: "主页", path: "/" },
    { name: "配方计算器", path: "/recipe" },
    { name: "关于", path: "/about" },
  ],
};

export default defineComponent({
  data() {
    return data;
  },
  setup() {
    onMounted(() => {
      const { proxy } = getCurrentInstance();
      setTimeout(() => {
        const path = proxy.$router.currentRoute.value.path;
        for (var i in data.views) {
          if (data.views[i].path == path) {
            data.selected.value = data.views[i];
          }
        }
      }, 200);
    });
  },
  components: {
    SelectButton,
  },
  methods: {
    click(path) {
      this.$router.push(path);
    },
  },
});
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
}

#nav {
  padding: 30px;
}

#nav a {
  font-weight: bold;
  color: #c1d1e0;
}

#nav a.router-link-exact-active {
  color: #42b983;
}

#main {
  padding: 10px;
}

body {
  margin: 0;
  height: 100%;
  overflow-x: hidden;
  overflow-y: auto;
  background-color: var(--surface-a);
  font-family: var(--font-family);
  font-weight: 400;
  color: var(--text-color);
}
</style>
