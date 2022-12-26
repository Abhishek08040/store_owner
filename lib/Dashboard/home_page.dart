import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _searchQuery = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return Material(

      child: Row(

        children: [

          const OwnerDrawer(),

          const SizedBox(width: 45,),

          SizedBox(
            width: 360,
            child: Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(top: 50, bottom: 40),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text('Employee overview',
                  style: GoogleFonts.andikaNewBasic(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,

                    children: [
                      InkWell(
                        onTap: ()
                        {

                        },
                        child: VxBox(
                          child: Container(
                            height: 200,
                            width: 150,
                            padding: const EdgeInsets.only(right: 14, top: 12),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [

                                Image.network('https://cdn-icons-png.flaticon.com/128/6823/6823086.png',
                                  height: 75, width: 75,),

                                Text("12", style: GoogleFonts.nanumPenScript(
                                  fontSize: 70,
                                  textStyle: const TextStyle(
                                    color: Color.fromARGB(
                                        255, 19, 43, 204),
                                  ),),),

                                Text("Employees", style: GoogleFonts.hiMelody(
                                  fontSize: 22,
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(
                                        255, 19, 43, 204),
                                  ),),),

                              ],
                            ),
                          ),
                        ).roundedLg.color(Vx.blue300).shadow3xl.make().py16(),
                      ),
                      InkWell(
                        onTap: ()
                        {

                        },
                        child: VxBox(
                          child: Container(
                            height: 200,
                            width: 150,
                            padding: const EdgeInsets.only(right: 14, top: 12),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [

                                Image.network('https://cdn-icons-png.flaticon.com/128/2534/2534204.png',
                                  height: 75, width: 75,),

                                Text("1", style: GoogleFonts.nanumPenScript(
                                  fontSize: 70,
                                  textStyle: const TextStyle(
                                    color: Colors.white
                                  ),),),

                                Text("Accountants", style: GoogleFonts.hiMelody(
                                  fontSize: 22,
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                  ),),),

                              ],
                            ),
                          ),
                        ).roundedLg.color(Colors.green).shadow3xl.make().py16(),
                      ),


                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,

                    children: [
                      InkWell(
                        onTap: ()
                        {

                        },
                        child: VxBox(
                          child: Container(
                            height: 200,
                            width: 150,
                            padding: const EdgeInsets.only(right: 14, top: 12),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [

                                Image.network('https://cdn-icons-png.flaticon.com/128/3281/3281869.png',
                                  height: 75, width: 75,),

                                Text("8", style: GoogleFonts.nanumPenScript(
                                  fontSize: 70,
                                  textStyle: const TextStyle(
                                    color: Colors.white
                                  ),),),

                                Text("Staffs", style: GoogleFonts.hiMelody(
                                  fontSize: 22,
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                  ),),),

                              ],
                            ),
                          ),
                        ).roundedLg.color(Colors.purple).shadow3xl.make().py16(),
                      ),
                      InkWell(
                        onTap: ()
                        {

                        },
                        child: VxBox(
                          child: Container(
                            height: 200,
                            width: 150,
                            padding: const EdgeInsets.only(right: 14, top: 12),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [

                                Image.network('https://cdn-icons-png.flaticon.com/128/9204/9204040.png',
                                  height: 75, width: 75,),

                                Text("4", style: GoogleFonts.nanumPenScript(
                                  fontSize: 70,
                                  textStyle: const TextStyle(
                                    color: Vx.red900
                                  ),),),

                                Text("Delivery Boys", style: GoogleFonts.hiMelody(
                                  fontSize: 22,
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Vx.red900,
                                  ),),),

                              ],
                            ),
                          ),
                        ).roundedLg.color(Colors.pinkAccent).shadow3xl.make().py16(),
                      ),
                    ],
                  ),


                ],
              ),
            ),
          ),

          SizedBox(width: 25,),

          Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(top: 50, bottom: 40),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text('Employee details',
                  style: GoogleFonts.andikaNewBasic(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),

                SizedBox(height: 10,),

                Expanded(
                  child: Card(
                    elevation: 8,

                    child: Container(
                      margin: EdgeInsets.all(20),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [

                              Container(
                                constraints: BoxConstraints(
                                  maxWidth: 400,
                                ),

                                child: Form(
                                  key: _key,
                                  child: TextFormField(
                                    controller: _searchQuery,

                                    validator: (value)
                                    {
                                      if (value!.isEmpty)
                                      {
                                        return "Please enter a staff name";
                                      }
                                    },

                                    decoration: InputDecoration(
                                      hintText: "Enter a staff name",
                                      border: OutlineInputBorder(),
                                      suffixIcon: IconButton(

                                          icon: Icon(Icons.search_outlined),
                                          onPressed: () async
                                          {
                                            if (_key.currentState!.validate())
                                              {
                                                // search a staff
                                              }

                                          },
                                      ),
                                    ),

                                  ),
                                ),
                              ),

                              SizedBox(width: 15,),

                              SizedBox(
                                height: 50,
                                child: ElevatedButton.icon(
                                  onPressed: ()
                                  {
                                    // add a staff

                                  },
                                  icon: Icon(Icons.person_add, size: 25,),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Colors.pink,
                                    ),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        )
                                    ),
                                  ),
                                  label: Text("Add a staff", style: GoogleFonts.openSans(),),
                                ),
                              ),

                            ],

                          ),





                        ],

                      ),
                    ),


                  ),
                ),



              ],
            ),
          ),


        ]

      ),


    );
  }
}
