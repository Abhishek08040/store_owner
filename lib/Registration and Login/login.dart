import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:validators/validators.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints)
          {
            if (constraints.maxWidth < 600)
            {
              return Container(
                padding: const EdgeInsets.all(25),
                margin: const EdgeInsets.all(25),
                child: Wrap(

                  children: const [
                    LoginCredentials(),
                    GiftStorePicture(),
                  ],
                ),
              );
            }
            else
            {
              return Container(
                padding: const EdgeInsets.all(25),
                margin: const EdgeInsets.all(25),
                child: Row(

                  children: [
                    LoginCredentials(),
                    GiftStorePicture(),
                  ],
                ),
              );
            }

          },

        ),
      ),
    );
  }
}

class LoginCredentials extends StatefulWidget {
  const LoginCredentials({Key? key}) : super(key: key);

  @override
  State<LoginCredentials> createState() => _LoginCredentialsState();
}

class _LoginCredentialsState extends State<LoginCredentials>
{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String loginMessage = '';

  @override
  Widget build(BuildContext context)
  {

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.all(25),

        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Text("Login", style: GoogleFonts.comfortaa(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 40,
              ),),
              const SizedBox(height: 20,),
              Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Enter your username:", style: GoogleFonts.andikaNewBasic(),),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value)
                    {
                      if (value!.isEmpty)
                      {
                        return "Please enter your email";
                      }
                      else if (!isEmail(value))
                      {
                        return "Invalid email";
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Enter your password:", style: GoogleFonts.andikaNewBasic(),),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value)
                    {
                      if (value!.isEmpty)
                      {
                        return "Please enter a password";
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Text(loginMessage, style: GoogleFonts.andikaNewBasic(color: Colors.red),),
                ],
              ),
              const SizedBox(height: 20,),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () async
                  {
                    if (_formKey.currentState!.validate())
                    {
                      try
                      {
                        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );

                        MotionToast snackbar = MotionToast.success(
                          title:  const Text("Logged in Successfully!"),
                          description:  const Text("You have been logged in successfully!"),
                        );

                        WidgetsBinding.instance.addPostFrameCallback((timeStamp)
                        {
                          snackbar.show(context);
                        });


                        FirebaseFirestore
                            .instance
                            .collection('Employees')
                            .where("Email",isEqualTo: _emailController.text)
                            .get()
                            .then((value)
                            {
                              String designation = value.docs.first['Designation'].toString() ?? 'Owner';

                              if (designation == 'Owner')
                              {
                                Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                              }
                              else if (designation=='Staff')
                              {

                                Navigator.pushNamedAndRemoveUntil(context, '/staff_home_page', (route) => false);
                              }

                            });


                      }

                      on FirebaseAuthException catch (e)
                      {
                        if (e.code == 'user-not-found')
                        {
                          loginMessage = 'No user found for that email.';
                        }
                        else if (e.code == 'wrong-password')
                        {
                          loginMessage = 'Wrong password provided for that user.';
                        }
                        setState(()
                        {


                        });
                      }
                    }

                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Vx.blue900,
                    ),
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                    ),
                  ),
                  child: Text("Login", style: GoogleFonts.openSans(),),
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("No account?", style: GoogleFonts.andikaNewBasic(),),
                  InkWell(
                    onTap: (){
                      // Sign up
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Text("Sign up", style: GoogleFonts.andikaNewBasic(
                        color: Colors.blue
                    ),),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(child: const Divider(thickness: 1, color: Colors.black,),),
                  Text(" OR ", style: GoogleFonts.sourceSansPro(),),
                  const Expanded(child: Divider(thickness: 1, color: Colors.black,),),
                ],
              ),
              const SizedBox(height: 20,),
              SizedBox(
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Sign in with Google


                  },
                  icon: Image.network('https://cdn-icons-png.flaticon.com/128/2504/2504914.png', height: 40, width: 40,),
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
                  label: Text("Sign in with Google", style: GoogleFonts.openSans(),),
                ),
              ),

            ],
          ),

        ),
      ),
    );

  }
}


class GiftStorePicture extends StatefulWidget {
  const GiftStorePicture({Key? key}) : super(key: key);

  @override
  State<GiftStorePicture> createState() => _GiftStorePictureState();
}

class _GiftStorePictureState extends State<GiftStorePicture>
{
  @override
  Widget build(BuildContext context)
  {
    return Expanded(
      child: Image.network('https://www.business2community.com/wp-content/uploads/2018/10/holiday-shopping-statistics-2018-presents.jpg'),
    );
  }
}



