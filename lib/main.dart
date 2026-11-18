import 'package:flutter/material.dart';
import 'core/routes.dart';
import 'core/theme.dart';

void main() => runApp(const MusintoApp());

class MusintoApp extends StatelessWidget {
  const MusintoApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Musinto',
        theme: buildTheme(),
        initialRoute: Routes.splash,
        routes: Routes.table,
      );
}
