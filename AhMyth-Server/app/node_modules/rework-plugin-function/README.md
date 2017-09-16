rework-plugin-function
====================

[![Build Status](https://travis-ci.org/reworkcss/rework-plugin-function.png)](https://travis-ci.org/reworkcss/rework-plugin-function)

function() plugin for rework, formerly included in core

Add user-defined CSS functions.

For example create `black(0.5)` shortcut, to replace
long `rgba(0, 0, 0, 0.5)`.

```js
var rework = require('rework'),
var reworkFunction = require('rework-plugin-function');

var css = rework(css)
  .use(reworkFunction({ black: black }))
  .toString()

function black(opacity) {
  return 'rgba(0, 0, 0, ' + opacity + ')';
}
```

User code will receive CSS arguments and replace user-defined function
by returned code.

```css
input {
  box-shadow: 0 0 5px black(0.7);
}
```

yields:

```css
input {
  box-shadow: 0 0 5px rgba(0, 0, 0, 0.7);
}
```

Nested functions works well too:

```javascript
var css = rework(css)
  .use(reworkFunction({
    subtract: function(a, b) { return a - b },
    multiply: function(a, b) { return a * b },
    divide: function(a, b) { return a / b },
    floor: Math.floor
  }))
.toString()
```

```css
input {
  top: divide(subtract(30, floor(multiply(20, 10))), 2);
}
```

Would yield:

```css
input {
  top: -85;
}
```
