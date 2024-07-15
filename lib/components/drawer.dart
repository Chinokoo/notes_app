import 'package:flutter/material.dart';
import 'package:notes_app/components/drawer_tile.dart';
import 'package:notes_app/pages/settings.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        children: [
          //drawer header.
          const DrawerHeader(child: Icon(Icons.notes_sharp)),

          //tiles in the drawer.
          DrawerTile(
            icon: const Icon(Icons.home),
            drawerTileTitle: "Home",
            onTap: () {
              Navigator.pop(context);
            },
          ),
          DrawerTile(
              icon: const Icon(Icons.settings),
              drawerTileTitle: "Settings",
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()));
              })
        ],
      ),
    );
  }
}
