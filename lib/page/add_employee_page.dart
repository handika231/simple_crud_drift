import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/custom_textfield_widget.dart';

class AddEmployeePage extends StatefulWidget {
  static const String routeName = '/addEmployee';
  const AddEmployeePage({super.key});

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _firstNameController = TextEditingController();

  final _lastNameController = TextEditingController();

  final _dateOfBirthDayController = TextEditingController();
  DateTime? _dateOfBirth;

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
            child: child ?? const SizedBox());
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
            onPressed: () {},
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
              TextFormField(
                readOnly: true,
                controller: _dateOfBirthDayController,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onTap: () => pickDateOfBirth(context),
                decoration: const InputDecoration(
                  labelText: 'date of birth',
                  border: OutlineInputBorder(),
                ),
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
}
