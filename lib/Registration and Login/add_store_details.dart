import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validators/validators.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:file_picker/file_picker.dart';
import 'package:getwidget/getwidget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motion_toast/motion_toast.dart';


class AddStoreDetails extends StatefulWidget {
  const AddStoreDetails({Key? key}) : super(key: key);

  @override
  State<AddStoreDetails> createState() => _AddStoreDetailsState();
}

class _AddStoreDetailsState extends State<AddStoreDetails>
{
  @override
  Widget build(BuildContext context)
  {
    return Page1();
  }
}

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1>
{
  GlobalKey<FormState> _storeDetailsPage1 = GlobalKey<FormState>();
  TextEditingController _storeName = TextEditingController();
  Uint8List storeLogo = new Uint8List(10);

  bool isImageLoaded = false;

  @override
  void initState()
  {
    rootBundle.load('images/store_logo_default.png')
        .then((data) => setState(()
        {
          this.storeLogo = data.buffer.asUint8List();
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

        key: _storeDetailsPage1,

        child: SingleChildScrollView(
          child: Container(

          padding: const EdgeInsets.all(25),
          margin: const EdgeInsets.all(25),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Add store details", style: GoogleFonts.comfortaa(
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
                      // Change store logo
                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                        type: FileType.image,
                      );

                      if (result != null)
                      {
                        setState(()
                        {
                          storeLogo = result.files.single.bytes!;
                        });
                      }
                    },

                    child: isImageLoaded ? Image.memory(storeLogo, height: 135, width: 135,) :
                        CircularProgressIndicator(color: Colors.blue,),
                  ),
                ),

                const SizedBox(height: 20,),

                Center(
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      Text("Enter your store name:", style: GoogleFonts.andikaNewBasic(),),

                      Container(

                        constraints: BoxConstraints(
                          maxWidth: 400,
                        ),

                        child: TextFormField(

                          controller: _storeName,

                          validator: (value)
                          {
                            if (value!.isEmpty)
                            {
                              return "Please enter the store name";
                            }
                          },

                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),


                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),

      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async
        {
          if (_storeDetailsPage1.currentState!.validate())
            {

              // Go to next page
              Navigator.push(context, MaterialPageRoute(builder: (context)
              {
                return Page2(
                    store_name : _storeName.text.toString(),
                    store_logo : storeLogo,
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
  final store_name;
  final store_logo;

  const Page2({Key? key,
    this.store_name,
    this.store_logo,
  }) : super(key: key);


  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2>
{
  GlobalKey<FormState> _storeDetailsPage2 = GlobalKey<FormState>();

  TextEditingController _storeOwnerName = new TextEditingController();
  TextEditingController _storeEmail = new TextEditingController();
  TextEditingController _storePhone = new TextEditingController();
  TextEditingController _storeLoc = new TextEditingController();


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
      ),

      body: Form(

        key: _storeDetailsPage2,

        child: SingleChildScrollView(
          child: Container(

            padding: const EdgeInsets.all(25),
            margin: const EdgeInsets.all(25),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Text("Add store details", style: GoogleFonts.comfortaa(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 30,
                ),),

                const SizedBox(height: 20,),

                Center(
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      Text("Enter the owner's name:", style: GoogleFonts.andikaNewBasic(),),

                      Container(

                        constraints: BoxConstraints(
                          maxWidth: 400,
                        ),

                        child: TextFormField(

                          controller: _storeOwnerName,

                          validator: (value)
                          {
                            if (value!.isEmpty)
                            {
                              return "Please enter the owner's name";
                            }
                          },

                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),


                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20,),

                Center(
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      Text("Enter the contact number:", style: GoogleFonts.andikaNewBasic(),),

                      Container(

                        constraints: BoxConstraints(
                          maxWidth: 400,
                        ),

                        child: TextFormField(

                          controller: _storePhone,

                          validator: (value)
                          {
                            if (value!.isEmpty)
                            {
                              return "Please enter the contact number";
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
                ),

                const SizedBox(height: 20,),

                Center(
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      Text("Enter the email address:", style: GoogleFonts.andikaNewBasic(),),

                      Container(

                        constraints: const BoxConstraints(
                          maxWidth: 400,
                        ),

                        child: TextFormField(

                          controller: _storeEmail,

                          validator: (value)
                          {
                            if (value!.isEmpty)
                            {
                              return "Please enter the email address";
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
                ),

                const SizedBox(height: 20,),

                Center(
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      Text("Enter the store location:", style: GoogleFonts.andikaNewBasic(),),

                      Container(

                        constraints: BoxConstraints(
                          maxWidth: 400,
                        ),

                        child: TextFormField(

                          controller: _storeLoc,

                          validator: (value)
                          {
                            if (value!.isEmpty)
                            {
                              return "Please enter the store location";
                            }
                          },

                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),


                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),

      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()
        {
          if (_storeDetailsPage2.currentState!.validate())
          {
            // Go to next page
            Navigator.push(context, MaterialPageRoute(builder: (context)
            {
              return Page3(
                store_name : widget.store_name.toString(),
                store_logo : widget.store_logo,

                owner_name : _storeOwnerName.text.toString(),
                contact_number : _storePhone.text.toString(),
                email_address : _storeEmail.text.toString(),
                store_location : _storeLoc.text.toString(),

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


class Page3 extends StatefulWidget {

  final store_name;
  final store_logo;
  final owner_name;
  final contact_number;
  final email_address;
  final store_location;

  const Page3({Key? key,
    this.store_name,
    this.store_logo,
    this.owner_name,
    this.contact_number,
    this.email_address,
    this.store_location,
  }) : super(key: key);

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3>
{

  GlobalKey<FormState> _storeDetailsPage3 = GlobalKey<FormState>();

  TextEditingController _GSTIdentificationNumber = new TextEditingController();
  TextEditingController _UPI_ID = new TextEditingController();
  List<PlatformFile> document_files_added = <PlatformFile>[];

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
      ),

      body: SingleChildScrollView(
        child: Form(

          key: _storeDetailsPage3,

          child: Container(

            padding: const EdgeInsets.all(25),
            margin: const EdgeInsets.all(25),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Text("Add store details", style: GoogleFonts.comfortaa(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 30,
                ),),

                const SizedBox(height: 20,),

                Center(
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      Text("Enter GST Identification number: ", style: GoogleFonts.andikaNewBasic(),),

                      Container(

                        constraints: BoxConstraints(
                          maxWidth: 400,
                        ),

                        child: TextFormField(

                          controller: _GSTIdentificationNumber,

                          validator: (value)
                          {
                            if (value!.isEmpty)
                            {
                              return "Please enter the GST Identification number";
                            }
                            else if (!RegExp(r'^[0-9]{2}[A-Z0-9]{10}[0-9]{1}Z[A-Z0-9]{1}$').hasMatch(value))
                              {
                                return 'Invalid GST Identification number';
                              }
                          },

                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),


                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20,),

                Center(
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      Text("Enter store's UPI ID:", style: GoogleFonts.andikaNewBasic(),),

                      Container(

                        constraints: BoxConstraints(
                          maxWidth: 400,
                        ),

                        child: TextFormField(

                          controller: _UPI_ID,

                          validator: (value)
                          {
                            if (value!.isEmpty)
                            {
                              return "Please enter the UPI ID";
                            }

                            else if (!RegExp(r'^[a-z0-9.-]+@[a-z]+$').hasMatch(value))
                            {
                              return "Please enter a valid UPI ID";
                            }
                          },

                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),


                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20,),

                InkWell(
                    child: Text("Upload documents",
                      style: GoogleFonts.andikaNewBasic(color: Colors.blueAccent, textStyle: TextStyle(fontSize: 15),),
                    ),

                  onTap: ()
                  async
                  {
                    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

                    if (result == null) return;
                    document_files_added += result.files;
                    setState(()
                    {

                    });

                  },
                ),

                SizedBox(height: 5,),

                SingleChildScrollView(

                  child: Center(
                    child: SizedBox(
                      height: 200,
                      width: 500,
                      child: ListView.builder(
                          itemCount: document_files_added.length,
                          itemBuilder: (BuildContext context, int index)
                          {
                            return ListTile(
                              title: Text(document_files_added[index].name.toString()),
                              trailing: SizedBox(
                                height: 35,
                                child: ElevatedButton.icon(
                                  icon: Icon(
                                    Icons.delete_outline, color: Colors.black,),
                                    onPressed: () async
                                    {
                                      document_files_added.remove(document_files_added[index]);
                                      setState(()
                                      {

                                      });
                                    },
                                  label: Text("Remove",
                                    style: TextStyle(color: Colors.black),),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(
                                        const Color.fromARGB(255, 206, 208, 206),
                                      ),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            side: BorderSide(color: Vx.black),
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                      ),
                    ),
                  ),
                ),

            ],
            ),
          ),

        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()
        {
          if (_storeDetailsPage3.currentState!.validate())
          {
            // Go to next page
            Navigator.push(context, MaterialPageRoute(builder: (context)
            {
              return Page4(
                store_name : widget.store_name.toString(),
                store_logo : widget.store_logo,
                owner_name : widget.owner_name.toString(),
                contact_number : widget.contact_number.toString(),
                email_address : widget.email_address.toString(),
                store_location : widget.store_location.toString(),

                GST_identification_number : _GSTIdentificationNumber.text.toString(),
                upi_id : _UPI_ID.text.toString(),
                document_files_added : document_files_added,

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


class Page4 extends StatefulWidget
{
    final store_name;
    final store_logo;
    final owner_name;
    final contact_number;
    final email_address;
    final store_location;
    final GST_identification_number;
    final upi_id;
    final document_files_added;

  const Page4({Key? key,
    this.store_name,
    this.store_logo,
    this.owner_name,
    this.contact_number,
    this.email_address,
    this.store_location,
    this.GST_identification_number,
    this.upi_id,
    this.document_files_added,

  }) : super(key: key);

  @override
  State<Page4> createState() => _Page4State();
}

class _Page4State extends State<Page4>
{

  List<PlatformFile> store_pictures = <PlatformFile>[];

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
      ),

      body: SingleChildScrollView(
        child: Container(

          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(20),

          child: Center(
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [

                Text("Add pictures of your store", style: GoogleFonts.comfortaa(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 30,
                ),),

                SizedBox(height: 18,),

                store_pictures.length > 0 ?
                GFItemsCarousel(
                  itemHeight: 400,
                  rowCount: 3,
                  children: store_pictures.map(
                        (store_image) {
                      return Container(

                        margin: EdgeInsets.all(10.0),
                        padding: EdgeInsets.all(10.0),

                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(35.0)),
                          child: GFCard(

                            borderOnForeground: true,
                            boxFit: BoxFit.cover,
                            image: Image.memory(store_image.bytes!, fit: BoxFit.fitHeight, height: 250,),
                            showImage: true,
                            content: IconButton(
                              iconSize: 30,
                              splashRadius: 30,
                              splashColor: Colors.black26,
                              icon: Icon(Icons.delete_outline),
                              color: Colors.black,
                              onPressed: ()
                              {
                                // delete

                                store_pictures.remove(store_image);

                                setState(()
                                {

                                });

                              },

                            ),
                          ),
                        ),

                      );
                    },
                  ).toList(),
                ) :
                    SizedBox(
                      height: 400,
                      width: 450,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(35.0)),
                        child: Card(

                          borderOnForeground: true,

                          child: Container(

                            padding: const EdgeInsets.all(25),
                            margin: const EdgeInsets.all(25),

                            child: Column(

                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                IconButton(
                                  iconSize: 40,
                                  splashRadius: 40,
                                  splashColor: Colors.pinkAccent,
                                  icon: Icon(Icons.add_a_photo_outlined),
                                  color: Colors.pink,
                                  onPressed: ()
                                  async
                                  {
                                    // add photos

                                    FilePickerResult? result = await FilePicker.platform.pickFiles(
                                        allowMultiple: true,
                                        type: FileType.image,
                                    );

                                    if (result == null) return;
                                    store_pictures += result.files;
                                    setState(()
                                    {

                                    });

                                  },

                                ),

                                SizedBox(height: 20,),

                                Text("Click here to add photos", style: GoogleFonts.andika(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),),

                              ],
                            ),
                          ),

                        ),
                      ),
                    ),

                SizedBox(height: 18,),

                store_pictures.length > 0 ?
                IconButton(
                  iconSize: 40,
                  splashRadius: 40,
                  splashColor: Colors.pinkAccent,
                  icon: Icon(Icons.add_a_photo_outlined),
                  color: Colors.pink,
                  onPressed: ()
                  async
                  {
                    // add photos

                    FilePickerResult? result = await FilePicker.platform.pickFiles(
                        allowMultiple: true,
                        type: FileType.image,
                    );

                    if (result == null) return;
                    store_pictures += result.files;
                    setState(()
                    {

                    });

                  },

                ) :
                    Container(),

              ],
            ),
          ),

        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async
        {
          final storageRef = FirebaseStorage.instance.ref(
              'online gift store/${widget.GST_identification_number}'
          );


          final image_ref = storageRef.child('logo.png');
          image_ref.putData(widget.store_logo);
          String store_logo_url = await image_ref.getDownloadURL();


          final store_documents_ref = storageRef.child('store documents');
          List<String> store_documents_url_list = <String>[];

          for (int i = 0; i < widget.document_files_added.length; i++)
          {
            TaskSnapshot uploaded_docs =  await store_documents_ref
                .child('${widget.document_files_added[i].name}')
                .putData(widget.document_files_added[i].bytes!);

            if (uploaded_docs.state == TaskState.success)
              {
                String store_documents_url = await store_documents_ref
                    .child('${widget.document_files_added[i].name}')
                    .getDownloadURL();

                store_documents_url_list.add(store_documents_url);
              }
          }


          final store_pictures_ref = storageRef.child('store pictures');
          List<String> store_pictures_url_list = <String>[];

          for (int i = 0; i < store_pictures.length; i++)
          {
            TaskSnapshot uploaded_pictures = await store_pictures_ref
                .child('${store_pictures[i].name}')
                .putData(store_pictures[i].bytes!);

            if (uploaded_pictures.state == TaskState.success)
              {
                String store_pictures_url = await store_pictures_ref
                    .child('${store_pictures[i].name}')
                    .getDownloadURL();

                store_pictures_url_list.add(store_pictures_url);
              }
          }

          Map <String, dynamic> newShop =
          {
            "Store name" : widget.store_name,
            "Store logo" : store_logo_url,
            "Owner's name" : widget.owner_name,
            "Contact no" : widget.contact_number,
            "Email" : widget.email_address,
            "Location" : widget.store_location,
            "GST Identification No" : widget.GST_identification_number,
            "UPI ID" : widget.upi_id,
            "Store pictures" : store_pictures_url_list,
            "Store documents" : store_documents_url_list,
          };

          FirebaseFirestore.instance.collection('online gift shop')
              .doc(widget.GST_identification_number)
              .set(newShop);


          MotionToast snackbar = MotionToast.success(
            title:  Text("Successfully Added!"),
            description:  Text("Your store has been added successfully!"),
          );

          WidgetsBinding.instance.addPostFrameCallback((timeStamp)
          {
            snackbar.show(context);
          });


          // Go to home page
          Navigator.pushNamedAndRemoveUntil(context, "/home" , (Route route) => false);
        },

        icon: Icon(Icons.arrow_forward_ios_outlined),
        backgroundColor: Colors.pink,
        hoverColor: Vx.pink600,
        elevation: 10.0,
        label: Text("Done", style: GoogleFonts.openSans(),),
      ),
    );
  }

}
