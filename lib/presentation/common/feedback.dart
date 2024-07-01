import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/model/feedback_model.dart';
import 'package:stockit/presentation/common/ratio%20nmenu.dart';

class feedback extends StatefulWidget {
  const feedback({super.key});

  @override
  State<feedback> createState() => _feedbackState();
}

class _feedbackState extends State<feedback> {
  final email = TextEditingController();
  final suggestion = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(136, 255, 255, 255),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_sharp,
            )),
        title: Text(
          'Feedback',
          style: GoogleFonts.abrilFatface(fontSize: 30),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/image 5.png'),
          fit: BoxFit.cover,
        )),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 100, bottom: 20, left: 5, right: 5),
          child: Container(
            color: const Color.fromARGB(204, 14, 14, 14),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                        height: 80,
                        width: 350,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: TextFormField(
                            controller: email,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Field is required";
                              } else {
                                return null;
                              }
                            },
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                hintText: ('Email Id'),
                                fillColor: const Color.fromARGB(136, 255, 255, 255),
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: SizedBox(
                        height: 300,
                        width: 350,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Field is required";
                            } else {
                              return null;
                            }
                          },
                          controller: suggestion,
                          maxLines: 10,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(100)
                          ],
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              hintText: ('Type Suggestion/Feedback'),
                              fillColor: const Color.fromARGB(136, 255, 255, 255),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                    ),
                    ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 221, 115, 22)),
                            foregroundColor:
                                MaterialStatePropertyAll(Colors.black)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            DbController().addToFeedBAck(FeedbackModel(
                                email: email.text,
                                suggestions: suggestion.text,
                                uid: FirebaseAuth.instance.currentUser!.uid));
                          }
                          email.clear();
                          suggestion.clear();
                          Navigator.pop(context);
                
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => rationmenu(),));
                        },
                        child: const Text('SUBMIT'))
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
