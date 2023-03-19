import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validators/validators.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({Key? key}) : super(key: key);

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee>
{
  final GlobalKey<FormState> _addEmployee = GlobalKey<FormState>();
  late final TextEditingController _employeeName = TextEditingController();
  late final TextEditingController _employeeDesignation = TextEditingController();
  late final TextEditingController _employeeJoiningDate = TextEditingController();
  late final TextEditingController _employeeEmail = TextEditingController();
  late final TextEditingController _employeeSalary = TextEditingController();

  final List<String> employeeDesignationList = ['Staff', 'Accountant', 'Delivery boy', 'Other'];

  @override
  Widget build(BuildContext context)
  {

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),

      body: Form(

        key: _addEmployee,

        child: SingleChildScrollView(
          child: Container(

            padding: const EdgeInsets.all(25),
            margin: const EdgeInsets.all(25),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Text("Add an Employee", style: GoogleFonts.comfortaa(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 30,
                ),),

                const SizedBox(height: 20,),

                Center(
                  child: Column(

                    children: [

                      Text("Enter the employee name:", style: GoogleFonts.andikaNewBasic(),),

                      Container(

                        constraints: const BoxConstraints(
                          maxWidth: 400,
                        ),

                        child: TextFormField(

                          controller: _employeeName,

                          validator: (value)
                          {
                            if (value!.isEmpty)
                            {
                              return "Please enter the employee name";
                            }
                            return null;
                          },

                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
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

                                Text("Select the designation:", style: GoogleFonts.andikaNewBasic(),),

                                Container(
                                  constraints: const BoxConstraints(
                                    maxWidth: 200,
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

                                    buttonPadding: const EdgeInsets.only(left: 20, right: 10),

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
                                        return 'Please select a designation.';
                                      }
                                      return null;
                                    },

                                    onChanged: (value)
                                    {
                                      setState(() {
                                        _employeeDesignation.text = value.toString();
                                      });

                                    },

                                    onSaved: (value)
                                    {
                                      setState(() {
                                        _employeeDesignation.text = value.toString();
                                      });

                                    },

                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(width: 20,),

                            Column(
                              children: [

                                Text("Select the joining date:", style: GoogleFonts.andikaNewBasic(),),

                                Container(

                                  constraints: const BoxConstraints(maxWidth: 180,),

                                  child: TextFormField(
                                    readOnly: true,

                                    onTap: ()
                                    {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            title: Center(
                                              child: Text('Select the joining date',
                                                style: GoogleFonts.andikaNewBasic(),
                                              ),
                                            ),
                                            content: SizedBox(
                                              height: 360,
                                              width: 500,

                                              child: Column(
                                                children: [

                                                  SfDateRangePicker(

                                                    view: DateRangePickerView.month,
                                                    selectionMode: DateRangePickerSelectionMode.single,
                                                    onSelectionChanged: (var dateSelected)
                                                    {
                                                      setState(()
                                                      {
                                                        _employeeJoiningDate.text = dateSelected
                                                            .value
                                                            .toString()
                                                            .substring(0,10);
                                                      });
                                                    },
                                                  ),



                                                  Align(
                                                    alignment: Alignment.centerRight,

                                                    child: IconButton(
                                                      iconSize: 30,
                                                      splashRadius: 30,
                                                      splashColor: Colors.black26,
                                                      icon: const Icon(Icons.done_outlined),
                                                      color: Colors.black,
                                                      onPressed: ()
                                                      {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                      );
                                    },

                                    controller: _employeeJoiningDate,

                                    validator: (value)
                                    {
                                      if (value!.isEmpty)
                                      {
                                        return "Please select the joining date";
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

                      Text("Enter the employee's email address:", style: GoogleFonts.andikaNewBasic(),),

                      Container(

                        constraints: const BoxConstraints(
                          maxWidth: 400,
                        ),

                        child: TextFormField(

                          controller: _employeeEmail,

                          validator: (value)
                          {
                            if (value!.isEmpty)
                            {
                              return "Please enter the employee's email address";
                            }

                            else if (!isEmail(value))
                            {
                              return "Please enter a valid email address";
                            }
                            return null;
                          },

                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20,),

                      _employeeDesignation.text.toString() == 'Delivery boy' ?
                          Text("Enter the earning per delivery:", style: GoogleFonts.andikaNewBasic()) :
                          Text("Enter the employee's salary:", style: GoogleFonts.andikaNewBasic(),),

                      Container(

                        constraints: const BoxConstraints(
                          maxWidth: 400,
                        ),

                        child: TextFormField(

                          controller: _employeeSalary,

                          validator: (value)
                          {
                            if (value!.isEmpty)
                            {
                              if (_employeeDesignation.text.toString() == 'Delivery boy')
                                {
                                  return "Please enter the earning per delivery";
                                }
                              return "Please enter the employee's salary";
                            }

                            else if (!RegExp(r'^\d+$').hasMatch(value))
                            {
                              if (_employeeDesignation.text.toString() == 'Delivery boy')
                              {
                                return "Invalid earnings";
                              }
                              return 'Invalid salary';
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
                ),

              ],
            ),
          ),
        ),

      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async
        {
          if (_addEmployee.currentState!.validate())
          {
            Map <String, dynamic> newEmployee =
            {
              "Name" : _employeeName.text.toString(),
              "Designation" : _employeeDesignation.text.toString(),
              "Joining Date" : _employeeJoiningDate.text.toString(),
              "Email" : _employeeEmail.text.toString(),
              "GST Identification No" : '12AAAAA0000A1Z6',
              "Salary" : int.parse(_employeeSalary.text.toString()),
              "Profile Picture" : null,
              "Gender" : null,
              "Phone" : null,
              "Location" : null,
            };

            FirebaseFirestore.instance.collection('Employees')
                .doc(_employeeEmail.text.toString())
                .set(newEmployee);

            MotionToast snackbar = MotionToast.success(
              title:  const Text("Successfully Added!"),
              description:  const Text("New employee has been added successfully!"),
            );


            WidgetsBinding.instance.addPostFrameCallback((timeStamp)
            {
              snackbar.show(context);
            });

            Navigator.pop(context);

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