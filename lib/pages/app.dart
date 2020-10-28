import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<List> _matrix;
  String _lastChar = 'O';
  String _result = 'Welcome !!';

  _MyAppState() {
    _init();
  }
  void _init() {
    _matrix = List<List>(3);
    for (var i = 0; i < _matrix.length; i++) {
      _matrix[i] = List(3);
      for (var j = 0; j < _matrix[i].length; j++) {
        _matrix[i][j] = '';
      }
    }

    _lastChar = 'O';
    _result = 'Welcome !!';
  }

  void _change(int x, int y) {
    setState(() {
      if (_matrix[x][y] == '') {
        if (_lastChar == 'O') {
          _matrix[x][y] = 'X';
        } else {
          _matrix[x][y] = 'O';
        }
        _lastChar = _matrix[x][y];
      }
    });
  }

  void _check(int x, int y) {
    var col = 0, row = 0, diag = 0, rdiag = 0;
    var n = _matrix.length - 1;
    var player = _matrix[x][y];
    for (var i = 0; i < _matrix.length; i++) {
      if (_matrix[x][i] == player) col++;
      if (_matrix[i][y] == player) row++;
      if (_matrix[i][i] == player) diag++;
      if (_matrix[i][n - i] == player) rdiag++;
    }
    bool won = false;
    if (row == n + 1 || col == n + 1 || diag == n + 1 || rdiag == n + 1) {
      setState(() {
        _result = '$player won This Game';
        won = true;
      });
    }
    if (!won) {
      bool tie = true;
      for (var i = 0; i < _matrix.length; i++) {
        for (var j = 0; j < _matrix[i].length; j++) {
          if (_matrix[i][j] == "") {
            tie = false;
            break;
          }
        }
      }
      if (tie) {
        setState(() {
          _result = 'This Game is a Tie';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _result,
              style: TextStyle(
                  fontSize: 30.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildElement(0, 0),
                _buildElement(0, 1),
                _buildElement(0, 2),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildElement(1, 0),
                _buildElement(1, 1),
                _buildElement(1, 2),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildElement(2, 0),
                _buildElement(2, 1),
                _buildElement(2, 2),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _init();
                });
              },
              icon: Icon(
                Icons.highlight_remove_rounded,
                size: 45.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildElement(int x, int y) {
    return GestureDetector(
      onTap: () {
        _change(x, y);
        _check(x, y);
      },
      child: Container(
        width: 90.0,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(color: Colors.deepPurpleAccent)),
        child: Center(
            child: Text(_matrix[x][y],
                style: TextStyle(fontSize: 100.0, color: Colors.purple))),
      ),
    );
  }
}