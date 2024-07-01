import 'package:flutter/material.dart';

import 'package:stockit/presentation/modules/user_module/neethi/cart.dart';
import 'package:stockit/presentation/modules/user_module/neethi/serch_result_product.dart';
import 'package:stockit/presentation/modules/user_module/neethi/labtest.dart';
import 'package:stockit/presentation/modules/user_module/neethi/neethi3.dart';
import 'package:stockit/presentation/modules/user_module/neethi/offer.dart';
import 'package:stockit/presentation/modules/user_module/neethi/topselling.dart';

class packages extends StatefulWidget {
   int indexnum=0;
   packages({super.key,required this.indexnum});

  @override
  State<packages> createState() => _packagesState();
}

class _packagesState extends State<packages> {
 final _pages=[
    
   neethi3(),
    const labtest(),
    const topsellind(),
    const offerall(),
    // const cart()
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
                icon: ImageIcon(
              AssetImage('images/Lab Items.png'),size: 30,
            ),
            label: ('Lab Test')),
             const BottomNavigationBarItem(
              backgroundColor: Colors.white,
                icon: ImageIcon(
              AssetImage('images/health.png'),size: 30,
              
            ),
            label: ('Health Care')),
            const BottomNavigationBarItem(
              backgroundColor: Colors.white,
                icon: ImageIcon(
              AssetImage('images/Discount.png'),size: 30,
              
            ),
            label: ('Offer')),
            // const BottomNavigationBarItem(
            //   backgroundColor: Colors.white,
            //     icon: ImageIcon(
            //   AssetImage('images/Cart.png'),size: 30,
              
            // ),
            // label: ('Cart')),
    ]);
    

}