<template lang="pug">
.app
  .row
    step-progress(
      :steps='steps'
      :current-step='currentStep'
      icon-class='fa fa-check'
      :activeColor='activeColor'
      :passiveColor='passiveColor'
      :lineThickness='lineThickness'
      :activeThickness='activeThickness'
      :passiveThickness='passiveThickness'
    )
  .buttons
    button(@click='currentStep--') < 
    button(@click='currentStep++') > 
    button(@click='activeColor = "purple" ') Set active color to purple 
    button(@click='passiveColor = "pink" ') Set passive color to pink 
    div(style='margin-top:10px')
      label  Thickness:  
      input(type = 'text' v-model='lineThickness')
    div(style='margin-top:10px')
      label  Active Step Thickness 
      input(type = 'text' v-model='activeThickness')
    div(style='margin-top:10px')
      label  Passive Step Thickness 
      input(type = 'text' v-model='passiveThickness')   
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
      currentStep: 0,
      activeColor: 'red',
      passiveColor: 'gray',
      lineThickness: 12,
      activeThickness: 5,
      passiveThickness: 5
    };
  }
};
</script>

<style lang="sass">
body
  font-family: 'Lato', sans-serif
.buttons
  text-align: center
  button
    margin-left: 10px
</style>