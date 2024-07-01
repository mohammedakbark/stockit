// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class NavigationPage extends StatefulWidget {
//   const NavigationPage({super.key});

//   @override
//   State<NavigationPage> createState() => _NavigationPageState();
// }

// class _NavigationPageState extends State<NavigationPage> {

//  List navigationPages=[
//   First(),
//   Second(),
//   Third()
//  ];
//   int _selectedindex=0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("data"),
//       backgroundColor: Colors,),
//       body:navigationPages[_selectedindex] ,

//       bottomNavigationBar: BottomNavigationBar(
//           showUnselectedLabels: true,
//           elevation: 0,
//           backgroundColor: const Color.fromARGB(139, 255, 255, 255),
//           items: [
//             const BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.home,
//                   size: 35,
//                 ),
//                 label: ('Home')),
//             const BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.library_books_rounded,
//                   size: 35,
//                 ),
//                 label: ('Orders')),
//             const BottomNavigationBarItem(
//                 icon: Icon(Icons.local_offer, size: 35),
//                 label: ('Special item')),
//           ],
//           currentIndex: _selectedindex,
//           selectedItemColor: const Color.fromARGB(255, 100, 74, 1),
//           unselectedItemColor: Colors.black,
//           onTap: (index) {
//             setState(() {
//               _selectedindex = index;
//             });
//           }),

//     );
//   }
// }



// class First extends StatelessWidget {
//   const First({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text("1 st"),);
//   }
// }

// class Second extends StatelessWidget {
//   const Second({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text("2 st"),);
//   }
// }

// class Third extends StatelessWidget {
//   const Third({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text("3 st"),);
//   }
// }