import 'package:flutter/material.dart';
import 'screen/home.dart';
import 'screen/login.dart';


void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
    ));

final routes = {
  '/': (BuildContext context) => new Login(),
  '/home': (BuildContext context) => new Home(),
};

