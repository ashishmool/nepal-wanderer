
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nepal_wanderer/models/CustomerModel.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:provider/provider.dart';

import '../provider/user_view_model.dart';

class FirestoreExample extends StatefulWidget {
  const FirestoreExample({super.key});

  static const String routeName = "/example";

  @override
  State<FirestoreExample> createState() => _FirestoreExampleState();
}

class _FirestoreExampleState extends State<FirestoreExample> {
  TextEditingController emailController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();

  final firestore = FirebaseFirestore.instance;

  ImagePicker picker = ImagePicker();
  FirebaseStorage storage = FirebaseStorage.instance;

  File ? image;
  String ? url;


  void pickImage(ImageSource source) async{
   var selected = await picker.pickImage(source: source,imageQuality: 100);
   if (selected == null){
     ScaffoldMessenger.of(context)
         .showSnackBar(SnackBar(content: Text("No image selected")));
   }else{
      setState(() {
        image = File(selected.path);
        saveToStorage();
      });
   }
  }

  void saveToStorage() async{
    String name = image!.path.split('/').last;

    final photo = await storage.ref()
        .child('users')
        .child(name)
        .putFile(File(image!.path));
    String tempUrl = await photo.ref.getDownloadURL();
    setState(() {
      url = tempUrl;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text("Email"),
              TextFormField(controller: emailController),
              SizedBox(height: 10),
              Text("First Name"),
              TextFormField(controller: fnameController),
              SizedBox(height: 10),
              Text("Last Name"),
              TextFormField(controller: lnameController),
              SizedBox(height: 10),
        
              image == null ? SizedBox() : Image.file(image!, height: 200, width: 300),
        
        
              ElevatedButton(
                  onPressed: () {
                    showDialog(context: context, builder: (context) =>
                    AlertDialog(
                      title: Text("Choose Location"),
                      content: Container(
                        height: 200,
                        child: Row(
                          children: [
                            Expanded(child: InkWell(
                              onTap: (){
                                pickImage(ImageSource.camera);
                                Navigator.pop(context);
                              },
                              child: Column(
                                children: [
                                  Image.asset("assets/images/cam-1.png", height: 60),
                                  Text("From Camera")
                                ],
                              ),
                            )),
                            Expanded(child: InkWell(
                              onTap: (){
                                pickImage(ImageSource.gallery);
                                Navigator.pop(context);
                              },
                              child: Column(
                                children: [
                                  Image.asset("assets/images/gallery-1.png", height: 60),
                                  Text("From Gallery")
                                ],
                              ),
                            )),
                          ],
                        ),
                      ),
                    ));
                  },
                  child: Text("Select Image")),
              SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () async {
                    OverlayLoadingProgress.start();
                    UserModel model = UserModel(
                        email: emailController.text,
                        fname: fnameController.text,
                        image: url,
                        lname: lnameController.text );
                    await firestore.collection('users')
                        .doc()
                        .set(model.toJson())
                        .then((value) {
                      clearData();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data Submitted")));
        
                      OverlayLoadingProgress.stop();
        
                    }).onError((error, stackTrace) {
        
                    });
            },
                  child: Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }

  void clearData() {
    emailController.clear();
    fnameController.clear();
    lnameController.clear();
  }
}
