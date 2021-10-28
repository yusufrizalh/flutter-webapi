// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_webapi/form/form.dart';
import 'package:flutter_webapi/model/student.dart';
import 'package:flutter_webapi/nameprefix.dart';

import 'package:http/http.dart' as http;

class EditPage extends StatefulWidget {
  late final Student student;

  EditPage({required this.student});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final formKey = GlobalKey<FormState>();

  // properties
  TextEditingController? nameController;
  TextEditingController? ageController;
  TextEditingController? emailController;
  TextEditingController? phoneController;

  Future editStudent() async {
    final url = '${NamePrefix.URL_PREFIX}/update.php';
    return await http.post(Uri.parse(url), body: {
      'id': widget.student.id.toString(),
      'name': nameController!.text,
      'age': ageController!.text,
      'email': emailController!.text,
      'phone': phoneController!.text,
    });
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.student.name);
    ageController = TextEditingController(text: widget.student.age.toString());
    emailController = TextEditingController(text: widget.student.email);
    phoneController = TextEditingController(text: widget.student.phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Student'),
      ),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.all(
          12.0,
        ),
        child: Center(
          child: AppForm(
            formKey: formKey,
            nameController: nameController!,
            ageController: ageController!,
            emailController: emailController!,
            phoneController: phoneController!,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: () {
            _updateStudent(context);
          },
          child: Text('UPDATE'),
        ),
      ),
    );
  }

  void _updateStudent(context) async {
    await editStudent();

    // redirect
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }
}
