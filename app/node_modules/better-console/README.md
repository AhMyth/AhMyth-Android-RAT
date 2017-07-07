# Better Console

![Screenshot](https://raw.github.com/mohsen1/better-console/master/screenshot.png)

## Installation

Use NPM

```shell
$ npm install better-console
```

## A better console for Node.js


`better-console` is a drop-in replacement for node's default console which
gives you colors and more methods in console.

## How to use it

You can override `console` object itself or assign better console to another variable. It's completely safe to override the native console object because better console calls native console methods for methods that are already available in it.

```
var console = require('better-console');

console.log("This is a log information");
console.warn("Warning!");
console.info("Information");
console.table([ [1,2], [3,4] ]);
console.time("Timer");
console.timeEnd("Timer");
console.dir(myObject);

```

## Methods

### `console.log`, `console.warn`, `console.error`, `console.info`, `console.debug`, `console.dir`, `console.trace`
These methods work exactly same as native console methods but with colors for `warn`, `info` or `error`

### `console.clear`

Clears the screen

### `console.table`

Draws a table of data if a 2d array or object passed to it

### `console.time`

Creates a new timer under the given name. Call console.timeEnd(name)`
 with the same name to stop the timer and print the time elapsed.

### `console.timeEnd`

Stops a timer created by a call to console.time(name) and write the time


### `console.count`

Writes number of times each argument is called with blue color

## TODOs

 * Use Unicode icons to mimic browser console icons in OSX
 * Make `console.trace` more detailed with V8 flags
