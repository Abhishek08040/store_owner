import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:owner/global_variables.dart';
import 'all_products.dart';
import 'low_stock_products.dart';
import 'out_of_stock_products.dart';


class Inventory extends StatefulWidget {
  const Inventory({Key? key}) : super(key: key);

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory>
{

  @override
  Widget build(BuildContext context)
  {
    var allProductsCollection = FirebaseFirestore
        .instance
        .collection('Products');

    allProductsCollection.get().then((value)
    {
      setState(() {
        totalProductsInInventoryCount = value.docs.length;
      });
    });

    var lowStockProductsCollection = FirebaseFirestore
        .instance
        .collection('Products')
        .where('Quantity', isLessThanOrEqualTo: 10)
        .where('Quantity', isGreaterThan: 0);

    lowStockProductsCollection.get().then((value)
    {
      setState(() {
        lowStockProductsCount = value.docs.length;
      });
    });

    var outOfStockProductsCollection = FirebaseFirestore
        .instance
        .collection('Products')
        .where('Quantity', isEqualTo: 0);

    outOfStockProductsCollection.get().then((value)
    {
      setState(() {
        outOfStockProductsCount = value.docs.length;
      });
    });


    return Material(

        child: Scaffold(
          body: Container(

            padding: const EdgeInsets.all(25),
            margin: const EdgeInsets.all(25),

            child: Column(

              children: [

                InkWell(

                  onTap: ()
                  {
                    listOfProducts.clear();
                    Navigator.push(context, MaterialPageRoute(builder: (context)
                    {
                      return AllProducts(
                        products : allProductsCollection,
                      );
                    })).then((value) { setState(() {});});
                  },

                  child: Text(totalProductsInInventoryCount.toString(), style: GoogleFonts.comfortaa(
                    color: Colors.blue,
                    fontWeight: FontWeight.w400,
                    fontSize: 100,
                  ),),
                ),

                const SizedBox(height: 20,),

                Text("Total products in inventory", style: GoogleFonts.andikaNewBasic(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),),

                const SizedBox(height: 20,),

                InkWell(

                  onTap: ()
                  {
                    listOfProducts.clear();
                    Navigator.push(context, MaterialPageRoute(builder: (context)
                    {
                      return OutOfStockProducts(
                        products : outOfStockProductsCollection,
                      );
                    })).then((value) { setState(() {});});
                  },

                  child: Text(outOfStockProductsCount.toString(), style: GoogleFonts.comfortaa(
                    color: Colors.blue,
                    fontWeight: FontWeight.w400,
                    fontSize: 100,
                  ),),
                ),

                const SizedBox(height: 20,),

                Text("Out of stock products", style: GoogleFonts.andikaNewBasic(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),),

                const SizedBox(height: 20,),

                InkWell(

                  onTap: ()
                  {
                    listOfProducts.clear();
                    Navigator.push(context, MaterialPageRoute(builder: (context)
                    {
                      return LowStockProducts(
                        products : lowStockProductsCollection,
                      );
                    })).then((value) { setState(() {});});
                  },

                  child: Text(lowStockProductsCount.toString(), style: GoogleFonts.comfortaa(
                    color: Colors.blue,
                    fontWeight: FontWeight.w400,
                    fontSize: 100,
                  ),),
                ),

                const SizedBox(height: 20,),

                Text("Low stock products", style: GoogleFonts.andikaNewBasic(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),),

                const SizedBox(height: 20,),

              ],
            ),
          ),
        ),

    );
  }
}

