import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/model/product_neethi_model.dart';
import 'package:stockit/presentation/modules/neethi%20store/neproductdetails.dart';
import 'package:stockit/presentation/modules/user_module/neethi/sebamade.dart';

class neallproduct extends StatefulWidget {
  const neallproduct({super.key});

  @override
  State<neallproduct> createState() => _neallproductState();
}

class _neallproductState extends State<neallproduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_sharp,
            )),
        title: Text(
          'Products',
          style: GoogleFonts.inknutAntiqua(fontSize: 25),
        ),
        backgroundColor: const Color.fromARGB(136, 255, 255, 255),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/pharmacy.png'), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 60,
                width: 355,
                child: Consumer<DbController>(
                  builder: (context,searcher,child) {
                    return TextFormField(
                      onTap: () {
                        searcher.getNeethiProdutForSearch(Provider.of<DbController>(context,listen: false).storeId!);
                      },
                      onChanged: (value) {
                        searcher.seachNeethiproduct(value);
                      },
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          fillColor: const Color.fromARGB(186, 255, 255, 255),
                          filled: true,
                          prefixIcon: const Icon(
                            Icons.search,
                            size: 35,
                          ),
                          hintText: ('sebamade')),
                    );
                  }
                ),
              ),
              const SizedBox(height: 15, width: 30),
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
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Showing suggession for sebamade',
                          style: GoogleFonts.abrilFatface(
                              fontSize: 15,
                              color: const Color.fromARGB(175, 0, 0, 0)),
                        ),
                      ),
                    ),
                    Consumer<DbController>(
                      builder: (context,searcher,child) {
                        return StreamBuilder<QuerySnapshot>(
                            stream: DbController().getSelectedNeethiProducts(Provider.of<DbController>(context,listen: false).storeId!),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              List<ProductNeethiModel> listOfNeethiProducts =[];
                          if(searcher.listOfNethiproductForSearch.isNotEmpty){
                            listOfNeethiProducts=searcher.searchResultofNeethiProduct;
          
                          }else{
                              listOfNeethiProducts=      snapshot.data!.docs
                                      .map((e) => ProductNeethiModel.fromJson(
                                          e.data() as Map<String, dynamic>))
                                      .toList();
                          }
                              
                              if (snapshot.hasData) {
                                return Expanded(
                                    child: ListView.builder(
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
                                                        fontSize: 18,
                                                        color: Colors.black),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 10),
                                                    child: Text(
                                                      'description ',
                                                      style:
                                                          GoogleFonts.abrilFatface(
                                                              fontSize: 12),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(child: SizedBox()),
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                               neproductdetails(model: listOfNeethiProducts[index],)));
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
                                return SizedBox();
                              }
                            });
                      }
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    // Provider.of<DbController>(context,listen: false).dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
