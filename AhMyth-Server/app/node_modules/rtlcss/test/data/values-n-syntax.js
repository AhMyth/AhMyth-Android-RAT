module.exports = [
  {
    'should': 'Should mirror property value: border-radius (4 values)',
    'expected': 'div { border-radius: 40.25px 10.5px 10.75px 40.3px; }',
    'input': 'div { border-radius: 10.5px 40.25px 40.3px 10.75px; }',
    'reversable': true
  },
  {
    'should': 'Should mirror property value: border-radius (3 values)',
    'expected': 'div { border-radius: 40.75px 10.75px 40.75px 40.3px; }',
    'input': 'div { border-radius: 10.75px 40.75px 40.3px; }',
    'reversable': false
  },
  {
    'should': 'Should mirror property value: border-radius (2 values)',
    'expected': 'div { border-radius: 40.25px 10.75px; }',
    'input': 'div { border-radius: 10.75px 40.25px; }',
    'reversable': true
  },
  {
    'should': 'Should mirror property value: border-radius (4 values - double)',
    'expected': 'div { border-radius: 40.25px 10.75px .5px 40.75px / .4em 1em 1em 4.5em; }',
    'input': 'div { border-radius: 10.75px 40.25px 40.75px .5px / 1em .4em 4.5em 1em; }',
    'reversable': true
  },
  {
    'should': 'Should mirror property value: border-radius (3 values - double)',
    'expected': 'div { border-radius: .40px 10.5px .40px 40px / 4em 1em 4em 3em; }',
    'input': 'div { border-radius: 10.5px .40px 40px / 1em 4em 3em; }',
    'reversable': false
  },
  {
    'should': 'Should mirror property value: border-radius (2 values- double)',
    'expected': 'div { border-radius: 40px 10px / 2.5em .75em; }',
    'input': 'div { border-radius: 10px 40px / .75em 2.5em; }',
    'reversable': true
  },
  {
    'should': 'Should mirror property value: border-width',
    'expected': 'div { border-width: 1px 4px .3em 2.5em; }',
    'input': 'div { border-width: 1px 2.5em .3em 4px; }',
    'reversable': true
  },
  {
    'should': 'Should mirror property value: border-width (none length)',
    'expected': 'div { border-width: thin medium thick none; }',
    'input': 'div { border-width: thin none thick medium; }',
    'reversable': true
  },
  {
    'should': 'Should mirror property value: border-style (4 values)',
    'expected': 'div { border-style: none dashed dotted solid; }',
    'input': 'div { border-style: none solid dotted dashed; }',
    'reversable': true
  },
  {
    'should': 'Should mirror property value: border-color (4 values)',
    'expected': 'div { border-color: rgba(255, 255, 255, 1) rgb( 0, 0, 0) #000 hsla(0, 100%, 50%, 1); }',
    'input': 'div { border-color: rgba(255, 255, 255, 1) hsla(0, 100%, 50%, 1) #000 rgb( 0, 0, 0); }',
    'reversable': true
  },
  {
    'should': 'Should not mirror property value: border-color (3 values)',
    'expected': 'div { border-color: #000 rgb( 0, 0, 0) hsla(0, 100%, 50%, 1); }',
    'input': 'div { border-color: #000 rgb( 0, 0, 0) hsla(0, 100%, 50%, 1); }',
    'reversable': false
  },
  {
    'should': 'Should not mirror property value: border-color (2 values)',
    'expected': 'div { border-color:rgb( 0, 0, 0) hsla(0, 100%, 50%, 1); }',
    'input': 'div { border-color:rgb( 0, 0, 0) hsla(0, 100%, 50%, 1); }',
    'reversable': false
  },
  {
    'should': 'Should mirror property value: margin',
    'expected': 'div { margin: .1em auto 3.5rem 2px; }',
    'input': 'div { margin: .1em 2px 3.5rem auto; }',
    'reversable': true
  },
  {
    'should': 'Should mirror property value: padding',
    'expected': 'div { padding: 1px 4px .3rem 2.5em; }',
    'input': 'div { padding: 1px 2.5em .3rem 4px; }',
    'reversable': true
  },
  {
    'should': 'Should mirror property value: box-shadow',
    'expected': 'div { box-shadow: -60px -16px rgba(0, 128, 128, 0.98), -10.25px 5px 5px #ff0, inset -0.5em 1em 0 white; }',
    'input': 'div { box-shadow: 60px -16px rgba(0, 128, 128, 0.98), 10.25px 5px 5px #ff0, inset 0.5em 1em 0 white; }',
    'reversable': true
  },
  {
    'should': 'Should mirror property value: text-shadow',
    'expected': 'div { text-shadow: -60px -16px rgba(0, 128, 128, 0.98), -10.25px 5px 5px #ff0, inset -0.5em 1em 0 white; }',
    'input': 'div { text-shadow: 60px -16px rgba(0, 128, 128, 0.98), 10.25px 5px 5px #ff0, inset 0.5em 1em 0 white; }',
    'reversable': true
  },
  {
    'should': 'Should mirror property value (no digit before the dot): box-shadow, text-shadow',
    'expected': 'div { box-shadow: inset -0.5em 1em 0 white; text-shadow: inset -0.5em 1em 0 white; }',
    'input': 'div { box-shadow: inset .5em 1em 0 white; text-shadow: inset .5em 1em 0 white; }',
    'reversable': false
  }
]
