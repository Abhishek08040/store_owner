import 'package:curved_drawer_fork/curved_drawer_fork.dart';
import 'package:flutter/material.dart';

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
        DrawerItem(icon: Icon(Icons.local_shipping_outlined), label: "Supplier"),
        DrawerItem(icon: Icon(Icons.currency_rupee_outlined), label: "Accounting & Financing"),
        DrawerItem(icon: Icon(Icons.chat_bubble_outline_outlined), label: "Chat"),
        DrawerItem(icon: Icon(Icons.inventory_outlined), label: "Inventory"),
        DrawerItem(icon: Icon(Icons.summarize_outlined), label: "Reports & Analytics"),
        DrawerItem(icon: Icon(Icons.thumbs_up_down_outlined), label: "Feedback & Complaints"),
        DrawerItem(icon: Icon(Icons.redeem_outlined), label: "Offers & Discounts"),

      ],

      onTap: (index) async
      {
        if (index == 0)
          {
            Navigator.pushNamedAndRemoveUntil(context, "/home" , (Route route) => false);
          }
        else if (index == 1)
          {
            Navigator.pushNamedAndRemoveUntil(context, "/supplier" , (Route route) => false);
          }
        else if (index == 4)
          {
            Navigator.pushNamedAndRemoveUntil(context, "/inventory" , (Route route) => false);
          }
      },
    );
  }
}
