import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:owner/Reports%20and%20Analytics/least_sold_products.dart';
import 'package:owner/Reports%20and%20Analytics/not_sold_products.dart';
import 'package:owner/global_variables.dart';
import 'all_products.dart';
import 'low_stock_products.dart';
import 'most_sold_products.dart';
import 'out_of_stock_products.dart';


class Inventory extends StatefulWidget {
  const Inventory({Key? key}) : super(key: key);

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory>
{

  bool isDataGenerated = false;

  @override
  Widget build(BuildContext context)
  {
    var allProductsCollection = FirebaseFirestore
        .instance
        .collection('Products');

    allProductsCollection.get().then((product)
    {
      setState(() {

        listOfAllProducts.clear();

        for (var doc in product.docs)
        {
          Map item = doc.data();

          String productID = item['StockCode'].toString();
          String productPicture = item['Picture'].toString();
          String productName = item['Name'].toString();
          num productPrice = item['UnitPrice'];
          num productRating = 3;
          String productDescription = item['Description'].toString();
          num totalQuantity = item['Quantity'];

          listOfAllProducts.add(Product(
            productID,
            productPicture,
            productName,
            productPrice,
            productRating,
            productDescription,
            0,
            totalQuantity,
          ));

        }

      });
    });

    getListOProductsSold();
    listOfMostSoldProducts.sort((b, a) => a.quantitySold.compareTo(b.quantitySold));

    var lowStockProductsCollection = allProductsCollection
        .where('Quantity', isLessThanOrEqualTo: 10)
        .where('Quantity', isGreaterThan: 0);

    lowStockProductsCollection.get().then((product) {
      setState(() {

        listOfLowStockProducts.clear();

        for (var doc in product.docs)
        {
          Map item = doc.data();

          String productID = item['StockCode'].toString();
          String productPicture = item['Picture'].toString();
          String productName = item['Name'].toString();
          num productPrice = item['UnitPrice'];
          num productRating = 3;
          String productDescription = item['Description'].toString();
          num totalQuantity = item['Quantity'];

          listOfLowStockProducts.add(Product(
            productID,
            productPicture,
            productName,
            productPrice,
            productRating,
            productDescription,
            0,
            totalQuantity,
          ));

        }


      });
    });


    var outOfStockProductsCollection = allProductsCollection
        .where('Quantity', isEqualTo: 0);

    outOfStockProductsCollection.get()
        .then((product)
    {
      setState(() {

        listOfOutOfStockProducts.clear();

        for (var doc in product.docs)
        {
          Map item = doc.data();

          String productID = item['StockCode'].toString();
          String productPicture = item['Picture'].toString();
          String productName = item['Name'].toString();
          num productPrice = item['UnitPrice'];
          num productRating = 3;
          String productDescription = item['Description'].toString();
          num totalQuantity = item['Quantity'];

          listOfOutOfStockProducts.add(Product(
            productID,
            productPicture,
            productName,
            productPrice,
            productRating,
            productDescription,
            0,
            totalQuantity,
          ));

        }


      });
    });


    return isDataGenerated ?

    Scaffold(

        appBar: AppBar(
          leading: BackButton(),
        ),

        body: Scaffold(
          body: Container(

            padding: const EdgeInsets.all(25),
            margin: const EdgeInsets.all(25),

            child: Wrap(

              direction: Axis.vertical,

              spacing: 20,

              children: [

                InkWell(

                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)
                    {
                      return const AllProducts();
                    })).then((value) { setState(() {});});
                  },

                  child: Text(listOfAllProducts.length.toString(), style: GoogleFonts.comfortaa(
                    color: Colors.blue,
                    fontWeight: FontWeight.w400,
                    fontSize: 100,
                  ),),
                ),

                const SizedBox(height: 20,),

                Text("Total products", style: GoogleFonts.andikaNewBasic(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),),

                const SizedBox(height: 20,),

                InkWell(

                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)
                    {
                      return const OutOfStockProducts();
                    })).then((value) { setState(() {});});
                  },

                  child: Text(listOfOutOfStockProducts.length.toString(), style: GoogleFonts.comfortaa(
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)
                    {
                      return const LowStockProducts();
                    })).then((value) { setState(() {});});
                  },


                  child: Text(listOfLowStockProducts.length.toString(), style: GoogleFonts.comfortaa(
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

                InkWell(

                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)
                    {
                      return const MostSoldProducts();
                    })).then((value) { setState(() {});});
                  },

                  child: Text('Most', style: GoogleFonts.comfortaa(
                    color: Colors.blue,
                    fontWeight: FontWeight.w400,
                    fontSize: 100,
                  ),),
                ),

                const SizedBox(height: 20,),

                Text("Most sold products", style: GoogleFonts.andikaNewBasic(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),),

                const SizedBox(height: 20,),

                InkWell(

                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)
                    {
                      return const LeastSoldProducts();
                    })).then((value) { setState(() {});});
                  },

                  child: Text('Least', style: GoogleFonts.comfortaa(
                    color: Colors.blue,
                    fontWeight: FontWeight.w400,
                    fontSize: 100,
                  ),),
                ),

                const SizedBox(height: 20,),

                Text("Least sold products", style: GoogleFonts.andikaNewBasic(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),),

                const SizedBox(height: 20,),

                InkWell(

                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)
                    {
                      return const NotSoldProducts();
                    })).then((value) { setState(() {});});
                  },

                  child: Text('Not sold', style: GoogleFonts.comfortaa(
                    color: Colors.blue,
                    fontWeight: FontWeight.w400,
                    fontSize: 100,
                  ),),
                ),

                const SizedBox(height: 20,),

                Text("Not sold products", style: GoogleFonts.andikaNewBasic(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),),

                const SizedBox(height: 20,),

              ],
            ),
          ),
        ),

    ) :

    const Scaffold(body: Center(child: CircularProgressIndicator()));

  }

  void getListOProductsSold()
  {
    Map quantitySold = {};

    var products = FirebaseFirestore
        .instance
        .collection('Transactions')
        .where('InvoiceDate', isLessThanOrEqualTo: 201012010828)
        .where('InvoiceDate', isGreaterThanOrEqualTo: 201012010826);

    products.get().then((QuerySnapshot snapshot)
    {
      listOfMostSoldProducts.clear();
      for (var doc in snapshot.docs)
      {
        Map item = doc.data()! as Map<String, dynamic>;

        var productsPurchasedByCustomer = item['StockCode'].map((e) => e.toString()).toList();

        for (var x in productsPurchasedByCustomer)
        {
          if (quantitySold.containsKey(x))
          {
            quantitySold[x] = quantitySold[x] + 1;
          }
          else
          {
            quantitySold[x] = 1;
          }
        }
      }

      for (var x in quantitySold.keys)
      {

        Product p = listOfAllProducts.singleWhere((element) => element.productID == x);
        p.quantitySold = quantitySold[x];
        listOfMostSoldProducts.add(p);

      }

      setState(() {
        isDataGenerated = true;
      });

    });

  }


}

