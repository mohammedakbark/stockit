import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class neofferproduct extends StatefulWidget {
  const neofferproduct({super.key});

  @override
  State<neofferproduct> createState() => _neofferproductState();
}

class _neofferproductState extends State<neofferproduct> {
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
                  padding: const EdgeInsets.only(top: 20, left: 10, right:10, bottom: 15),
                  child: Container(
                    color:  const Color.fromARGB(178, 233, 231, 231),
                    child: Column(
                      children: [
                         Expanded(child: ListView.builder(itemCount: 5,itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
                    child: Container(height:90,width: 350,decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10),border:Border.all(width: 1,color: Colors.black)),
                    child:Column(children: [
                      SizedBox(height: 10,), 
                       Text('Sebamade Baby Cleansing Bar-100g',style: GoogleFonts.inknutAntiqua(fontSize:13,),),
                        SizedBox(height: 8,),
                        Row(
                         children: [
                          SizedBox(width: 45,),
                           Icon(Icons.currency_rupee,size: 19,),
                           Text('256',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                           SizedBox(width:10,),
                           Icon(Icons.currency_rupee,size: 15,color: Colors.grey[400],),
                           Text('300',style: TextStyle(decorationColor: Colors.grey[400],
                           decoration: TextDecoration.lineThrough,
                            fontSize:15,fontWeight: FontWeight.bold,color: Colors.grey[400]),
                            ),
                             SizedBox(width:20),
                           Text('15%OFF',style: TextStyle(color: Colors.red,fontSize: 18,fontWeight: FontWeight.bold),),   
                         ],
                         
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