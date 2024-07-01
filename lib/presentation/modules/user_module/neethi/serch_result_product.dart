import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/model/product_neethi_model.dart';
import 'package:stockit/presentation/modules/neethi%20store/neproductdetails.dart';
import 'package:stockit/presentation/modules/user_module/neethi/neethi3.dart';
import 'package:stockit/presentation/modules/user_module/neethi/sebamade.dart';
import 'package:stockit/presentation/modules/user_module/neethi/topselling.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
               Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_sharp,
             
            )),
        
         backgroundColor: const Color.fromARGB(136, 255, 255, 255),
    ),
      body:  SingleChildScrollView(
      child: Container(
        
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('images/pharmacy.png'),fit: BoxFit.cover)
        ),
          child: Consumer<DbController>(
            builder: (context,searcher,child) {
              return Column(children: [
                //SizedBox(height: 90,width: 50,),
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: SizedBox(height: 50,width: 355,
                    child: TextFormField(
                      onTap: () {
                        searcher.getNeethiProducForSearch( Provider.of<DbController>(context,listen: false).currentStoreid);
                      },
                      onChanged: (value) {
                        searcher.searchNeethiProdut(value);
                      },
                      cursorColor: Colors.black,
                                     decoration: InputDecoration(focusedBorder:const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)) ,
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                     fillColor: const Color.fromARGB(186, 255, 255, 255),filled: true,prefixIcon: const Icon(Icons.search,size: 35,),
                                     hintText: ('Sebamade')),
                                     ),
                  ),
                ),
                const SizedBox(height: 15,width: 30),
               Container(
                    height: 565,
                    width: 355,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(186, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Colors.black)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 80),
                          child: Text(
                            'Showing suggession for sebamade',
                            style: GoogleFonts.abrilFatface(
                                fontSize: 15,
                                color: const Color.fromARGB(175, 0, 0, 0)),
                          ),
                        ),
                        StreamBuilder<QuerySnapshot>(
                            stream: DbController().getAllNeethiProducts( Provider.of<DbController>(context,listen: false).currentStoreid),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              List<ProductNeethiModel> listOfNeethiProducts =[];

                              if(searcher.listOFneethoiProductForSeach.isNotEmpty){
                                listOfNeethiProducts=searcher.searchResultOfNeethiProduct;

                              }else{
                                  listOfNeethiProducts=          snapshot.data!.docs
                                      .map((e) => ProductNeethiModel.fromJson(
                                          e.data() as Map<String, dynamic>))
                                      .toList();
              

                              }
                      
                              if (snapshot.hasData) {
                                return Expanded(
                                    child:listOfNeethiProducts.isEmpty?const Center(child: Text("No Product Found"),): ListView.builder(
                                  itemCount: listOfNeethiProducts.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(left: 10),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    listOfNeethiProducts[index].prodName,
                                                    style: GoogleFonts.abrilFatface(
                                                        fontSize: 15,
                                                        color: Colors.black),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        right: 140),
                                                    child: Text(
                                                      '150g ',
                                                      style:
                                                          GoogleFonts.abrilFatface(
                                                              fontSize: 12),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Expanded(child: SizedBox()),
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              BuyProductPage(model: listOfNeethiProducts[index],)));
                                                },
                                                icon: const Icon(
                                                  Icons.arrow_forward_ios_rounded,
                                                  size: 20,
                                                )),
                                          ],
                                        ),
                                        const Divider(color: Colors.black)
                                      ],
                                    );
                                  },
                                ));
                              }else{
                                return const SizedBox();
                              }
                            })
                      ],
                    ),
                  )                
              ],);
            }
          ),
      
      ),
    ),
    );
  }
}