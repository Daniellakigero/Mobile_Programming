import 'package:calculator/main.dart';
import 'package:flutter/material.dart';
import 'auth_service.dart';
// import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthService _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  final confirmPassword = _confirmPasswordController.text;

                  if (password != confirmPassword) {
                    // Handle password mismatch
                    return;
                  }

                  final user = await _auth.signUpWithEmail(email, password);
                  if (user != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  } else {
                    // Handle sign-up error
                  }
                },
                child: const Text('Sign Up'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(300, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';

// class SignUpScreen extends StatelessWidget {
//   const SignUpScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               SizedBox(
//                 width:
//                     300, // Adjust this value to change the width of the input fields
//                 child: TextField(
//                   decoration: InputDecoration(
//                     labelText: 'Email',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     contentPadding:
//                         EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               SizedBox(
//                 width: 300,
//                 child: TextField(
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     contentPadding:
//                         EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                   ),
//                   obscureText: true,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               SizedBox(
//                 width: 300,
//                 child: TextField(
//                   decoration: InputDecoration(
//                     labelText: 'Confirm Password',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     contentPadding:
//                         EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                   ),
//                   obscureText: true,
//                 ),
//               ),
//               const SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: () {},
//                 child: const Text('Sign Up'),
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: Size(300, 40),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }







