var console = require('./index');

console.log('> console.info("This is information")');
console.info("This is information");

console.log('');
console.log('> console.error("Oops!")');
console.error("Oops!");

console.log('');
console.log("> var arr = [");
console.log("   ['a','b','c','d'],");
console.log("   ['e','f','h','j']");
console.log(" ];");
console.log("> console.table(arr);");

var arr = [
  ['a','b','c','d'],
  ['e','f','h','j']
];
console.table(arr);
console.log('> ');
