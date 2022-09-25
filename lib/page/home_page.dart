import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_drift/data/local/db/app_db.dart';
import 'package:simple_drift/page/add_employee_page.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AppDB _appDB;
  @override
  void initState() {
    super.initState();
    _appDB = AppDB();
  }

  @override
  void dispose() {
    _appDB.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, AddEmployeePage.routeName);
        },
        label: const Text('Add Employee'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.amber,
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text('Home'),
      ),
      body: FutureBuilder<List<EmployeeData>>(
        future: _appDB.getAllEmployees(),
        initialData: const [],
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<EmployeeData> listOfEmployee = snapshot.data;
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                EmployeeData employee = listOfEmployee[index];
                String dateOfBirth = DateFormat('dd-MM-yyyy').format(
                  employee.dateOfBirth.toLocal(),
                );
                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AddEmployeePage.routeName,
                      arguments: employee.id,
                    );
                  },
                  title: Text(employee.userName),
                  subtitle: Text(dateOfBirth),
                );
              },
            );
          }
        },
      ),
    );
  }
}
