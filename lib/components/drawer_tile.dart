import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final String drawerTileTitle;
  final Icon icon;
  final void Function()? onTap;
  const DrawerTile(
      {super.key,
      required this.icon,
      required this.drawerTileTitle,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: ListTile(
        leading: icon,
        title: Text(drawerTileTitle),
        onTap: onTap,
      ),
    );
  }
}
