module.exports = {
    env: {
        browser: true,
        commonjs: true,
        es2020: true,
        node: true,
    },
    extends: [
        'airbnb-base',
    ],
    parserOptions: {
        ecmaVersion: 11,
    },
    rules: {
        indent: ['error', 4],
        quotes: ['error', 'single'],
    },
    globals: {
        angulaer: 'writable',
        electron: 'writable',
        $appCtrl: 'writable',
        logStatus: 'writable',
    },
};
