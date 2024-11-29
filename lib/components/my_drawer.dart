import 'package:flutter/material.dart';

import '../screens/setting_page.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          DrawerHeader(child: Icon(Icons.headphones, size: 50,)),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 25.0),
            child: ListTile(
              title:  Text('H O M E'),
              leading: const Icon(Icons.home, color: Colors.grey,),
              onTap: (){
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 0),
            child: ListTile(
              title:  Text('S E T T I N G S'),
              leading: const Icon(Icons.settings, color: Colors.grey,),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => MySettings()

                ));
              },
            ),
          )
        ],
      ),
    );
  }
}
