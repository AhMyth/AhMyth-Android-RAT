module.exports = [
  {
    'should': 'Should complement percentage horizontal position ',
    'expected': 'div {background-position:100% 75%;}',
    'input': 'div {background-position:0 75%;}',
    'reversable': false
  },
  {
    'should': 'Should complement percentage horizontal position with calc',
    'expected': 'div {background-position:calc(100% - (30% + 50px)) 75%;}',
    'input': 'div {background-position:calc(30% + 50px) 75%;}',
    'reversable': false
  },
  {
    'should': 'Should complement percentage horizontal position ',
    'expected': 'div {background-position:81.25% 75%, 10.75% top;}',
    'input': 'div {background-position:18.75% 75%, 89.25% top;}',
    'reversable': true
  },
  {
    'should': 'Should complement percentage horizontal position with calc',
    'expected': 'div {background-position:calc(100% - (30% + 50px)) calc(30% + 50px), 10.75% top;}',
    'input': 'div {background-position:calc(30% + 50px) calc(30% + 50px), 89.25% top;}',
    'reversable': false
  },
  {
    'should': 'Should mirror background-position',
    'expected': 'div {background-position:right 75%, left top;}',
    'input': 'div {background-position:left 75%, right top;}',
    'reversable': true
  },
  {
    'should': 'Should mirror background-position (calc)',
    'expected': 'div {background-position:right -ms-calc(30% + 50px), left top;}',
    'input': 'div {background-position:left -ms-calc(30% + 50px), right top;}',
    'reversable': true
  },
  {
    'should': 'Should complement percentage: position-x (treat 0 as 0%)',
    'expected': 'div {background-position-x:100%, 0%;}',
    'input': 'div {background-position-x:0, 100%;}',
    'reversable': false
  },
  {
    'should': 'Should complement percentage: position-x',
    'expected': 'div {background-position-x:81.75%, 11%;}',
    'input': 'div {background-position-x:18.25%, 89%;}',
    'reversable': true
  },
  {
    'should': 'Should complement percentage with calc: position-x',
    'expected': 'div {background-position-x:calc(100% - (30% + 50px)), -webkit-calc(100% - (30% + 50px));}',
    'input': 'div {background-position-x:calc(30% + 50px), -webkit-calc(30% + 50px);}',
    'reversable': false
  },
  {
    'should': 'Should mirror position-x',
    'expected': 'div {background-position-x:right, left;}',
    'input': 'div {background-position-x:left, right;}',
    'reversable': true
  },
  {
    'should': 'Should mirror position-x (calc)',
    'expected': 'div {background-position-x:calc(100% - (30% + 50px)), calc(100% - (50px * 5));}',
    'input': 'div {background-position-x:calc(30% + 50px), calc(50px * 5);}',
    'reversable': false
  },
  {
    'should': 'Should keep as is: position-x',
    'expected': 'div {background-position-x:100px, 0px;}',
    'input': 'div {background-position-x:100px, 0px;}',
    'reversable': true
  },
  {
    'should': 'Should mirror background-position edge offsets (4 values)',
    'expected': 'div {background-position: left 5px bottom 5px, bottom 15px right 15px;}',
    'input': 'div {background-position: right 5px bottom 5px, bottom 15px left 15px;}',
    'reversable': true
  },
  {
    'should': 'Should mirror background-position edge offsets (3 values)',
    'expected': 'div {background-position: left 5px bottom, top 15px right;}',
    'input': 'div {background-position: right 5px bottom, top 15px left;}',
    'reversable': true
  }
]
