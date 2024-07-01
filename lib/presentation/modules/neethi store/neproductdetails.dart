import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockit/data/model/product_neethi_model.dart';
import 'package:stockit/presentation/modules/user_module/neethi/cart.dart';

class neproductdetails extends StatefulWidget {
  ProductNeethiModel model;
   neproductdetails({super.key,required this.model});

  @override
  State<neproductdetails> createState() => _neproductdetailsState();
}

class _neproductdetailsState extends State<neproductdetails> {
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
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_sharp,
             
            )),
        backgroundColor: Color.fromARGB(141, 255, 255, 255),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/pharmacy.png'), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 40, left: 20, right: 20, bottom: 80),
          child: Container(
            color: Color.fromARGB(178, 233, 231, 231),
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
                  padding: const EdgeInsets.only(right: 40, top: 25),
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
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'MRP',
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.currency_rupee,
                      size: 18,
                      color: Colors.grey,
                    ),
                    Text(
                      widget.model.mrp,
                      style: TextStyle(
                          decorationColor: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Text(
                        '${widget.model.offer}%OFF',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 90,
                    ),
                    Icon(
                      Icons.currency_rupee,
                      size: 28,
                    ),
                    Text(
                      widget.model.price,
                      style: TextStyle(
                          fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 90,
                    ),
                   
                  ],
                ),
                SizedBox(height: 50,),
                 Padding(
                   padding: const EdgeInsets.only(left: 250),
                   child: IconButton(onPressed: ()=>_showDeleteConfirmationDialog(context), 
                                        icon: Icon(Icons.delete,size: 30,color: Colors.orange,)),
                 )
              ],
            ),
          ),
        ),
      ),
    );
  }
}