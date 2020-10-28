import 'package:flutter/material.dart';
import 'pages/app.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'Tic Tac Toe',
  theme: ThemeData(primarySwatch: Colors.deepPurple),
  home: MyApp(),
));