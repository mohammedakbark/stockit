import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class maveliowners extends StatefulWidget {
  const maveliowners({super.key});

  @override
  State<maveliowners> createState() => _maveliownersState();
}

class _maveliownersState extends State<maveliowners> {
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
      body:  Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/login.png'), fit: BoxFit.cover)),
                child: ListView.builder(itemCount: 7,itemBuilder:(context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                    child: Container(
                    
                      height: 165,width: 250,
                      decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          SizedBox(width: 20,),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 35),
                            child: CircleAvatar(backgroundColor: Colors.white,
                            child: CircleAvatar(backgroundImage: AssetImage('images/Ellipse 4.png'),radius: 43,),
                            radius: 46,),
                          ),
                            SizedBox(width: 20,),
                            Column(
                              children: [
                                
                                Padding(
                                  padding: const EdgeInsets.only(left: 60),
                                  child: Row(
                                    children: [
                                      Text(' Sharika',style: GoogleFonts.abrilFatface(fontSize:20,color:Colors.white),),
                                      SizedBox(width: 50,),
                                      IconButton(onPressed: ()=>_showDeleteConfirmationDialog(context), 
                                      icon: Icon(Icons.delete,size: 20,color: Colors.white,))
                                    ],
                                  ),
                                ),
                                
                                Text('Thachanpoyil(H)',style: GoogleFonts.abyssinicaSil(fontSize:18,color:Colors.white),),
                                Text('Manjeri branch  ',style: GoogleFonts.abyssinicaSil(fontSize:16,color:Colors.white),),
                                Text('676509(pin), Malappuram(Dt)',style: GoogleFonts.abyssinicaSil(fontSize:16,color:Colors.white),),
                                 Text('9867345208(Ph)',style: GoogleFonts.abyssinicaSil(fontSize:16,color:Colors.white),),
                                 
                              ],
                            )
                            
                        ],
                      ),
                    ),
                  );
                },),
      ) ,
    );
  }
}