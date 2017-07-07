rework-plugin-url
====================

[![Build Status](https://travis-ci.org/reworkcss/rework-plugin-url.png)](https://travis-ci.org/reworkcss/rework-plugin-url)

Map `url()` calls. Replace all `url()`s using a given function.

```js
var css = rework(read(css))
  .use(rework.url(function(url){
    return 'http://example.com' + url;
  }))
  .toString()
```

```css
body {
  background: url(/images/bg.png);
}
```

yields:

```css
body {
  background: url(http://example.com/images/bg.png);
}
```
