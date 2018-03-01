#   Vue Step Progress Bar

##  Demo
// TODO

##  Installation

Install the plugin with npm:
```shell
npm install --save vue-step-progress
```

## Usage

Add the Library import in the components you want to use the progress bar in:
```javascript
import StepProgress from 'vue-step-progress';

// ...
// register the component in your Vue instance
  components: {
    'step-progress': StepProgress
  },
// ...
```

Put the `step-progress` element into your HTML where you want the Component to appear and pass the `steps` Array Prop and the `current-step` Number prop.
```html
<div>
  <step-progress :steps="mySteps" :current-step="currentStep"></step-progress>
</div>
```

## Props

#### `steps`

A string array of all steps to be displayed. The Strings will be present as labels in the component. Example:

```javascript
['Step 1', 'Step 2', 'Step 3']
```

#### `current-step`

A simple Number prop that defines the index of the active step. Example:
```
2
```


## Custom Styling

To style the component override the css classes.

// TODO: find better solutions


## Changelog

- 0.1.0: Initial Release