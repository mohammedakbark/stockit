import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/model/add_product_store.dart';

class mavmodulespecial extends StatefulWidget {
  const mavmodulespecial({super.key});

  @override
  State<mavmodulespecial> createState() => _mavmodulespecialState();
}

class _mavmodulespecialState extends State<mavmodulespecial> {
   void _showDeleteConfirmationDialog(BuildContext context) {
    // Create an alert dialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirm Delete"),
      content: Text("Are you sure you want to delete?"),
      actions: [
        TextButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
        TextButton(
          child: Text(
            "Delete",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            // Perform deletion logic here
            //  e.g., remove item from list, call an API
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
      ],
    );

    // Show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.menu)),
        title: Text(
          'Special Item',
          style: GoogleFonts.abrilFatface(fontSize: 20),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/image 5.png'), fit: BoxFit.cover)),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 80, bottom: 30, left: 30, right: 30),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: DbController().getSpecialMaveliProducts(    Provider.of<DbController>(context,listen: false).storeId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      List<StoreProductModel> list = [];
                      list = snapshot.data!.docs
                          .map((e) => StoreProductModel.fromJson(
                              e.data() as Map<String, dynamic>))
                          .toList();

                      if (snapshot.hasData) {
                        return list.isEmpty
                            ? Center(
                                child: Text(
                                  "No Products",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            : ListView.builder(
                                itemCount: list.length,
                                itemBuilder: (context, index) => Column(
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.black),
                                                color: Color.fromARGB(
                                                    206, 255, 255, 255)),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 10,
                                                    bottom: 10,
                                                    left: 10,
                                                  ),
                                                  child: SizedBox(
                                                    height: 100,
                                                    width: 100,
                                                    child: Image.network(
                                                                                                    fit: BoxFit.cover,

                                                        list[index].imageUrl),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20, bottom: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          list[index]
                                                              .productName,
                                                          style: GoogleFonts
                                                              .inknutAntiqua(
                                                                  fontSize:
                                                                      20)),
                                                      Row(
                                                        children: [
                                                          Icon(Icons
                                                              .currency_rupee_sharp),
                                                          Text(
                                                            '${list[index].price}/Kg',
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 8),
                                                            child: Text(
                                                                '${list[index].qty} Kg/Person',
                                                                style: TextStyle(
                                                                    fontSize: 18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)),
                                                          ),
                                                           IconButton(onPressed: ()=>_showDeleteConfirmationDialog(context), 
                                      icon: Icon(Icons.delete,size: 20,color: Colors.amber,))
                                                        ],
                                                      ),
                                                      // ElevatedButton(style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black),foregroundColor: MaterialStatePropertyAll(Colors.white)),
                                                      // onPressed: (){}, child: const Text('Choose',style: TextStyle(fontSize: 15,),))
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )),
                                        SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    ));
                      } else {
                        return SizedBox();
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
