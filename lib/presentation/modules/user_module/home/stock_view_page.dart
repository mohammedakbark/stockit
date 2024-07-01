import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockit/presentation/modules/user_module/home/ration_special_stock.dart';
import 'package:stockit/presentation/modules/user_module/home/ration_list.dart';
import 'package:stockit/presentation/modules/user_module/home/ration_stock.dart';
import 'package:stockit/presentation/modules/user_module/home/ration4.dart';

class RationStockViewPage extends StatefulWidget {
  String name;
  String cardNumber;
  String cardColor;
  int number;
  String card;
  String storeId;
  RationStockViewPage(
      {super.key,
      required this.card,
      required this.storeId,
      required this.cardColor,
      required this.cardNumber,
      required this.name,
      required this.number});

  @override
  State<RationStockViewPage> createState() => _RationStockViewPageState();
}

class _RationStockViewPageState extends State<RationStockViewPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
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
                size: 25,
              )),
          title: Text(
            '${widget.card} card',
            style: GoogleFonts.inknutAntiqua(fontSize: 25),
          ),
          backgroundColor: const Color.fromARGB(136, 255, 255, 255),
        ),
        body: TabBarView(
          children: [
            RationStock(
              selectedCard: widget.card,
              storeID: widget.storeId,
              cardNumber: widget.cardNumber,
              name: widget.name,
              numberOfMembers: widget.number.toString(),
            ),
            RationSpecialStock(
                card: widget.card,
                storeId: widget.storeId,
                cardNumber: widget.cardNumber,
                name: widget.name,
                numberOfMembers: widget.number.toString()),
          ],
        ),
      ),
    );
  }
}
