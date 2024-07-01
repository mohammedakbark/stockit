import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockit/presentation/common/special_stock_supplyco_and_maveli.dart';
import 'package:stockit/presentation/modules/user_module/home/ration_special_stock.dart';
import 'package:stockit/presentation/modules/user_module/user%20supplyco/supplyco_stock_view.dart';
import 'package:stockit/presentation/modules/user_module/user%20supplyco/supplyco_list.dart';

class supplycostocks extends StatefulWidget {
  String storeID;
  supplycostocks({super.key, required this.storeID});

  @override
  State<supplycostocks> createState() => _supplycostocksState();
}

class _supplycostocksState extends State<supplycostocks> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        //extendBodyBehindAppBar: true,
        appBar: AppBar(
          bottom: TabBar(
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              tabs: [
                Tab(
                  child: Text(
                    'Stocks',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Tab(
                    child: Text(
                  'Special Item',
                  style: TextStyle(fontSize: 20),
                )),
              ]),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_sharp,
              )),
          title: Text(
            'Supplyco Store',
            style: GoogleFonts.inknutAntiqua(fontSize: 25),
          ),
          backgroundColor: Color.fromARGB(37, 255, 255, 255),
        ),
        body: TabBarView(
          children: [
            SupplycoStockView(
              storeId: widget.storeID,
            ),
            SpecialStockOFMaveliAndSupplyco(
                collection: "Supplyco Products", storeId: widget.storeID)
          ],
        ),
      ),
    );
  }
}
