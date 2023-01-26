import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
