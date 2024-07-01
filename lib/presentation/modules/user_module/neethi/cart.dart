import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockit/presentation/modules/user_module/neethi/neethi3.dart';

class cart extends StatefulWidget {
  const cart({super.key});

  @override
  State<cart> createState() => _cartState();
}

class _cartState extends State<cart> {
  int _selectedindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
               Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_sharp,
              
            )),
        title: Text(
          'Cart Products',
          style: GoogleFonts.inknutAntiqua(fontSize: 25),
        ),
         backgroundColor: const Color.fromARGB(136, 255, 255, 255),
    ),
    body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('images/pharmacy.png'),fit: BoxFit.cover)
      ),
      child: Padding(
                padding: const EdgeInsets.only(top: 100, left: 20, right: 20, bottom: 15),
                child: Container(
                  color:  const Color.fromARGB(178, 233, 231, 231),
                  child: Column(
                    children: [
                     
                       Expanded(child: ListView.builder(itemCount: 5,itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
                  child: Container(height: 85,width: 330,decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10),border:Border.all(width: 1,color: Colors.black)),
                  child:Column(children: [ 
                     Row(
                       children: [
                         Padding(
                           padding: const EdgeInsets.only(top: 8,left: 5),
                           child: Text('Ecosprine 75mg ofb 14 tabletes',style: GoogleFonts.inknutAntiqua(fontSize:15,),),
                         ),
                        
                       ],
                     ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5,left: 20),
                        child: Row(
                         children: [
                           Icon(Icons.currency_rupee,size: 19,),
                           Text('65',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                           SizedBox(width:10,),
                           Icon(Icons.currency_rupee,size: 15,color: Colors.grey[400],),
                           Text('99',style: TextStyle(decorationColor: Colors.grey[400],
                           decoration: TextDecoration.lineThrough,
                            fontSize:15,fontWeight: FontWeight.bold,color: Colors.grey[400]),
                            ),
                             SizedBox(width:20),
                           Text('66%OFF',style: TextStyle(color: Colors.red,fontSize: 16,fontWeight: FontWeight.bold),),
                           Padding(
                             padding: const EdgeInsets.only(left: 45),
                             child: IconButton(onPressed: (){}, icon:Icon(Icons.favorite,size: 26,color: Colors.amber[600],)),
                           ),
                          ],
                         
                        ),
                      ),
                     
                      
                  ],)
                  ),
                );
              },))
                    ],
                  ),
                ),
              ),
    ),
    // bottomNavigationBar: BottomNavigationBar(
    //       showUnselectedLabels: true,
    //       elevation: 0,
    //       backgroundColor: const Color.fromARGB(139, 255, 255, 255),
    //       items: [
    //         const BottomNavigationBarItem(
    //             icon: Icon(
    //               Icons.home,
    //               size: 35,
    //             ),
    //             label: ('Home')),
           
    //         const BottomNavigationBarItem(
    //             icon: ImageIcon(
    //           AssetImage('images/Lab Items.png'),size: 30,
              
    //         ),
    //         label: ('Lab Test')),
    //          const BottomNavigationBarItem(
    //             icon: ImageIcon(
    //           AssetImage('images/health.png'),size: 30,
              
    //         ),
    //         label: ('Health Care')),
    //         const BottomNavigationBarItem(
    //             icon: ImageIcon(
    //           AssetImage('images/Discount.png'),size: 30,
              
    //         ),
    //         label: ('Offer')),
    //         const BottomNavigationBarItem(
    //             icon: ImageIcon(
    //           AssetImage('images/Cart.png'),size: 30,
              
    //         ),
    //         label: ('Cart')),
             
             
    //       ],
    //       currentIndex: _selectedindex,
    //       selectedItemColor: const Color.fromARGB(255, 196, 145, 6),
    //       unselectedItemColor: Colors.black,
    //       onTap: (index) {
    //         setState(() {
    //           _selectedindex = index;
    //         });
    //       }),
    );
  }
}