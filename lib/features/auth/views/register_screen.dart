import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_placement/common/utils/utils.dart';
import 'package:job_placement/features/auth/cubit/register_cubit.dart';
import 'package:job_placement/features/auth/views/auth_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Enter your email",
                  style: applyTextStyle(20, FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a valid email";
                    } else if (!value.contains('@') || !value.contains('.')) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  decoration: InputDecoration(
                      hintText: "email",
                      label: Text("Email"),
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Enter your username",
                  style: applyTextStyle(20, FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _userController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter username";
                    }
                    return null;
                  },
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  decoration: InputDecoration(
                    hintText: "username",
                    label: Text("Username"),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Enter your password",
                  style: applyTextStyle(20, FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a valid password";
                    } else if (value.length < 3) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  decoration: InputDecoration(
                    hintText: "password",
                    label: Text("Password"),
                    border: OutlineInputBorder(),
                  ),
                ),
                Row(children: [
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text("Forgot Password?",
                        style: applyTextStyle(15, FontWeight.bold)),
                  ),
                ]),
                SizedBox(
                  height: (30),
                ),
                BlocConsumer<RegisterCubit, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "Registerd Successfully,Now login using email and password"),
                        ),
                      );
                      Navigator.of(context).pop();
                    }
                    if (state is RegisterError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<RegisterCubit>().registerUser(
                              name: _userController.text,
                              email: _emailController.text,
                              password: _passwordController.text);
                        }
                      },
                      child: Text(
                        "Register",
                        style: applyTextStyle(20, FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          foregroundColor:
                              Theme.of(context).colorScheme.onBackground,
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                    );
                  },
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
