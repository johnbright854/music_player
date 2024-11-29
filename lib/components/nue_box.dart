import 'package:flutter/material.dart';
import 'package:music_player/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class NueBox extends StatelessWidget {
  final Widget? child;
  const NueBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {

    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Container(
      padding: EdgeInsets.all(20),
      child: child,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              //darker shadow on bottom right
              color: isDarkMode ? Colors.black : Colors.grey.shade500,
              blurRadius: 15,
              offset: const Offset(4, 4)
            ),
            BoxShadow(
              //darker shadow on bottom right
                color: isDarkMode ? Colors.grey.shade800 : Colors.white,
                blurRadius: 15,
                offset: const Offset(-4, -4)
            )
          ]
      ),

    );
  }
}
