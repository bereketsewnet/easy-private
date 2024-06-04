import 'package:Easy/CustomUi/CustomTtextFormFeild.dart';
import 'package:Easy/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterFromScreen extends StatefulWidget {
  const RegisterFromScreen({super.key});

  @override
  State<RegisterFromScreen> createState() => _RegisterFromScreenState();
}

class _RegisterFromScreenState extends State<RegisterFromScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  String _selectedRole = 'Admin';
  String? _selectedGender;

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Additional'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 35),
              child:  const Stack(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.grey,
                    // hello
                    backgroundImage: AssetImage('assets/sample_profile.jpg'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: secondary,
                      radius: 13,
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                CustomTextFormFeild(
                    lable: 'First Name', controller: _firstNameController),
                CustomTextFormFeild(
                    lable: 'Last Name', controller: _lastNameController),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                CustomTextFormFeild(
                  lable: 'Phone Number',
                  controller: _phoneNumberController,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(
                left: 20,
                top: 10,
                right: 20,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: DropdownButton<String>(
                value: _selectedRole,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRole = newValue!;
                  });
                },
                style: const TextStyle(
                  color: primary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                underline: Container(),
                elevation: 0,
                dropdownColor: Colors.white,
                icon: const Icon(
                  Icons.arrow_downward_outlined,
                  color: primary,
                  size: 24,
                ),
                items: <String>['Admin', 'Teacher', 'Student', 'Parent']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      activeColor: Colors.white,
                      tileColor: primary,
                      title: const Text(
                        'Male',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      value: 'male',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: RadioListTile<String>(
                      activeColor: Colors.white,
                      tileColor: primary,
                      title: const Text(
                        'Female',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      value: 'female',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom:20),
        child: FloatingActionButton(
          backgroundColor: primary,
          onPressed: () {},
          child: const Icon(
            Icons.done,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
