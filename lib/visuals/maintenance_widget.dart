// Core
import 'package:flutter/material.dart';

// Portfolio
import 'package:portfolio/supports/theme.dart';
import 'package:portfolio/services/storage.dart';

class MaintenanceWidget extends StatefulWidget {
  final String message;

  const MaintenanceWidget({super.key, this.message = "En maintenance..."});

  @override
  State<MaintenanceWidget> createState() => _MaintenanceWidgetState();
}

class _MaintenanceWidgetState extends State<MaintenanceWidget> {
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
    return Center(
      child: Column(
        mainAxisAlignment: .center,
        children: [
          Text(
            widget.message,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: normalPrimary),
          ),
          SizedBox(height: 20),
          if (imageURL != null)
            Image.network(
              imageURL!,
              fit: .cover,
              webHtmlElementStrategy: .prefer,
            ),
        ],
      ),
    );
  }
}
