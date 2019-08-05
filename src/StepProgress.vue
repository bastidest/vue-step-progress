<template lang="pug">
.step-progress__wrapper
  .step-progress__wrapper-before(
    :style='{"background-color": passiveColor, height: lineThickness + "px" }'
  )
  .step-progress__bar
    .step-progress__step(
      v-for='(step, index) in steps'
      :style=`{
        "--activeColor" : activeColor,
        "--passiveColor" : passiveColor,
        "--activeBorder" : activeThickness + "px",
        "--passiveBorder" : passiveThickness + "px"
      }`
      :class=`{
        "step-progress__step--active": index === currentStep,
        "step-progress__step--valid": index < currentStep
      }`
    )
      span {{ index + 1 }}
      .step-progress__step-icon(:class='iconClass')
      .step-progress__step-label {{ step }}
  .step-progress__wrapper-after(
    :style=`{
      transform: "scaleX(" + scaleX + ") translateY(-50%) perspective(1000px)",
      "background-color": activeColor,
      height: lineThickness + "px"
    }`
  )

</template>

<script>

export default {
  name: 'StepProgress',
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
    },
    iconClass: {
      type: String,
      default: 'fa fa-check'
    },
    activeColor: {
      type: String,
      default: 'red'
    },
    passiveColor: {
      type: String,
      default: 'gray'
    },
    activeThickness: {
      type: Number,
      default: 5
    },
    passiveThickness: {
      type: Number,
      default: 5
    },
    lineThickness: {
      type: Number,
      default: 12
    }
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
  }
};
</script>

<style lang="sass">
.step-progress
  &__wrapper
    width: 90%
    margin: 0 auto
    position: relative

  &__wrapper-before
    content: ''
    position: absolute
    left: 0
    top: 50%
    height: 12px
    width: 100%
    background-color: gray
    transform: translateY(-50%) perspective(1000px)

  &__wrapper-after
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

  &__bar
    width: 100%
    display: flex
    height: 100px
    justify-content: space-between
    align-items: center
    margin-bottom: 40px

  &__step
    z-index: 2
    position: relative
    --activeColor: red
    --passiveColor: gray
    --activeBorder: 5px
    --passiveBorder: 5px
    span
      color: var(--passiveColor)
      transition: .3s ease
      display: block
      font-size: 50px
      transform: translate3d(0,0,0) scale(1) perspective(1000px)
      font-weight: 900
      text-align: center
      opacity: 1

      @media (max-width: 767px)
        font-size: 28px

    &--active
      span
        color: var(--activeColor)
      .step-progress__step-label
        color: var(--activeColor)
      .step-progress__step-icon
        opacity: 1
    &--valid
      .step-progress__step-icon
        opacity: 1
        transform: translate3d(-50%, -50%, 0) scale(1) perspective(1000px) 
      span
        color: var(--activeColor)
        opacity: 0
        transform: translate3d(0,0,0) scale(2) perspective(1000px) 
      .step-progress__step-label
        color: var(--activeColor)
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
      border: var(--passiveBorder) solid var(--passiveColor)
      transition: .3s ease

      @media (max-width: 767px)
        width: 40px
        height: 40px

    &--active:after
      border: var(--activeBorder) solid var(--activeColor)
    &--valid:after
      background-color: var(--activeColor)
      border: var(--activeBorder) solid var(--activeColor)

  &__step-label
    position: absolute
    top: calc(100% + 25px)
    left: 50%
    transform: translateX(-50%) perspective(1000px)
    white-space: nowrap
    font-size: 18px
    font-weight: 600
    color: gray
    transition: .3s ease

  &__step-icon
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