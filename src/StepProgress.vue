<template lang="pug">
.step-progress-wrapper()
  .step-progress-wrapper-before
  .step-progress-bar
    .step-progress-step(v-for='(step, index) in steps' :class='{active: index < currentStep, valid: index < currentStep}')
      span {{ index + 1 }}
      .step-progress-step-icon.fa.fa-check
      .step-progress-step-label {{ step }}
  .step-progress-wrapper-after(:style='{transform: "scaleX(" + scaleX + ") translateY(-50%) perspective(1000px)"}')

</template>

<script>

export default {
  name: 'StepProgress',
  components: {
  },
  props: {
    steps: {
      type: Array,
      default() {return [];},
      validator(val) {
        return val && val.length > 0;
      }
    },
    currentStep: {
      type: Number,
      default: 0
    }
  },
  data() {
    return {

    };
  },
  computed: {
    scaleX() {
      let step = this.currentStep;
      if(step < 0) {
        step = 0;
      } else if (step >= this.steps.length) {
        step = this.steps.length - 1;
      }
      return step / (this.steps.length - 1);
    }
  },
  watch: {
  },
  mounted() {
  },
  methods: {
  },
};
</script>

<style lang="sass">
.step-progress-wrapper
  width: 90%
  margin: 0 auto
  position: relative

.step-progress-wrapper-before
  content: ''
  position: absolute
  left: 0
  top: 50%
  height: 12px
  width: 100%
  background-color: gray
  transform: translateY(-50%) perspective(1000px)

.step-progress-wrapper-after
  content: ''
  position: absolute
  left: 0
  top: 50%
  height: 12px
  width: 100%
  background-color: red
  transform: scaleX(0) translateY(-50%) perspective(1000px) 
  transform-origin: left center
  transition: transform .5s ease

.step-progress-bar
  width: 100%
  display: flex
  height: 100px
  justify-content: space-between
  align-items: center
  margin-bottom: 40px

.step-progress-step
  z-index: 2
  position: relative

  &.active
    span
      color: red
      opacity: 0
    .step-progress-step-label
      color: red
    .step-progress-step-icon
      opacity: 1
  &.valid
    .step-progress-step-icon
      transform: translate3d(-50%, -50%, 0) scale(1) perspective(1000px) 
    span
      color: red
      transform: translate3d(0,0,0) scale(2) perspective(1000px) 
    .step-progress-step-label
      color: red !important
  &:after
    content: ""
    position: absolute
    z-index: -1
    left: 50%
    top: 50%
    transform: translate(-50%, -50%) perspective(1000px) 
    width: 75px
    height: 75px
    background-color: #fff
    border-radius: 50%
    border: 5px solid gray
    transition: .3s ease

    @media (max-width: 767px)
      width: 40px
      height: 40px

  &.active:after
    border: 5px solid red
  &.valid:after
    background-color: red
    border: 5px solid red

  span
    color: gray
    transition: .3s ease
    display: block
    font-size: 50px
    transform: translate3d(0,0,0) scale(1) perspective(1000px)
    font-weight: 900
    text-align: center
    opacity: 1

    @media (max-width: 767px)
      font-size: 28px


.step-progress-step-label
  position: absolute
  top: calc(100% + 25px)
  left: 50%
  transform: translateX(-50%) perspective(1000px)
  white-space: nowrap
  font-size: 18px
  font-weight: 600
  color: gray
  transition: .3s ease

.step-progress-step-icon
  font-size: 36px
  color: #fff
  position: absolute
  left: 50%
  top: 50%
  transition: transform .3s ease
  opacity: 0
  transform: translate3d(-50%, -50%, 0) scale(0) perspective(1000px) 

  @media (max-width: 767px)
    font-size: 22px
</style>