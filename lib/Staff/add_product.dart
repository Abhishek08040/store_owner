import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:velocity_x/velocity_x.dart';

class StaffAddProduct extends StatefulWidget {
  const StaffAddProduct({Key? key}) : super(key: key);

  @override
  State<StaffAddProduct> createState() => _StaffAddProductState();
}

class _StaffAddProductState extends State<StaffAddProduct>
{
  final GlobalKey<FormState> _addProduct = GlobalKey<FormState>();
  late final TextEditingController _productStockCode = TextEditingController();
  late final TextEditingController _productName = TextEditingController();
  late final TextEditingController _productColor = TextEditingController();
  late final TextEditingController _productQuantity = TextEditingController();
  late final TextEditingController _productPrice = TextEditingController();
  late final TextEditingController _productDescription = TextEditingController();
  Uint8List display_photo = Uint8List(10);
  bool isImageSelected = false;


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(leading: const BackButton(),),
      body: Center(
        child: Form(
          key: _addProduct,

          child: SingleChildScrollView(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,

              children: [

                Container(

                  margin: const EdgeInsets.all(25),
                  padding: const EdgeInsets.all(30),

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
                          isImageSelected = true;
                        });
                      }
                    },

                    child: isImageSelected ? Image.memory(display_photo, height: 115, width: 115,) :
                    const Icon(Icons.add_a_photo_outlined, size: 60,),
                  ),
                ),

                const SizedBox(height: 20,),

                Container(

                  constraints: const BoxConstraints(maxWidth: 400,),

                  child: Row(

                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [

                      Column(
                        children: [

                          Text("Stock Code:", style: GoogleFonts.andikaNewBasic(),),

                          Container(

                            constraints: const BoxConstraints(
                              maxWidth: 120,
                            ),

                            child: TextFormField(

                              controller: _productStockCode,

                              validator: (value)
                              {
                                if (value!.isEmpty)
                                {
                                  return "Empty product's stock code";
                                }
                                return null;
                              },

                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 20,),

                      Column(
                        children: [

                          Text("Product name:", style: GoogleFonts.andikaNewBasic(),),

                          Container(

                            constraints: const BoxConstraints(
                              maxWidth: 260,
                            ),

                            child: TextFormField(

                              controller: _productName,

                              validator: (value)
                              {
                                if (value!.isEmpty)
                                {
                                  return "Please enter the product's name";
                                }
                                return null;
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

                const SizedBox(height: 20,),

                Container(
                  constraints: const BoxConstraints(maxWidth: 400,),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      FloatingActionButton.small(
                        backgroundColor: Colors.red,
                        onPressed: () {
                          setState(() {
                            _productColor.text = 'red';
                          });
                        },
                        child: Container(),
                      ),
                      FloatingActionButton.small(
                        backgroundColor: Colors.yellow,
                        onPressed: () {
                          setState(() {
                            _productColor.text = 'yellow';
                          });
                        },
                        child: Container(),
                      ),
                      FloatingActionButton.small(
                        backgroundColor: Colors.green,
                        onPressed: () {
                          setState(() {
                            _productColor.text = 'green';
                          });
                        },
                        child: Container(),
                      ),
                      FloatingActionButton.small(
                        backgroundColor: Colors.blue,
                        onPressed: () {
                          setState(() {
                            _productColor.text = 'blue';
                          });
                        },
                        child: Container(),
                      ),
                      FloatingActionButton.small(
                        backgroundColor: Colors.white,
                        onPressed: () {
                          setState(() {
                            _productColor.text = 'white';
                          });
                        },
                        child: Container(),
                      ),
                      FloatingActionButton.small(
                        backgroundColor: Colors.black,
                        onPressed: () {
                          setState(() {
                            _productColor.text = 'black';
                          });
                        },
                        child: Container(),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20,),

                Container(

                  constraints: const BoxConstraints(maxWidth: 400,),

                  child: Row(

                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [

                      Column(
                        children: [
                          Text("Enter the quantity:", style: GoogleFonts.andikaNewBasic(),),

                          Container(

                            constraints: const BoxConstraints(
                              maxWidth: 190,
                            ),

                            child: TextFormField(

                              controller: _productQuantity,

                              validator: (value)
                              {
                                if (value!.isEmpty)
                                {
                                  return "Empty quantity";
                                }

                                else if (!RegExp(r'^\d+$').hasMatch(value))
                                {

                                  return 'Invalid quantity';
                                }

                                return null;

                              },

                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 20,),

                      Column(
                        children: [

                          Text("Enter the price:", style: GoogleFonts.andikaNewBasic(),),

                          Container(

                            constraints: const BoxConstraints(
                              maxWidth: 190,
                            ),

                            child: TextFormField(

                              controller: _productPrice,

                              validator: (value)
                              {
                                if (value!.isEmpty)
                                {
                                  return "Please enter the price";
                                }

                                else if (!RegExp(r'^\d+$').hasMatch(value))
                                {

                                  return 'Invalid price';
                                }

                                return null;

                              },

                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.currency_rupee),
                              ),
                            ),
                          ),
                        ],
                      ),


                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Text("Enter the description:", style: GoogleFonts.andikaNewBasic(),),

                Container(

                  constraints: const BoxConstraints(
                    maxWidth: 400,
                  ),

                  child: TextFormField(

                    controller: _productDescription,

                    maxLines: 3,

                    validator: (value)
                    {
                      if (value!.isEmpty)
                      {
                        return "Empty description";
                      }

                      return null;

                    },

                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
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
          if (_addProduct.currentState!.validate())
            {
              final storageRef = FirebaseStorage
                  .instance
                  .ref('products/${_productName.text.toString()}');

                final imageRef = storageRef.child('display photo.png');
                imageRef.putData(display_photo, SettableMetadata(
                  contentType: "image/jpeg",
                ));
                String productPictureURL = await imageRef.getDownloadURL();


                Map <String, dynamic> newProduct =
                {
                  "Name" : _productName.text.toString(),
                  "Picture" : productPictureURL.substring(0, productPictureURL.length-43),
                  "Color" : _productColor.text.toString(),
                  "UnitPrice" : int.parse(_productPrice.text.toString()),
                  "Description" : _productDescription.text.toString(),
                  "Quantity" : int.parse(_productQuantity.text.toString()),
                  "QuantitySold" : 0,
                  "StockCode" : _productStockCode.text.toString(),
                  "SearchQueries" : _productName.text.toString().split(' '),
                  "Ratings Sum" : 0,
                  "Ratings Count" : 0,
                };


              FirebaseFirestore.instance.collection('Products')
                  .doc(_productStockCode.text)
                  .set(newProduct);


              MotionToast snackbar = MotionToast.success(
                title:  const Text("Product added successfully!"),
                description:  const Text("Your product has been created successfully!"),
              );

              snackbar.show(context);

              setState((){
                _productName.clear();
                _productStockCode.clear();
                _productColor.clear();
                _productQuantity.clear();
                _productPrice.clear();
                _productDescription.clear();
              });

            }
        },


        icon: const Icon(Icons.done_outlined),
        backgroundColor: Colors.pink,
        hoverColor: Vx.pink600,
        elevation: 10.0,
        label: Text("Done", style: GoogleFonts.openSans(),),
      ),

    );
  }
}
