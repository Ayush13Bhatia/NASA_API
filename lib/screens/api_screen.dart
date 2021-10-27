import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widget/api_item.dart';

class ApiScreen extends StatefulWidget {
  const ApiScreen({Key? key}) : super(key: key);

  @override
  _ApiScreenState createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  @override
  void initState() {
    // Provider.of(context, listen: false).getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pageBody = ApiItem();
    String title = 'NASA API';

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: CupertinoNavigationBar(
              backgroundColor: CupertinoColors.systemOrange,
              middle: Text(title),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: pageBody,
          );
  }
}
