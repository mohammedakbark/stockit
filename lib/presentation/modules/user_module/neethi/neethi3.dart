import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockit/presentation/modules/user_module/neethi/labtest.dart';
import 'package:stockit/presentation/modules/user_module/neethi/medicine.dart';
import 'package:stockit/presentation/modules/user_module/neethi/menunee.dart';
import 'package:stockit/presentation/modules/user_module/neethi/neethi_list.dart';
import 'package:stockit/presentation/modules/user_module/package.dart';

class neethi3 extends StatefulWidget {
    neethi3({super.key});

  @override
  State<neethi3> createState() => _neethi3State();
}

class _neethi3State extends State<neethi3> {
   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
 

     
    
  int _selectedindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      endDrawer:menuneethi(),
       endDrawerEnableOpenDragGesture: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
               Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_sharp,
              
            )),
        title: Text(
          'Pharmecy',
          style: GoogleFonts.inknutAntiqua(fontSize: 30),
        ),
         
        backgroundColor: const Color.fromARGB(136, 255, 255, 255),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width, //color: Colors.black,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/pharmacy.png'), fit: BoxFit.cover)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 300),
              child: ElevatedButton(
                  style: ButtonStyle(
                      //elevation:MaterialStatePropertyAll(8),
                      backgroundColor: const MaterialStatePropertyAll(
                          Color.fromARGB(207, 255, 255, 255)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.black))),
                      minimumSize: const MaterialStatePropertyAll(Size(300, 70))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  medicine()));
                  },
                  child: Text(
                    'Order Medicine',
                    style: GoogleFonts.abrilFatface(
                        fontSize: 25, color: Colors.black),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                  style: ButtonStyle(
                      //elevation:MaterialStatePropertyAll(8),
                      backgroundColor: const MaterialStatePropertyAll(
                          Color.fromARGB(207, 255, 255, 255)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.black))),
                      minimumSize: const MaterialStatePropertyAll(Size(300, 70))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const labtest()));
                  },
                  child: Text(
                    'Book Labtest',
                    style: GoogleFonts.abrilFatface(
                        fontSize: 25, color: Colors.black),
                  )),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //     showUnselectedLabels: true,
      //     elevation: 0,
      //     backgroundColor: const Color.fromARGB(139, 255, 255, 255),
      //     items: [
      //       const BottomNavigationBarItem(
      //           icon: Icon(
      //             Icons.home,
      //             size: 35,
      //           ),
      //           label: ('Home')),
           
      //       const BottomNavigationBarItem(
      //           icon: ImageIcon(
      //         AssetImage('images/Lab Items.png'),size: 30,
              
      //       ),
      //       label: ('Lab Test')),
      //        const BottomNavigationBarItem(
      //           icon: ImageIcon(
      //         AssetImage('images/health.png'),size: 30,
              
      //       ),
      //       label: ('Health Care')),
      //       const BottomNavigationBarItem(
      //           icon: ImageIcon(
      //         AssetImage('images/Discount.png'),size: 30,
              
      //       ),
      //       label: ('Offer')),
      //       const BottomNavigationBarItem(
      //           icon: ImageIcon(
      //         AssetImage('images/Cart.png'),size: 30,
              
      //       ),
      //       label: ('Cart')),
             
             
      //     ],
      //     currentIndex: _selectedindex,
      //     selectedItemColor: const Color.fromARGB(255, 196, 145, 6),
      //     unselectedItemColor: Colors.black,
      //     onTap: (index) {
      //       setState(() {
      //         _selectedindex = index;
      //       });
      //     }),
    );
  }
}
