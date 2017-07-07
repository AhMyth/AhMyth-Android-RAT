module.exports = [
  {
    'should': 'Should treat 0 as 0%',
    'expected': '.banner { background: 100% top url(topbanner.png) #00D repeat-y fixed; }',
    'input': '.banner { background: 0 top url(topbanner.png) #00D repeat-y fixed; }',
    'reversable': false
  },
  {
    'should': 'Should complement percentage horizontal position',
    'expected': '.banner { background: 81% top url(topbanner.png) #00D repeat-y fixed; }',
    'input': '.banner { background: 19% top url(topbanner.png) #00D repeat-y fixed; }',
    'reversable': true
  },
  {
    'should': 'Should complement calc horizontal position',
    'expected': '.banner { background: calc(100% - (19% + 2px)) top url(topbanner.png) #00D repeat-y fixed; }',
    'input': '.banner { background: calc(19% + 2px) top url(topbanner.png) #00D repeat-y fixed; }',
    'reversable': false
  },
  {
    'should': 'Should mirror keyword horizontal position',
    'expected': '.banner { background: right top url(topbanner.png) #00D repeat-y fixed; }',
    'input': '.banner { background: left top url(topbanner.png) #00D repeat-y fixed; }',
    'reversable': true
  },
  {
    'should': 'Should not process string map in url (default)',
    'expected': '.banner { background: 10px top url(ltr-top-right-banner.png) #00D repeat-y fixed; }',
    'input': '.banner { background: 10px top url(ltr-top-right-banner.png) #00D repeat-y fixed; }',
    'reversable': true
  },
  {
    'should': 'Should process string map in url (processUrls:true)',
    'expected': '.banner { background: 10px top url(rtl-top-left-banner.png) #00D repeat-y fixed; }',
    'input': '.banner { background: 10px top url(ltr-top-right-banner.png) #00D repeat-y fixed; }',
    'reversable': true,
    'options': { 'processUrls': true }
  },
  {
    'should': 'Should process string map in url (processUrls:{decl:true})',
    'expected': '.banner { background: 10px top url(rtl-top-left-banner.png) #00D repeat-y fixed; }',
    'input': '.banner { background: 10px top url(ltr-top-right-banner.png) #00D repeat-y fixed; }',
    'reversable': true,
    'options': { 'processUrls': { 'decl': true } }
  },
  {
    'should': 'Should not process string map in url (processUrls:{atrule:true})',
    'expected': '.banner { background: 10px top url(ltr-top-right-banner.png) #00D repeat-y fixed; }',
    'input': '.banner { background: 10px top url(ltr-top-right-banner.png) #00D repeat-y fixed; }',
    'reversable': true,
    'options': { 'processUrls': { 'atrule': true } }
  },
  {
    'should': 'Should not swap bright:bleft, ultra:urtla',
    'expected': '.banner { background: 10px top url(ultra/bright.png) #00D repeat-y fixed; }',
    'input': '.banner { background: 10px top url(ultra/bright.png) #00D repeat-y fixed; }',
    'reversable': true
  },
  {
    'should': 'Should swap bright:bleft, ultra:urtla (processUrls: true, greedy)',
    'expected': '.banner { background: 10px top url(urtla/bleft.png) #00D repeat-y fixed; }',
    'input': '.banner { background: 10px top url(ultra/bright.png) #00D repeat-y fixed; }',
    'reversable': true,
    'options': { 'processUrls': true, 'greedy': true }
  },
  {
    'should': 'Should not flip hex colors ',
    'expected': '.banner { background: #ff0; }',
    'input': '.banner { background: #ff0; }',
    'reversable': true
  },
  {
    'should': 'Should treat 0 as 0% (url first)',
    'expected': '.banner { background: url(topbanner.png) 100% top #00D repeat-y fixed; }',
    'input': '.banner { background: url(topbanner.png) 0 top #00D repeat-y fixed; }',
    'reversable': false
  },
  {
    'should': 'Should complement calc horizontal position (url first)',
    'expected': '.banner { background: url(topbanner.png) calc(100% - (19% + 2px)) top #00D repeat-y fixed; }',
    'input': '.banner { background: url(topbanner.png) calc(19% + 2px) top #00D repeat-y fixed; }',
    'reversable': false
  }
]
