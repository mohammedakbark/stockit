import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int _selectedindex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(backgroundColor: Colors.black45,toolbarHeight: 50,
      //bottom: AppBar(backgroundColor: Colors.black45,),
        centerTitle: true,
        leading: const Icon(Icons.menu,size:35,),
        title:const Text('welcome'),
        actions:const [
           Padding(
            padding: EdgeInsets.all(20.0),
            child: Icon(Icons.add_alarm,color: Color.fromARGB(255, 221, 5, 5),size: 35,),
          ),
           Padding(
            padding: EdgeInsets.all(20.0),
            child: Icon(Icons.add,color:Colors.black,),
          )
        ],
      ),
      body:Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("images/rationwallppr.jpg"),fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        width: double.infinity,
      ),
      bottomNavigationBar:BottomNavigationBar(
      items: [const BottomNavigationBarItem(icon:Icon(Icons.search),label:('searching')),
      const BottomNavigationBarItem(icon:Icon(Icons.ac_unit),label:('searching')),
      const BottomNavigationBarItem(icon:Icon(Icons.home),label:('Home'),)],
      currentIndex:_selectedindex ,
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor:Colors.blueGrey ,
      onTap:(index){
        setState(() {
          _selectedindex=index;
          
        });
      })
      );
  }
}