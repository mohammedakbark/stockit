// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class menu extends StatefulWidget {
//   const menu({super.key});

//   @override
//   State<menu> createState() => _menuState();
// }

// class _menuState extends State<menu> {
//   @override
//   Widget build(BuildContext context) {
//     // ignore: prefer_const_constructors
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(186, 255, 255, 255),
//         leading: IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons
//                 .arrow_back_ios_new)), //Icon(Icons.arrow_back_ios_sharp, size: 35,),
//         actions: [
//           IconButton(
//               onPressed: () {},
//               icon: const Icon(
//                 Icons.menu,
//                 size: 35,
//                 color: Colors.black,
//               ))
//         ],
//       ),
//       // drawerDragStartBehavior: ,
//       // drawer: Drawer(
//       //   child: ListView(
//       //   children: [
//       //     UserAccountsDrawerHeader(accountName: Text('ammu'), accountEmail: Text('ammu@gmail.com'),
//       //     currentAccountPicture: CircleAvatar(),),
//       //     ListTile(
//       //       leading: Icon(Icons.person),
//       //       title: Text('profile'),
//       //     ),
//       //      ListTile(
//       //       leading: Icon(Icons.person),
//       //       title: Text('setting'),
//       //     ),
//       //      ListTile(
//       //       leading: Icon(Icons.person),
//       //       title: Text('logout'),
//       //     ),
//       //   ],
//       //   ),
//       // ),
//       body: Stack(
//         alignment: Alignment.topRight,
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             decoration: const BoxDecoration(
//                 image: DecorationImage(
//                     image: AssetImage('images/image 5.png'),
//                     fit: BoxFit.cover)),
//           ),
//           Visibility(
//             visible: true,
//             child: Drawer(
//               child: ListView(
//                 children: [
//                   const UserAccountsDrawerHeader(
//                     accountName: Text('ammu'),
//                     accountEmail: Text('ammu@gmail.com'),
//                     currentAccountPicture: CircleAvatar(),
//                   ),
//                   const ListTile(
//                     leading: Icon(Icons.person),
//                     title: Text('profile'),
//                   ),
//                   const ListTile(
//                     leading: Icon(Icons.person),
//                     title: Text('setting'),
//                   ),
//                   const ListTile(
//                     leading: Icon(Icons.person),
//                     title: Text('logout'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
