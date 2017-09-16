module.exports = [
  {
    'should': 'Should support plugins',
    'expected': 'div:before { content: "ABC";} div:after { content: "B";}',
    'input': 'div:before { content: "A";} div:after { content: "B";}',
    'reversable': true,
    'plugins': [
      {
        'name': 'test',
        'directives': {
          'control': {},
          'value': []
        },
        'processors': [
          {
            'name': 'content',
            'expr': /content/im,
            'action': function (prop, value, cxt) {
              if (value === '"A"') {
                return { 'prop': prop, 'value': '"ABC"' }
              } else if (value === '"ABC"') {
                return { 'prop': prop, 'value': '"A"' }
              }
              return { 'prop': prop, 'value': value }
            }
          }
        ]
      }
    ]
  },
  {
    'should': 'Should allow overriding default plugin',
    'expected': 'div { text-align:right;}',
    'input': 'div { text-align:right;}',
    'plugins': [
      {
        'name': 'rtlcss',
        'directives': {
          'control': {},
          'value': []
        },
        'processors': []
      }
    ]
  }
]
