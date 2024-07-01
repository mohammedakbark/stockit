import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/model/feedback_model.dart';
import 'package:stockit/presentation/modules/user_module/login/menuhome.dart';

class menureview extends StatefulWidget {
  const menureview({super.key});

  @override
  State<menureview> createState() => _menureviewState();
}

class _menureviewState extends State<menureview> {
  final email =TextEditingController();
  final feedback=TextEditingController();
  final _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(136, 255, 255, 255),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_sharp)),
        title: Text(
          'Review/Feedback',
          style: GoogleFonts.abrilFatface(fontSize: 30),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 73, 49, 38),
                      Color.fromARGB(255, 244, 119, 2)
                    ]),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 250, left: 50),
                    child: Image(
                      image: AssetImage('images/image 29.png'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 100, bottom: 20, left: 5, right: 5),
                    child: Container(
                      height: 700,
                      width: 400,
                      color: Color.fromARGB(204, 14, 14, 14),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
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
                                        if(value!.isEmpty){
                                          return "Field is Required";
                                        }else{
                                          return null;
                                        }
                                      },
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          hintText: ('Email Id'),
                                          fillColor:
                                              Color.fromARGB(88, 255, 255, 255),
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                    ),
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: SizedBox(
                                  height: 300,
                                  width: 350,
                                  child: TextFormField(
                                    controller: feedback,
                                    validator: (value) {
                                        if(value!.isEmpty){
                                          return "Field is Required";
                                        }else{
                                          return null;
                                        }
                                      },
                                    maxLines: 10,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(100)
                                    ],
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black)),
                                        hintText: ('Type Suggestion/Feedback'),
                                        fillColor:
                                            Color.fromARGB(88, 255, 255, 255),
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Color.fromARGB(255, 221, 115, 22)),
                                      foregroundColor:
                                          MaterialStatePropertyAll(Colors.black)),
                                  onPressed: () {
                                    if(_formKey.currentState!.validate()){

                                      DbController().addToFeedBAck(FeedbackModel(email: email.text, suggestions: feedback.text, uid: Provider.of<DbController>(context,listen: false).storeId!)).then((value) {
                                        Navigator.pop(context);
                                        email.clear();
                                        feedback.clear();
                                      });
                                      
                                    }
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => menuhome(),));
                                  },
                                  child: Text('SUBMIT'))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
