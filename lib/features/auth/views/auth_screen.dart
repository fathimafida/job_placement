import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_placement/common/utils/utils.dart';
import 'package:job_placement/features/auth/cubit/auth_cubit.dart';
import 'package:job_placement/features/auth/views/register_screen.dart';

import 'package:job_placement/features/home/views/home_view.dart';
import 'package:logman/logman.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Logman.instance.attachOverlay(
        context: context,
      );
    });
  }

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: "20mcs24@meaec.edu.in");
  final _passwordController = TextEditingController(text: "123456");

  void _onLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().loginUser(
          email: _emailController.text, password: _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Enter your email",
                        style: applyTextStyle(16, FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a valid email";
                          } else if (!value.contains('@') ||
                              !value.contains('.')) {
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
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Enter your password",
                        style: applyTextStyle(16, FontWeight.bold),
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
                          child: Text(
                            "Forgot Password?",
                            style: applyTextStyle(15, FontWeight.bold),
                          ),
                        ),
                      ]),
                      SizedBox(
                        height: (30),
                      ),
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is AuthSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Login Successfully")));

                            navigateTO(context, JobHomeScreen());
                          }
                          if (state is AuthError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.message)));
                          }
                        },
                        builder: (context, state) {
                          if (state is AuthLoading) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ElevatedButton(
                            onPressed: _onLogin,
                            child: Text(
                              "Login",
                              style: applyTextStyle(18, FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                foregroundColor:
                                    Theme.of(context).colorScheme.onBackground,
                                minimumSize: Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: applyTextStyle(14, FontWeight.normal),
                          ),
                          TextButton(
                              onPressed: () {
                                navigateTO(context, RegisterScreen());
                              },
                              child: Text(
                                "Sign Up",
                                style: applyTextStyle(14, FontWeight.normal),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
