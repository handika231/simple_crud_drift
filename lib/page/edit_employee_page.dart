import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_drift/data/local/db/app_db.dart';
import 'package:simple_drift/widgets/custom_datetime_widget.dart';

import '../widgets/custom_textfield_widget.dart';

class EditEmployeePage extends StatefulWidget {
  static const String routeName = '/editEmployee';
  final int args;
  const EditEmployeePage({super.key, required this.args});

  @override
  State<EditEmployeePage> createState() => _EditEmployeePageState();
}

class _EditEmployeePageState extends State<EditEmployeePage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _firstNameController = TextEditingController();

  final _lastNameController = TextEditingController();

  final _dateOfBirthDayController = TextEditingController();
  DateTime? _dateOfBirth;
  final AppDB _appDB = AppDB.singleton;
  @override
  void initState() {
    super.initState();
    getEmployee();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dateOfBirthDayController.dispose();
    _appDB.close();

    super.dispose();
  }

  Future pickDateOfBirth(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? initialDate,
      firstDate: DateTime(initialDate.year - 100),
      lastDate: DateTime(initialDate.year + 100),
      confirmText: 'Select',
      builder: (context, child) {
        return Theme(
          data: ThemeData().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.pink,
              onPrimary: Colors.white,
              surface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child ?? const SizedBox(),
        );
      },
    );
    if (newDate == null) return;
    setState(() {
      _dateOfBirth = newDate;
      _dateOfBirthDayController.text = DateFormat('dd-MM-yyyy').format(newDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save),
          ),
        ],
        title: const Text('EDIT Employee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextField(
                controller: _nameController,
                name: 'Username',
              ),
              const SizedBox(
                height: 12,
              ),
              CustomTextField(
                controller: _firstNameController,
                name: 'First Name',
              ),
              const SizedBox(
                height: 12,
              ),
              CustomTextField(
                controller: _lastNameController,
                name: 'Last Name',
              ),
              const SizedBox(
                height: 12,
              ),
              CustomDateTimeWidget(
                controller: _dateOfBirthDayController,
                onPressed: () => pickDateOfBirth(context),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getEmployee() async {
    EmployeeData employee = await _appDB.getEmployeeById(widget.args);
    _nameController.text = employee.userName;
    _firstNameController.text = employee.firstName;
    _lastNameController.text = employee.lastName;
    _dateOfBirthDayController.text =
        DateFormat('dd/MM/yyyy').format(employee.dateOfBirth);
    _dateOfBirth = employee.dateOfBirth;
  }
}
