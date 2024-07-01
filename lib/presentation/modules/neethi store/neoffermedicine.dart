import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:stockit/presentation/modules/neethi%20store/neofferlab.dart';
import 'package:stockit/presentation/modules/user_module/neethi/offerlab.dart';

class neoffermedicine extends StatefulWidget {
  const neoffermedicine({super.key});

  @override
  State<neoffermedicine> createState() => _neoffermedicineState();
}

class _neoffermedicineState extends State<neoffermedicine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
       
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width, //color: Colors.black,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/pharmacy.png'), fit: BoxFit.cover)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 15),
                  child: Container(
                    color:  const Color.fromARGB(178, 233, 231, 231),
                    child: Column(
                      children: [
                        
                         Expanded(child: ListView.builder(itemCount: 5,itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
                    child: Container(height: 90,width: 350,decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10),border:Border.all(width: 1,color: Colors.black)),
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
                             Text('66%OFF',style: TextStyle(color: Colors.red,fontSize: 18,fontWeight: FontWeight.bold),),
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
      

    );
  }
}