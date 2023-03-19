import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:owner/Reports%20and%20Analytics/least_sold_products.dart';
import 'package:owner/Reports%20and%20Analytics/not_sold_products.dart';
import 'package:owner/global_variables.dart';
import 'package:velocity_x/velocity_x.dart';
import 'all_products.dart';
import 'low_stock_products.dart';
import 'most_sold_products.dart';
import 'out_of_stock_products.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ReportsAndAnalyticsHome extends StatefulWidget {
  const ReportsAndAnalyticsHome({Key? key}) : super(key: key);

  @override
  State<ReportsAndAnalyticsHome> createState() => _ReportsAndAnalyticsHomeState();
}

class _ReportsAndAnalyticsHomeState extends State<ReportsAndAnalyticsHome>
{
  late final TextEditingController _dateRangeLow = TextEditingController();
  late final TextEditingController _dateRangeHigh = TextEditingController();

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

    return Scaffold(
      appBar: AppBar(leading: const BackButton(),),

      body: SingleChildScrollView(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [

            Text('Select a range of dates to analyse data', style: GoogleFonts.andikaNewBasic(
                fontWeight: FontWeight.w700,
                fontSize: 20
            ),),

            SizedBox(
              width: 400,

              child: Row(
                children: [

                  SizedBox(
                    width: 150,
                    child: TextFormField(
                      readOnly: true,

                      onTap: ()
                      {
                        showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Center(
                                child: Text('Select the lower range',
                                  style: GoogleFonts.andikaNewBasic(),
                                ),
                              ),
                              content: SizedBox(
                                height: 360,
                                width: 500,

                                child: Column(
                                  children: [

                                    SfDateRangePicker(

                                      view: DateRangePickerView.decade,
                                      selectionMode: DateRangePickerSelectionMode.single,
                                      onSelectionChanged: (var dateSelected)
                                      {
                                        setState(()
                                        {
                                          _dateRangeLow.text = dateSelected
                                              .value
                                              .toString()
                                              .substring(0,10);
                                        });
                                      },
                                    ),

                                    Align(
                                      alignment: Alignment.centerRight,

                                      child: IconButton(
                                        iconSize: 30,
                                        splashRadius: 30,
                                        splashColor: Colors.black26,
                                        icon: const Icon(Icons.done_outlined),
                                        color: Colors.black,
                                        onPressed: ()
                                        {
                                          Navigator.pop(context);
                                          String x = _dateRangeLow.text.replaceAll('-', '');
                                          x = x.padRight(12,'0');

                                          dateLowerRange = int.parse(x);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                        );
                      },

                      controller: _dateRangeLow,

                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  const SizedBox(width: 50),

                  SizedBox(
                    width: 150,

                    child: TextFormField(
                      readOnly: true,

                      onTap: ()
                      {
                        showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Center(
                                child: Text('Select the higher range',
                                  style: GoogleFonts.andikaNewBasic(),
                                ),
                              ),
                              content: SizedBox(
                                height: 360,
                                width: 500,

                                child: Column(
                                  children: [

                                    SfDateRangePicker(

                                      view: DateRangePickerView.decade,
                                      selectionMode: DateRangePickerSelectionMode.single,
                                      onSelectionChanged: (var dateSelected)
                                      {
                                        setState(()
                                        {
                                          _dateRangeHigh.text = dateSelected
                                              .value
                                              .toString()
                                              .substring(0,10);
                                        });
                                      },
                                    ),



                                    Align(
                                      alignment: Alignment.centerRight,

                                      child: IconButton(
                                        iconSize: 30,
                                        splashRadius: 30,
                                        splashColor: Colors.black26,
                                        icon: const Icon(Icons.done_outlined),
                                        color: Colors.black,
                                        onPressed: ()
                                        {
                                          Navigator.pop(context);

                                          String x = _dateRangeHigh.text.replaceAll('-', '');
                                          x = x.padRight(12,'0');

                                          dateHigherRange = int.parse(x);
                                          log(dateHigherRange.toString());
                                          log(dateLowerRange.toString());

                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                        );
                      },

                      controller: _dateRangeHigh,

                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 40,),

            Text('Inventory data analytics', style: GoogleFonts.andikaNewBasic(
                fontWeight: FontWeight.w700,
                fontSize: 20
            ),),

            const SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [

                InkWell(

                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)
                    {
                      return const AllProducts();
                    })).then((value) { setState(() {});});
                  },

                  child: VxBox(
                    child: Container(
                      height: 200,
                      width: 150,
                      padding: const EdgeInsets.only(right: 14, top: 12),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [

                          Image.network('https://cdn-icons-png.flaticon.com/128/2825/2825867.png',
                            height: 75, width: 75,),

                          Text(listOfAllProducts.length.toString(), style: GoogleFonts.nanumPenScript(
                            fontSize: 55,
                            textStyle: const TextStyle(
                              color: Colors.white,
                            ),),),

                          Text("Total products", style: GoogleFonts.hiMelody(
                            fontSize: 18,
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),),),

                        ],
                      ),
                    ),
                  ).roundedLg.color(Colors.pinkAccent).shadow3xl.make().py16(),
                ),

                InkWell(

                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)
                    {
                      return const MostSoldProducts();
                    })).then((value) { setState(() {});});
                  },

                  child: VxBox(
                    child: Container(
                      height: 200,
                      width: 150,
                      padding: const EdgeInsets.only(right: 14, top: 12),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [

                          Image.network('https://cdn-icons-png.flaticon.com/128/5655/5655906.png',
                            height: 75, width: 75,),

                          Text("Most", style: GoogleFonts.nanumPenScript(
                            fontSize: 55,
                            textStyle: const TextStyle(
                              color: Colors.white,
                            ),),),

                          Text("sold products", style: GoogleFonts.hiMelody(
                            fontSize: 18,
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),),),

                        ],
                      ),
                    ),
                  ).roundedLg.color(Colors.purple).shadow3xl.make().py16(),
                ),

                InkWell(

                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)
                    {
                      return const LeastSoldProducts();
                    })).then((value) { setState(() {});});
                  },

                  child: VxBox(
                    child: Container(
                      height: 200,
                      width: 150,
                      padding: const EdgeInsets.only(right: 14, top: 12),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [

                          Image.network('https://cdn-icons-png.flaticon.com/128/3115/3115493.png',
                            height: 75, width: 75,),

                          Text("Least", style: GoogleFonts.nanumPenScript(
                            fontSize: 55,
                            textStyle: const TextStyle(
                              color: Colors.white,
                            ),),),

                          Text("sold products", style: GoogleFonts.hiMelody(
                            fontSize: 18,
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),),),

                        ],
                      ),
                    ),
                  ).roundedLg.color(Vx.blue300).shadow3xl.make().py16(),
                ),

                InkWell(
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)
                    {
                      return const NotSoldProducts();
                    })).then((value) { setState(() {});});
                  },

                  child: VxBox(
                    child: Container(
                      height: 200,
                      width: 150,
                      padding: const EdgeInsets.only(right: 14, top: 12),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [

                          Image.network('https://cdn-icons-png.flaticon.com/128/3570/3570095.png',
                            height: 75, width: 75,),

                          Text('', style: GoogleFonts.nanumPenScript(
                            fontSize: 55,
                            textStyle: const TextStyle(
                              color: Colors.white,
                            ),),),

                          Text("sold products", style: GoogleFonts.hiMelody(
                            fontSize: 18,
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),),),

                        ],
                      ),
                    ),
                  ).roundedLg.color(Colors.green).shadow3xl.make().py16(),
                ),

              ],
            ).px64(),

            const SizedBox(height: 20,),

            Text('Urgent!!', style: GoogleFonts.andikaNewBasic(
              fontWeight: FontWeight.w700,
              fontSize: 20
            ),),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [

                InkWell(

                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)
                    {
                      return const OutOfStockProducts();
                    })).then((value) { setState(() {});});
                  },

                  child: VxBox(
                    child: Container(
                      height: 200,
                      width: 150,
                      padding: const EdgeInsets.only(right: 14, top: 12),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [

                          Image.network('https://cdn-icons-png.flaticon.com/128/4961/4961667.png',
                            height: 75, width: 75,),

                          Text(listOfOutOfStockProducts.length.toString(), style: GoogleFonts.nanumPenScript(
                            fontSize: 55,
                            textStyle: const TextStyle(
                              color: Colors.white,
                            ),),),

                          Text("Out of stock", style: GoogleFonts.hiMelody(
                            fontSize: 18,
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),),),

                        ],
                      ),
                    ),
                  ).roundedLg.color(Vx.blue300).shadow3xl.make().py16(),
                ),

                InkWell(

                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)
                    {
                      return const LowStockProducts();
                    })).then((value) { setState(() {});});
                  },

                  child: VxBox(
                    child: Container(
                      height: 200,
                      width: 150,
                      padding: const EdgeInsets.only(right: 14, top: 12),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [

                          Image.network('https://cdn-icons-png.flaticon.com/128/3638/3638928.png',
                            height: 75, width: 75,),

                          Text(listOfLowStockProducts.length.toString(), style: GoogleFonts.nanumPenScript(
                            fontSize: 55,
                            textStyle: const TextStyle(
                              color: Colors.white,
                            ),),),

                          Text("Low stock", style: GoogleFonts.hiMelody(
                            fontSize: 18,
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),),),

                        ],
                      ),
                    ),
                  ).roundedLg.color(Colors.purple).shadow3xl.make().py16(),
                ),


              ],
            ).px64(),



          ],
        ),
      )

    ) ;
    //const Scaffold(body: Center(child: CircularProgressIndicator()));

  }
}
