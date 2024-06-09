import 'package:Easy/common/SnackBar/lower_snack_bar.dart';
import 'package:Easy/common/utils/colors.dart';
import 'package:Easy/provider/controller/AuthController.dart';
import 'package:Easy/provider/controller/UserController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../common/custom_widget/CustomTtextFormFeild.dart';

class RegisterFromPage extends StatefulWidget {
  final String email;
  final String password;

  const RegisterFromPage(
      {super.key, required this.email, required this.password});

  @override
  State<RegisterFromPage> createState() => _RegisterFromPageState();
}

class _RegisterFromPageState extends State<RegisterFromPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  String _selectedUserType = 'Admin';
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 35),
                child: const Stack(
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
                    lable: 'First Name',
                    controller: _firstNameController,
                    keybordType: TextInputType.text,
                  ),
                  CustomTextFormFeild(
                    lable: 'Last Name',
                    controller: _lastNameController,
                    keybordType: TextInputType.text,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  CustomTextFormFeild(
                    lable: 'Phone Number',
                    controller: _phoneNumberController,
                    keybordType: TextInputType.phone,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
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
                  value: _selectedUserType,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedUserType = newValue!;
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
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: FloatingActionButton(
          backgroundColor: primary,
          onPressed: register,
          child: GetBuilder<UserController>(
            builder: (controller) {
              return controller.isLoading
                  ? const SpinKitWanderingCubes(
                      color: Colors.white,
                      size: 20,
                    )
                  : const Icon(
                      Icons.done,
                      color: Colors.white,
                    );
            },
          ),
        ),
      ),
    );
  }

  register() {
    String fName = _firstNameController.text;
    String lName = _lastNameController.text;
    String phoneNumber = _phoneNumberController.text;
    String userType = _selectedUserType;
    String? sex = _selectedGender;

    AuthController authController = Get.find();
    LowerSnackBar lowerSnackBar = Get.find();
    UserController userController = Get.find();

    userController.controlLoading(true);

    if (fName.isEmpty) {
      userController.controlLoading(false);
      lowerSnackBar.warningSnackBar(context, 'Please Enter First Name');
    } else if (lName.isEmpty) {
      userController.controlLoading(false);
      lowerSnackBar.warningSnackBar(context, 'Please Enter Last Name');
    } else if (phoneNumber.isEmpty) {
      userController.controlLoading(false);
      lowerSnackBar.warningSnackBar(context, 'Please Enter PhoneNumber');
    } else if (userType.isEmpty) {
      userController.controlLoading(false);
      lowerSnackBar.warningSnackBar(context, 'Please Choose User Type');
    } else if (sex!.isEmpty) {
      userController.controlLoading(false);
      lowerSnackBar.warningSnackBar(context, 'Please Choose Gender');
    } else {
      authController.registerUser(
        context,
        _firstNameController.text,
        _lastNameController.text,
        widget.email,
        widget.password,
        _phoneNumberController.text,
        _selectedUserType,
        'profileUrl',
        _selectedGender!,
      );
    }
  }
}
