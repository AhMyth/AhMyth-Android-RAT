var Table = require('cli-table');

module.exports = exports = function logTable(data){
  if(typeof data !== 'object' || data === null){
    console.log('');
    return;
  }

  if(typeof data[Object.keys(data)[0]] !== 'object' || data[Object.keys(data)[0]] === null){
    console.log('');
    return;
  }


  var firstKey = Object.keys(data)[0];
  var firstObject = data[firstKey];
  var thead = Object.keys(firstObject);
  thead.unshift('(index)');
  var colWidths = thead.map(calculateColWidth);


  Object.keys(data).forEach(function(rowKey){
    var row = data[rowKey];

    if(typeof row == 'object'){
      Object.keys(row).forEach(function(k,i){
        var width = calculateColWidth (row[k]);
        if(colWidths[i+1] < width)
          colWidths[i+1] = width;
      });
    }
  });

  var table = new Table({
    head: thead,
    colWidths: colWidths
  });

  Object.keys(data).forEach(function(rowKey){
    var row = data[rowKey];
    var rowValues = [];

    if(typeof row == 'object'){
      rowValues = Object.keys(row).map(function(k){
        return row[k];
      });
    }
    table.push([rowKey].concat(rowValues));
  });

  console.log(table.toString());

  function calculateColWidth (item) {
    var MAX_COL_WIDTH = 28;
    var MIN_COL_WIDTH = 3;
    var width = null;

    if(item.toString){
     if(item.toString().length > MAX_COL_WIDTH)
      width = MAX_COL_WIDTH;
     if(item.toString().length < MIN_COL_WIDTH)
      width = MIN_COL_WIDTH;
     else if(!width)
      width = item.toString().length;
    }else{
      width = MAX_COL_WIDTH;
    }

    return width + 2;
  }
};
