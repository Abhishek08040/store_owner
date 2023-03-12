import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ShowEmployeesTable extends StatefulWidget
{
  final selectedDesignation;
  const ShowEmployeesTable({Key? key,
    this.selectedDesignation}) : super(key: key);

  @override
  State<ShowEmployeesTable> createState() => _ShowEmployeesTableState();
}

class _ShowEmployeesTableState extends State<ShowEmployeesTable>
{
  CollectionReference employees = FirebaseFirestore
      .instance
      .collection('Employees');

  late EmployeesDataSource _employeesDataSource;


  @override
  Widget build(BuildContext context)
  {
    return FutureBuilder(
        future: widget.selectedDesignation.toString() == 'all' ?
        employees.get() :
        employees.where('Designation', isEqualTo: widget.selectedDesignation.toString()).get(),


        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot)
        {

          if (snapshot.connectionState == ConnectionState.waiting)
          {
            return const Center(child: CircularProgressIndicator());
          }


          else if (!snapshot.hasData || snapshot.data.docs.length < 1)
          {
            return Scaffold(

              appBar: AppBar(
                leading: const BackButton(),
              ),


              body: DefaultTextStyle(
                style: GoogleFonts.andikaNewBasic(textStyle: const TextStyle(
                    color: Color(0xff403b58)),
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
                child: const Center(
                  child: Text("No Employees Found!",
                  ),
                ),
              ),
            );
          }


          else if (snapshot.hasData && snapshot.connectionState == ConnectionState.done)
          {
            int no = 0;
            String profilePicture;
            String name;
            String gender;
            String designation;
            String joiningDate;
            String email;
            String phone;
            String location;
            int salary;

            var employeeRow;

            int itemCount = snapshot.data.docs.length;
            List<Employee> employeeList = <Employee>[];

            for (int i = 0; i < itemCount; i++)
            {
              no++;
              employeeRow = snapshot.data.docs[i].data();

              profilePicture = employeeRow['Profile Picture'].toString();
              name = employeeRow['Name'];
              gender = employeeRow['Gender'].toString();
              designation = employeeRow['Designation'];
              joiningDate = employeeRow['Joining Date'].toString();
              email = employeeRow['Email'];
              phone = employeeRow['Phone'].toString();
              location = employeeRow['Location'].toString();
              salary = employeeRow['Salary'] ?? 0;

              employeeList.add(Employee(
                  no,
                  profilePicture,
                  name,
                  gender,
                  designation,
                  joiningDate,
                  email,
                  phone,
                  location,
                  salary)
              );
            }

            _employeesDataSource = EmployeesDataSource(employees : employeeList);

            return Hero(
              tag: 'employee table',

              child: Scaffold(

                appBar: AppBar(
                  leading: const BackButton(),
                ),

                body: SingleChildScrollView(

                  child: SfDataGrid(
                      source: _employeesDataSource,
                      columnWidthMode: ColumnWidthMode.fill,
                      headerGridLinesVisibility: GridLinesVisibility.horizontal,
                      columns: [
                        GridColumn(
                            columnName: 'no',
                            width: 60,
                            label: Container(
                              color: const Color.fromARGB(255, 49, 175, 212),
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              alignment: Alignment.center,
                              child: const Text('No', overflow: TextOverflow.visible,
                                style: TextStyle(color: Colors.white),),
                            )
                        ),
                        GridColumn(
                            columnName: 'Profile\nPicture',
                            label: Container(
                              color: const Color.fromARGB(255, 49, 175, 212),
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              alignment: Alignment.center,
                              child: const Text('Profile Picture', overflow: TextOverflow.visible,
                                style: TextStyle(color: Colors.white),),
                            )
                        ),
                        GridColumn(
                            columnName: 'Name',
                            width: 150,
                            label: Container(
                              color: const Color.fromARGB(255, 49, 175, 212),
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              alignment: Alignment.center,
                              child: const Text('Name', overflow: TextOverflow.visible,
                                style: TextStyle(color: Colors.white),),
                            )
                        ),
                        GridColumn(
                            columnName: 'Gender',
                            label: Container(
                              color: const Color.fromARGB(255, 49, 175, 212),
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              alignment: Alignment.center,
                              child: const Text('Gender', overflow: TextOverflow.visible,
                                style: TextStyle(color: Colors.white),),
                            )
                        ),
                        GridColumn(
                            columnName: 'Designation',
                            label: Container(
                              color: const Color.fromARGB(255, 49, 175, 212),
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              alignment: Alignment.center,
                              child: const Text('Designation', overflow: TextOverflow.visible,
                                  style: TextStyle(color: Colors.white)),
                            )
                        ),
                        GridColumn(
                            columnName: 'Joining Date',
                            label: Container(
                              color: const Color.fromARGB(255, 49, 175, 212),
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              alignment: Alignment.center,
                              child: const Text('Joining Date', overflow: TextOverflow.visible,
                                  style: TextStyle(color: Colors.white)),
                            )
                        ),
                        GridColumn(
                            columnName: 'Email',
                            label: Container(
                              color: const Color.fromARGB(255, 49, 175, 212),
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              alignment: Alignment.center,
                              child: const Text('Email', overflow: TextOverflow.visible,
                                style: TextStyle(color: Colors.white),),
                            )
                        ),
                        GridColumn(
                            columnName: 'Phone',
                            label: Container(
                              color: const Color.fromARGB(255, 49, 175, 212),
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              alignment: Alignment.center,
                              child: const Text('Phone', overflow: TextOverflow.visible,
                                  style: TextStyle(color: Colors.white)),
                            )
                        ),
                        GridColumn(
                            columnName: 'Location',
                            label: Container(
                              color: const Color.fromARGB(255, 49, 175, 212),
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              alignment: Alignment.center,
                              child: const Text('Location', overflow: TextOverflow.visible,
                                  style: TextStyle(color: Colors.white)),
                            )
                        ),
                        GridColumn(
                            columnName: 'Salary',
                            label: Container(
                              color: const Color.fromARGB(255, 49, 175, 212),
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              alignment: Alignment.center,
                              child: const Text('Salary', overflow: TextOverflow.visible,
                                  style: TextStyle(color: Colors.white)),
                            )
                        ),
                      ]
                  ),
                ),
              ),
            );
          }


          return Scaffold(

            appBar: AppBar(
              leading: const BackButton(),
            ),


            body: DefaultTextStyle(
              style: GoogleFonts.poppins(textStyle: const TextStyle(
                  color: Color(0xff403b58)),
                fontSize: 32,
                fontWeight: FontWeight.w300,
              ),
              child: const Center(
                child: Text("Error loading\nemployees!",
                ),
              ),
            ),
          );

        }
    );
  }
}

