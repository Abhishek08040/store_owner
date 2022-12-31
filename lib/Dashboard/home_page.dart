import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:owner/Dashboard/show_employees_table.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:app_popup_menu/app_popup_menu.dart';
import '../drawer.dart';

class HomePage extends StatefulWidget
{
  const HomePage({Key? key,}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _searchQuery = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;

  late String GSTIdentificationNumber;

  String email = '';
  String selectedDesignation = 'all';
  String name = '';
  String display_photo_url = '';
  bool isImageLoaded = false;

  int noOfEmployees = 0 ;
  int noOfAccountants = 0;
  int noOfStaffs = 0;
  int noOfDeliveryBoys = 0;

  @override
  void initState()
  {
    super.initState();
    email = user!.email!;
  }

  @override
  void dispose()
  {
    super.dispose();
  }

  void setGSTIdentificationNumber() async
  {
    FirebaseFirestore
        .instance
        .collection('Employees')
        .where("Email",isEqualTo: email)
        .get()
        .then((value)
    async {
      String gst = value.docs.single.data()['GST Identification No'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('gst', gst);

      setState(() {
        GSTIdentificationNumber = gst;
      });
    });
  }

  @override
  Widget build(BuildContext context)
  {
    setGSTIdentificationNumber();

    FirebaseFirestore
        .instance
        .collection('Employees')
        .get()
        .then((value)
    {
      setState(() {
        noOfEmployees = value.docs.length;
      });
    });

    FirebaseFirestore
        .instance
        .collection('Employees')
        .where("Designation",isEqualTo: 'Accountant')
        .get()
        .then((value)
    {
      setState(() {
        noOfAccountants = value.docs.length;
      });
    });

    FirebaseFirestore
        .instance
        .collection('Employees')
        .where("Designation",isEqualTo: 'Staff')
        .get()
        .then((value)
    {
      setState(() {
        noOfStaffs = value.docs.length;
      });
    });

    FirebaseFirestore
        .instance
        .collection('Employees')
        .where("Designation",isEqualTo: 'Delivery boy')
        .get()
        .then((value)
    {
      setState(() {
        noOfDeliveryBoys = value.docs.length;
      });
    });

    FirebaseFirestore
        .instance
        .collection('Employees')
        .where("Email",isEqualTo: email)
        .get()
        .then((value)
    {
      setState(() async {
        name = value.docs.first.data()['Name'];
        display_photo_url = value.docs.first.data()['Profile Picture'];
        isImageLoaded = true;
      });
    });


    return Material(

      child: Stack(

        children: [

          Positioned(

            top: 0,
            right: 0,

            child: Container(
              height: 120,
              width: 300,

              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [

                    InkWell(
                      onTap: ()
                        {

                        },

                        child: Icon(Icons.notifications, size: 30,)
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [

                        isImageLoaded ? Image.network(
                          display_photo_url,
                          height: 50, width: 50,
                        ) : CircularProgressIndicator(),

                        Text(name, style: GoogleFonts.andikaNewBasic(),),

                      ],
                    ),

                    InkWell(

                      onTap: ()
                      {
                        showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Center(
                                child: Text('Confirm log out?',
                                  style: GoogleFonts.andikaNewBasic(),
                                ),
                              ),
                              content: SizedBox(
                                height: 60,
                                width: 100,

                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: [

                                    InkWell(
                                      child: Text('Cancel',  style: GoogleFonts.andikaNewBasic(color: Colors.blue),),
                                      onTap: ()
                                      {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    InkWell(
                                      child: Text('Yes',  style: GoogleFonts.andikaNewBasic(color: Colors.blue),),
                                      onTap: () async
                                      {
                                        FirebaseAuth.instance.signOut();
                                        final prefs = await SharedPreferences.getInstance();
                                        final success1 = await prefs.remove('owner name');
                                        final success2 = await prefs.remove('gst');
                                        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                                      },
                                    ),

                                  ],
                                ),
                              ),
                            )
                        );
                      },

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [

                          Icon(Icons.logout, size: 30,),

                          Text('log out', style: GoogleFonts.andikaNewBasic(),),

                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),

          Positioned(
            left: 145,
            child: Row(
              children: [

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
                                setState(() {
                                  selectedDesignation = 'all';
                                });

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

                                      Text(noOfEmployees.toString(), style: GoogleFonts.nanumPenScript(
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
                                setState(() {
                                  selectedDesignation = 'Accountant';
                                });

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

                                      Text(noOfAccountants.toString(), style: GoogleFonts.nanumPenScript(
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
                                setState(() {
                                  selectedDesignation = 'Staff';
                                });
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

                                      Text(noOfStaffs.toString(), style: GoogleFonts.nanumPenScript(
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
                                setState(() {
                                  selectedDesignation = 'Delivery boy';
                                });

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

                                      Text(noOfDeliveryBoys.toString(), style: GoogleFonts.nanumPenScript(
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

                const SizedBox(width: 25,),

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

                      const SizedBox(height: 10,),

                      Card(
                        elevation: 8,

                        child: Container(
                          margin: const EdgeInsets.all(20),

                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [

                                Container(
                                  width: 730,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                    children: [

                                      Container(
                                        constraints: const BoxConstraints(
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
                                                return "Please enter the staff name";
                                              }
                                            },

                                            decoration: InputDecoration(
                                              hintText: "Enter the staff name",
                                              border: const OutlineInputBorder(),
                                              suffixIcon: IconButton(

                                                icon: const Icon(Icons.search_outlined),
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

                                      Row(
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            child: ElevatedButton.icon(
                                              onPressed: ()
                                              {
                                                // add a staff
                                                Navigator.pushNamed(context, '/add_an_employee');

                                              },
                                              icon: const Icon(Icons.person_add, size: 25,),
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
                                              label: Text("Add an employee", style: GoogleFonts.openSans(),),
                                            ),
                                          ),
                                          const SizedBox(width: 10,),
                                          Hero(
                                            tag: 'employee table',

                                            child: SizedBox(
                                              height: 50,
                                              child: ElevatedButton(
                                                onPressed: ()
                                                {
                                                  // expand table
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)
                                                  {
                                                    return ShowEmployeesTable(
                                                        selectedDesignation : selectedDesignation,
                                                    );
                                                  }));
                                                },
                                                child: const Icon(Icons.open_in_full_outlined, size: 25,),
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
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                    ],

                                  ),
                                ),

                                const SizedBox(height: 20,),

                                SizedBox(
                                  width: 730,
                                  height: 350,
                                  child: ShowEmployeesTable(selectedDesignation : selectedDesignation),
                                ),
                              ]
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          OwnerDrawer(),

        ]
      ),

    );
  }
}
