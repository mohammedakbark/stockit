import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockit/presentation/modules/user_module/home/grocery.dart';
import 'package:stockit/presentation/modules/user_module/packagegrocery.dart';
//import 'package:stockit/home/home2.dart';

class ordercomplt extends StatefulWidget {
  const ordercomplt({super.key});

  @override
  State<ordercomplt> createState() => _ordercompltState();
}

class _ordercompltState extends State<ordercomplt> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => packagesgro(indexnum: 0,)));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,

        //  leading: IconButton(onPressed: (){
        //   Navigator.pop(context);
        //  }, icon:Icon(Icons.arrow_back_ios_sharp) ),
        title: Text(
          'StockIt',
          style: GoogleFonts.inknutAntiqua(fontSize: 30),
        ),
        backgroundColor: Color.fromARGB(136, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/image 5.png'), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 100, left: 25, right: 25, bottom: 40),
            child: Container(
              color: Color.fromARGB(135, 255, 255, 255),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 45),
                    child: Image(image: AssetImage("images/Checkmark.png")),
                  ),
                  Text(
                    'Order Completed !',
                    style: GoogleFonts.abrilFatface(fontSize: 25),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text('Please arrive within ',
                        style: GoogleFonts.abrilFatface(fontSize: 16)),
                  ),
                  Text('Five days.',
                      style: GoogleFonts.abrilFatface(fontSize: 16))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
