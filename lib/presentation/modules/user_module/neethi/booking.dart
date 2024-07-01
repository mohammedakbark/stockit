import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/model/booking_model.dart';
import 'package:stockit/data/provider/controller.dart';
import 'package:stockit/presentation/modules/user_module/neethi/booksuccss.dart';

class BookingDetaiPage extends StatefulWidget { 
  String type;
  String productId;
  BookingDetaiPage({super.key, required this.productId, required this.type});

  @override
  State<BookingDetaiPage> createState() => _BookingDetaiPageState();
}

class _BookingDetaiPageState extends State<BookingDetaiPage> {
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final bookingDetails = TextEditingController();
  final age = TextEditingController();
  var date = TextEditingController();
  var time = TextEditingController();
  @override
  Widget build(BuildContext context) {
    DateTime _dateTime = DateTime.now();
    TimeOfDay _selectedtime = TimeOfDay.now();
    // void _showdatepicker() {

    //       .then((value) => setState(() {
    //             _dateTime = value!;
    //           }));
    // }

    //final List options = ['option1', 'option2'];
    String currentoption = "Male";
    return Scaffold(
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
              padding: const EdgeInsets.only(
                  top: 120, left: 30, right: 30, bottom: 40),
              child: Container(
                color: const Color.fromARGB(178, 233, 231, 231),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // ignore: prefer_const_constructors
                      SizedBox(
                        height: 45,
                        width: 30,
                      ),
                      Text('Enter your Details',
                          style: GoogleFonts.abrilFatface(
                            fontSize: 30,
                            color: Colors.black,
                          )),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        height: 65,
                        width: 300,
                        child: TextFormField(
                          controller: name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Feild is required";
                            } else {
                              return null;
                            }
                          },
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              fillColor:
                                  const Color.fromARGB(255, 237, 234, 234),
                              filled: true,
                              hintText: ('Type Your Name')),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 65,
                        width: 300,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 237, 234, 234),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: Colors.black)),
                        child: Consumer<Controller>(
                            builder: (context, controller, chuld) {
                          return Row(
                            children: [
                              const Text('    Gender:',
                                  style: TextStyle(fontSize: 18)),
                              Expanded(
                                child: RadioListTile(
                                    title: const Text('M'),
                                    value: 'Male',
                                    groupValue: controller.selectedItem,
                                    onChanged: (value) {
                                      controller.chanageItem(value);
                                    }),
                              ),
                              Expanded(
                                child: RadioListTile(
                                    title: const Text('F'),
                                    value: 'Female',
                                    groupValue: controller.selectedItem,
                                    onChanged: (value) {
                                      controller.chanageItem(value);

                                      // SizedBox(
                                      //   height: 50,
                                      //   width: 100,
                                      //   child: TextField(
                                      //     decoration: InputDecoration(
                                      //         border: OutlineInputBorder(
                                      //             borderRadius:
                                      //                 BorderRadius.circular(10)),
                                      //         fillColor: Color.fromARGB(
                                      //             255, 237, 234, 234),
                                      //         filled: true,
                                      //         hintText:
                                      //             '${_dateTime.day}-${_dateTime.month}-${_dateTime.year}',
                                      //         suffixIcon: IconButton(
                                      //             onPressed: () async {
                                      //               final TimeOfDay? timeOfDay =
                                      //                   await showTimePicker(
                                      //                       context: context,
                                      //                       initialTime:
                                      //                           _selectedtime,
                                      //                       initialEntryMode:
                                      //                           TimePickerEntryMode
                                      //                               .dial);
                                      //               if (timeOfDay != null) {
                                      //                 setState(() {
                                      //                   _selectedtime = timeOfDay;
                                      //                 });
                                      //               }
                                      //             },
                                      //             icon: Icon(
                                      //               Icons.schedule,
                                      //               color: Colors.black,
                                      //               size: 30,
                                      //             ))),
                                      //   ),
                                      // );
                                    }),
                              ),
                            ],
                          );
                        }),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        height: 65,
                        width: 300,
                        child: TextFormField(
                          controller: bookingDetails,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Feild is required";
                            } else {
                              return null;
                            }
                          },
                          maxLines: 3,
                          minLines: 1,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              fillColor:
                                  const Color.fromARGB(255, 237, 234, 234),
                              filled: true,
                              hintText: ('Booking Details')),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            height: 65,
                            width: 60,
                            child: TextFormField(
                              controller: age,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Feild is required";
                                } else {
                                  return null;
                                }
                              },
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(2)
                              ],
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  fillColor:
                                      const Color.fromARGB(255, 237, 234, 234),
                                  filled: true,
                                  hintText: ('Age')),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            height: 65,
                            width: 120,
                            child: TextFormField(
                              controller: date,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Feild is required";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  fillColor:
                                      const Color.fromARGB(255, 237, 234, 234),
                                  filled: true,
                                  hintText:
                                      '${_dateTime.day}-${_dateTime.month}-${_dateTime.year}',
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        showDatePicker(
                                                context: context,
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime(3000))
                                            .then((value) {
                                          setState(() {
                                            date = TextEditingController(
                                                text:
                                                    '${value!.day}-${value.month}-${value.year}');
                                          });
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.calendar_month_rounded,
                                        color: Colors.black,
                                        size: 30,
                                      ))),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            height: 65,
                            width: 120,
                            child: TextFormField(
                              controller: time,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Feild is required";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  fillColor:
                                      const Color.fromARGB(255, 237, 234, 234),
                                  filled: true,
                                  hintText:
                                      '${_selectedtime.hour}-${_selectedtime.minute}-${_selectedtime.period.name}',
                                  suffixIcon: IconButton(
                                      onPressed: () async {
                                        await showTimePicker(
                                          context: context,
                                          initialTime: _selectedtime,
                                        ).then((value) {
                                          time = TextEditingController(
                                              text:
                                                  '${value!.hour}-${value.minute}-${value.period.name.toUpperCase()}');
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.schedule,
                                        color: Colors.black,
                                        size: 30,
                                      ))),
                            ),
                          ),
                        ],
                      ),
                      Consumer<Controller>(
                          builder: (context, controller, chil) {
                        return ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                DbController()
                                    .bookOrder(BookingModel(
                                      storeId: "",
                                      status:"Pending",
                                        age: age.text,
                                        date: date.text,
                                        productId: widget.productId,
                                        detail: bookingDetails.text,
                                        gender: controller.selectedItem,
                                        name: name.text,
                                        time: time.text,
                                        typeOfOrder: widget.type,
                                        uid: FirebaseAuth
                                            .instance.currentUser!.uid))
                                    .then((value) {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => booksuccss()));
                                });
                              }
                            },
                            child: const Text("Submit"));
                      })
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
