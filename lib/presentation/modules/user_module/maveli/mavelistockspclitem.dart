import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockit/presentation/common/special_stock_supplyco_and_maveli.dart';
import 'package:stockit/presentation/modules/user_module/home/ration_special_stock.dart';
import 'package:stockit/presentation/modules/user_module/maveli/maveli_list.dart';
import 'package:stockit/presentation/modules/user_module/maveli/maveli_stoc_view.dart';

class mavelistocks extends StatefulWidget {
  String storeId;
   mavelistocks({super.key,required this.storeId});

  @override
  State<mavelistocks> createState() => _mavelistocksState();
}

class _mavelistocksState extends State<mavelistocks> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
 bottom: TabBar(indicatorColor: Colors.black,labelColor: Colors.black,tabs:[
            
            Tab(child: Text('Stocks',style: TextStyle(fontSize: 20),),),
            Tab(child: Text('Special Item',style: TextStyle(fontSize: 20),)),
            
          ] ),
          leading: IconButton(
              onPressed: () {
                 Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_sharp,
                
              )),
          title: Text(
            'Maveli Store',
            style: GoogleFonts.inknutAntiqua(fontSize: 30),
          ),
          
          backgroundColor: const Color.fromARGB(136, 255, 255, 255),
        ),
        body: TabBarView(children: [
        MaveliStockview(storeId: widget.storeId,),
       SpecialStockOFMaveliAndSupplyco(collection: "Maveli Products", storeId:widget. storeId)
        
          
        ],),
      ),

    );
  }
}