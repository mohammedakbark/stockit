import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/provider/controller.dart';
import 'package:stockit/presentation/common/order.dart';
import 'package:stockit/presentation/common/ordercmplt.dart';

class blue extends StatefulWidget {
  const blue({super.key});
 @override
  State<blue> createState() => _blueState();
}

class _blueState extends State<blue> {
  int _selectedindex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
     body:Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('images/image 5.png'),fit: BoxFit.cover)),
      child: Column(
        children: [
          
          SizedBox(height: 140,),
           
           
          Expanded(child: ListView.builder(itemCount: 5,itemBuilder: (context, index) =>
          
          Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(185, 255, 255, 255)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 10,),
                        child: Image.asset('images/race.png'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,bottom: 10),
                        child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Rice',
                                style: GoogleFonts.inknutAntiqua(
                                    fontSize: 20)),
                            const Row(
                              children: [
                                Icon(Icons.currency_rupee_sharp),
                                Text(
                                  '8/Kg',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                               const Padding(
                                 padding: EdgeInsets.only(left: 8),
                                 child: Text('2 Kg/Person',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                               ),
                                    ElevatedButton(style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black),foregroundColor: MaterialStatePropertyAll(Colors.white)),
                                    onPressed: (){}, child: const Text('Choose',style: TextStyle(fontSize: 15,),))
                          ],
                        ),
                      )
                    ],
                  )),
                  SizedBox(height: 10,),
            ],
          ),)),
                          SizedBox(height: 10,),
                          SizedBox(
                      height: 40,
                      width: 130,
                      child: ElevatedButton(style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 227, 131, 52)),foregroundColor: MaterialStatePropertyAll(Colors.black)),
                        onPressed: (){
                                                     Provider.of<Controller>(context,listen: false).clearList();

                           Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>ordercomplt()));
                        }, child: Text('Order',style: GoogleFonts.inknutAntiqua(fontSize:20),)),
                    )
        ],
      ),
     ),
    //  bottomNavigationBar: BottomNavigationBar(
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
    //             icon: Icon(
    //               Icons.library_books_rounded,
    //               size: 35,
    //             ),
    //             label: ('Orders')),
    //         const BottomNavigationBarItem(
    //             icon: Icon(Icons.local_offer, size: 35),
    //             label: ('Special item')),
    //       ],
    //       currentIndex: _selectedindex,
    //       selectedItemColor: const Color.fromARGB(255, 100, 74, 1),
    //       unselectedItemColor: Colors.black,
    //       onTap: (index) {
    //         setState(() {
    //           _selectedindex = index;
    //         });
    //       }),
    );
  }
}