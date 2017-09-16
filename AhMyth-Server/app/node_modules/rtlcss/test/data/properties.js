module.exports = [
  {
    'should': 'Should mirror property name: border-top-right-radius',
    'expected': 'div { border-top-left-radius:15px; }',
    'input': 'div { border-top-right-radius:15px; }',
    'reversable': true
  },
  {
    'should': 'Should mirror property name: border-bottom-right-radius',
    'expected': 'div { border-bottom-left-radius:15px; }',
    'input': 'div { border-bottom-right-radius:15px; }',
    'reversable': true
  },
  {
    'should': 'Should mirror property name: border-left',
    'expected': 'div { border-right:1px solid black; }',
    'input': 'div { border-left:1px solid black; }',
    'reversable': true
  },
  {
    'should': 'Should mirror property name: border-left-color',
    'expected': 'div { border-right-color:black; }',
    'input': 'div { border-left-color:black; }',
    'reversable': true
  },
  {
    'should': 'Should mirror property name: border-left-style',
    'expected': 'div { border-right-style:solid; }',
    'input': 'div { border-left-style:solid; }',
    'reversable': true
  },
  {
    'should': 'Should mirror property name: border-left-width',
    'expected': 'div { border-right-width:1em; }',
    'input': 'div { border-left-width:1em; }',
    'reversable': true
  },
  {
    'should': 'Should mirror property name: left',
    'expected': 'div { right:auto; }',
    'input': 'div { left:auto; }',
    'reversable': true
  },
  {
    'should': 'Should mirror property name: margin-left',
    'expected': 'div { margin-right:2em; }',
    'input': 'div { margin-left:2em; }',
    'reversable': true
  },
  {
    'should': 'Should mirror property name: padding-left',
    'expected': 'div { padding-right:2em; }',
    'input': 'div { padding-left:2em; }',
    'reversable': true
  }
]