class EmployeesDataSource extends DataGridSource
{
  EmployeesDataSource({required List<Employee> employees})
  {
    dataGridRows  = employees.map<DataGridRow>((e) => DataGridRow
      (
        cells: [
          DataGridCell<int>(columnName: 'no', value: e.no),
          DataGridCell<String>(columnName: 'Profile Picture', value: e.profilePicture),
          DataGridCell<String>(columnName: 'Name', value: e.name),
          DataGridCell<String>(columnName: 'Gender', value: e.gender),
          DataGridCell<String>(columnName: 'Designation', value: e.designation),
          DataGridCell<String>(columnName: 'Joining Date', value: e.joiningDate),
          DataGridCell<String>(columnName: 'Email', value: e.email),
          DataGridCell<String>(columnName: 'Phone', value: e.phone),
          DataGridCell<String>(columnName: 'Location', value: e.location),
          DataGridCell<int>(columnName: 'Salary', value: e.salary),
        ]
      )
    ).toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row)
  {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell)
        {
          return Container(
            alignment: Alignment.center,
            child: dataGridCell.value == 'null' ? const Text('NA') :

            dataGridCell.columnName == 'Profile Picture' ?
              dataGridCell.value == 'null' ? const Text('NA') : Image.network(dataGridCell.value) :

            dataGridCell.columnName == 'Salary' ?
              dataGridCell.value == 0 ? const Text('NA') :  Text(dataGridCell.value.toString()) :

            Text(dataGridCell.value.toString()),
          );
        }).toList()
    );
  }
}

class Employee
{
  Employee(
      this.no,
      this.profilePicture,
      this.name,
      this.gender,
      this.designation,
      this.joiningDate,
      this.email,
      this.phone,
      this.location,
      this.salary
      );

  final int no;
  final String profilePicture;
  final String name;
  final String gender;
  final String designation;
  final String joiningDate;
  final String email;
  final String phone;
  final String location;
  final int salary;
}