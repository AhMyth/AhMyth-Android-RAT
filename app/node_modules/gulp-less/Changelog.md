
### 3.2.0

 * Update package.json to skip the problematic 2.7.0 release of less. Use 2.6.x or 2.7.1 instead
 * bump dependencies on accord, mocha and should

### 3.1.0

 * Upgrade accord dependency
 * remove CSS minifier recommendation from README
 * Upgrade Less dependency from 2.5.1 to 2.6.0

### 3.0.5

 * BugFix: fix dynamic imports broken in the 3.0.4 release

### 3.0.4

 * Fix the error passing in the stream (#198)
 * Update dependencies

### 3.0.3

 * Make sourcemap file and sources relative (#161)

### 3.0.2

 * Upgrade Less to 2.4.0 (#157)

### 3.0.1

 - Bumped accord version to 0.15.1 to fix #122

### 3.0.0

 - Switch to using [accord](https://github.com/jenius/accord) for options parsing

### 2.0.3

 - Fix less errors by using promises correctly
 - Fix option merging, object.assign was used incorrectly

### 2.0.1

Revert moving the replaceExt to after sourcemaps are applied

### 2.0.0

Update to Less 2.0
