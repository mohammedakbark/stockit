import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';

import 'package:stockit/data/helper/service.dart';
import 'package:stockit/data/model/store_model.dart';
import 'package:stockit/data/provider/controller.dart';
import 'package:stockit/presentation/modules/admin/widgets/hometile.dart';

class rationowners extends StatefulWidget {
  const rationowners({super.key});

  @override
  State<rationowners> createState() => _rationownersState();
}

class _rationownersState extends State<rationowners> {
 

  

  @override
  Widget build(BuildContext context) {
    // Future<void> _pickedImageGallery() async {
    //   final pickedImage =
    //       await ImagePicker().pickImage(source: ImageSource.gallery);
    //   if (pickedImage == null) return;

    //   selectedImage = File(pickedImage.path);
    //   setState(() {});
    // }

    return Scaffold(
      body: HomeTile(type: 'Ration'),

     
    );
  }
}
