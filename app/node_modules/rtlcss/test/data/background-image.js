module.exports = [
  {
    'should': 'Should process string map in url (processUrls:true)',
    'expected': 'div { background-image: url(images/rtl.png), url(images/right.png);}',
    'input': 'div { background-image: url(images/ltr.png), url(images/left.png);}',
    'reversable': true,
    'options': { 'processUrls': true }
  },
  {
    'should': 'Should not negate color value for linear gradient',
    'expected': 'div { background-image: linear-gradient(rgba(255, 255, 255, 0.3) 0%, #ff8 100%);}',
    'input': 'div { background-image: linear-gradient(rgba(255, 255, 255, 0.3) 0%, #ff8 100%);}',
    'reversable': true
  },
  {
    'should': 'Should not negate color value for linear gradient with calc',
    'expected': 'div { background-image: linear-gradient(rgba(255, 255, calc((125 * 2) + 5), 0.3) 0%, #ff8 100%);}',
    'input': 'div { background-image: linear-gradient(rgba(255, 255, calc((125 * 2) + 5), 0.3) 0%, #ff8 100%);}',
    'reversable': true
  },
  {
    'should': 'Should negate angle value for linear gradient',
    'expected': 'div { background-image: linear-gradient(13.25deg, rgba(255, 255, 255, .15) 25%, transparent 25%);}',
    'input': 'div { background-image: linear-gradient(-13.25deg, rgba(255, 255, 255, .15) 25%, transparent 25%);}',
    'reversable': true
  }
]
