import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class project extends StatefulWidget {
  const project({super.key});

  @override
  State<project> createState() => _projectState();
}

class _projectState extends State<project> {
  int _selectedindex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color.fromARGB(201, 141, 139, 139),toolbarHeight: 50,
      leading: const Icon(Icons.arrow_back_ios_new_sharp,color:Colors.black,size: 35,),
      actions: const [Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(Icons.menu, color:Colors.black,size: 35,),
      )]
      ),
  
      body:Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("images/rationwallppr.jpg"),fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        width: double.infinity,
      ),
  
      bottomNavigationBar:BottomNavigationBar(
      items: const [BottomNavigationBarItem (icon:Icon(Icons.home),label:('Home')),BottomNavigationBarItem(icon: Icon(Icons.list_alt_outlined),label:('Order')),BottomNavigationBarItem(icon: Icon(Icons.favorite_rounded),label:('Favorite Store')),BottomNavigationBarItem(icon: Icon(Icons.notifications_active),label:('Notifications'))],
      currentIndex: _selectedindex,
      selectedItemColor:Colors.blueAccent,
      unselectedItemColor:Colors.blueGrey,
      onTap: (index){
        setState(() {
          _selectedindex=index;
        });
      }),

     );
  }
}