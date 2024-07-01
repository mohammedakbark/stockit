import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/helper/login_preference.dart';
import 'package:stockit/presentation/modules/user_module/login/menuappinfo.dart';
import 'package:stockit/presentation/modules/user_module/login/menureview.dart';

class neethimenu extends StatefulWidget {
  const neethimenu({super.key});

  @override
  State<neethimenu> createState() => _neethimenuState();
}

class _neethimenuState extends State<neethimenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child:  Consumer<DbController>(
        builder: (context,controller,child) {
          return FutureBuilder(
            future: controller.getCurrentStoreData(controller.storeId),
            builder: (context,snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator(),);
              }

              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50,right: 130),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(controller.storeModel!.imageUrl),
                      radius: 65,backgroundColor:Colors.grey,),
                  ),
                 Padding(
                   padding: const EdgeInsets.only(left: 60),
                   child: Text(controller.storeModel!.name,style: GoogleFonts.abrilFatface(fontSize:20,color:Colors.white),),
                 ),
                 SizedBox(height: 50,),
                
                 ListTile(
                  leading: Icon(Icons.language,color:Colors.yellow[800],size: 35,),
                  title: Text('Language',style: GoogleFonts.inknutAntiqua(color:Colors.white),),
                 ),
                  Divider(),
                   ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => menureview(),
                                  ));
                            },
                            leading: Image.asset(
                              'images/review.png',
                              scale: 1,
                            ),
                            title: Text('Review/Feedback',
                                style: GoogleFonts.inknutAntiqua(
                                     color: Colors.white)),
                          ),
                          Divider(),
                           ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => menuappinfo(),
                                  ));
                            },
                            leading: Image.asset(
                              'images/appinfo.png',
                              scale: 1,
                            ),
                            title: Text('AppInfo',
                                style: GoogleFonts.inknutAntiqua(
                                     color: Colors.white)),
                          ),
                          Divider(),
                           ListTile(
                            onTap: () async {
                                                    LoginPreference.removePreference(context);
              
                              
                            },
                            leading: Image.asset(
                              'images/logout.png',
                              scale: 1,
                            ),
                            title: Text('Logout',
                                style: GoogleFonts.inknutAntiqua(
                                    fontSize: 15, color: Colors.white)),
                          ),
                          Divider(),
                ],
              );
            }
          );
        }
      ),
    );
  }
}