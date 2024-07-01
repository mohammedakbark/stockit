import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/provider/controller.dart';
import 'package:stockit/data/provider/location_provider.dart';
//import 'package:stockit/home/home2.dart';
import 'package:stockit/presentation/modules/user_module/login/menuhome.dart';
import 'package:stockit/presentation/modules/user_module/neethi/menunee.dart';
import 'package:stockit/presentation/modules/user_module/neethi/neethihome.dart';
import 'package:stockit/presentation/modules/user_module/packagegrocery.dart';

class home1 extends StatefulWidget {
  const home1({super.key});

  @override
  State<home1> createState() => _home1State();
}

class _home1State extends State<home1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer:const menuhome() ,
     // endDrawer:menuhome(),
 appBar: AppBar(
        backgroundColor: const Color.fromARGB(139, 255, 255, 255),toolbarHeight: 50,
      leading: Builder(builder: (context) {
            return IconButton(onPressed: (){
              Scaffold.of(context).openDrawer();
            }, icon: const Icon(Icons.menu,color: Colors.black,));
          },),
        title: Text('StockIt',style: GoogleFonts.abrilFatface(fontSize:30)),
      ),
      body: SingleChildScrollView(
        child: Consumer<LocationService>(
          builder: (context,controller,child) {
         
              
                return FutureBuilder(
                  future:controller.getMyLocation() ,
                  builder: (context,snapshot) {
                      if(snapshot.connectionState==ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator(),);
                }
                    return Column(
                      children: [
                        Container(
                          height: 403,
                          width: double.infinity,
                          decoration: const BoxDecoration(image: DecorationImage(image:AssetImage('images/rationwallppr.jpg'),fit: BoxFit.cover)),
                        child: Stack(children: [Padding(
                          padding: const EdgeInsets.only(top: 340,left: 100),
                          child: SizedBox(
                            height: 50,width: 200,
                            child: ElevatedButton(style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromARGB(198, 255, 255, 255))),
                            onPressed: (){
                              Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>  packagesgro(indexnum: 0,)));
                            }, child:Text("Grocery",style:GoogleFonts.abrilFatface(fontSize:20,color:Colors.black),))
                            ),
                        )],),
                          ),
                          
                        Container(
                          //height: MediaQuery.of(context).size.height,
                         // width: MediaQuery.of(context).size.width,
                          height:400,
                          width: double.infinity,
                          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('images/young.png'),fit: BoxFit.cover)),
                           child: Stack(children: [Padding(
                             padding: const EdgeInsets.only(left: 100,top: 10),
                             child: SizedBox(
                                           height: 50,width: 200,
                                           child: ElevatedButton(style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromARGB(178, 255, 255, 255))),
                                           onPressed: (){
                                            Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const neethi()));
                                           }, child:Text("Pharmecy",style:GoogleFonts.abrilFatface(fontSize:20,color:Colors.black),))
                                           ),
                           )],),
                        )
                      ],
                    );
                  }
                );
              }
        
        ),
      ),);
  
  }
}