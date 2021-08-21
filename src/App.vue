<template>
  <div id="nav">
    <SelectButton
      v-model="selected"
      :options="views"
      optionLabel="name"
      @click="click(selected.path)"
    />
  </div>
  <router-view />
</template>

<script>
import { defineComponent, onMounted, getCurrentInstance, ref } from "vue";

import SelectButton from "primevue/selectbutton";

const data = {
  selected: ref(null),
  views: [
    { name: "Home", path: "/" },
    { name: "About", path: "/about" },
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
      }, 50);
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
