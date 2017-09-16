module.exports = [
  {
    'should': 'Should mirror transform : matrix',
    'expected': 'div { transform: matrix(2, 0.1, 20.75, 2, 2, 2); }',
    'input': 'div { transform: matrix(2, -0.1, -20.75, 2, -2, 2); }',
    'reversable': true
  },
  {
    'should': 'Should mirror transform (with no digits before dot): matrix',
    'expected': 'div { transform: matrix(2, 0.1, 0.75, 2, 2, 2); }',
    'input': 'div { transform: matrix(2, -0.1, -.75, 2, -2, 2); }',
    'reversable': false
  },
  {
    'should': 'Should mirror transform with calc: matrix',
    'expected': 'div { transform: matrix( -moz-calc(((25%/2) * 10px)), calc(-1*(((25%/2) * 10px))), 20.75, 2, 2, 2 ); }',
    'input': 'div { transform: matrix( -moz-calc(((25%/2) * 10px)), calc(((25%/2) * 10px)), -20.75, 2, -2, 2 ); }',
    'reversable': false
  },
  {
    'should': 'Should mirror transform : matrix3d',
    'expected': 'div { transform:matrix3d(0.227114470162179, 0.127248412323519, 0, 0.000811630714323203, 0.113139853456515, 1.53997196559414, 0, 0.000596368270149729, 0, 0, 1, 0, -165, 67, 0, 1); }',
    'input': 'div { transform:matrix3d(0.227114470162179, -0.127248412323519, 0, -0.000811630714323203, -0.113139853456515, 1.53997196559414, 0, 0.000596368270149729, 0, 0, 1, 0, 165, 67, 0, 1); }',
    'reversable': true
  },
  {
    'should': 'Should mirror transform (with no digits before dot): matrix3d',
    'expected': 'div { transform:matrix3d(0.227114470162179, 0.127248412323519, 0, 0.000811630714323203, 0.113139853456515, 1.53997196559414, 0, 0.000596368270149729, 0, 0, 1, 0, -165, 67, 0, 1); }',
    'input': 'div { transform:matrix3d(0.227114470162179, -.127248412323519, 0, -0.000811630714323203, -0.113139853456515, 1.53997196559414, 0, 0.000596368270149729, 0, 0, 1, 0, 165, 67, 0, 1); }',
    'reversable': false
  },
  {
    'should': 'Should mirror transform with calc : matrix3d',
    'expected': 'div { transform:matrix3d(0.227114470162179, 0.127248412323519, 0, 0.000811630714323203, 0.113139853456515, 1.53997196559414, 0, 0.000596368270149729, 0, 0, 1, 0, calc(-1*(((25%/2) * 10px))), 67, 0, 1); }',
    'input': 'div { transform:matrix3d(0.227114470162179, -0.127248412323519, 0, -0.000811630714323203, -0.113139853456515, 1.53997196559414, 0, 0.000596368270149729, 0, 0, 1, 0, calc(((25%/2) * 10px)), 67, 0, 1); }',
    'reversable': false
  },
  {
    'should': 'Should mirror transform : translate',
    'expected': 'div { transform: translate(-10.75px); }',
    'input': 'div { transform: translate(10.75px); }',
    'reversable': true
  },
  {
    'should': 'Should mirror transform (with no digits before dot): translate',
    'expected': 'div { transform: translate(-0.75px); }',
    'input': 'div { transform: translate(.75px); }',
    'reversable': false
  },
  {
    'should': 'Should mirror transform with calc: translate',
    'expected': 'div { transform: translate(-moz-calc(-1*(((25%/2) * 10px)))); }',
    'input': 'div { transform: translate(-moz-calc(((25%/2) * 10px))); }',
    'reversable': false
  },
  {
    'should': 'Should mirror transform : translateX',
    'expected': 'div { transform: translateX(-50.25px); }',
    'input': 'div { transform: translateX(50.25px); }',
    'reversable': true
  },
  {
    'should': 'Should mirror transform (with no digits before dot): translateX',
    'expected': 'div { transform: translateX(-0.25px); }',
    'input': 'div { transform: translateX(.25px); }',
    'reversable': false
  },
  {
    'should': 'Should mirror transform with calc : translateX',
    'expected': 'div { transform: translateX(-ms-calc(-1*(((25%/2) * 10px))))); }',
    'input': 'div { transform: translateX(-ms-calc(((25%/2) * 10px)))); }',
    'reversable': false
  },
  {
    'should': 'Should mirror transform : translate3d',
    'expected': 'div { transform: translate3d(-12.75px, 50%, 3em); }',
    'input': 'div { transform: translate3d(12.75px, 50%, 3em); }',
    'reversable': true
  },
  {
    'should': 'Should mirror transform (with no digits before dot): translate3d',
    'expected': 'div { transform: translate3d(-0.75px, 50%, 3em); }',
    'input': 'div { transform: translate3d(.75px, 50%, 3em); }',
    'reversable': false
  },
  {
    'should': 'Should mirror transform with calc: translate3d',
    'expected': 'div { transform: translate3d(-webkit-calc(-1*(((25%/2) * 10px))))), 50%, calc(((25%/2) * 10px))))); }',
    'input': 'div { transform: translate3d(-webkit-calc(((25%/2) * 10px)))), 50%, calc(((25%/2) * 10px))))); }',
    'reversable': false
  },
  {
    'should': 'Should mirror transform : rotate',
    'expected': 'div { transform: rotate(-20.75deg); }',
    'input': 'div { transform: rotate(20.75deg); }',
    'reversable': true
  },
  {
    'should': 'Should mirror transform (with no digits before dot): rotate',
    'expected': 'div { transform: rotate(-0.75deg); }',
    'input': 'div { transform: rotate(.75deg); }',
    'reversable': false
  },
  {
    'should': 'Should mirror transform with calc: rotate',
    'expected': 'div { transform: rotate(calc(-1*(((25%/2) * 10deg)))); }',
    'input': 'div { transform: rotate(calc(((25%/2) * 10deg))); }',
    'reversable': false
  },
  {
    'should': 'Should mirror transform : rotate3d',
    'expected': 'div { transform: rotate3d(10, -20.15, 10, -45.14deg); }',
    'input': 'div { transform: rotate3d(10, 20.15, 10, 45.14deg); }',
    'reversable': true
  },
  {
    'should': 'Should mirror transform (with no digits before dot): rotate3d',
    'expected': 'div { transform: rotate3d(10, -20, 10, -0.14deg); }',
    'input': 'div { transform: rotate3d(10, 20, 10, .14deg); }',
    'reversable': false
  },
  {
    'should': 'Should mirror transform with calc: rotate3d',
    'expected': 'div { transform: rotate3d(10, -20.15, 10, calc(-1*(((25%/2) * 10deg)))); }',
    'input': 'div { transform: rotate3d(10, 20.15, 10, calc(((25%/2) * 10deg))); }',
    'reversable': false
  },
  {
    'should': 'Should not mirror transform : rotateX',
    'expected': 'div { transform: rotateX(45deg); }',
    'input': 'div { transform: rotateX(45deg); }',
    'reversable': false
  },
  {
    'should': 'Should not mirror transform with calc: rotateX',
    'expected': 'div { transform: rotateX(calc(((25%/2) * 10deg))); }',
    'input': 'div { transform: rotateX(calc(((25%/2) * 10deg))); }',
    'reversable': false
  },
  {
    'should': 'Should not mirror transform : rotateY',
    'expected': 'div { transform: rotateY(45deg); }',
    'input': 'div { transform: rotateY(45deg); }',
    'reversable': false
  },
  {
    'should': 'Should not mirror transform with calc: rotateY',
    'expected': 'div { transform: rotateY(calc(((25%/2) * 10deg))); }',
    'input': 'div { transform: rotateY(calc(((25%/2) * 10deg))); }',
    'reversable': false
  },
  {
    'should': 'Should mirror transform : rotateZ',
    'expected': 'div { transform: rotateZ(-45.75deg); }',
    'input': 'div { transform: rotateZ(45.75deg); }',
    'reversable': true
  },
  {
    'should': 'Should mirror transform (with no digits before dot): rotateZ',
    'expected': 'div { transform: rotateZ(-0.75deg); }',
    'input': 'div { transform: rotateZ(.75deg); }',
    'reversable': false
  },
  {
    'should': 'Should mirror transform with calc: rotateZ',
    'expected': 'div { transform: rotateZ(-ms-calc(-1*(((25%/2) * 10deg)))); }',
    'input': 'div { transform: rotateZ(-ms-calc(((25%/2) * 10deg))); }',
    'reversable': false
  },
  {
    'should': 'Should mirror transform : skew',
    'expected': 'div { transform: skew(-20.25rad,-30deg); }',
    'input': 'div { transform: skew(20.25rad,30deg); }',
    'reversable': true
  },
  {
    'should': 'Should mirror transform (with no digits before dot): skew',
    'expected': 'div { transform: skew(-0.25rad,-30deg); }',
    'input': 'div { transform: skew(.25rad,30deg); }',
    'reversable': false
  },
  {
    'should': 'Should mirror transform with calc: skew',
    'expected': 'div { transform: skew(calc(-1*(((25%/2) * 10rad))),calc(-1*(((25%/2) * 10deg)))); }',
    'input': 'div { transform: skew(calc(((25%/2) * 10rad)),calc(((25%/2) * 10deg))); }',
    'reversable': false
  },
  {
    'should': 'Should mirror transform : skewX',
    'expected': 'div { transform: skewX(-20.75rad); }',
    'input': 'div { transform: skewX(20.75rad); }',
    'reversable': true
  },
  {
    'should': 'Should mirror transform (with no digits before dot): skewX',
    'expected': 'div { transform: skewX(-0.75rad); }',
    'input': 'div { transform: skewX(.75rad); }',
    'reversable': false
  },
  {
    'should': 'Should mirror transform with calc: skewX',
    'expected': 'div { transform: skewX(-moz-calc(-1*(((25%/2) * 10rad)))); }',
    'input': 'div { transform: skewX(-moz-calc(((25%/2) * 10rad))); }',
    'reversable': false
  },
  {
    'should': 'Should mirror transform : skewY',
    'expected': 'div { transform: skewY(-10.75grad); }',
    'input': 'div { transform: skewY(10.75grad); }',
    'reversable': true
  },
  {
    'should': 'Should mirror transform (with no digits before dot): skewY',
    'expected': 'div { transform: skewY(-0.75grad); }',
    'input': 'div { transform: skewY(.75grad); }',
    'reversable': false
  },
  {
    'should': 'Should mirror transform with calc: skewY',
    'expected': 'div { transform: skewY(calc(-1*(((25%/2) * 10grad)))); }',
    'input': 'div { transform: skewY(calc(((25%/2) * 10grad))); }',
    'reversable': false
  },
  {
    'should': 'Should mirror multiple transforms : translateX translateY Rotate',
    'expected': 'div { transform: translateX(-50.25px) translateY(50.25px) rotate(-20.75deg); }',
    'input': 'div { transform: translateX(50.25px) translateY(50.25px) rotate(20.75deg); }',
    'reversable': true
  },
  {
    'should': 'Should mirror multiple transforms with calc : translateX translateY Rotate',
    'expected': 'div { transform: translateX(-ms-calc(-1*(((25%/2) * 10px)))) translateY(-moz-calc(((25%/2) * 10rad))) rotate(calc(-1*(((25%/2) * 10grad)))); }',
    'input': 'div { transform: translateX(-ms-calc(((25%/2) * 10px))) translateY(-moz-calc(((25%/2) * 10rad))) rotate(calc(((25%/2) * 10grad))); }',
    'reversable': false
  }
]
