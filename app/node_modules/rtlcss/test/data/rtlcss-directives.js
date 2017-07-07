module.exports = [
  {
    'should': 'Should auto rename selectors having no directional decl. unless forced to ignore. (autoRename:true)',
    'expected': '.right .rtl .bright .ultra { display:block; }',
    'input': '/*rtl:ignore*/ .right .rtl .bright .ultra { display:block; }',
    'reversable': false,
    'options': { 'autoRename': true }
  },
  {
    'should': 'Should auto rename selectors having no directional decl. unless forced to ignore. (autoRename:true, clean: false)',
    'expected': '/*rtl:ignore*/ .right .rtl .bright .ultra { display:block; }',
    'input': '/*rtl:ignore*/ .right .rtl .bright .ultra { display:block; }',
    'reversable': false,
    'options': { 'autoRename': true, 'clean': false }
  },
  {
    'should': 'Should auto rename selectors having no directional decl. unless forced to ignore. (autoRename:true, !important comment)',
    'expected': '.right .rtl .bright .ultra { display:block; }',
    'input': '/*!rtl:ignore*/ .right .rtl .bright .ultra { display:block; }',
    'reversable': false,
    'options': { 'autoRename': true }
  },
  {
    'should': 'Should auto rename selectors having no directional decl. unless forced to ignore. (autoRename:true, clean:false, !important comment)',
    'expected': '/*!rtl:ignore*/ .right .rtl .bright .ultra { display:block; }',
    'input': '/*!rtl:ignore*/ .right .rtl .bright .ultra { display:block; }',
    'reversable': false,
    'options': { 'autoRename': true, 'clean': false }
  },
  {
    'should': 'Should auto rename selectors having no directional decl. unless forced to ignore. (autoRename:true,greedy)',
    'expected': '.right .rtl .bright .ultra { display:block; }',
    'input': '/*rtl:ignore*/ .right .rtl .bright .ultra { display:block; }',
    'reversable': false,
    'options': { 'autoRename': true, 'greedy': true }
  },
  {
    'should': 'Should auto rename selectors having no directional decl. unless forced to ignore. (autoRename:true, greedy, !important comment)',
    'expected': '.right .rtl .bright .ultra { display:block; }',
    'input': '/*!rtl:ignore*/ .right .rtl .bright .ultra { display:block; }',
    'reversable': false,
    'options': { 'autoRename': true, 'greedy': true }
  },
  {
    'should': 'Should rename selectors when forced. (default)',
    'expected': '.left .ltr .bright .ultra { display:block; }',
    'input': '/*rtl:rename*/.right .rtl .bright .ultra { display:block; }',
    'reversable': false
  },
  {
    'should': 'Should rename selectors when forced. (clean:false)',
    'expected': '/*rtl:rename*/.left .ltr .bright .ultra { display:block; left:0;}',
    'input': '/*rtl:rename*/.right .rtl .bright .ultra { display:block; right:0;}',
    'reversable': false,
    'options': { 'clean': false }
  },
  {
    'should': 'Should rename selectors when forced. (!important comment)',
    'expected': '.left .ltr .bright .ultra { display:block; left:0; }',
    'input': '/*!rtl:rename*/.right .rtl .bright .ultra { display:block; right:0; }',
    'reversable': false
  },
  {
    'should': 'Should rename selectors when forced. (clean:false, !important comment)',
    'expected': '/*!rtl:rename*/.left .ltr .bright .ultra { display:block; left:0; }',
    'input': '/*!rtl:rename*/.right .rtl .bright .ultra { display:block; right:0; }',
    'reversable': false,
    'options': { 'clean': false }
  },
  {
    'should': 'Should rename selectors when forced. (greedy)',
    'expected': '.left .ltr .bleft .urtla { display:block; left:0; }',
    'input': '/*rtl:rename*/.right .rtl .bright .ultra { display:block; right:0; }',
    'reversable': false,
    'options': { 'greedy': true }
  },
  {
    'should': 'Should rename selectors when forced. (greedy, !important comment)',
    'expected': '.left .ltr .bleft .urtla { display:block; left:0; }',
    'input': '/*!rtl:rename*/.right .rtl .bright .ultra { display:block; right:0; }',
    'reversable': false,
    'options': { 'greedy': true }
  },
  {
    'should': 'Should prepend value. (default)',
    'expected': 'div { font-family: "Droid Arabic Kufi", "Droid Sans", Tahoma; }',
    'input': 'div { font-family: "Droid Sans", Tahoma/*rtl:prepend:"Droid Arabic Kufi", */; }',
    'reversable': false
  },
  {
    'should': 'Should prepend value. (clean:false)',
    'expected': 'div { font-family: "Droid Arabic Kufi", "Droid Sans", Tahoma/*rtl:prepend:"Droid Arabic Kufi", */; }',
    'input': 'div { font-family: "Droid Sans", Tahoma/*rtl:prepend:"Droid Arabic Kufi", */; }',
    'reversable': false,
    'options': { 'clean': false }
  },
  {
    'should': 'Should prepend value (!important comment)',
    'expected': 'div { font-family: "Droid Arabic Kufi", "Droid Sans", Tahoma; }',
    'input': 'div { font-family: "Droid Sans", Tahoma/*!rtl:prepend:"Droid Arabic Kufi", */; }',
    'reversable': false
  },
  {
    'should': 'Should prepend value (clean:false, !important comment)',
    'expected': 'div { font-family: "Droid Arabic Kufi", "Droid Sans", Tahoma/*!rtl:prepend:"Droid Arabic Kufi", */; }',
    'input': 'div { font-family: "Droid Sans", Tahoma/*!rtl:prepend:"Droid Arabic Kufi", */; }',
    'reversable': false,
    'options': { 'clean': false }
  },
  {
    'should': 'Should replace value.',
    'expected': 'div { font-family: "Droid Arabic Kufi"; }',
    'input': 'div { font-family: "Droid Sans", Tahoma/*rtl:"Droid Arabic Kufi"*/; }',
    'reversable': false
  },
  {
    'should': 'Should replace value.(clean:false)',
    'expected': 'div { font-family: "Droid Arabic Kufi"/*rtl:"Droid Arabic Kufi"*/; }',
    'input': 'div { font-family: "Droid Sans", Tahoma/*rtl:"Droid Arabic Kufi"*/; }',
    'reversable': false,
    'options': { 'clean': false }
  },
  {
    'should': 'Should replace value. (!important comment)',
    'expected': 'div { font-family: "Droid Arabic Kufi"; }',
    'input': 'div { font-family: "Droid Sans", Tahoma/*!rtl:"Droid Arabic Kufi"*/; }',
    'reversable': false
  },
  {
    'should': 'Should replace value. (clean:false, !important comment)',
    'expected': 'div { font-family: "Droid Arabic Kufi"/*!rtl:"Droid Arabic Kufi"*/; }',
    'input': 'div { font-family: "Droid Sans", Tahoma/*!rtl:"Droid Arabic Kufi"*/; }',
    'reversable': false,
    'options': { 'clean': false }
  },
  {
    'should': 'Should append value. (default)',
    'expected': 'div { font-family: "Droid Sans", Tahoma, "Droid Arabic Kufi"; }',
    'input': 'div { font-family: "Droid Sans", Tahoma/*rtl:append:, "Droid Arabic Kufi"*/; }',
    'reversable': false
  },
  {
    'should': 'Should append value. (clean:false)',
    'expected': 'div { font-family: "Droid Sans", Tahoma/*rtl:append:, "Droid Arabic Kufi"*/, "Droid Arabic Kufi"; }',
    'input': 'div { font-family: "Droid Sans", Tahoma/*rtl:append:, "Droid Arabic Kufi"*/; }',
    'reversable': false,
    'options': { 'clean': false }
  },
  {
    'should': 'Should append value. (!important comment)',
    'expected': 'div { font-family: "Droid Sans", Tahoma, "Droid Arabic Kufi"; }',
    'input': 'div { font-family: "Droid Sans", Tahoma/*!rtl:append:, "Droid Arabic Kufi"*/; }',
    'reversable': false
  },
  {
    'should': 'Should append value. (clean:false, !important comment)',
    'expected': 'div { font-family: "Droid Sans", Tahoma/*!rtl:append:, "Droid Arabic Kufi"*/, "Droid Arabic Kufi"; }',
    'input': 'div { font-family: "Droid Sans", Tahoma/*!rtl:append:, "Droid Arabic Kufi"*/; }',
    'reversable': false,
    'options': { 'clean': false }
  },
  {
    'should': 'Should insert value. (default)',
    'expected': 'div { font-family: "Droid Sans", "Droid Arabic Kufi", Tahoma; }',
    'input': 'div { font-family: "Droid Sans"/*rtl:insert:, "Droid Arabic Kufi"*/, Tahoma; }',
    'reversable': false
  },
  {
    'should': 'Should insert value. (clean:false)',
    'expected': 'div { font-family: "Droid Sans", "Droid Arabic Kufi"/*rtl:insert:, "Droid Arabic Kufi"*/, Tahoma; }',
    'input': 'div { font-family: "Droid Sans"/*rtl:insert:, "Droid Arabic Kufi"*/, Tahoma; }',
    'reversable': false,
    'options': { 'clean': false }
  },
  {
    'should': 'Should insert value. (!important comment)',
    'expected': 'div { font-family: "Droid Sans", "Droid Arabic Kufi", Tahoma; }',
    'input': 'div { font-family: "Droid Sans"/*!rtl:insert:, "Droid Arabic Kufi"*/, Tahoma; }',
    'reversable': false
  },
  {
    'should': 'Should insert value. (clean:false, !important comment)',
    'expected': 'div { font-family: "Droid Sans", "Droid Arabic Kufi"/*!rtl:insert:, "Droid Arabic Kufi"*/, Tahoma; }',
    'input': 'div { font-family: "Droid Sans"/*!rtl:insert:, "Droid Arabic Kufi"*/, Tahoma; }',
    'reversable': false,
    'options': { 'clean': false }
  },
  {
    'should': 'Should ignore flipping - rule level (default)',
    'expected': 'div { left:10px; text-align:right;}',
    'input': '/*rtl:ignore*/div { left:10px; text-align:right;}',
    'reversable': false
  },
  {
    'should': 'Should ignore flipping - rule level (clean:false)',
    'expected': '/*rtl:ignore*/div { left:10px; text-align:right;}',
    'input': '/*rtl:ignore*/div { left:10px; text-align:right;}',
    'reversable': false,
    'options': { 'clean': false }
  },
  {
    'should': 'Should ignore flipping - rule level (default, !important comment)',
    'expected': 'div { left:10px; text-align:right;}',
    'input': '/*!rtl:ignore*/div { left:10px; text-align:right;}',
    'reversable': false
  },
  {
    'should': 'Should ignore flipping - rule level (clean:false , !important comment)',
    'expected': '/*!rtl:ignore*/div { left:10px; text-align:right;}',
    'input': '/*!rtl:ignore*/div { left:10px; text-align:right;}',
    'reversable': false,
    'options': { 'clean': false }
  },
  {
    'should': 'Should ignore flipping - decl. level (default)',
    'expected': 'div { left:10px;text-align:left;}',
    'input': 'div { left:10px/*rtl:ignore*/;text-align:right;}',
    'reversable': false
  },
  {
    'should': 'Should ignore flipping - decl. level (clean:false)',
    'expected': 'div { left:10px/*rtl:ignore*/;text-align:left;}',
    'input': 'div { left:10px/*rtl:ignore*/;text-align:right;}',
    'reversable': false,
    'options': { 'clean': false }
  },
  {
    'should': 'Should ignore flipping - decl. level (default, !important comment)',
    'expected': 'div { left:10px;text-align:left;}',
    'input': 'div { left:10px/*!rtl:ignore*/;text-align:right;}',
    'reversable': false
  },
  {
    'should': 'Should ignore flipping - decl. level (clean:false, !important comment)',
    'expected': 'div { left:10px/*!rtl:ignore*/;text-align:left;}',
    'input': 'div { left:10px/*!rtl:ignore*/;text-align:right;}',
    'options': { 'clean': false }
  },
  {
    'should': 'Should add raw css rules',
    'expected': 'div {left:10px;text-align:right;} a {display:block;}',
    'input': '/*rtl:raw: div { left:10px;text-align:right;}*/ a {display:block;}',
    'reversable': false
  },
  {
    'should': 'Should add raw css declarations',
    'expected': 'div { font-family:"Droid Kufi Arabic"; right:10px;text-align:left;}',
    'input': 'div { /*rtl:raw: font-family: "Droid Kufi Arabic";*/ left:10px;text-align:right;}',
    'reversable': false
  },
  {
    'should': 'Should add raw css (clean:false)',
    'expected': 'div {left:10px;text-align:right;} /*rtl:raw: div { left:10px;text-align:right;}*/ a {display:block;}',
    'input': '/*rtl:raw: div { left:10px;text-align:right;}*/ a {display:block;}',
    'reversable': false,
    'options': { 'clean': false }
  },
  {
    'should': 'Should add raw css declarations (clean:false)',
    'expected': 'div { font-family:"Droid Kufi Arabic"; /*rtl:raw: font-family: "Droid Kufi Arabic";*/ right:10px;text-align:left;}',
    'input': 'div { /*rtl:raw: font-family: "Droid Kufi Arabic";*/ left:10px;text-align:right;}',
    'reversable': false,
    'options': { 'clean': false }
  },
  {
    'should': 'Should support block-style',
    'expected': ' div {left:10px; text-align:right;}',
    'input': ' div {/*rtl:begin:ignore*/left:10px;/*rtl:end:ignore*/ text-align:left;}',
    'reversable': false
  },
  {
    'should': 'Should support none block-style',
    'expected': ' div {left:10px; text-align:left;}',
    'input': ' /*rtl:ignore*/div {left:10px; text-align:left;}',
    'reversable': false
  },
  {
    'should': 'Should remove rules (block-style)',
    'expected': ' b{float:right;}',
    'input': ' /*rtl:begin:remove*/div {left:10px; text-align:left;} a { display:block;} /*rtl:end:remove*/ b{float:left;}',
    'reversable': false
  },
  {
    'should': 'Should remove rules',
    'expected': ' a { display:block;} b{float:right;}',
    'input': ' /*rtl:remove*/div {left:10px; text-align:left;} a { display:block;} b{float:left;}',
    'reversable': false
  },
  {
    'should': 'Should remove declarations',
    'expected': ' div { text-align:right;}',
    'input': ' div {/*rtl:remove*/left:10px; text-align:left;}',
    'reversable': false
  },
  {
    'should': 'Should remove declarations (block-style)',
    'expected': ' div { display:inline;}',
    'input': ' div {/*rtl:begin:remove*/left:10px; text-align:left;/*rtl:end:remove*/ display:inline;}',
    'reversable': false
  },
  {
    'should': 'Should override options',
    'expected': '.right { display:inline;}',
    'input': '/*rtl:options:{"autoRename":false}*/ .right { display:inline;}',
    'reversable': false,
    'options': { 'autoRename': true }
  },
  {
    'should': 'Should support nested options override',
    'expected': '.right { display:inline;}.bleft { display:inline;}',
    'input': '/*rtl:begin:options:{"autoRename":false}*/ .right { display:inline;} /*rtl:begin:options:{"autoRename":true, "greedy": true}*/.bright { display:inline;}/*rtl:end:options*//*rtl:end:options*/',
    'reversable': false,
    'options': { 'autoRename': true }
  },
  {
    'should': 'Should ignore the target node (decl)',
    'expected': `
    .code {
      direction:ltr;
      text-align:left;
      float: right;
      text-align: left;
    }
    `,
    'input': `
    .code {
      /*rtl:ignore*/
      direction:ltr;
      /*rtl:ignore*/
      text-align:left;
      /*rtl:ignore*/
      float: right;
      /*rtl:ignore*/
      text-align: left;
    }
    `,
    'reversable': false
  },
  {
    'should': 'Should ignore the target node (rule)',
    'expected': `
      .example-1 {
        text-align:right;
        left:10px;
      }
      .example-2 {
        left:10px;
        text-align:right;
      }
      .example-3 {
        right:10px;
        text-align:left;
      }
    `,
    'input': `
      /*rtl:ignore*/
      .example-1 {
        text-align:right;
        left:10px;
      }
      /*rtl:ignore*/
      .example-2 {
        left:10px;
        text-align:right;
      }
      .example-3 {
        left:10px;
        text-align:right;
      }
    `,
    'reversable': false
  },
  {
    'should': 'Should ignore the target node (atrule)',
    'expected': `
      @media screen and (max-width: 568px) {
        .example {
          left:10px;
          text-align:right;
        }
      }

      @media screen and (max-width: 568px) {
        .example {
          right:10px;
          text-align:left;
        }
      }
    `,
    'input': `
      /*rtl:ignore*/
      @media screen and (max-width: 568px) {
        .example {
          left:10px;
          text-align:right;
        }
      }

      @media screen and (max-width: 568px) {
        .example {
          left:10px;
          text-align:right;
        }
      }
    `,
    'reversable': false
  }
]
