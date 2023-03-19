import 'package:curved_drawer_fork/curved_drawer_fork.dart';
import 'package:flutter/material.dart';

import 'global_variables.dart';

class OwnerDrawer extends StatefulWidget
{
  const OwnerDrawer({Key? key,}) : super(key: key);

  @override
  State<OwnerDrawer> createState() => _OwnerDrawerState();
}

class _OwnerDrawerState extends State<OwnerDrawer>
{
  @override
  Widget build(BuildContext context)
  {
    return CurvedDrawer(
      color: Colors.black,
      labelColor: Colors.white,
      backgroundColor: Colors.pink,
      buttonBackgroundColor: Colors.black,
      width: 80.0,
      items: const <DrawerItem> [

        DrawerItem(icon: Icon(Icons.groups_outlined,), label: "Employees"),
        DrawerItem(icon: Icon(Icons.inventory_outlined), label: "Inventory"),
        DrawerItem(icon: Icon(Icons.summarize_outlined), label: "Reports & Analytics"),

      ],

      onTap: (index) async
      {
        if (index == 0)
          {
            Navigator.pushNamed(context, "/home" );
          }
        else if (index == 1)
          {
            Navigator.pushNamed(context, "/inventory",);
          }
        else if (index == 2)
          {
            Navigator.pushNamed(context, "/analytics",);
          }
      },
    );
  }
}
