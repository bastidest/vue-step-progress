<template lang="pug">
.app
  .row
    step-progress(:steps='steps' :current-step='currentStep')
  .buttons
    button(@click='currentStep--') <
    button(@click='currentStep++') >
</template>

<script>
import StepProgress from '../src/StepProgress.vue';

export default {
  name: 'App',
  components: {
    'step-progress': StepProgress
  },
  data() {
    return {
      steps: [
        'Learn Vue',
        'Open Source',
        '???',
        'Profit'
      ],
      currentStep: 0
    };
  },
  computed: {
  },
  watch: {
  },
  mounted() {
  },
  methods: {
  }
};
</script>

<style lang="sass">
body
  font-family: 'Lato', sans-serif

.buttons
  text-align: center
</style>