# Gulp prompt

Add interaction to gulp tasks.

## .confirm([options])

Options:

 - **message** - Message to be displayed
 - **default** - Default response if none is provided

This method will allow the pipe to continue if the user input is true, otherwise, it will be terminated.

Default usage:
```javascript

gulp.src('test.js')
	.pipe(prompt.confirm())
	.pipe(gulp.dest('dest'));

```

If a string is provided to the options, it will be set as the message:
```javascript

gulp.src('test.js')
	.pipe(prompt.confirm('Are you ready for Gulp?'))
	.pipe(gulp.dest('dest'));

```

Example when using options:
```javascript

gulp.src('test.js')
	.pipe(prompt.confirm({
		message: 'Continue?',
		default: true
	}))
	.pipe(gulp.dest('dest'));

```

## .prompt(questions, callback)

This is a clean pass-through function for gulp to utilize the full [Inquirer.js Library](https://github.com/SBoudrias/Inquirer.js), please refer to them for documentation on corresponding parameters.

Please note that all types are avaiable, not just the examples below.

Example Input:
```javascript

gulp.src('test.js')
	.pipe(prompt.prompt({
		type: 'input',
		name: 'task',
		message: 'Which task would you like to run?'
	}, function(res){
		//value is in res.task (the name option gives the key)
	}));

```

Example Checkbox:
```javascript

gulp.src('test.js')
	.pipe(prompt.prompt({
		type: 'checkbox',
		name: 'bump',
		message: 'What type of bump would you like to do?',
		choices: ['patch', 'minor', 'major']
	}, function(res){
		//value is in res.bump (as an array)
	}));

```

Example Password:
```javascript

gulp.src('test.js')
	.pipe(prompt.prompt({
		type: 'password',
		name: 'pass',
		message: 'Please enter your password'
	}, function(res){
		//value is in res.pass
	}));

```

Example Multiple:
```javascript

gulp.src('test.js')
	.pipe(prompt.prompt([{
		type: 'input',
		name: 'first',
		message: 'First question?'
	},
	{
		type: 'input',
		name: 'second',
		message: 'Second question?'
	}], function(res){
		//value is in res.first and res.second
	}));

```

Example Validation:
```javascript

gulp.src('test.js')
	.pipe(prompt.prompt({
		type: 'password',
		name: 'pass',
		message: 'Please enter your password',
		validate: function(pass){

			if(pass !== '123456'){
				return false;
			}

			return true;
		}
	}, function(res){
		//value is in res.pass
	}));

```
