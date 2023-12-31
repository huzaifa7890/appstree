import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'homepage/homepage.dart';
import 'provider/productprovider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Appstree',
        home: HomePage(),
      ),
    );
  }
}
