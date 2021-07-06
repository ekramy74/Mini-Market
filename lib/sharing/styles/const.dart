import 'package:flutter/material.dart';
import 'package:mini_market/modules/login/login.dart';
import 'package:mini_market/network/local/cache_helper.dart';
import 'package:mini_market/sharing/components/components.dart';

const defaultcolor = Colors.indigo;

void signout(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    navigateandFinish(context, LoginScreen());
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';
