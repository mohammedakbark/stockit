import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stockit/presentation/common/order.dart';
import 'package:stockit/presentation/modules/user_module/package.dart';
import 'package:stockit/presentation/modules/rationstore.dart/product.dart';
import 'package:stockit/presentation/modules/rationstore.dart/rationprofile.dart';
import 'package:stockit/presentation/modules/rationstore.dart/rspclitem.dart';
import 'package:stockit/presentation/modules/supplycostore.dart/smorder.dart';
import 'package:stockit/presentation/modules/supplycostore.dart/smprofile.dart';
import 'package:stockit/presentation/modules/supplycostore.dart/smspecial.dart';
import 'package:stockit/presentation/modules/supplycostore.dart/smstocks.dart';
import 'package:stockit/presentation/modules/user_module/user%20supplyco/supplycostocks.dart';

class pacakagesupplyco extends StatefulWidget {
  int indexnum=0;
   pacakagesupplyco({super.key,required this.indexnum});

  @override
  State<pacakagesupplyco> createState() => _pacakagesupplycoState();
}

class _pacakagesupplycoState extends State<pacakagesupplyco> {
  final _pages=[
    
   smstocks(),
    const smspecial(),
    const smorder(),
    const smprofile()
    
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[widget.indexnum],
      bottomNavigationBar:mynav(
        index:widget.indexnum,
        onTap:(index){
        setState(() {
          widget.indexnum=index;
        });
      }
        )
    );
  }
}
Widget mynav({
  int? index,
  void Function(int)?onTap,
  selectedcolor,
})
{
  return BottomNavigationBar(
    showUnselectedLabels: true,
    currentIndex: index!,
    selectedItemColor: Color.fromARGB(255, 237, 176, 11),
    unselectedItemColor: Colors.black,
    showSelectedLabels: true,
    onTap: onTap ,
    items: [
      const BottomNavigationBarItem(
        backgroundColor: Colors.white,
                icon: Icon(
                  Icons.home,
                  size: 35,
                ),
                label: ('Home')),
           const BottomNavigationBarItem(
        backgroundColor: Colors.white,
                icon: Icon(
                  Icons.local_offer,
                  size: 35,
                ),
                label: ('Special')),
            const BottomNavigationBarItem(
        backgroundColor: Colors.white,
                icon: Icon(
                  Icons.library_books_rounded,
                  size: 35,
                ),
                label: ('Orders')),
                const BottomNavigationBarItem(
        backgroundColor: Colors.white,
                icon: Icon(
                  Icons.person_pin,
                  size: 35,
                ),
                label: ('Profile')),
            
    ]);
    

}