import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockit/presentation/modules/neethi%20store/neethimenu.dart';
import 'package:stockit/presentation/modules/neethi%20store/nelabtest.dart';
import 'package:stockit/presentation/modules/neethi%20store/nemedicine.dart';
import 'package:stockit/presentation/modules/user_module/neethi/labtest.dart';
import 'package:stockit/presentation/modules/user_module/neethi/medicine.dart';

class neethihome extends StatefulWidget {
  const neethihome({super.key});

  @override
  State<neethihome> createState() => _neethihomeState();
}

class _neethihomeState extends State<neethihome> {
  @override
  Widget build(BuildContext context) {
    //   final __nameController = TextEditingController();
    // final _descriptioncontroller = TextEditingController();
    // final _priceController = TextEditingController();
    // final _quantityController = TextEditingController();
    // final _categoryController = TextEditingController();
    
 return Scaffold(
      // extendBodyBehindAppBar: true,
     drawer: neethimenu(),
       endDrawerEnableOpenDragGesture: false,
      appBar: AppBar(
         leading: Builder(builder: (context) {
            return IconButton(onPressed: (){
              Scaffold.of(context).openDrawer();
            }, icon: Icon(Icons.menu,color: Colors.black,));
          },),
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
              padding: const EdgeInsets.only(top: 250),
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
                            builder: (context) =>  nemedicine()));
                  },
                  child: Text(
                    'Medicine',
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
                            builder: (context) => const nelabtest()));
                  },
                  child: Text(
                    ' Labtest',
                    style: GoogleFonts.abrilFatface(
                        fontSize: 25, color: Colors.black),
                  )),
            ),
          ],
        ),
      ),
        //  floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        // floatingActionButton: FloatingActionButton(
        //   foregroundColor: Colors.white,
        //   backgroundColor: Colors.black,
        //   elevation: 0,
        //   mini: true,
        //   onPressed: () {
        //     showModalBottomSheet<void>(
        //       context: context,
        //       builder: (BuildContext context) {
        //         return Container(
        //           decoration: BoxDecoration(
        //               color: Colors.white,
        //               borderRadius: BorderRadius.circular(20)),
        //           height: 400,
        //           width: double.infinity,
        //           child: Column(
        //             children: [
        //             Padding(
        //               padding: const EdgeInsets.only(right: 80),
        //               child: Text('Click + button to upload product photo',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
        //             ),
                    
        //               Row(
        //                 children: [
        //                   Stack(
        //                     children: [
        //                       Container(
        //                         height: 150,
        //                         width: 150,
        //                         decoration: BoxDecoration(
        //                             borderRadius: BorderRadius.circular(10),
        //                             image: DecorationImage(
        //                                 image:
        //                                     AssetImage('images/imageicon.png'),
        //                                 fit: BoxFit.cover)),
        //                       ),
        //                       Padding(
        //                         padding: const EdgeInsets.only(
        //                             left: 120, bottom: 150),
        //                         child: Container(
        //                           height: 50,
        //                           width: 50,
        //                           decoration: BoxDecoration(
        //                             shape: BoxShape.circle,
        //                             color: Colors.white,
        //                           ),
        //                           child: IconButton(
        //                               onPressed: () {},
        //                               icon: Icon(
        //                                 Icons.add,
        //                                 color: Colors.black,
        //                                 size: 30,
        //                               )),
        //                         ),
        //                       ),
        //                       Container(
        //                         height: 50,
        //                         width: 50,
                                
        //                       ),
        //                     ],
        //                   ),
        //                   Column(
        //                     children: [
        //                      Padding(
        //                        padding: const EdgeInsets.only(right: 140),
        //                        child: Text('Name:',style: TextStyle(fontWeight: FontWeight.bold),),
        //                      ),
        //                       Padding(
        //                         padding: const EdgeInsets.only(right: 50),
        //                         child: SizedBox(
        //                           height: 65,
        //                           width: 150,
        //                           child: TextFormField(
        //                             autovalidateMode:
        //                                 AutovalidateMode.onUserInteraction,
        //                             controller: __nameController,
        //                             validator: (value) {
        //                               if (value!.isEmpty) {
        //                                 return 'please type product name';
        //                               }
        //                               return null;
        //                             },
        //                             cursorColor: Colors.black,
        //                             keyboardType: TextInputType.name,
        //                             decoration: InputDecoration(
        //                                 focusedBorder: OutlineInputBorder(
        //                                     borderSide: BorderSide(
        //                                         color: Colors.black)),
        //                                 border: OutlineInputBorder(
        //                                     borderRadius:
        //                                         BorderRadius.circular(10),
        //                                     borderSide: BorderSide(
        //                                         color: Colors.black)),
        //                                 fillColor:
        //                                     Color.fromARGB(177, 255, 255, 255),
        //                                 filled: true,
        //                                 hintText: ('Product name')),
        //                           ),
        //                         ),
        //                       ),
        //                    Padding(
        //                      padding: const EdgeInsets.only(right: 100),
        //                      child: Text('Description',style: TextStyle(fontWeight: FontWeight.bold),),
        //                    ),
        //                    SizedBox(
        //                     height: 65,
        //                     width: 200,
        //                     child: TextFormField(
        //                       autovalidateMode:
        //                           AutovalidateMode.onUserInteraction,
        //                       controller: _descriptioncontroller,
        //                       validator: (value) {
        //                         if (value!.isEmpty) {
        //                           return 'please type product details';
        //                         }
        //                         return null;
        //                       },
        //                       cursorColor: Colors.black,
        //                       keyboardType: TextInputType.name,
        //                       decoration: InputDecoration(
        //                         focusedBorder: OutlineInputBorder(
        //                             borderSide:
        //                                 BorderSide(color: Colors.black)),
        //                         border: OutlineInputBorder(
        //                             borderRadius:
        //                                 BorderRadius.circular(10),
        //                             borderSide:
        //                                 BorderSide(color: Colors.black)),
        //                         fillColor:
        //                             Color.fromARGB(177, 255, 255, 255),
        //                         filled: true,
        //                         hintText: (' product details'),
        //                       ),
        //                     ),
        //                                                    ),
        //                    SizedBox(height: 20,)
                              
        //                     ],
        //                   )
        //                 ],
        //               ),
        //               Row(
        //                 children: [
        //                   Column(
        //                     children: [
        //                       Padding(
        //                         padding: const EdgeInsets.only(right: 50
        //                         ),
        //                         child: Text(
        //                           'MRP',
        //                           style: TextStyle(fontWeight: FontWeight.bold),
        //                         ),
        //                       ),
        //                       SizedBox(
        //                         height: 65,
        //                         width: 100,
        //                         child: TextFormField(
        //                           autovalidateMode:
        //                               AutovalidateMode.onUserInteraction,
        //                           controller: _priceController,
        //                           validator: (value) {
        //                             if (value!.isEmpty) {
        //                               return 'MRP';
        //                             }
        //                             return null;
        //                           },
        //                           cursorColor: Colors.black,
        //                           keyboardType: TextInputType.number,
        //                           inputFormatters: [
        //                             FilteringTextInputFormatter.digitsOnly
        //                           ],
        //                           decoration: InputDecoration(
        //                             focusedBorder: OutlineInputBorder(
        //                                 borderSide:
        //                                     BorderSide(color: Colors.black)),
        //                             border: OutlineInputBorder(
        //                                 borderRadius: BorderRadius.circular(10),
        //                                 borderSide:
        //                                     BorderSide(color: Colors.black)),
        //                             fillColor:
        //                                 Color.fromARGB(177, 255, 255, 255),
        //                             filled: true,
        //                             hintText: ('MRP'),
        //                             prefixIcon: Icon(Icons.currency_rupee),
        //                           ),
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                   SizedBox(
        //                     width: 20,
        //                   ),
        //                   Column(
        //                     children: [
        //                       Padding(
        //                         padding: const EdgeInsets.only(right:40),
        //                         child: Text(
        //                           'OFFER %',
        //                           style: TextStyle(fontWeight: FontWeight.bold),
        //                         ),
        //                       ),
        //                       SizedBox(
        //                         height: 65,
        //                         width: 100,
        //                         child: TextFormField(
        //                           autovalidateMode:
        //                               AutovalidateMode.onUserInteraction,
        //                           controller: _quantityController,
        //                           validator: (value) {
        //                             if (value!.isEmpty) {
        //                               return 'Offer%';
        //                             }
        //                             return null;
        //                           },
        //                           cursorColor: Colors.black,
                                  
        //                           decoration: InputDecoration(
        //                             focusedBorder: OutlineInputBorder(
        //                                 borderSide:
        //                                     BorderSide(color: Colors.black)),
        //                             border: OutlineInputBorder(
        //                                 borderRadius: BorderRadius.circular(10),
        //                                 borderSide:
        //                                     BorderSide(color: Colors.black)),
        //                             fillColor:
        //                                 Color.fromARGB(177, 255, 255, 255),
        //                             filled: true,
        //                             hintText: ('Offer%'),
        //                           ),
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                   SizedBox(width: 15,),
        //                    Column(
        //                     children: [
        //                       Text(
        //                         'Price',
        //                         style: TextStyle(fontWeight: FontWeight.bold),
        //                       ),
        //                       SizedBox(
        //                         height: 65,
        //                         width: 100,
        //                         child: TextFormField(
        //                           autovalidateMode:
        //                               AutovalidateMode.onUserInteraction,
        //                           controller: _quantityController,
        //                           validator: (value) {
        //                             if (value!.isEmpty) {
        //                               return 'Sale price';
        //                             }
        //                             return null;
        //                           },
        //                           cursorColor: Colors.black,
        //                           keyboardType: TextInputType.number,
        //                           inputFormatters: [
        //                             FilteringTextInputFormatter.digitsOnly
        //                           ],
        //                           decoration: InputDecoration(
        //                             focusedBorder: OutlineInputBorder(
        //                                 borderSide:
        //                                     BorderSide(color: Colors.black)),
        //                             border: OutlineInputBorder(
        //                                 borderRadius: BorderRadius.circular(10),
        //                                 borderSide:
        //                                     BorderSide(color: Colors.black)),
        //                             fillColor:
        //                                 Color.fromARGB(177, 255, 255, 255),
        //                             filled: true,
        //                             hintText: ('Price'),
        //                           ),
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                 ],
        //               ),
        //               // Row(
        //               //   children: [
        //               //     Column(
        //               //       children: [
        //               //         Padding(
        //               //           padding: const EdgeInsets.only(right: 120),
        //               //           child: Text(
        //               //             'Category',
        //               //             style: TextStyle(fontWeight: FontWeight.bold),
        //               //           ),
        //               //         ),
        //               //         SizedBox(
        //               //           height: 65,
        //               //           width: 200,
        //               //           child: TextFormField(
        //               //             autovalidateMode:
        //               //                 AutovalidateMode.onUserInteraction,
        //               //             controller: _categoryController,
        //               //             validator: (value) {
        //               //               if (value!.isEmpty) {
        //               //                 return 'Category';
        //               //               }
        //               //               return null;
        //               //             },
        //               //             cursorColor: Colors.black,
        //               //             keyboardType: TextInputType.number,
        //               //             inputFormatters: [
        //               //               FilteringTextInputFormatter.digitsOnly
        //               //             ],
        //               //             decoration: InputDecoration(
        //               //               focusedBorder: OutlineInputBorder(
        //               //                   borderSide:
        //               //                       BorderSide(color: Colors.black)),
        //               //               border: OutlineInputBorder(
        //               //                   borderRadius: BorderRadius.circular(10),
        //               //                   borderSide:
        //               //                       BorderSide(color: Colors.black)),
        //               //               fillColor:
        //               //                   Color.fromARGB(177, 255, 255, 255),
        //               //               filled: true,
        //               //               hintText: ('Category'),
        //               //               suffixIcon: Icon(Icons.arrow_drop_down)
        //               //             ),
        //               //           ),
        //               //         ),
        //               //       ],
        //               //     ),
        //               //   ],
        //               // ),
        //               ElevatedButton(onPressed: (){}, child: Text('Submit'))
        //             ],
        //           ),
        //         );
        //       },
        //     );
        //   },
        //   child: Icon(Icons.add),
        // ),
    );
  }
}