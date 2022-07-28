const { createApp } = Vue

createApp({
  name: 'App',
  components: {
    'step-progress': StepProgress.default
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
}).mount('#app')
