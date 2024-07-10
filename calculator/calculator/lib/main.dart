import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'sign_in_screen.dart';
import 'sign_up_screen.dart';
import 'calculator_screen.dart';
import 'connectivity_service.dart';
import 'battery_service.dart';
import 'theme_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<ThemeMode> _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = ThemeService().getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ThemeMode>(
      future: _themeMode,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        return MaterialApp(
          title: 'Calculator',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: snapshot.data ?? ThemeMode.dark,
          home: const HomeScreen(),
        );
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final ConnectivityService _connectivityService = ConnectivityService();
  final BatteryService _batteryService = BatteryService();
  final ThemeService _themeService = ThemeService();
  late bool _isDarkMode;

  final List<Widget> _screens = [
    const SignInScreen(),
    const SignUpScreen(),
    const CalculatorScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _connectivityService.startMonitoring();
    _batteryService.startMonitoring();
    _themeService.getTheme().then((themeMode) {
      setState(() {
        _isDarkMode = themeMode == ThemeMode.dark;
      });
    });
  }

  @override
  void dispose() {
    _connectivityService.stopMonitoring();
    super.dispose();
  }

  void _toggleTheme(bool isDarkMode) async {
    setState(() {
      _isDarkMode = isDarkMode;
    });
    ThemeMode themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    await _themeService.setTheme(themeMode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Calculator App'),
        actions: [
          Switch(
            value: _isDarkMode,
            onChanged: _toggleTheme,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 33, 103, 243),
              ),
              child: Text('Menu'),
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Sign In'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('Sign Up'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text('Calculator'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentIndex = 2;
                });
              },
            ),
          ],
        ),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Sign In',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Sign Up',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
        ],
      ),
    );
  }
}














// import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// import 'sign_in_screen.dart';
// import 'sign_up_screen.dart';
// import 'calculator_screen.dart';
// import 'connectivity_service.dart';
// import 'battery_service.dart';
// import 'theme_service.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   late Future<ThemeMode> _themeMode;

//   @override
//   void initState() {
//     super.initState();
//     _themeMode = ThemeService().getTheme();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<ThemeMode>(
//       future: _themeMode,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator();
//         }
//         return MaterialApp(
//           title: 'Calculator',
//           debugShowCheckedModeBanner: false,
//           theme: ThemeData.light(),
//           darkTheme: ThemeData.dark(),
//           themeMode: snapshot.data ?? ThemeMode.dark,
//           home: const HomeScreen(),
//         );
//       },
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _currentIndex = 0;
//   final ConnectivityService _connectivityService = ConnectivityService();
//   final BatteryService _batteryService = BatteryService();
//   final ThemeService _themeService = ThemeService();
//   late bool _isDarkMode;

//   final List<Widget> _screens = [
//     const SignInScreen(),
//     const SignUpScreen(),
//     const CalculatorScreen(),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _connectivityService.startMonitoring();
//     _batteryService.startMonitoring();
//     _themeService.getTheme().then((themeMode) {
//       setState(() {
//         _isDarkMode = themeMode == ThemeMode.dark;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _connectivityService.stopMonitoring();
//     super.dispose();
//   }

//   void _toggleTheme(bool isDarkMode) async {
//     setState(() {
//       _isDarkMode = isDarkMode;
//     });
//     ThemeMode themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
//     await _themeService.setTheme(themeMode);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Calculator App'),
//         actions: [
//           Switch(
//             value: _isDarkMode,
//             onChanged: _toggleTheme,
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             const DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Color.fromARGB(255, 33, 103, 243),
//               ),
//               child: Text('Menu'),
//             ),
//             ListTile(
//               leading: const Icon(Icons.login),
//               title: const Text('Sign In'),
//               onTap: () {
//                 Navigator.pop(context);
//                 setState(() {
//                   _currentIndex = 0;
//                 });
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.person_add),
//               title: const Text('Sign Up'),
//               onTap: () {
//                 Navigator.pop(context);
//                 setState(() {
//                   _currentIndex = 1;
//                 });
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.calculate),
//               title: const Text('Calculator'),
//               onTap: () {
//                 Navigator.pop(context);
//                 setState(() {
//                   _currentIndex = 2;
//                 });
//               },
//             ),
//           ],
//         ),
//       ),
//       body: _screens[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         selectedItemColor: Colors.orange,
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.login),
//             label: 'Sign In',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_add),
//             label: 'Sign Up',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.calculate),
//             label: 'Calculator',
//           ),
//         ],
//       ),
//     );
//   }
// }














































