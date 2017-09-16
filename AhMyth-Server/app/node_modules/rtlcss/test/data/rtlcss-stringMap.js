module.exports = [
  {
    'should': 'Should rename "left", "Left", "LEFT" (autoRename:true). ',
    'expected': 'div.right, div.Right, div.RIGHT, div.respectLeft { width:10px;}',
    'input': 'div.left, div.Left, div.LEFT, div.respectLeft { width:10px;}',
    'reversable': true,
    'options': { 'autoRename': true }
  },
  {
    'should': 'Should rename "left", "Left", "LEFT" (autoRename:true, greedy). ',
    'expected': 'div.right, div.Right, div.RIGHT, div.respectRight { width:10px;}',
    'input': 'div.left, div.Left, div.LEFT, div.respectLeft { width:10px;}',
    'reversable': true,
    'options': {
      'autoRename': true,
      'greedy': true
    }
  },
  {
    'should': 'Should rename "ltr", "Ltr", "LTR" (autoRename:true). ',
    'expected': 'div.rtl, div.Rtl, div.RTL, div.Ultra { width:10px;}',
    'input': 'div.ltr, div.Ltr, div.LTR, div.Ultra { width:10px;}',
    'reversable': true,
    'options': { 'autoRename': true }
  },
  {
    'should': 'Should rename "ltr", "Ltr", "LTR" (autoRename:true, greedy). ',
    'expected': 'div.rtl, div.Rtl, div.RTL, div.Urtla { width:10px;}',
    'input': 'div.ltr, div.Ltr, div.LTR, div.Ultra { width:10px;}',
    'reversable': true,
    'options': {
      'autoRename': true,
      'greedy': true
    }
  },
  {
    'should': 'Should rename "prev"/"next" (autoRename:true, custom stringMap - *)',
    'expected': 'div.next, div.Right { width:10px;}',
    'input': 'div.prev, div.Left { width:10px;}',
    'reversable': true,
    'options': { 'autoRename': true, 'stringMap': [{ 'search': 'prev', 'replace': 'next', 'options': { scope: '*' } }] }
  },
  {
    'should': 'Should rename "prev"/"next" (autoRename:true, custom stringMap - selector)',
    'expected': 'div.next, div.Right { width:10px;}',
    'input': 'div.prev, div.Left { width:10px;}',
    'reversable': true,
    'options': { 'autoRename': true, 'stringMap': [{ 'search': 'prev', 'replace': 'next', 'options': { scope: 'selector' } }] }
  },
  {
    'should': 'Should not rename "prev"/"next" (autoRename:true, custom stringMap - url)',
    'expected': 'div.prev, div.Right { width:10px;}',
    'input': 'div.prev, div.Left { width:10px;}',
    'reversable': true,
    'options': { 'autoRename': true, 'stringMap': [{ 'search': 'prev', 'replace': 'next', 'options': { scope: 'url' } }] }
  },
  {
    'should': 'Should not swap "prev"/"next" in Url or Selector (autoRename:true, custom stringMap - url)',
    'expected': 'div.prev { background-image: url(/content/pix/prev.png);}',
    'input': 'div.prev { background-image: url(/content/pix/prev.png);}',
    'reversable': true,
    'options': { 'autoRename': true, 'stringMap': [{ 'search': 'prev', 'replace': 'next', 'options': { scope: 'url' } }] }
  },
  {
    'should': 'Should not swap "prev"/"next" in Url and Rename in selector (autoRename:true, custom stringMap - *)',
    'expected': 'div.next { display:block }; div.next { background-image: url(/content/pix/next.png);}',
    'input': 'div.prev { display:block }; div.prev { background-image: url(/content/pix/next.png);}',
    'reversable': true,
    'options': { 'autoRename': true, 'stringMap': [{ 'search': 'prev', 'replace': 'next', 'options': { scope: '*' } }] }
  },
  {
    'should': 'Should swap "prev"/"next" in Url (autoRename:true, processUrls:true)',
    'expected': 'div.prev { background-image: url(/content/pix/next.png);}',
    'input': 'div.prev { background-image: url(/content/pix/prev.png);}',
    'reversable': true,
    'options': { 'autoRename': true, 'processUrls': true, 'stringMap': [{ 'search': 'prev', 'replace': 'next', 'options': { scope: 'url' } }] }
  },
  {
    'should': 'Should swap "prev"/"next" in Url and Rename in selector (autoRename:true, processUrls:true)',
    'expected': 'div.next { display:block }; div.prev { background-image: url(/content/pix/prev.png);}',
    'input': 'div.prev { display:block }; div.prev { background-image: url(/content/pix/next.png);}',
    'reversable': true,
    'options': { 'autoRename': true, 'processUrls': true, 'stringMap': [{ 'search': 'prev', 'replace': 'next', 'options': { scope: '*' } }] }
  },
  {
    'should': 'Should rename "previous" to "nextious" (autoRename:true, greedy: true)',
    'expected': 'div.nextious{ width:10px;}',
    'input': 'div.previous{ width:10px;}',
    'reversable': true,
    'options': { 'autoRename': true, 'stringMap': [{ 'name': 'prev-next', 'search': 'prev', 'replace': 'next', 'options': { 'greedy': true } }] }
  },
  {
    'should': 'Should escape strings used in stringMap (processUrls: true, custom stringMap)',
    'expected': '@import url("//a.b/c-rtl.css"); @import url("//a.b/css");',
    'input': '@import url("//a.b/c.css"); @import url("//a.b/css");',
    'reversable': true,
    'options': { 'processUrls': true, 'stringMap': [{ 'name': 'import-stylesheet', 'priority': 1, 'exclusive': true, 'search': ['.css'], 'replace': ['-rtl.css'], 'options': { 'scope': 'url' } }] }
  }
]
