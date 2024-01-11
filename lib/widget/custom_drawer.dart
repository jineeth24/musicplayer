import 'package:flutter/material.dart';

import '../screens/settings_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DrawerHeader(
            child: Center(
              child: Icon(
                Icons.music_note,
                size: 40,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          //home tile
           Padding(
            padding:const EdgeInsets.only(left: 25, top: 0),
            child: ListTile(
              title: const Text("Home"),
              leading:const Icon(Icons.home),
              onTap: () => Navigator.pop(context),
            ),
          ),

          //setting tile
           Padding(
            padding:const EdgeInsets.only(left: 25, top: 0),
            child: ListTile(
              title: const Text("settings"),
              leading:const Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(builder: ((context) => SettingsScreen())));
              },
            ),
          ),
        ],
      ),
    );
  }
}
