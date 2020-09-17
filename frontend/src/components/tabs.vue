<template>
  <div class="border-gray-400 border-b flex mb-4">
    <div
      class="tab-item"
      :class="{
        'active': activeTab === 'main'
      }"
      @click="$emit('change-tab', 'main')"
    >Основные данные</div>
    <div
      class="tab-item"
      :class="{
        'active': activeTab === 'address'
      }"
      @click="$emit('change-tab', 'address')"
    >Адрес доставки</div>
  </div>
</template>

<script>
export default {
  props: {
    activeTab: {
      type: String,
      default: 'main',
    },
  },
};
</script>

<style lang="postcss" scoped>
.tab-item {
  @apply border-t border-l border-r border-transparent rounded-t -mb-px px-3 py-2 cursor-pointer text-blue-600;
}
.tab-item.active {
  @apply border-gray-400 text-gray-900 bg-white; 
}
</style>