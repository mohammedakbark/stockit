import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockit/presentation/modules/user_module/home/ration_list.dart';
import 'package:stockit/presentation/modules/user_module/home/ration_stock.dart';
import 'package:stockit/presentation/modules/user_module/home/ration4.dart';

import 'package:stockit/presentation/modules/user_module/home/stock_view_page.dart';

class RationDetailAddingPage extends StatefulWidget {
  String storeId;
   RationDetailAddingPage({super.key,required this.storeId});

  @override
  State<RationDetailAddingPage> createState() => _RationDetailAddingPageState();
}

class _RationDetailAddingPageState extends State<RationDetailAddingPage> {
  final __nameController = TextEditingController();
  final _cardnumberController = TextEditingController();
  final _memberController = TextEditingController();
  // String? card;
  String _selectedValue = "White";
  void _handleRadioValueChanged(String value) {
    setState(() {
      _selectedValue = value;
    });
  }

  final _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_sharp)),
        title: Text(
          'Ration Store',
          style: GoogleFonts.inknutAntiqua(fontSize: 25),
        ),
        backgroundColor: const Color.fromARGB(136, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/image 5.png'),
                      fit: BoxFit.cover)),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 100, left: 10, right: 10, bottom: 30),
                child: Container(
                  color: const Color.fromARGB(135, 255, 255, 255),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          'Your Details',
                          style: GoogleFonts.abrilFatface(
                              fontSize: 40, color: Colors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: SizedBox(
                            height: 65,
                            width: 340,
                            child: TextFormField(
                              cursorColor: Colors.black,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: __nameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter value';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: Colors.black)),
                                  fillColor: const Color.fromARGB(177, 255, 255, 255),
                                  filled: true,
                                  hintText: ('Enter your Name')),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: SizedBox(
                            height: 65,
                            width: 340,
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: _cardnumberController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter card number';
                                }
                                return null;
                              },
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: Colors.black)),
                                  fillColor: const Color.fromARGB(177, 255, 255, 255),
                                  filled: true,
                                  hintText: ('Ration card Number')),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color.fromARGB(179, 0, 0, 0)),
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(177, 255, 255, 255),
                            ),
                            //color: Color.fromARGB(177, 255, 255, 255),
                            height: 250,
                            width: 340,
                            child: Column(
                              children: [
                                const Padding(
                                  padding:
                                      EdgeInsets.only(right: 70, top: 10),
                                  child: Text(
                                    "Select Card color:",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Row(
                                      //mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Radio<String>(
                                          value: "White",
                                          groupValue: _selectedValue,
                                          onChanged: (value) =>
                                              _handleRadioValueChanged(value!),
                                        ),
                                        const Text('White'),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                 // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Radio<String>(
                                      value: "Blue",
                                      groupValue: _selectedValue,
                                      onChanged: (value) =>
                                          _handleRadioValueChanged(value!),
                                    ),
                                    const Text('Blue'),
                                  ],
                                ),
                                 Row(
                                 // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Radio<String>(
                                      value: "Pink",
                                      groupValue: _selectedValue,
                                      onChanged: (value) =>
                                          _handleRadioValueChanged(value!),
                                    ),
                                    const Text('Pink'),
                                  ],
                                ),
                                Row(
                                 // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Radio<String>(
                                      value: "Yellow",
                                      groupValue: _selectedValue,
                                      onChanged: (value) =>
                                          _handleRadioValueChanged(value!),
                                    ),
                                    const Text('Yellow'),
                                  ],
                                ),
                             
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, right: 95),
                          child: SizedBox(
                            height: 65,
                            width: 240,
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: _memberController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter value';
                                }
        
                                return null;
                              },
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(2),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: Colors.black)),
                                  fillColor: const Color.fromARGB(177, 255, 255, 255),
                                  filled: true,
                                  hintText: ('Number of members')),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            height: 50,
                            width: 150,
                            child: ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.black),
                                    foregroundColor:
                                        MaterialStatePropertyAll(Colors.white)),
                                        onPressed: (){
          //                              
        if(_formKey.currentState!.validate()){
              Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RationStockViewPage(
            cardColor: _selectedValue,
            cardNumber: _cardnumberController.text,
            name: __nameController.text,
            number: int.parse(_memberController.text,),
            card: _selectedValue,
            storeId:widget.storeId ,
          )),
        );
          
        
        }
                                        }
                                // onPressed: () {
                                //   if (_formkey.currentState!.validate()) {
                                //     Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) => rationstocks()),
                                //     );
                                //   }
                                // },
                             ,   child: const Text(
                                  'Submit',
                                  style: TextStyle(fontSize: 18),
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
