import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:owner/global_variables.dart';


class UnsoldProducts extends StatefulWidget {
  const UnsoldProducts({Key? key}) : super(key: key);

  @override
  State<UnsoldProducts> createState() => _UnsoldProductsState();
}

class _UnsoldProductsState extends State<UnsoldProducts>
{
  List<Product> listOfUnsoldProducts = [];


  @override
  Widget build(BuildContext context)
  {
    List<String> productsPurchased = [];

    for (var element in listOfMostSoldProducts) {
      productsPurchased.add(element.productID);
    }

    listOfUnsoldProducts =
        listOfAllProducts.filter((element) => !productsPurchased.contains(element.productID))
    .toList();


    return Scaffold(
      body: listOfUnsoldProducts.isEmpty ?

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

            child: Text('Unsold products:', style: GoogleFonts.andikaNewBasic(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),),
          ).centered().p16(),

          Expanded(

            child: ListView.builder(
                itemCount: listOfUnsoldProducts.length,
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
                                listOfUnsoldProducts[index].productPicture,
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

                              Text(listOfUnsoldProducts[index].productName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: GoogleFonts.andikaNewBasic(
                                    fontSize: 18, fontWeight: FontWeight.w800
                                ),),


                              Text(listOfUnsoldProducts[index].productDescription,
                                overflow: TextOverflow.visible,
                                maxLines: 1,
                                style: GoogleFonts.andikaNewBasic(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black54,
                                ),),


                              Row(
                                children: [
                                  for (int i = 0; i < listOfUnsoldProducts[index].productRating; i++)
                                    Text(' ★ ', style: GoogleFonts.andikaNewBasic(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromRGBO(58, 1, 92, 1),
                                    ),),
                                ],
                              ),


                              Text("₹ ${listOfUnsoldProducts[index].productPrice}",
                                style: GoogleFonts.andikaNewBasic(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Vx.blue900
                                ),).px2(),


                              Expanded(

                                child: Row(
                                  children: [

                                    Text("Quantity: ${listOfUnsoldProducts[index].totalQuantity}",
                                      style: GoogleFonts.andikaNewBasic(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Vx.blue900
                                      ),).px2(),

                                    Text("Quantity sold: ${listOfUnsoldProducts[index].quantitySold}",
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

