import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/helper/service.dart';
import 'package:stockit/data/provider/controller.dart';
import 'package:stockit/presentation/modules/user_module/neethi/medicineserch.dart';
import 'package:stockit/presentation/modules/user_module/neethi/neethi3.dart';

class medicine extends StatefulWidget {
  const medicine({super.key});

  @override
  State<medicine> createState() => _medicineState();
}

class _medicineState extends State<medicine> {
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
          'Pharmecy',
          style: GoogleFonts.inknutAntiqua(fontSize: 30),
        ),
        backgroundColor: const Color.fromARGB(136, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width, //color: Colors.black,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/pharmacy.png'), fit: BoxFit.cover)),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 200, left: 15),
                      child: Image.asset(
                        "images/Doctor.png",
                        scale: 1.5,
                      )
                      //Image(image: AssetImage('images/Doctor.png',)),
                      ),
                  Padding(
                    padding: const EdgeInsets.only(top: 200, left: 3),
                    child: Column(
                      children: [
                        Text(
                          'Hey there,',
                          style: GoogleFonts.inknutAntiqua(fontSize: 15),
                        ),
                        Text(
                          'Search for medicines.',
                          style: GoogleFonts.inknutAntiqua(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                  height: 60,
                  width: 340,
                  child: TextFormField(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const medicinserch()));
                    },
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        fillColor: Color.fromARGB(136, 255, 255, 255),
                        filled: true,
                        prefixIcon: Icon(
                          Icons.search,
                          size: 35,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black))),
                  )),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(224, 191, 233, 226),
                ),
                height: 150,
                width: 340,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, right: 20),
                      child: Text(
                        'Quickly Order via Prescription.',
                        style: GoogleFonts.inknutAntiqua(fontSize: 17),
                      ),
                    ),
                    // Container(
                    //   height: 20,
                    // ),
                    Consumer<Controller>(builder: (context, controler, child) {
                      return Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 15),
                                child: Text(
                                  'Upload the prescription photo',
                                  style: GoogleFonts.inknutAntiqua(
                                      fontSize: 14,
                                      color:
                                          const Color.fromARGB(177, 0, 0, 0)),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          const Color.fromARGB(205, 0, 0, 0))),
                                  onPressed: () {
                                    controler
                                        .pickeImageFromGallery()
                                        .then((value) {
                                      controler
                                          .storeImage(controler.fileImage!,
                                              "Prescription")
                                          .then((url) {
                                        DbController()
                                            .uploadPrescription(url,Provider.of<DbController>(context,listen: false).currentStoreid)
                                            .then((value) {
                                          Services.successMessage(context,
                                              "Prescription send to Neethi store!");
                                          Navigator.pop(context);
                                          controler.fileImage = null;
                                        });
                                      });
                                    });
                                  },
                                  child: Text(
                                    'Upload',
                                    style: GoogleFonts.inknutAntiqua(
                                        fontSize: 15, color: Colors.white),
                                  ))
                            ],
                          ),
                          // Image.asset(
                          //   'images/Prescription.png',
                          //   scale: 1.2,
                          // )
                          Container(
                            height: 100,
                            width: 80,
                            color: Color.fromARGB(224, 191, 233, 226),
                            child: controler.fileImage != null
                                ? Image.file(controler.fileImage!)
                                : Image.asset(
                                    'images/Prescription.png',
                                    fit: BoxFit.cover,
                                  ),
                          )
                        ],
                      );
                    }),
                    //ElevatedButton(onPressed: (){}, child: Text('Upload'))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      //  bottomNavigationBar: BottomNavigationBar(
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
