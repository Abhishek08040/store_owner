import 'package:flutter/material.dart';
import 'package:owner/drawer.dart';


class SupplierPage extends StatefulWidget {
  const SupplierPage({Key? key}) : super(key: key);

  @override
  State<SupplierPage> createState() => _SupplierPageState();
}

class _SupplierPageState extends State<SupplierPage>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Row(
        children: [
          OwnerDrawer(),
          Text('Supplier'),
        ],

      ),
    );
  }
}
