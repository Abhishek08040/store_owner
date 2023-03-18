import 'package:flutter/material.dart';
import 'package:owner/Dashboard/add_employee.dart';
import 'package:owner/Dashboard/show_employees_table.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Dashboard/home_page.dart';
import 'Registration and Login/add_store_details.dart';
import 'Registration and Login/login.dart';
import 'Registration and Login/sign_up.dart';
import 'Reports and Analytics/inventory.dart';
import 'Staff/add_product.dart';
import 'Staff/staff_home_page.dart';
import 'Supplier/supplier_page.dart';


void main() async
{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyAJqMebJHcXRYo7tVwpjx8YmoNrBhmVxQs",
        authDomain: "online-gift-store-bb0d8.firebaseapp.com",
        projectId: "online-gift-store-bb0d8",
        storageBucket: "online-gift-store-bb0d8.appspot.com",
        messagingSenderId: "169940591133",
        appId: "1:169940591133:web:89cca5795c0cee26865cf4",
        measurementId: "G-PGRGZQ30G1"
    )


 // await Firebase.initializeApp(
 //    options: const FirebaseOptions(
 //        apiKey: "AIzaSyA5_Ls7_puwbff3XBtZrwXRZXOnoax4eF8",
 //        authDomain: "online-gift-shop-project.firebaseapp.com",
 //        databaseURL: "https://online-gift-shop-project-default-rtdb.firebaseio.com",
 //        projectId: "online-gift-shop-project",
 //        storageBucket: "online-gift-store-bb0d8.appspot.com",
 //        messagingSenderId: "318114597835",
 //        appId: "1:318114597835:web:5809ff877b1fd47db0844e",
 //        measurementId: "G-QNVHZ8M248"
 //    )

  // await Firebase.initializeApp(
  //       options: const FirebaseOptions(
  //           apiKey: "AIzaSyD0Ic4vZej96SujRl0d3r6SE2S5MhdbUzM",
  //           authDomain: "online-gift-shop2.firebaseapp.com",
  //           projectId: "online-gift-shop2",
  //           storageBucket: "online-gift-shop2.appspot.com",
  //           messagingSenderId: "802005617416",
  //           appId: "1:802005617416:web:54c241ecd24569ba3a3abd",
  //           measurementId: "G-7S2XX3HE62"
  //       )



  );

  setPathUrlStrategy();
  runApp(const MyApp());

}


class MyApp extends StatelessWidget
{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp
      (
      title: "Online Gift Shop",

      debugShowCheckedModeBanner: false,

      theme: ThemeData
        (
          colorScheme: ColorScheme.fromSwatch().copyWith
            (
            primary: const Color.fromARGB(255, 20, 15, 45),
            secondary: const Color.fromARGB(255, 217, 4, 41),
          )
      ),

      initialRoute: '/login',

      routes: {
        '/login': (context) => const Login(),
        '/signup': (context) => const SignUp(),
        '/add_store_details': (context) => const AddStoreDetails(),
        '/home': (context) => const HomePage(),
        '/supplier': (context) => const SupplierPage(),
        '/employees': (context) => const ShowEmployeesTable(),
        '/add_an_employee': (context) => const AddEmployee(),
        '/inventory': (context) => const Inventory(),
        '/staff_home_page': (context) => const StaffHomePage(),
        '/staff_add_product': (context) => const StaffAddProduct(),

      },

      onUnknownRoute: (RouteSettings settings)
      {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) =>
              Scaffold(
                body: Center(
                  child: Container(

                    padding: const EdgeInsets.all(25),
                    margin: const EdgeInsets.all(25),

                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [

                        Text("404", style: GoogleFonts.comfortaa(
                          color: Colors.blue,
                          fontWeight: FontWeight.w400,
                          fontSize: 100,
                        ),),

                        const SizedBox(height: 20,),

                        Text("PAGE NOT FOUND", style: GoogleFonts.andikaNewBasic(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),),

                      ],
                    ),
                  ),
                ),
              ),

        );
      },

    );
  }
}
