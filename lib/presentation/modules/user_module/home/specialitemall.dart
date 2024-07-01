// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:stockit/presentation/modules/user_module/home/ration_detail_adding_page.dart';

// class specialitemall extends StatefulWidget {
//   const specialitemall({super.key});

//   @override
//   State<specialitemall> createState() => _specialitemallState();
// }

// class _specialitemallState extends State<specialitemall> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//        body:   SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//           Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('images/image 5.png'),fit: BoxFit.cover)),
//             child: Column(children: [
//               SizedBox(height: 90,),
//                SizedBox(
//                          height: 60,
//                          width:350,
//                           child: TextFormField(cursorColor: Colors.black,
//                            decoration: InputDecoration(focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.black)),border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                            fillColor: Color.fromARGB(255, 255, 255, 255),filled: true,prefixIcon: Icon(Icons.search,size: 35,),hintText: ('Search location')),
//                            ),
//                         ),
               
//                Expanded(child: ListView.builder(itemCount: 7,itemBuilder: (context, index) {
//                 return Padding(
//                   padding: EdgeInsets.only(top: 20,left: 20,right: 20),
//                   child: Container(
//                     padding: EdgeInsets.all(10),
                    
//                   decoration: BoxDecoration(border: Border.all(
//                     width: 1,
//                     color: Colors.black,),borderRadius: BorderRadius.circular(7),color: Colors.white
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: SizedBox(
                          
//                           child: Text('Ration Store Munduparamba,Eranad Thaluk,676509,Malappuram(Dt),Malappuram-Manjeri Rod',style: GoogleFonts.abyssinicaSil(fontSize:15),)),
//                       ),
//                       ElevatedButton(style: ButtonStyle(
//                       //elevation:MaterialStatePropertyAll(8),
//                       backgroundColor: MaterialStatePropertyAll(Color.fromARGB(233, 135, 133, 133)),
//                       shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(color: Colors.black))),
//                      // minimumSize:MaterialStatePropertyAll(Size(10,10)) 
//                     ),
//                         onPressed: (){
//                            Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) =>RationDetailAddingPage(storeId: "",)));
//                         }, child: Text("select",style: GoogleFonts.abyssinicaSil(fontSize:18,color:Colors.black),))
//                     ],
//                   ),
//                   ),
//                 );
                  
        
//                }))
//             ],),
            
//           ),
           
//         ],),
//       ),
//     );
//   }
// }