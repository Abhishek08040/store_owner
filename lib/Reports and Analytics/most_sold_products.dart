import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:owner/global_variables.dart';


class MostSoldProducts extends StatefulWidget {
  const MostSoldProducts({Key? key}) : super(key: key);

  @override
  State<MostSoldProducts> createState() => _MostSoldProductsState();
}

class _MostSoldProductsState extends State<MostSoldProducts> {
  @override
  Widget build(BuildContext context)
  {
    Map quantitySold = {};

    var products = FirebaseFirestore
        .instance
        .collection('Transactions')
        .where('InvoiceDate', isGreaterThan: 201012010826);

    products.get().then((QuerySnapshot snapshot)
    {
      listOfProducts.clear();
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


      int maxProducts = 10;

      for (var x in quantitySold.keys)
      {
        if (maxProducts > 0)
        {
          maxProducts--;

          FirebaseFirestore
              .instance
              .collection('Products')
              .doc(x)
              .get()
              .then((product)
          {

            String productID = product['StockCode'].toString();
            String productPicture = product['Picture'].toString();
            String productName = product['Name'].toString();
            num productPrice = product['UnitPrice'];
            //num productRating = int.parse(product['Ratings'].toString() ?? '3');
            num productRating = 3;
            String productDescription = product['Description'].toString();

            listOfProducts.add(Product(
              productID,
              productPicture,
              productName,
              productPrice,
              productRating,
              productDescription,
              quantitySold[x],
              0,
            ));

          });
        }
        else
        {
          break;
        }
      }

    }

    );

    return Material(
      child: listOfProducts.isEmpty ?

      Scaffold(
        body: Text(
          "No products found!",
          style: GoogleFonts.andikaNewBasic(
              fontSize: 15, fontWeight: FontWeight.w400),).p32(),
      ) :

      Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 225),

          child: GridView.count(
            crossAxisCount: 3,
            children: List.generate(listOfProducts.length, (index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Center(
                    child: VxBox(
                      child: Image.network(
                        listOfProducts[index].productPicture,
                      ),
                    ).rounded.white
                        .square(160)
                        .p16
                        .make(),
                  ),


                  Text(listOfProducts[index].productName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: GoogleFonts.andikaNewBasic(
                        fontSize: 18, fontWeight: FontWeight.w800
                    ),),


                  Text(listOfProducts[index].productDescription,
                    overflow: TextOverflow.visible,
                    maxLines: 1,
                    style: GoogleFonts.andikaNewBasic(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                    ),),


                  Row(
                    children: [
                      for (int i = 0; i <
                          listOfProducts[index].productRating; i++)
                        Text(' ★ ', style: GoogleFonts.andikaNewBasic(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromRGBO(58, 1, 92, 1),
                        ),),
                    ],
                  ),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text("₹ ${listOfProducts[index].productPrice}",
                        style: GoogleFonts.andikaNewBasic(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Vx.blue900
                        ),).px2(),


                      Text("Quantity sold: ${listOfProducts[index].quantitySold}",
                        style: GoogleFonts.andikaNewBasic(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Vx.blue900
                        ),).px2(),

                    ],
                  ),


                  const SizedBox(height: 15,),

                ],
              ).p12();
            },),
          ),
        ),
      ),

    );


  }
}


class Product
{
  final String productID;
  final String productPicture;
  final String productName;
  final num productPrice;
  final num productRating;
  final String productDescription;
  final num quantitySold;
  final num totalQuantity;


  Product(this.productID, this.productPicture, this.productName, this.productPrice, this.productRating, this.productDescription, this.quantitySold, this.totalQuantity);
}
