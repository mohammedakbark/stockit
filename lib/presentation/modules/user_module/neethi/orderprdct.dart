import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockit/presentation/modules/user_module/neethi/booksuccss.dart';

class orderproduct extends StatefulWidget {
  const orderproduct({super.key});

  @override
  State<orderproduct> createState() => _orderproductState();
}

class _orderproductState extends State<orderproduct> {
  final GlobalKey <FormState>_formkey=GlobalKey<FormState>();
   final _bookingController = TextEditingController();
  final __nameController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    DateTime _dateTime = DateTime.now();
    TimeOfDay _selectedtime = TimeOfDay.now();
    void _showdatepicker() {
      showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              lastDate: DateTime(3000))
          .then((value) => setState(() {
                _dateTime = value!;
              }));
    }

    String currentoption = "";
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
                color: const Color.fromARGB(178, 233, 231, 231),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 45,
                        width: 30,
                      ),
                      Text('Enter your Details',
                          style: GoogleFonts.abrilFatface(
                            fontSize: 32,
                            color: Colors.black,
                          )),
                          
                          Padding(
                            padding: const EdgeInsets.only(top: 45),
                            child: SizedBox(
                                               height: 80,
                                                  width: 300,
                                                  child: TextFormField(
                                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller:__nameController,
                    validator: (value) {
                     
                      if(value!.isEmpty){
                        return 'Please Enter value';
                  
                   }
                   return null;
                    },
                            cursorColor: Colors.black,
                            decoration: InputDecoration(focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.black)) ,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                fillColor: Color.fromARGB(255, 237, 234, 234),
                                filled: true,
                                hintText: ('Type Your Name')),
                                                  ),
                                                ),
                          ),
                        SizedBox(
                        height: 80,
                        width: 300,
                        child: TextFormField(inputFormatters: [FilteringTextInputFormatter.digitsOnly,],keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller:_bookingController,
                  
                  validator: (value) {
                    
                    if(value!.isEmpty){
                      return 'Please enter valid phone number';
                    }
                    
                    return null;
                  },
                  
                          maxLines: 3,
                          minLines: 1,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.black)) ,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              fillColor: Color.fromARGB(255, 237, 234, 234),
                              filled: true,
                              hintText: ('Phone number')),
                        ),
                      ),
                       
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Row(
                          children: [
                           SizedBox(
                                  height: 80,
                                  width: 100,
                                  child: TextField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(2),FilteringTextInputFormatter.digitsOnly
                                    ],
                                    keyboardType: TextInputType.number,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.black)) ,
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10)),
                                        fillColor: Color.fromARGB(255, 237, 234, 234),
                                        filled: true,
                                        hintText: ('No.of product')),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                                              height: 80,
                                                              width: 110,
                                                              child: TextField(
                                  decoration: InputDecoration(focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.black)) ,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10)),
                                      fillColor: Color.fromARGB(255, 237, 234, 234),
                                      filled: true,
                                      hintText:
                                          '${_dateTime.day}-${_dateTime.month}-${_dateTime.year}',
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            _showdatepicker();
                                          },
                                          icon: Icon(
                                            Icons.calendar_month_rounded,
                                            color: Colors.black,
                                            size: 30,
                                          ))),
                                                              ),
                                                            ),
                                ),
                           
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 100,height: 40,
                        child: ElevatedButton(style: ButtonStyle( foregroundColor: MaterialStatePropertyAll(Colors.black),backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 28, 209, 179))),
                          onPressed: (){
                             if(_formkey.currentState!.validate()){
                      Navigator.push(context,
             MaterialPageRoute(builder:(context)=> booksuccss()),);
                          }
                          },
                          child: Text('Order',style: TextStyle(fontWeight: FontWeight.bold),)),
                      )
                    ],
                  ),
                ),
              ),
            ),
        ),
      ),
    );
  }
}
