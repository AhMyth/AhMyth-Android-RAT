# homedir

[![Build Status](http://img.shields.io/travis/wilmoore/node-homedir.svg)](https://travis-ci.org/wilmoore/node-homedir) [![NPM version](http://img.shields.io/npm/v/homedir.svg)](https://www.npmjs.org/package/homedir) [![NPM downloads](http://img.shields.io/npm/dm/homedir.svg)](https://www.npmjs.org/package/homedir) [![LICENSE](http://img.shields.io/npm/l/homedir.svg)](license)

  Platform agnostic user home directory path resolution (i.e. `man 5 passwd`) for [Node.js][].

> The user's home directory. This is the full path name where the user will be placed on login.

#### OSX

    homedir();
    #=> /Users/wilmoore

    homedir('Guest');
    #=> /Users/Guest

#### Windows

    homedir();
    #=> C:\Users\wilmoore

    homedir('Public');
    #=> C:\Users\Public

#### Linux

    homedir();
    #=> /home/wilmoore

    homedir('guest');
    #=> /home/guest

## Installation

    npm install homedir --save

## Alternatives

- [userhome][]
- [home-dir][]


## License

  [MIT](LICENSE)

[userhome]: https://www.npmjs.org/package/userhome
[home-dir]: https://www.npmjs.org/package/home-dir
[Node.js]:  http://nodejs.org

