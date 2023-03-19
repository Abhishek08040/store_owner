import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:owner/global_variables.dart';


class MostSoldProducts extends StatefulWidget {
  const MostSoldProducts({Key? key}) : super(key: key);

  @override
  State<MostSoldProducts> createState() => _MostSoldProductsState();
}

class _MostSoldProductsState extends State<MostSoldProducts>
{

  @override
  Widget build(BuildContext context)
  {

    getListOProductsSold();
    return Scaffold(
      appBar: AppBar(leading: BackButton(),),

      body: listOfMostSoldProducts.isEmpty ?

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

            child: Text('Most sold products:', style: GoogleFonts.andikaNewBasic(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),),
          ).centered().p16(),

          Expanded(

            child: ListView.builder(
                itemCount: listOfMostSoldProducts.length > 15 ? 15 : listOfMostSoldProducts.length,
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
                                listOfMostSoldProducts[index].productPicture,
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

                              Text(listOfMostSoldProducts[index].productName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: GoogleFonts.andikaNewBasic(
                                    fontSize: 18, fontWeight: FontWeight.w800
                                ),),


                              Text(listOfMostSoldProducts[index].productDescription,
                                overflow: TextOverflow.visible,
                                maxLines: 1,
                                style: GoogleFonts.andikaNewBasic(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black54,
                                ),),


                              Row(
                                children: [
                                  for (int i = 0; i < listOfMostSoldProducts[index].productRating; i++)
                                    Text(' ★ ', style: GoogleFonts.andikaNewBasic(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromRGBO(58, 1, 92, 1),
                                    ),),
                                ],
                              ),


                              Text("₹ ${listOfMostSoldProducts[index].productPrice}",
                                style: GoogleFonts.andikaNewBasic(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Vx.blue900
                                ),).px2(),


                              Expanded(

                                child: Row(
                                  children: [

                                    Text("Quantity: ${listOfMostSoldProducts[index].totalQuantity}",
                                      style: GoogleFonts.andikaNewBasic(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Vx.blue900
                                      ),).px2(),

                                    Text("Quantity sold: ${listOfMostSoldProducts[index].quantitySold}",
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

