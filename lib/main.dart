import 'package:flutter/material.dart';
import 'package:owner/Dashboard/add_employee.dart';
import 'package:owner/Dashboard/show_employees_table.dart';
import 'package:owner/Reports%20and%20Analytics/most_sold_products.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Dashboard/home_page.dart';
import 'Registration and Login/add_store_details.dart';
import 'Registration and Login/login.dart';
import 'Registration and Login/sign_up.dart';
import 'Reports and Analytics/inventory.dart';
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
      title: "Owner Page",

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
        '/most_sold_products': (context) => const MostSoldProducts(),
        '/inventory': (context) => const Inventory(),

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
