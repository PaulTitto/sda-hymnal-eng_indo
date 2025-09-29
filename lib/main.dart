import 'package:flutter/material.dart';

import 'router/router_delegate.dart';

void main() {
  runApp(const SdaHymnalApp());
}

class SdaHymnalApp extends StatefulWidget {
  const SdaHymnalApp({super.key});

  @override
  State<SdaHymnalApp> createState() => _SdaHymnalAppState();
}

class _SdaHymnalAppState extends State<SdaHymnalApp> {
  late HymnRouterDelegate _routerDelegate;
  late HymnRouteInformationParser _routeInformationParser;

  @override
  void initState() {
    super.initState();
    _routerDelegate = HymnRouterDelegate();
    _routeInformationParser = HymnRouteInformationParser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SDA Hymnal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}