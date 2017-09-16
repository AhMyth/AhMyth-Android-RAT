var chalk = require('chalk');
var util = require('util');
var logTable = require('./log_table');
var countBuffer = {};

function logWithColor(color, args, isError){
  var log = util.format.apply(this, args);
  if(isError)
    console.error(chalk[color](log));
  else
    console.log(chalk[color](log));
}


module.exports = {

  // Writes a message to the console. You may pass as many arguments as
  // you'd like, and they will be joined together in a space-delimited line.
  // The first argument to log may be a string containing
  // printf-like string substitution patterns.
  log: function(){
    console.log.apply(this, arguments);
  },

  // Writes a message to the console with blue color
  info: function(){
    logWithColor('blue', arguments);
  },

  // Writes a message to the console with yellow color
  warn: function(){
    logWithColor('yellow', arguments, true);
  },

  // Writes a message to the console with red color
  error: function(){
    logWithColor('red', arguments, true);
  },

  // Writes a message to the console with regular color
  debug: function(){
    console.log.apply(this, arguments);
  },

  // Prints an interactive listing of all properties of the object.
  dir: function(){
    console.dir.apply(this, arguments);
  },

  // Clears the terminal buffer
  clear: function(){
     process.stdout.write('\u001B[2J\u001B[0;0f');
  },

  // Prints a stack trace of JavaScript execution at the point
  // where it is called. The stack trace details the functions on the stack,
  // as well as the values that were passed as arguments to each function.
  trace: function(){
    console.trace.apply(this, arguments);
  },

  // Does nothing if first argument is truly. If first argument is falsy
  // it Writes red warning and throws assertion error
  assert: function(assertion){
    // todo: for now we are cheating, it's just console.erroring and then
    // leave console.asset to do it's job. actual todo: print what
    // console.assert prints just make first line red
    if (!assertion){
      logWithColor('red', ['AssertionError: false == true']);
      console.assert(assertion);
    }
  },

  // Writes number of times each argument is called with blue color
  count: function(toCount){
    var toCountString = toCount.toString && toCount.toString(),
        log;

    if (countBuffer[toCountString] == null){
      countBuffer[toCountString] = 0;
    }else{
      countBuffer[toCountString] += 1;
    }

    log = toCountString + ': ' + countBuffer[toCountString];
    logWithColor('blue', [log]);
  },

  // Creates a new timer under the given name. Call console.timeEnd(name)
  // with the same name to stop the timer and print the time elapsed..
  time: function(){
    console.time.apply(this, arguments);
  },

  // Stops a timer created by a call to console.time(name) and writes the time
  // elapsed.
  timeEnd: function(){
    console.timeEnd.apply(this, arguments);
  },

  // draws a table of elements inside of a 2d array or object
  table: function(){
    logTable.apply(this, arguments);
  }
};


