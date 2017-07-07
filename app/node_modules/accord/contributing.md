Contributing
------------

Anything that people should know before filing issues or opening pull requests should be here. This is a good place to put details on coding conventions, how to build the project, and how to run tests.

### Filing Issues

If you have found an issue with this library, please let us know! Make sure that before you file an issue, you have searched to see if someone else has already opened it. When opening the issue, make sure there's a clear and concise title and description, and that the description contains specific steps that can be followed to reproduce the issue you are experiencing. Following these guidelines will get your issue fixed up the quickest!

If you are making a feature request, that is welcome in the issues section as well. Make sure again that the title and issue summary are clear so that we can understand what you're asking for. Any use cases would also help. And if you are requesting a feature and are able to work with javscript code, please consider submitting a pull request for the feature!

### Pull Requests

When submitting a pull request, make sure that the code follows the general style and structure elsewhere in the library, that your commit messages are [well-formed](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html), and that you have added tests for whatever feature you are adding.

### Running Tests

To run tests, make sure you have `npm install`ed, then just run `mocha` in the root. If you'd like to run tests just for one specific adapter, you can use mocha's grep option, like this `mocha -g jade` - this would run just the jade test suite.

The way tests are set up is fairly simple, a folder in `fixtures` and a `describe` block for each adapter. All tests are currently compared to expected output through an pure javascript AST, to ensure compatibility across systems.
