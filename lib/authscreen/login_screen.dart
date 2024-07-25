import 'package:admin_panel/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'custom_clipper.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            clipper: MyCustomClipper(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/login_image.jpg'), // Use your image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.65),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // TextFormField(
                    //   keyboardType: TextInputType.emailAddress,
                    //   controller: phoneController,
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter your email';
                    //     }
                    //     return null;
                    //   },
                    //   decoration: InputDecoration(
                    //     filled: true,
                    //     fillColor: const Color(0xFFE0E0E0).withOpacity(0.8),
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(12),
                    //       borderSide: BorderSide.none,
                    //     ),
                    //     hintText: 'Email',
                    //     hintStyle: const TextStyle(color: Colors.black54),
                    //   ),
                    // ),
                    // const SizedBox(height: 16),
                    // Consumer<ObscureTextProvider>(
                    //   builder: (BuildContext context, value, Widget? child) {
                    //     return TextFormField(
                    //       controller: _passwordController,
                    //       keyboardType: TextInputType.visiblePassword,
                    //       validator: (value) {
                    //         if (value == null || value.isEmpty) {
                    //           return 'Please enter your password';
                    //         }
                    //         return null;
                    //       },
                    //       obscureText: value.isNotVisible,
                    //       decoration: InputDecoration(
                    //         suffix: GestureDetector(
                    //           onTap: () {
                    //             value.setVisibility();
                    //           },
                    //           child: Icon(value.isNotVisible
                    //               ? Icons.visibility_off
                    //               : Icons.visibility),
                    //         ),
                    //         filled: true,
                    //         fillColor: const Color(0xFFE0E0E0).withOpacity(0.8),
                    //         border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(12),
                    //           borderSide: BorderSide.none,
                    //         ),
                    //         hintText: 'Password',
                    //         hintStyle: const TextStyle(color: Colors.black54),
                    //       ),
                    //     );
                    //   },
                    // ),
                    // const SizedBox(height: 32),
                    Consumer<PhoneProvider>(
                      builder: (BuildContext context, PhoneProvider value,
                          Widget? child) {
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(
                                  0xffffa726), // Bright orange color
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () async {
                              value.login(context: context);
                            },
                            child: value.isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    'Send Code',
                                    style: TextStyle(
                                      color: Color(0xffffffff), // White color
                                      fontSize: 18,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                 ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
