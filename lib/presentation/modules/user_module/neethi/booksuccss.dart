import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockit/presentation/modules/user_module/neethi/labtest.dart';
import 'package:stockit/presentation/modules/user_module/neethi/neethi3.dart';
import 'package:stockit/presentation/modules/user_module/neethi/neethi_list.dart';
import 'package:stockit/presentation/modules/user_module/package.dart';

class booksuccss extends StatefulWidget {
  const booksuccss({super.key});

  @override
  State<booksuccss> createState() => _booksuccssState();
}

class _booksuccssState extends State<booksuccss> {
  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds:4),(){
       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>packages(indexnum: 0)), (route) => false);
     });
  }
  Widget build(BuildContext context) {
    return Scaffold(

      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // leading: IconButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     icon: const Icon(
        //       Icons.arrow_back_ios_sharp,
              
        //     )),
            title: Text('StockIt',style: GoogleFonts.inknutAntiqua(fontSize: 30),),
        backgroundColor: const Color.fromARGB(136, 255, 255, 255),
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
              padding: const EdgeInsets.only(top: 100, left: 20, right: 20, bottom: 30),
              child: Container(
                color: Color.fromARGB(178, 233, 231, 231),
                child: Column(
                  children: [
            
                    Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: Image.asset('images/booksuccess.png',scale:1 ,),
                    ),
                    Text('Successfull!',style: GoogleFonts.abrilFatface(fontSize:30))
                  ],
                ),
              ),
            ),
        ),
      ),
    );
  }
}