import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockit/presentation/modules/user_module/home/home1.dart';
import 'package:stockit/presentation/modules/user_module/neethi/neethi_list.dart';

class neethi extends StatefulWidget {
  const neethi({super.key});

  @override
  State<neethi> createState() => _neethiState();
}

class _neethiState extends State<neethi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
          appBar: AppBar(
         leading: IconButton(onPressed: (){
          Navigator.pop(context);
         }, icon:Icon(Icons.arrow_back_ios_sharp,) ),
        title: Text(
          'Pharmecy',
          style: GoogleFonts.inknutAntiqua(fontSize: 30),
        ),
        
        backgroundColor: const Color.fromARGB(136, 255, 255, 255),
      ),
      body: Container(
        height:MediaQuery.of(context).size.height ,
        width: MediaQuery.of(context).size.width,//color: Colors.black,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/pharmacy.png'),fit: BoxFit.cover)),
        child: Column(children: [
           Padding(
             padding: const EdgeInsets.only(top:360 ),
             child: ElevatedButton(
                    style: ButtonStyle(
                      //elevation:MaterialStatePropertyAll(8),
                      backgroundColor: MaterialStatePropertyAll(Color.fromARGB(207, 255, 255, 255)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(color: Colors.black))),
                      minimumSize:MaterialStatePropertyAll(Size(300,70)) 
                    ),
                
                    onPressed: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>const NeethiListView()));
                    }, child:Text('Neethi Store',style: GoogleFonts.abrilFatface(fontSize:25,color:Colors.black),) ),
           ),

        ],),
      ),

    );
  }
}