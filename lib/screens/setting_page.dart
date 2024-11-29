import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class MySettings extends StatefulWidget {
  const MySettings({super.key});

  @override
  State<MySettings> createState() => _MySettingsState();
}

class _MySettingsState extends State<MySettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text('S E T T I N G S'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, borderRadius: BorderRadius.circular(15)),
          child: Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Dark Mode', style: TextStyle(fontSize: 18),),
              CupertinoSwitch(
                  value: Provider.of<ThemeProvider>(context, listen: true).isDarkMode,
                  onChanged: (value)=>
                      Provider.of<ThemeProvider>(context, listen: false).toggleTheme()),
            ],
          ),
        ),
      ),
    );
  }
}
