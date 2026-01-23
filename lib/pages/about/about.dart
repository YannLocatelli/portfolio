// Core
import 'package:flutter/material.dart';

// External
import 'package:go_router/go_router.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            context.go("/");
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("About"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [const Text('About')],
        ),
      ),
    );
  }
}
