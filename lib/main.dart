import 'package:flutter/material.dart';
import 'package:owner/Dashboard/show_employees_table.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Dashboard/home_page.dart';
import 'Registration and Login/add_store_details.dart';
import 'Registration and Login/login.dart';
import 'Registration and Login/sign_up.dart';


void main() async
{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyA5_Ls7_puwbff3XBtZrwXRZXOnoax4eF8",
        appId: "1:318114597835:web:5809ff877b1fd47db0844e",
        messagingSenderId: "318114597835",
        projectId: "online-gift-shop-project",
        storageBucket: "gs://online-gift-shop-project.appspot.com",
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

      initialRoute: '/employees',

      routes: {
        '/login': (context) => const Login(),
        '/signup': (context) => const SignUp(),
        '/add_store_details': (context) => const AddStoreDetails(),
        '/home': (context) => const HomePage(),
        '/employees': (context) => const ShowEmployeesTable(),
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
