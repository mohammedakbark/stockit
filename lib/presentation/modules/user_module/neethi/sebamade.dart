import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockit/data/model/product_neethi_model.dart';
import 'package:stockit/presentation/modules/user_module/neethi/booking.dart';
import 'package:stockit/presentation/modules/user_module/neethi/cart.dart';
import 'package:stockit/presentation/modules/user_module/neethi/serch_result_product.dart';

class BuyProductPage extends StatefulWidget {
  ProductNeethiModel model;
   BuyProductPage({super.key,required this.model});

  @override
  State<BuyProductPage> createState() => _BuyProductPageState();
}

class _BuyProductPageState extends State<BuyProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_sharp,
             
            )),
        backgroundColor: const Color.fromARGB(141, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/pharmacy.png'), fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 100, left: 20, right: 20, bottom: 50),
            child: Container(
              color: const Color.fromARGB(178, 233, 231, 231),
              child: Column(
                children: [
                  Container(
                      height: 300,
                      width: 350,
                      color: Colors.white,
                      child: Image(
                        image: NetworkImage(widget.model.imageUrl),
                        fit: BoxFit.cover,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(right: 40, top: 10),
                    child: Text(
                      widget.model.prodName,
                      style: GoogleFonts.abrilFatface(fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 210, top: 5),
                    child: Text(widget.model.description,
                        style: GoogleFonts.abrilFatface(fontSize: 14)),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        'MRP',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Icon(
                        Icons.currency_rupee,
                        size: 18,
                        color: Colors.grey,
                      ),
                      Text(
                        widget.model.mrp,
                        style: const TextStyle(
                            decorationColor: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        '${ widget.model.offer}%OFF',
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      const Icon(
                        Icons.currency_rupee,
                        size: 22,
                      ),
                      Text(
                       widget.model.price,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 90,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 20, left: 15),
                      //   child: ElevatedButton(
                      //       style: ButtonStyle(
                      //           backgroundColor: MaterialStatePropertyAll(
                      //               Color.fromARGB(200, 236, 145, 26))),
                      //       onPressed: () {
                      //         Navigator.push(
                      //           context,
                      //           MaterialPageRoute(builder: (context) => cart()),
                      //         );
                      //       },
                      //       child: Text(
                      //         'Add to Cart',
                      //         style: GoogleFonts.abrilFatface(
                      //             fontSize: 15, color: Colors.black),
                      //       )),
                      // )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 100,
                    height: 40,
                    child: ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.black)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  BookingDetaiPage(
                                 type: "Product",
                                                                          productId:widget.model.prodictid!,
                            )),
                          );
                        },
                        child: Text(
                          'Order',
                          style: GoogleFonts.abrilFatface(
                              fontSize: 15, color: Colors.white),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
