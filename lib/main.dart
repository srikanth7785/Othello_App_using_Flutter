import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './IntroductionPage.dart';
void main()
{
  SystemChrome.setPreferredOrientations(
  [
    DeviceOrientation.portraitUp
  ]
);
  runApp(new MaterialApp(
    title: "Othello",
    home: IntroPage(),
  ));
}
