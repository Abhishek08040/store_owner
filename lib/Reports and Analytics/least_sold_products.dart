import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:owner/global_variables.dart';


class LeastSoldProducts extends StatefulWidget {
  const LeastSoldProducts({Key? key}) : super(key: key);

  @override
  State<LeastSoldProducts> createState() => _LeastSoldProductsState();
}

class _LeastSoldProductsState extends State<LeastSoldProducts>
{

  @override
  Widget build(BuildContext context)
  {
    List<Product> listOfLeastSoldProducts = listOfMostSoldProducts.reversed.toList();

    return Scaffold(
      appBar: AppBar(leading: BackButton(),),

      body: listOfLeastSoldProducts.isEmpty ?

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

            child: Text('Least sold products:', style: GoogleFonts.andikaNewBasic(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),),
          ).centered().p16(),

          Expanded(

            child: ListView.builder(
                itemCount: listOfLeastSoldProducts.length > 15 ? 15 : listOfLeastSoldProducts.length,
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
                                listOfLeastSoldProducts[index].productPicture,
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

                              Text(listOfLeastSoldProducts[index].productName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: GoogleFonts.andikaNewBasic(
                                    fontSize: 18, fontWeight: FontWeight.w800
                                ),),


                              Text(listOfLeastSoldProducts[index].productDescription,
                                overflow: TextOverflow.visible,
                                maxLines: 1,
                                style: GoogleFonts.andikaNewBasic(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black54,
                                ),),


                              Row(
                                children: [
                                  for (int i = 0; i < listOfLeastSoldProducts[index].productRating; i++)
                                    Text(' ★ ', style: GoogleFonts.andikaNewBasic(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromRGBO(58, 1, 92, 1),
                                    ),),
                                ],
                              ),


                              Text("₹ ${listOfLeastSoldProducts[index].productPrice}",
                                style: GoogleFonts.andikaNewBasic(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Vx.blue900
                                ),).px2(),


                              Expanded(

                                child: Row(
                                  children: [

                                    Text("Quantity: ${listOfLeastSoldProducts[index].totalQuantity}",
                                      style: GoogleFonts.andikaNewBasic(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Vx.blue900
                                      ),).px2(),

                                    Text("Quantity sold: ${listOfLeastSoldProducts[index].quantitySold}",
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

