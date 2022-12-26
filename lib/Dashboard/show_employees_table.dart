import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ShowEmployeesTable extends StatefulWidget {
  const ShowEmployeesTable({Key? key}) : super(key: key);

  @override
  State<ShowEmployeesTable> createState() => _ShowEmployeesTableState();
}

class _ShowEmployeesTableState extends State<ShowEmployeesTable>
{
  CollectionReference employees = FirebaseFirestore
      .instance
      .collection('10AAAAA0000A1Z6/Employees/Employees Details');

  late EmployeesDataSource _employeesDataSource;

  @override
  Widget build(BuildContext context)
  {
    return
      FutureBuilder(
        future: employees.get(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot)
        {

          if (snapshot.connectionState == ConnectionState.waiting)
          {
            return Scaffold(
                body: Center(child: CircularProgressIndicator())
            );
          }


          else if (!snapshot.hasData || snapshot.data.docs.length < 1)
          {
            return Scaffold(
              body: DefaultTextStyle(
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    color: Color(0xff403b58)),
                  fontSize: 32,
                  fontWeight: FontWeight.w300,
                ),
                child: Center(
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

              profilePicture = employeeRow['Profile Picture'];
              name = employeeRow['Name'];
              gender = employeeRow['Gender'];
              designation = employeeRow['Designation'];
              joiningDate = employeeRow['Joining Date'];
              email = employeeRow['Email'];
              phone = employeeRow['Phone'];
              location = employeeRow['Location'];
              salary = employeeRow['Salary'];

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

            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Expanded(
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
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                alignment: Alignment.center,
                                child: const Text('No', overflow: TextOverflow.visible,
                                  style: TextStyle(color: Colors.white),),
                              )
                          ),
                          GridColumn(
                              columnName: 'Profile Picture',
                              label: Container(
                                color: const Color.fromARGB(255, 49, 175, 212),
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                alignment: Alignment.center,
                                child: Text('Profile Picture', overflow: TextOverflow.visible,
                                  style: TextStyle(color: Colors.white),),
                              )
                          ),
                          GridColumn(
                              columnName: 'Name',
                              width: 150,
                              label: Container(
                                color: const Color.fromARGB(255, 49, 175, 212),
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                alignment: Alignment.center,
                                child: Text('Name', overflow: TextOverflow.visible,
                                  style: TextStyle(color: Colors.white),),
                              )
                          ),
                          GridColumn(
                              columnName: 'Gender',
                              label: Container(
                                color: const Color.fromARGB(255, 49, 175, 212),
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                alignment: Alignment.center,
                                child: Text('Gender', overflow: TextOverflow.visible,
                                  style: TextStyle(color: Colors.white),),
                              )
                          ),
                          GridColumn(
                              columnName: 'Designation',
                              label: Container(
                                color: const Color.fromARGB(255, 49, 175, 212),
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                alignment: Alignment.center,
                                child: Text('Designation', overflow: TextOverflow.visible,
                                    style: TextStyle(color: Colors.white)),
                              )
                          ),
                          GridColumn(
                              columnName: 'Joining Date',
                              label: Container(
                                color: const Color.fromARGB(255, 49, 175, 212),
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                alignment: Alignment.center,
                                child: Text('Joining Date', overflow: TextOverflow.visible,
                                    style: TextStyle(color: Colors.white)),
                              )
                          ),
                          GridColumn(
                              columnName: 'Email',
                              label: Container(
                                color: const Color.fromARGB(255, 49, 175, 212),
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                alignment: Alignment.center,
                                child: Text('Email', overflow: TextOverflow.visible,
                                  style: TextStyle(color: Colors.white),),
                              )
                          ),
                          GridColumn(
                              columnName: 'Phone',
                              label: Container(
                                color: const Color.fromARGB(255, 49, 175, 212),
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                alignment: Alignment.center,
                                child: Text('Phone', overflow: TextOverflow.visible,
                                    style: TextStyle(color: Colors.white)),
                              )
                          ),
                          GridColumn(
                              columnName: 'Location',
                              label: Container(
                                color: const Color.fromARGB(255, 49, 175, 212),
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                alignment: Alignment.center,
                                child: Text('Location', overflow: TextOverflow.visible,
                                    style: TextStyle(color: Colors.white)),
                              )
                          ),
                          GridColumn(
                              columnName: 'Salary',
                              label: Container(
                                color: const Color.fromARGB(255, 49, 175, 212),
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                alignment: Alignment.center,
                                child: Text('Salary', overflow: TextOverflow.visible,
                                    style: TextStyle(color: Colors.white)),
                              )
                          ),
                        ]
                    ),
                  ),
                ],
              ),
            );
          }


          return Scaffold(
            body: DefaultTextStyle(
              style: GoogleFonts.poppins(textStyle: TextStyle(
                  color: Color(0xff403b58)),
                fontSize: 32,
                fontWeight: FontWeight.w300,
              ),
              child: Center(
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
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: dataGridCell.columnName == 'Profile Picture' ? 
            Image.network(dataGridCell.value) :
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