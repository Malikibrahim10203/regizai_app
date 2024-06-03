import 'package:flutter/material.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({Key? key, required this.picture, required this.apiResponse}) : super(key: key);

  final picture;
  final apiResponse;

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
