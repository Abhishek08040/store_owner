import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class StaffHomePage extends StatefulWidget {
  const StaffHomePage({Key? key}) : super(key: key);

  @override
  State<StaffHomePage> createState() => _StaffHomePageState();
}

class _StaffHomePageState extends State<StaffHomePage>
{
  User? user = FirebaseAuth.instance.currentUser;
  String name = '';
  String storeGST = '';
  String storeName = '';
  String storeLogo = '';
  String storeOwner = '';
  String storeContactNo = '';

  @override
  Widget build(BuildContext context)
  {
    Query employeeCollection = FirebaseFirestore
        .instance
        .collection('Employees')
        .where("Email",isEqualTo: user?.email.toString());

    employeeCollection.get().then((value)
    {
      setState(() {
        name = value.docs.first['Name'].toString();
        storeGST = value.docs.first['Store'].toString();
      });
    });

    FirebaseFirestore
        .instance
        .collection('Stores')
        .doc('12AAAAA0000A1Z6')
        .get()
        .then((value)
        {
          setState(() {
            storeName = value['Store name'].toString();
            storeLogo = value['Store logo'].toString();
            storeOwner = value['Owner\'s name'].toString();
            storeContactNo = value['Contact no'].toString();
          });

        });

    return Scaffold(
      appBar: AppBar(leading: const BackButton(),),

      body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Welcome $name", style: GoogleFonts.comfortaa(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 30,
        ),),

        const SizedBox(height: 20,),

        Container(

          margin: const EdgeInsets.all(25),
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(width: 2, color: Colors.pinkAccent),
          ),

          child: Image.network(storeLogo, height: 135, width: 135,),

        ),

        const SizedBox(height: 20,),

        Center(
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              Text(storeName,
                style: GoogleFonts.andikaNewBasic(textStyle: const TextStyle(
                  fontSize: 25,
                )),),
              const SizedBox(height: 10,),
              Text("Owner: $storeOwner",
                style: GoogleFonts.andikaNewBasic(textStyle: const TextStyle(
                  fontSize: 20,
                )),),
              Text("Contact No: $storeContactNo",
                style: GoogleFonts.andikaNewBasic(textStyle: const TextStyle(
                  fontSize: 20,
                )),),

            ],
          ),
        ),

      ],
    ),
      
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () 
        {
          Navigator.pushNamed(context, '/staff_add_product');
        },

        icon: const Icon(Icons.add),
        backgroundColor: Colors.pink,
        hoverColor: Vx.pink600,
        elevation: 10.0,
        label: Text("Add product", style: GoogleFonts.openSans(),),
      ),

    );
  }
}
