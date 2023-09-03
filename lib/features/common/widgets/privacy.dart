import 'package:flutter/material.dart';
import 'dart:io';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({super.key});

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  String fileContents = 'Loading...';

  @override
  void initState() {
    super.initState();
    _loadFileContents();
  }

  Future<void> _loadFileContents() async {
    final contents = await readFileContents();
    setState(() {
      fileContents = contents;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Read Text File'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(fileContents),
        ),
      ),
    );
  }

  Future<String> readFileContents() async {
    try {
      final file = File('assets/privacy.txt');

      if (await file.exists()) {
        final contents = await file.readAsString();
        return contents;
      } else {
        return 'File not found at ${file.path}';
      }
    } catch (e) {
      return 'Error reading file: $e';
    }
  }
}
