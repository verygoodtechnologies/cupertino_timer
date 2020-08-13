# cupertino_timer

An iOS style timer widget.

## Usage


### Basic
```
CupertinoTimer(duration: new Duration(minutes: 1))
```
![Basic](https://github.com/verygoodtechnologies/cupertino_timer/blob/master/example/images/Basic.png?raw=true)

### Advanced
```
CupertinoTimer(
    duration: Duration(minutes: 1),
    startOnInit: true,
    timeStyle: TextStyle(
        fontFamily: 'Avenir Next',
        fontWeight: FontWeight.bold),
    ringColor: Colors.blue,
    ringStroke: 10)
```
![Advanced](https://github.com/verygoodtechnologies/cupertino_timer/blob/master/example/images/Advanced.png?raw=true)