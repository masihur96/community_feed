import 'package:community_feed_app/services/local_session.dart';
import 'package:community_feed_app/utils/app_color.dart';
import 'package:community_feed_app/utils/screen_size.dart';
import 'package:community_feed_app/viewmodels/auth_viewmodel.dart';
import 'package:community_feed_app/views/screens/feed_screen.dart';
import 'package:flutter/material.dart';

import '../../widgets/feed_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LocalSession localSession = LocalSession();
  bool _isLoading = false;
  bool _isSecure = false;
  bool _isRemember = false;
  final _formKey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";

  @override
  void initState() {
    navigateToNext();
    // TODO: implement initState
    super.initState();
  }

  navigateToNext() async {
    String? sessionToken = await localSession.getAccessToken();
    if (sessionToken != null && sessionToken.isNotEmpty) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => FeedScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade700, Colors.teal.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Logo
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenSize(context, .3),
                  ),
                  Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.cover,
                    height: screenSize(context, .28),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: screenSize(context, 1.3),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: FeedColors.tealDeep,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black87, // Shadow color
                        offset: Offset(0, -2), // Spread shadow upwards
                        blurRadius: 10, // Softness of the shadow
                        spreadRadius: 1, // Extend the shadow area
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Sign In Text
                          SizedBox(
                            height: screenSize(context, .02),
                          ),
                          Center(
                            child: Text(
                              'Sign In',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      color: Colors.white,
                                      fontSize: screenSize(context, .08)),
                            ),
                          ),
                          SizedBox(
                            height: screenSize(context, .08),
                          ),
                          // Email Field

                          Text(
                            "Email",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Colors.grey.shade300,
                                ),
                          ),
                          FeedTextFormField(
                            hintText: 'Email',
                            fillColor: FeedColors.tealLight,
                            textStyle: TextStyle(color: Colors.white),
                            hintTextStyle: TextStyle(color: Colors.white),
                            validator: (String? value) {
                              if (value == null || value.trim() == "") {
                                return 'Enter Email Address';
                              }
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(value)) {
                                return 'Invalid Email';
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              _email = value!;
                            },
                          ),

                          const SizedBox(height: 16),
                          // Password Field
                          Text(
                            "Password",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Colors.grey.shade300,
                                ),
                          ),
                          FeedTextFormField(
                            hintText: 'Password',
                            fillColor: FeedColors.tealLight,
                            suffixIconData: _isSecure
                                ? Icons.visibility
                                : Icons.visibility_off,
                            isObscure: _isSecure,
                            suffixOnTap: () {
                              setState(() {
                                _isSecure = !_isSecure;
                              });
                            },
                            suffixIconColor: Colors.white,
                            textStyle: const TextStyle(color: Colors.white),
                            hintTextStyle: const TextStyle(color: Colors.white),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Password field is empty"; // No error when the field is empty
                              }

                              return null;
                            },
                            onSaved: (String? value) {
                              _password = value!;
                            },
                          ),
                          const SizedBox(height: 16),
                          // Remember Me Checkbox
                          Row(
                            children: [
                              Checkbox(
                                value: _isRemember,
                                checkColor: Colors.white,
                                focusColor: Colors.white,
                                onChanged: (value) {
                                  setState(() {
                                    _isRemember = !_isRemember;
                                  });
                                },
                                fillColor:
                                    WidgetStateProperty.resolveWith<Color>(
                                  (Set<WidgetState> states) {
                                    if (states.contains(WidgetState.selected)) {
                                      return Colors
                                          .green; // Box color when checked
                                    } else if (states
                                        .contains(WidgetState.disabled)) {
                                      return Colors
                                          .grey; // Box color when disabled
                                    }
                                    return Colors
                                        .white; // Default box color when unchecked
                                  },
                                ),
                              ),
                              Text(
                                'Remember me',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          // Login Button
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _handleLogin,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: _isLoading
                                  ? const CircularProgressIndicator(
                                      color: FeedColors.tealDeep,
                                    )
                                  : Text(
                                      'Login',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: FeedColors.tealDeep,
                                          ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    final AuthViewModel _authViewModel = AuthViewModel();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      // Simulate login process
      setState(() {
        _isLoading = true;
      });
      bool? isSuccess = await _authViewModel.logIn(
        email: _email,
        password: _password,
      );

      if (isSuccess != null && isSuccess) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => FeedScreen()),
          (Route<dynamic> route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalied Email Or Password"),
          ),
        );
      } // Dummy delay for demonstration

      setState(() {
        _isLoading = false;
      });

      // Handle navigation or showing error dialog based on login success/failure here
    }
  }
}
