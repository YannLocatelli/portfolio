// Core
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// External
import 'package:portfolio/services/storage.dart';

// Portfolio
import 'package:portfolio/supports/globals.dart' as globals;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? imageURL;

  @override
  void initState() {
    super.initState();

    syncStorage();
  }

  void syncStorage() async {
    final url = await FirebaseStorageService.getTestFile();
    setState(() {
      imageURL = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Yann Locatelli"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            if (imageURL != null)
              Image.network(
                imageURL!,
                fit: BoxFit.cover,
                webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
              ),
            Text('Is online: ${globals.maintenanceEnabled == false}'),
            TextButton(
              onPressed: () => context.push("/about"),
              child: Text("Go About"),
            ),
          ],
        ),
      ),
    );
  }
}
