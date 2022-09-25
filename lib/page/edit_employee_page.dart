import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_drift/data/local/db/app_db.dart';
import 'package:simple_drift/widgets/custom_datetime_widget.dart';

import '../widgets/custom_textfield_widget.dart';

class EditEmployeePage extends StatefulWidget {
  static const String routeName = '/editEmployee';
  const EditEmployeePage({super.key});

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
  late AppDB _appDB;
  @override
  void initState() {
    super.initState();
    _appDB = AppDB();
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
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              addDataEmployee().then(
                (_) {
                  Navigator.pop(context);
                },
              );
            },
            icon: const Icon(Icons.save),
          ),
        ],
        title: const Text('Add Employee'),
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

  Future addDataEmployee() async {
    final entity = EmployeeCompanion(
      userName: Value(_nameController.text),
      firstName: Value(_firstNameController.text),
      lastName: Value(_lastNameController.text),
      dateOfBirth: Value(_dateOfBirth!),
    );
    _appDB.insertEmployee(entity).then(
          (value) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Employee added successfully',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              action: SnackBarAction(
                label: 'Ok',
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.white,
            ),
          ),
        );
  }
}
