module.exports = [
  {
    'should': 'Should mirror (x-offset: 0 means 0%)',
    'expected': 'div { transform-origin:100%; }',
    'input': 'div { transform-origin:0; }',
    'reversable': false
  },
  {
    'should': 'Should mirror (x-offset)',
    'expected': 'div { transform-origin:90.25%; }',
    'input': 'div { transform-origin:9.75%; }',
    'reversable': true
  },
  {
    'should': 'Should mirror calc (x-offset)',
    'expected': 'div { transform-origin: -moz-calc(100% - (((25%/2) * 10px))); }',
    'input': 'div { transform-origin: -moz-calc(((25%/2) * 10px)); }',
    'reversable': false
  },
  {
    'should': 'Should not mirror (x-offset: not percent, not calc)',
    'expected': 'div { transform-origin:10.75px; }',
    'input': 'div { transform-origin:10.75px; }',
    'reversable': false
  },
  {
    'should': 'Should mirror (offset-keyword)',
    'expected': 'div { transform-origin:right; }',
    'input': 'div { transform-origin:left; }',
    'reversable': true
  },
  {
    'should': 'Should mirror (x-offset y-offset: 0 means 0%)',
    'expected': 'div { transform-origin:100% 0; }',
    'input': 'div { transform-origin:0 0; }',
    'reversable': false
  },
  {
    'should': 'Should mirror with y being calc (x-offset y-offset: 0 means 0%)',
    'expected': 'div { transform-origin:100% -webkit-calc(15% * (3/2)); }',
    'input': 'div { transform-origin:0 -webkit-calc(15% * (3/2)); }',
    'reversable': false
  },
  {
    'should': 'Should mirror percent (x-offset y-offset)',
    'expected': 'div { transform-origin:30.25% 10%; }',
    'input': 'div { transform-origin:69.75% 10%; }',
    'reversable': true
  },
  {
    'should': 'Should mirror with x being calc (x-offset y-offset)',
    'expected': 'div { transform-origin: -webkit-calc(100% - (15% * (3/2))) 30.25%; }',
    'input': 'div { transform-origin: -webkit-calc(15% * (3/2)) 30.25%; }',
    'reversable': false
  },
  {
    'should': 'Should mirror with y being calc (x-offset y-offset)',
    'expected': 'div { transform-origin:30.25% calc(15% * (3/2)); }',
    'input': 'div { transform-origin:69.75% calc(15% * (3/2)); }',
    'reversable': true
  },
  {
    'should': 'Should mirror (y-offset x-offset-keyword)',
    'expected': 'div { transform-origin:70% right; }',
    'input': 'div { transform-origin:70% left; }',
    'reversable': true
  },
  {
    'should': 'Should mirror with calc (y-offset x-offset-keyword)',
    'expected': 'div { transform-origin:-ms-calc(140%/2) right; }',
    'input': 'div { transform-origin:-ms-calc(140%/2) left; }',
    'reversable': true
  },
  {
    'should': 'Should mirror (x-offset-keyword y-offset)',
    'expected': 'div { transform-origin:right 70%; }',
    'input': 'div { transform-origin:left 70%; }',
    'reversable': true
  },
  {
    'should': 'Should mirror with calc (x-offset-keyword y-offset)',
    'expected': 'div { transform-origin:right -moz-calc(((140%/2))); }',
    'input': 'div { transform-origin:left -moz-calc(((140%/2))); }',
    'reversable': true
  },
  {
    'should': 'Should mirror (y-offset-keyword x-offset)',
    'expected': 'div { transform-origin:top 30.25%; }',
    'input': 'div { transform-origin:top 69.75%; }',
    'reversable': true
  },
  {
    'should': 'Should not mirror with x being calc (y-offset-keyword x-offset)',
    'expected': 'div { transform-origin:top calc(100% - (((140%/2)))); }',
    'input': 'div { transform-origin:top calc(((140%/2))); }',
    'reversable': false
  },
  {
    'should': 'Should mirror (x-offset-keyword y-offset-keyword)',
    'expected': 'div { transform-origin:right top; }',
    'input': 'div { transform-origin:left top; }',
    'reversable': true
  },
  {
    'should': 'Should mirror (y-offset-keyword x-offset-keyword)',
    'expected': 'div { transform-origin:top right; }',
    'input': 'div { transform-origin:top left; }',
    'reversable': true
  },
  {
    'should': 'Should mirror (x-offset y-offset z-offset)',
    'expected': 'div { transform-origin:80.25% 30% 10%; }',
    'input': 'div { transform-origin:19.75% 30% 10%; }',
    'reversable': true
  },
  {
    'should': 'Should mirror with x being calc (x-offset y-offset z-offset)',
    'expected': 'div { transform-origin: calc(100% - (25% * 3 + 20px)) 30% 10%; }',
    'input': 'div { transform-origin: calc(25% * 3 + 20px) 30% 10%; }',
    'reversable': false
  },
  {
    'should': 'Should mirror (y-offset x-offset-keyword z-offset)',
    'expected': 'div { transform-origin:20% right 10%; }',
    'input': 'div { transform-origin:20% left 10%; }',
    'reversable': true
  },
  {
    'should': 'Should mirror (x-offset-keyword y-offset z-offset)',
    'expected': 'div { transform-origin:left 20% 10%; }',
    'input': 'div { transform-origin:right 20% 10%; }',
    'reversable': true
  },
  {
    'should': 'Should mirror (x-offset-keyword y-offset-keyword z-offset)',
    'expected': 'div { transform-origin:left bottom 10%; }',
    'input': 'div { transform-origin:right bottom 10%; }',
    'reversable': true
  },
  {
    'should': 'Should mirror (y-offset-keyword x-offset-keyword z-offset)',
    'expected': 'div { transform-origin:bottom left 10%; }',
    'input': 'div { transform-origin:bottom right 10%; }',
    'reversable': true
  }
]
