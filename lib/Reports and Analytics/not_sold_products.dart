import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:owner/global_variables.dart';


class NotSoldProducts extends StatefulWidget {
  const NotSoldProducts({Key? key}) : super(key: key);

  @override
  State<NotSoldProducts> createState() => _NotSoldProductsState();
}

class _NotSoldProductsState extends State<NotSoldProducts>
{
  List<Product> listOfNotSoldProducts = [];

  @override
  Widget build(BuildContext context)
  {
    List<String> productsPurchased = [];

    for (var element in listOfMostSoldProducts) {
      productsPurchased.add(element.productID);
    }

    List<String> productsNotPurchased = [];

    for (var element in listOfAllProducts)
    {
      if (!productsPurchased.contains(element.productID))
      {
        productsNotPurchased.add(element.productID);
      }
    }

    listOfNotSoldProducts.clear();
    for (var element in productsNotPurchased)
      {
        listOfNotSoldProducts.add(listOfAllProducts.singleWhere((p) =>
            p.productID == element));
      }

    return Scaffold(
      body: listOfNotSoldProducts.isEmpty ?

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

            child: Text('Not sold products:', style: GoogleFonts.andikaNewBasic(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),),
          ).centered().p16(),

          Expanded(

            child: ListView.builder(
                itemCount: listOfNotSoldProducts.length,
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
                                listOfNotSoldProducts[index].productPicture,
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

                              Text(listOfNotSoldProducts[index].productName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: GoogleFonts.andikaNewBasic(
                                    fontSize: 18, fontWeight: FontWeight.w800
                                ),),


                              Text(listOfNotSoldProducts[index].productDescription,
                                overflow: TextOverflow.visible,
                                maxLines: 1,
                                style: GoogleFonts.andikaNewBasic(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black54,
                                ),),


                              Row(
                                children: [
                                  for (int i = 0; i < listOfNotSoldProducts[index].productRating; i++)
                                    Text(' ★ ', style: GoogleFonts.andikaNewBasic(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromRGBO(58, 1, 92, 1),
                                    ),),
                                ],
                              ),


                              Text("₹ ${listOfNotSoldProducts[index].productPrice}",
                                style: GoogleFonts.andikaNewBasic(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Vx.blue900
                                ),).px2(),


                              Expanded(

                                child: Row(
                                  children: [

                                    Text("Quantity: ${listOfNotSoldProducts[index].totalQuantity}",
                                      style: GoogleFonts.andikaNewBasic(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Vx.blue900
                                      ),).px2(),

                                    Text("Quantity sold: ${listOfNotSoldProducts[index].quantitySold}",
                                      style: GoogleFonts.andikaNewBasic(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Vx.blue900),
                                    ).px2(),

                                  ],
                                ),
                              ),


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

