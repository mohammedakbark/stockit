import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockit/presentation/modules/neethi%20store/labtestorder.dart';
import 'package:stockit/presentation/modules/neethi%20store/neethimenu.dart';
import 'package:stockit/presentation/modules/neethi%20store/orderall.dart';
import 'package:stockit/presentation/modules/neethi%20store/prescriptionorder.dart';
import 'package:stockit/presentation/modules/user_module/neethi/offer.dart';
import 'package:stockit/presentation/modules/user_module/neethi/offerlab.dart';
import 'package:stockit/presentation/modules/user_module/neethi/offermedcine.dart';

class ordernee extends StatefulWidget {
  const ordernee({super.key});

  @override
  State<ordernee> createState() => _orderneeState();
}

class _orderneeState extends State<ordernee> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: neethimenu(),
        //extendBodyBehindAppBar: true,
        appBar: AppBar(
          bottom: TabBar(indicatorColor: Colors.black,labelColor: Colors.black,tabs:[
            
            Tab(child: Text('All'),),
            Tab(child: Text('Prescription')),
            Tab(child: Text('Lab test'),)
          ] ),
          leading: Builder(builder: (context) {
            return IconButton(onPressed: (){
              Scaffold.of(context).openDrawer();
            }, icon: Icon(Icons.menu,color: Colors.black,));
          },),
          title: Text(
            'Orders',
            style: GoogleFonts.inknutAntiqua(fontSize: 30),
          ),
        backgroundColor: Color.fromARGB(101, 255, 255, 255),
           
        ),
        body: TabBarView(children: [
          orderall(),
        prescriptionorder(),
          orderlabtest()
        ],),
      ),
    );
  }
}