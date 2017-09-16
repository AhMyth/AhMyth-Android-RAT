module.exports = [
  {
    'should': 'Should not negate tokens',
    'expected': 'div { box-shadow: rgba(0, 128, 128, 0.98) inset -5em 1em 0;}',
    'input': 'div { box-shadow: rgba(0, 128, 128, 0.98) inset 5em 1em 0;}',
    'reversable': true
  }
]
