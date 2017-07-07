var console = require('./index');

console.log('Something');
console.clear();
console.info('Console should be clean now');

console.log('Log');
console.log('A string');
console.log('A manipulated string (%s) with number: %d', 'apple', 42);
console.log(1);
console.log(true);
console.log({ me: 1 });
console.log([1, 2, 3]);
console.log('');


console.info('Information');
console.info('A string');
console.info('A manipulated string (%s) with number: %d', 'apple', 42);
console.info(1);
console.info(true);
console.info({ me: 1 });
console.info([1, 2, 3]);
console.info('');


console.warn('Warning');
console.warn('A string');
console.warn('A manipulated string (%s) with number: %d', 'apple', 42);
console.warn(1);
console.warn(true);
console.warn({ me: 1 });
console.warn([1, 2, 3]);
console.warn('');


console.error('Error');
console.error('A string');
console.error('A manipulated string (%s) with number: %d', 'apple', 42);
console.error(1);
console.error(true);
console.error({ me: 1 });
console.error([1, 2, 3]);
console.error('');



console.count('me');
console.count('me');

var arr = [
  ['a', 'b', 'c', 'd'],
  ['e', 'f', 'h', 'j']
];
console.table(arr);

var obj = {
  SF: { total_population: 1000 },
  LA: { total_population: 2000 },
  NY: { total_population: 3000 }
};
console.table(obj);

console.table([
  { a: 1,  b: 2, c: 3 },
  { a: 1,  b: 2, c: 3, d: 4 },
  { k: 11, f: 22 },
  { a: 1,  b: 2, c: 3 }
]);

var obj = {
  SF: { f: 300, m: 100 },
  LA: { f: 200, m: 200 },
  NY: { f: 400, m: 500 }
};
console.table(obj);


var arr = [
  ['a', 'b', 'c', 'd'],
  ['e', 'f', 'hoooohoooohooooo', 'j']
];
console.table(arr);
console.table(null);
console.table([null]);

console.assert(true);
console.assert(false);
