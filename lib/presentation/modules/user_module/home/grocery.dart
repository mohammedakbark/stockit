import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockit/presentation/common/ratio%20nmenu.dart';
import 'package:stockit/presentation/modules/user_module/home/home1.dart';
import 'package:stockit/presentation/modules/user_module/home/ration_list.dart';
import 'package:stockit/presentation/modules/user_module/maveli/maveli_list.dart';
import 'package:stockit/presentation/modules/user_module/user%20supplyco/supplyco_list.dart';

class grocery extends StatefulWidget {
  const grocery({super.key});

  @override
  State<grocery> createState() => _groceryState();
}

class _groceryState extends State<grocery> {
  int _selectedindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      endDrawer: const rationmenu(),
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(149, 255, 255, 255),
          toolbarHeight: 50,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ))
          // actions: [
          // IconButton(onPressed: (){}, icon: const Icon(Icons.menu,size: 35,color: Colors.black,))
          // ],
          ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/image 5.png'),
                      fit: BoxFit.cover)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 250),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            //elevation:MaterialStatePropertyAll(8),
                            backgroundColor: const MaterialStatePropertyAll(
                                Color.fromARGB(207, 255, 255, 255)),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(color: Colors.black))),
                            minimumSize:
                                const MaterialStatePropertyAll(Size(300, 55))),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RationViewList()));
                        },
                        child: Text(
                          'Ration Store',
                          style: GoogleFonts.abrilFatface(
                              fontSize: 20, color: Colors.black),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            //elevation:MaterialStatePropertyAll(8),
                            backgroundColor: const MaterialStatePropertyAll(
                                Color.fromARGB(207, 255, 255, 255)),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(color: Colors.black))),
                            minimumSize:
                                const MaterialStatePropertyAll(Size(300, 55))),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MavelistoreListView()));
                        },
                        child: Text(
                          'Maveli Store',
                          style: GoogleFonts.abrilFatface(
                              fontSize: 20, color: Colors.black),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            // elevation:MaterialStatePropertyAll(8),
                            backgroundColor: const MaterialStatePropertyAll(
                                Color.fromARGB(207, 255, 255, 255)),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(color: Colors.black))),
                            minimumSize:
                                const MaterialStatePropertyAll(Size(300, 55))),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SupplycoListView()));
                        },
                        child: Text(
                          'Supplyco Store',
                          style: GoogleFonts.abrilFatface(
                              fontSize: 20, color: Colors.black),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      extendBody: true,
    );
  }
}
