<template>
  <div id="app">
    <div class="container mx-auto px-10 py-4">
      <delivery-form></delivery-form>
    </div>
  </div>
</template>

<script>
import DeliveryForm from '@/components/delivery-form.vue';

export default {
  name: 'App',
  components: {
    DeliveryForm,
  },
};
</script>
