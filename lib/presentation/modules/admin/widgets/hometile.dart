import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/model/store_model.dart';

class HomeTile extends StatelessWidget {
  String type;
   HomeTile({super.key,required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/login.png'), fit: BoxFit.cover)),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream:   DbController().getAllStore(type),
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }
           List<StoreModel>listOfStore=snapshot.data!.docs.map((e) => StoreModel.fromjson(e.data())).toList();
            if(snapshot.hasData){
            return listOfStore.isEmpty?Center(child: Text("No Store Available"),): ListView.builder(
                      itemCount: listOfStore.length,
                      itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              padding: EdgeInsets.all(8),
              // height: 165,
              // width: 250,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                
                   CircleAvatar(
                     backgroundColor: Colors.white,
                     child: CircleAvatar(
                       backgroundImage: NetworkImage(listOfStore[index].imageUrl),
                       radius: 43,
                     ),
                     radius: 46,
                   ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            listOfStore[index].name,
                            style: GoogleFonts.abrilFatface(
                                fontSize: 20, color: Colors.white),
                          ),
                          // SizedBox(width: 20,),
                        // Expanded(child: SizedBox()),
                          IconButton(
                              onPressed: () =>
                                  _showDeleteConfirmationDialog(context,listOfStore[index].storeId),
                              icon: const Icon(
                                Icons.delete,
                                size: 20,
                                color: Colors.white,
                              ))
                        ],
                      ),
                      Text(
                         "Store Id ${listOfStore[index].storeId}",
                        style: GoogleFonts.abyssinicaSil(
                            fontSize: 18, color: Colors.white),
                      ),
                      Text(
                         listOfStore[index].branch,
                        style: GoogleFonts.abyssinicaSil(
                            fontSize: 16, color: Colors.white),
                      ),
                      Text(
                         listOfStore[index].pin,
                        style: GoogleFonts.abyssinicaSil(
                            fontSize: 16, color: Colors.white),
                      ),
                      Text(
                        '${ listOfStore[index].phoneNumber}(Ph)',
                        style: GoogleFonts.abyssinicaSil(
                            fontSize: 16, color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            );
                      },
                    );
          }
          else{
            return SizedBox();
          }
          }
        ),
      );
  }
   void _showDeleteConfirmationDialog(BuildContext context,id) {
    // Create an alert dialog
    AlertDialog alert = AlertDialog(
      title: const Text("Confirm Delete"),
      content: const Text("Are you sure you want to delete?"),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
        TextButton(
          child: const Text(
            "Delete",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            DbController().deleteAStore(id);

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
}