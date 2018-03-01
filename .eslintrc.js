module.exports = {
  "plugins": [
      "vue"
  ],
  "extends": [
      "eslint:recommended",
      "plugin:vue/recommended"
  ],
  "env": {
      "browser": true,
      "commonjs": true,
      "es6": true,
      "node": true
  },
  "parserOptions": {
      "ecmaFeatures": {
          "jsx": true
      },
      "sourceType": "module"
  },
  "rules": {
      "indent": [
          "error",
          2
      ],
      "linebreak-style": [
          "error",
          "unix"
      ],
      "quotes": [
          "error",
          "single"
      ],
      "semi": [
          "error",
          "always"
      ]
  }
};