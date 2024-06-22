import 'package:flutter/material.dart';
import 'package:mismatchh/presentation/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Consumer<ThemeProvider>(
        builder: (BuildContext context, provider, Widget? child) {
          return Switch.adaptive(
              activeColor: Colors.red,
              inactiveThumbColor: Colors.green,
              applyCupertinoTheme: true,
              value: provider.isDarkMode, onChanged: (value) {
            provider.toggleTheme();
          });
        },
      ),
    );
  }
}
