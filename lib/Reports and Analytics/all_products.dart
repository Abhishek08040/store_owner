import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import '../global_variables.dart';


class AllProducts extends StatefulWidget {

  const AllProducts({Key? key,}) : super(key: key);

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts>
{
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

    return Scaffold(
      appBar: AppBar(leading: BackButton(),),

      body: listOfAllProducts.isEmpty ?

      Center(
        child: Text('No products found!', style: GoogleFonts.comfortaa(
          fontWeight: FontWeight.w400,
          fontSize: 25,
        ),),
      ) :

      Column(
        children: [

          SizedBox(
            width: 600,

            child: Text('All products:', style: GoogleFonts.andikaNewBasic(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),),
          ).centered().p16(),

          Expanded(

            child: ListView.builder(
                itemCount: listOfAllProducts.length,
                itemBuilder: (BuildContext context, int index)
                {
                  return Center(
                    child: Container(
                      width: 600,
                      height: 180,
                      color: Colors.white,

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [

                          Text((index+1).toString(),
                            style: GoogleFonts.andikaNewBasic(
                                fontSize: 20, fontWeight: FontWeight.w800
                            ),),

                          Center(
                            child: VxBox(
                              child: Image.network(
                                listOfAllProducts[index].productPicture,
                              ),
                            ).rounded.white
                                .square(160)
                                .p16
                                .make(),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,

                            children: [

                              Text(listOfAllProducts[index].productName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: GoogleFonts.andikaNewBasic(
                                    fontSize: 18, fontWeight: FontWeight.w800
                                ),),


                              Text(listOfAllProducts[index].productDescription,
                                overflow: TextOverflow.visible,
                                maxLines: 1,
                                style: GoogleFonts.andikaNewBasic(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black54,
                                ),),


                              Row(
                                children: [
                                  for (int i = 0; i < listOfAllProducts[index].productRating; i++)
                                    Text(' ★ ', style: GoogleFonts.andikaNewBasic(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromRGBO(58, 1, 92, 1),
                                    ),),
                                ],
                              ),


                              Text("₹ ${listOfAllProducts[index].productPrice}",
                                style: GoogleFonts.andikaNewBasic(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Vx.blue900
                                ),).px2(),


                              Text("Quantity: ${listOfAllProducts[index].totalQuantity}",
                                style: GoogleFonts.andikaNewBasic(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Vx.blue900
                                ),).px2(),

                            ],

                          ),


                        ],
                      ).p32(),

                    ),
                  ).p16();
                }),
          ),
        ],
      ),

    );

  }
}
