module.exports = [
  {
    'should': 'Should not rename selectors unless a pair exits (autoRename:true,autoRenameStrict:true )',
    'expected': '.right .rtl .bright .ultra { display:block; }',
    'input': '.right .rtl .bright .ultra { display:block; }',
    'reversable': true,
    'options': { 'autoRename': true, 'autoRenameStrict': true }
  },
  {
    'should': 'Should rename selectors only if a pair exits (autoRename:true,autoRenameStrict:true )',
    'expected': '.left { display:block; } .right { display:none; }',
    'input': '.right { display:block; } .left { display:none; }',
    'reversable': true,
    'options': { 'autoRename': true, 'autoRenameStrict': true }
  },
  {
    'should': 'Should not rename selectors having directional decl. (default)',
    'expected': '.right .rtl .bright .ultra { display:block; right:0; }',
    'input': '.right .rtl .bright .ultra { display:block; left:0; }',
    'reversable': true
  },
  {
    'should': 'Should not auto rename selectors having no directional decl. (default)',
    'expected': '.right .rtl .bright .ultra { display:block; }',
    'input': '.right .rtl .bright .ultra { display:block; }',
    'reversable': true
  },
  {
    'should': 'Should not auto rename selectors having no directional decl. (greedy)',
    'expected': '.right .rtl .bright .ultra { display:block; }',
    'input': '.right .rtl .bright .ultra { display:block; }',
    'reversable': true,
    'options': { 'greedy': true }
  },
  {
    'should': 'Should auto rename selectors having no directional decl. (autoRename:true)',
    'expected': '.left .ltr .bright .ultra { display:block; }',
    'input': '.right .rtl .bright .ultra { display:block; }',
    'reversable': true,
    'options': { 'autoRename': true }
  },
  {
    'should': 'Should auto rename selectors having no directional decl. (autoRename:true,greedy)',
    'expected': '.left .ltr .bleft .urtla { display:block; }',
    'input': '.right .rtl .bright .ultra { display:block; }',
    'reversable': true,
    'options': { 'autoRename': true, 'greedy': true }
  },
  {
    'should': 'Should not auto rename when rules are flipped via directives (autoRename:true)',
    'expected': 'div.right { display:block; font-family: "Droid Sans", Tahoma, "Droid Arabic Kufi"; }',
    'input': 'div.right { display:block; font-family: "Droid Sans", Tahoma/*!rtl:append:, "Droid Arabic Kufi"*/; }',
    'reversable': false,
    'options': { 'autoRename': true }
  },
  {
    'should': 'Should not preserve processing directive. (default)',
    'expected': 'div { left:0; }',
    'input': '/*rtl:ignore*/div { left:0; }',
    'reversable': false
  },
  {
    'should': 'Should preserve processing directive. (clean:false)',
    'expected': '/*rtl:ignore*/div { left:0; }',
    'input': '/*rtl:ignore*/div { left:0; }',
    'reversable': false,
    'options': { 'clean': false }
  },
  {
    'should': 'Should not process string map in url (default)',
    'expected': 'div { background-image: url(ltr/left.png); right:0; }',
    'input': 'div { background-image: url(ltr/left.png); left:0; }',
    'reversable': true
  },
  {
    'should': 'Should process urls (processUrls:true)',
    'expected': 'div { background-image: url(rtl/right.png); right:0; }',
    'input': 'div { background-image: url(ltr/left.png); left:0; }',
    'reversable': true,
    'options': { 'processUrls': true }
  },
  {
    'should': 'Should process urls in declarations (processUrls:{decl:true})',
    'expected': 'div { background-image: url(rtl/right.png); right:0; }',
    'input': 'div { background-image: url(ltr/left.png); left:0; }',
    'reversable': true,
    'options': { 'processUrls': { 'decl': true } }
  },
  {
    'should': 'Should process @import url (processUrls:true)',
    'expected': 'div{display:none;} @import url("rtl/right.css");',
    'input': 'div{display:none;} @import url("ltr/left.css");',
    'reversable': true,
    'options': { 'processUrls': true }
  },
  {
    'should': 'Should process url in atrule (processUrls:{atrule:true})',
    'expected': 'div{display:none;} @import url("rtl/right.css");',
    'input': 'div{display:none;} @import url("ltr/left.css");',
    'reversable': true,
    'options': { 'processUrls': { 'atrule': true } }
  },
  {
    'should': 'Should respect word boundaries when processing @import url (processUrls:true,greedy:false)',
    'expected': 'div{display:none;} @import url("ultr/bright.css");',
    'input': 'div{display:none;} @import url("ultr/bright.css");',
    'reversable': true,
    'options': { 'processUrls': true, 'greedy': false }
  },
  {
    'should': 'Should not respect word boundaries when processing @import url (processUrls:true,greedy:true)',
    'expected': 'div{display:none;} @import url("urtla/bleft.css");',
    'input': 'div{display:none;} @import url("ultra/bright.css");',
    'reversable': true,
    'options': { 'processUrls': true, 'greedy': true }
  },
  {
    'should': 'Should preserve comments inside declarations',
    'expected': 'div { border-radius: 40.25px 10.5px /*comment*/ 10.75px 40.3px; }',
    'input': 'div { border-radius: 10.5px 40.25px /*comment*/ 40.3px 10.75px; }',
    'reversable': true
  }
]
