#   Vue Step Progress Bar

##  Demo
![demo gif](https://user-images.githubusercontent.com/1242917/36874916-15c773c2-1dae-11e8-8780-595903b79018.gif)

##  Installation

Install the plugin with npm:
```shell
npm install --save vue-step-progress
```

## Usage
⚠️ The default settings use Font Awesome for the checkmark icon. You can change the css icon class by using the 'icon-class' prop.

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
  <step-progress :steps="mySteps" :current-step="currentStep" icon-class="fa fa-check"></step-progress>
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

#### `icon-class`

_Optional_

The css class of the checkmark icon. Default:
```
fa fa-check
```


## Changelog

- 0.1.0: Initial Release
- 0.2.0: ⚠️BREAKING⚠️ - Rename and fix css classes
