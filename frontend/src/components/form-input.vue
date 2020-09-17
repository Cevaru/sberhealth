<template>
  <div class="relative">
    <label>
      <div class="mb-1 pl-2"><slot name="label"></slot></div>
      <input
        class="
          border rounded w-full px-2 py-1 relative z-20
          focus:outline-none
          transition duration-200
        "
        :class="{
          'border-red-400 bg-red-100 focus:border-red-600': isInvalid,
          'border-gray-400 bg-white focus:border-gray-600': !isInvalid,
        }"
        type="text"
        :value="value"
        :placeholder="placeholder"
        :isInvalid="isInvalid"
        @input="$emit('input', $event.target.value)"
      >
      <div
        class="
          absolute bottom-0 z-10 transform text-xs text-red-600
          transition duration-200 pl-2
        "
        :class="{
          'translate-y-full': isInvalid,
          'translate-y-0': !isInvalid,
        }"
      >
        <slot name="error"></slot>
      </div>
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
    isInvalid: {
      type: Boolean,
      default: false,
    },
  },
}
</script>
