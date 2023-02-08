import 'dart:typed_data';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp>
{
  @override
  Widget build(BuildContext context)
  {
    return Page1();
  }
}

class Page1 extends StatefulWidget
{
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1>
{
  GlobalKey<FormState> _sign_up_key1 = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _gender = new TextEditingController();
  TextEditingController _phone = new TextEditingController();
  Uint8List display_photo = new Uint8List(10);

  List<String> genderList = ['Male', 'Female', 'Other'];

  bool isImageLoaded = false;

  @override
  void initState()
  {

    rootBundle.load('images/display_photo.png')
        .then((data) => setState(()
        {
          this.display_photo = data.buffer.asUint8List();
          this.isImageLoaded = true;
        }));
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
      ),

      body: Form(

        key: _sign_up_key1,

        child: SingleChildScrollView(
          child: Center(
            child: Container(

            padding: const EdgeInsets.all(25),
            margin: const EdgeInsets.all(25),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Text("Sign Up", style: GoogleFonts.comfortaa(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 30,
                  ),),

                  const SizedBox(height: 20,),

                  Container(

                    margin: EdgeInsets.all(25),
                    padding: EdgeInsets.all(30),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 2, color: Colors.pinkAccent),
                    ),

                    child: InkWell(

                      onTap: ()
                      async
                      {
                        FilePickerResult? result = await FilePicker.platform.pickFiles(
                          type: FileType.image,
                        );

                        if (result != null)
                        {
                          setState(()
                          {
                            display_photo = result.files.single.bytes!;
                          });
                        }
                      },

                      child: isImageLoaded ? Image.memory(display_photo, height: 115, width: 115,) :
                          CircularProgressIndicator(color: Colors.blue,),
                    ),
                  ),

                  const SizedBox(height: 20,),

                  Text("Enter your Name:", style: GoogleFonts.andikaNewBasic(),),

                  Container(
                    constraints: BoxConstraints(
                      maxWidth: 400,
                    ),

                    child: TextFormField(

                      controller: _name,

                      validator: (value)
                      {
                        if (value!.isEmpty)
                        {
                          return "Please enter your name";
                        }
                      },

                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),


                    ),
                  ),

                  const SizedBox(height: 20,),

                  Container(
                    width: 400,

                    child: Row(

                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [

                        Column(
                          children: [

                            Text("Select your gender:", style: GoogleFonts.andikaNewBasic(),),

                            Container(
                              constraints: const BoxConstraints(
                                maxWidth: 125,
                              ),

                              child: DropdownButtonFormField2(
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),

                                isExpanded: true,

                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black45,
                                ),

                                iconSize: 30,

                                buttonHeight: 60,

                                buttonPadding: const EdgeInsets.only(left: 5, right: 5),

                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),

                                items: genderList
                                    .map((item) =>
                                    DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                    .toList(),

                                validator: (value)
                                {
                                  if (value == null)
                                  {
                                    return 'Empty selection';
                                  }
                                  return null;
                                },

                                onChanged: (value)
                                {
                                  setState(() {
                                    _gender.text = value.toString();
                                  });

                                },

                                onSaved: (value)
                                {
                                  setState(() {
                                    _gender.text = value.toString();
                                  });

                                },

                              ),
                            ),
                          ],
                        ),

                        Column(
                          children: [

                            Text("Enter your contact number:", style: GoogleFonts.andikaNewBasic(),),

                            Container(

                              constraints: BoxConstraints(
                                maxWidth: 265,
                              ),

                              child: TextFormField(

                                controller: _phone,

                                validator: (value)
                                {
                                  if (value!.isEmpty)
                                  {
                                    return "Please enter your contact number";
                                  }
                                  else if (!RegExp(r'^([+0][1-9])?[0-9]{10,12}$').hasMatch(value))
                                  {
                                    return "Please enter a valid contact number";
                                  }
                                },

                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async
        {
          if (_sign_up_key1.currentState!.validate())
            {
              // Go to next page
              Navigator.push(context, MaterialPageRoute(builder: (context)
              {
                return Page2(
                  name : _name,
                  gender : _gender,
                  phone : _phone,
                  display_photo : display_photo,
                );
              }));

            }
        },

        icon: Icon(Icons.arrow_forward_ios_outlined),
        backgroundColor: Colors.pink,
        hoverColor: Vx.pink600,
        elevation: 10.0,
        label: Text("Next", style: GoogleFonts.openSans(),),
      ),

    );
  }
}


class Page2 extends StatefulWidget
{
  final name;
  final gender;
  final phone;
  final display_photo;

  const Page2({Key? key, this.name, this.gender, this.phone, this.display_photo}) : super(key: key);


  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2>
{
  GlobalKey<FormState> _sign_up_key2 = GlobalKey<FormState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _designation = TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _location = new TextEditingController();

  String signUpMessage = '';
  bool isUserRegistered = false;
  List<String> employeeDesignationList = ['Owner', 'Accountant', 'Staff', 'Delivery boy', 'Other'];

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
      ),

      body: Form(

        key: _sign_up_key2,

        child: SingleChildScrollView(
          child: Container(

            padding: const EdgeInsets.all(25),
            margin: const EdgeInsets.all(25),

            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Text("Welcome ${widget.name.text.toString()}", style: GoogleFonts.comfortaa(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 30,
                  ),),

                  const SizedBox(height: 20,),

                  Container(
                    width: 400,

                    child: Row(

                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [

                        Column(
                          children: [

                            Text("Enter your email:", style: GoogleFonts.andikaNewBasic(),),

                            Container(

                              constraints: const BoxConstraints(
                                maxWidth: 265,
                              ),

                              child: TextFormField(

                                controller: _email,

                                validator: (value)
                                {
                                  if (value!.isEmpty)
                                  {
                                    return "Please enter your email address";
                                  }

                                  else if (!isEmail(value))
                                  {
                                    return "Please enter a valid email address";
                                  }

                                },

                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),

                        Column(
                          children: [

                            Text("Sign in as:", style: GoogleFonts.andikaNewBasic(),),

                            Container(
                              constraints: const BoxConstraints(
                                maxWidth: 125,
                              ),

                              child: DropdownButtonFormField2(
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),

                                isExpanded: true,

                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black45,
                                ),

                                iconSize: 30,

                                buttonHeight: 60,

                                buttonPadding: const EdgeInsets.only(left: 5, right: 5),

                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),

                                items: employeeDesignationList
                                    .map((item) =>
                                    DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                    .toList(),

                                validator: (value)
                                {
                                  if (value == null)
                                  {
                                    return 'Empty selection';
                                  }
                                  return null;
                                },

                                onChanged: (value)
                                {
                                  setState(() {
                                    _designation.text = value.toString();
                                  });

                                },

                                onSaved: (value)
                                {
                                  setState(() {
                                    _designation.text = value.toString();
                                  });

                                },

                              ),
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),

                  const SizedBox(height: 20,),

                  Text("Choose a password:", style: GoogleFonts.andikaNewBasic(),),

                  Container(

                    constraints: BoxConstraints(
                      maxWidth: 400,
                    ),

                    child: TextFormField(

                      obscureText: true,

                      controller: _password,

                      validator: (value)
                      {
                        if (value!.isEmpty)
                        {
                          return "Please enter a password";
                        }
                      },

                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),


                    ),
                  ),

                  const SizedBox(height: 20,),

                  Text("Confirm your password:", style: GoogleFonts.andikaNewBasic(),),

                  Container(

                    constraints: BoxConstraints(
                      maxWidth: 400,
                    ),

                    child: TextFormField(
                      obscureText: true,

                      validator: (value)
                      {
                        if (value != _password.text.toString())
                        {
                          return "Passwords do not match";
                        }
                      },

                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),


                    ),
                  ),

                  const SizedBox(height: 20,),

                  Text("Enter your location:", style: GoogleFonts.andikaNewBasic(),),

                  Container(

                    constraints: const BoxConstraints(
                      maxWidth: 400,
                    ),

                    child: TextFormField(

                      controller: _location,

                      validator: (value)
                      {
                        if (value!.isEmpty)
                        {
                          return "Please enter your location";
                        }
                      },

                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),

                  Text(signUpMessage, style: GoogleFonts.andikaNewBasic(color: Colors.red),),
                ],
              ),
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async
        {
          final storageRef = FirebaseStorage
              .instance
              .ref('employee data/${_email.text.toString()}');

          if (_sign_up_key2.currentState!.validate())
          {
            final image_ref = storageRef.child('display photo.png');
            image_ref.putData(widget.display_photo, SettableMetadata(
              contentType: "image/jpeg",
            ));
            String profilePictureURL = await image_ref.getDownloadURL();


            Map <String, dynamic> newEmployee =
            {
              "Name" : widget.name.text.toString(),
              "Profile Picture" : profilePictureURL.substring(0, profilePictureURL.length-43),
              "Gender" : widget.gender.text.toString(),
              "Phone" : widget.phone.text.toString(),
              "Email" : _email.text.toString(),
              "Location" : _location.text.toString(),
            };

            FirebaseFirestore
                .instance
                .collection('Employees')
                .where("Email",isEqualTo: _email.text.toString())
                .get()
                .then((value)
            {
              if (value.docs.length > 0)
              {
                setState(() {
                  isUserRegistered = true;
                });
              }
            });

            if (isUserRegistered || _designation.text.toString() == 'Owner')
            {
              setState(() {
                signUpMessage = '';
              });

              try
              {
                UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: _email.text.toString(),
                  password: _password.text.toString(),
                );

                _designation.text.toString() == 'Owner' ?
                FirebaseFirestore.instance.collection('Employees')
                    .doc(_email.text.toString())
                    .set(newEmployee) :
                FirebaseFirestore.instance.collection('Employees')
                    .doc(_email.text.toString())
                    .update(newEmployee);

                MotionToast snackbar = MotionToast.success(
                  title:  const Text("Account created successfully!"),
                  description:  const Text("Your account has been created successfully!"),
                );

                WidgetsBinding.instance.addPostFrameCallback((timeStamp)
                {
                  snackbar.show(context);
                });

                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('owner name', widget.name.text.toString());

                if (_designation.text.toString() == 'Owner')
                  {
                    Navigator.pushNamedAndRemoveUntil(context, '/add_store_details', (route) => false);
                  }
                else
                  {
                    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                  }
              }

              on FirebaseAuthException catch (e)
              {
                if (e.code == 'weak-password')
                {
                  signUpMessage = 'The password provided is too weak.';
                }
                else if (e.code == 'email-already-in-use')
                {
                  signUpMessage = 'The account already exists for that email.';
                }
              }

              catch (e)
              {

              }
              setState(() {

              });
            }

            else
            {
              setState(() {
                signUpMessage = 'Your email is not registered to any store';
              });
            }

          }
        },

        icon: Icon(Icons.done_outlined),
        backgroundColor: Colors.pink,
        hoverColor: Vx.pink600,
        elevation: 10.0,
        label: Text("Done", style: GoogleFonts.openSans(),),
      ),

    );
  }
}