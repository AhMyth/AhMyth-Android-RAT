module.exports = [
  {
    'should': 'Should mirror property value: clear',
    'expected': 'div { clear:right; }',
    'input': 'div { clear:left; }',
    'reversable': true
  },
  {
    'should': 'Should mirror property value: direction',
    'expected': 'div { direction:ltr; }',
    'input': 'div { direction:rtl; }',
    'reversable': true
  },
  {
    'should': 'Should mirror property value: float',
    'expected': 'div { float:right; }',
    'input': 'div { float:left; }',
    'reversable': true
  },
  {
    'should': 'Should mirror property value: text-align',
    'expected': 'div { text-align:right; }',
    'input': 'div { text-align:left; }',
    'reversable': true
  },
  {
    'should': 'Should mirror property value: cursor nw',
    'expected': 'div { cursor:nw-resize; }',
    'input': 'div { cursor:ne-resize; }',
    'reversable': true
  },
  {
    'should': 'Should mirror property value: cursor sw',
    'expected': 'div { cursor:sw-resize; }',
    'input': 'div { cursor:se-resize; }',
    'reversable': true
  },
  {
    'should': 'Should mirror property value: cursor nesw',
    'expected': 'div { cursor:nesw-resize; }',
    'input': 'div { cursor:nwse-resize; }',
    'reversable': true
  },
  {
    'should': 'Should keep property value as is: cursor ew',
    'expected': 'div { cursor:ew-resize; }',
    'input': 'div { cursor:ew-resize; }',
    'reversable': false
  },
  {
    'should': 'Should process string map in url: cursor (processUrls: true)',
    'expected': '.foo { cursor: url(right.cur), url(rtl.cur), se-resize, auto }',
    'input': '.foo { cursor: url(left.cur), url(ltr.cur), sw-resize, auto }',
    'reversable': true,
    'options': { 'processUrls': true }
  },
  {
    'should': 'Should mirror property value: transition',
    'expected': '.foo { transition: right .3s ease .1s, left .3s ease .1s, margin-right .3s ease, margin-left .3s ease, padding-right .3s ease, padding-left .3s ease}',
    'input': '.foo { transition: left .3s ease .1s, right .3s ease .1s, margin-left .3s ease, margin-right .3s ease, padding-left .3s ease, padding-right .3s ease}',
    'reversable': true
  },
  {
    'should': 'Should mirror property value: transition-property',
    'expected': '.foo { transition-property: right; }',
    'input': '.foo { transition-property: left; }',
    'reversable': true
  }
]
