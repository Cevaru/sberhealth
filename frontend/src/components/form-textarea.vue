<template>
  <div class="relative">
    <label>
      <div class="mb-1 pl-2"><slot name="label"></slot></div>
      <textarea
        class="
          xl:col-span-3
          lg:col-span-2
          resize-none col-span-1 order-7 w-full
          border rounded border-gray-400 px-2 pt-1
          focus:outline-none focus:border-gray-600
        "
        :value="value"
        rows="3"
        :placeholder="placeholder"
        @input="$emit('input', $event.target.value)"
      ></textarea>
    </label>
  </div>
</template>

<script>
export default {
  props: {
    value: {
      type: String,
      required: true,
    },
    placeholder: {
      type: String,
      default: '',
    },
  },
}
</script>
