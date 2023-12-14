import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  static const String routeName="/form_screen";

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController contact = TextEditingController();
  final TextEditingController email = TextEditingController();

  final database = FirebaseDatabase.instance;

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: 24),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value){
                    if(value ==""){
                      return "Enter First Name";
                    } //Regex
                  },
                  controller: firstname,
                  decoration: InputDecoration(
                    hintText: 'Enter First Name',
                    prefixIcon: Icon(Icons.mail),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value){
                    if(value ==""){
                      return "Enter Last Name";
                    } //Regex
                  },
                  controller: lastname,
                  decoration: InputDecoration(
                    hintText: 'Enter Last Name',
                    prefixIcon: Icon(Icons.mail),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value){
                    if(value ==""){
                      return "Enter Address";
                    } //Regex
                  },
                  controller: address,
                  decoration: InputDecoration(
                    hintText: 'Enter Address',
                    prefixIcon: Icon(Icons.mail),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value){
                    if(value ==""){
                      return "Enter Contact Number";
                    } //Regex
                  },
                  controller: contact,
                  decoration: InputDecoration(
                    hintText: 'Enter Contact',
                    prefixIcon: Icon(Icons.mail),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value){
                    if(value ==""){
                      return "Enter Email Address";
                    } //Regex
                  },
                  controller: email,
                  decoration: InputDecoration(
                    hintText: 'Enter Email',
                    prefixIcon: Icon(Icons.mail),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
        
                      if(_key.currentState!.validate()){
                        var data={
                          "firstName":firstname.text,
                          "lastName":lastname.text,
                          "address":address.text,
                          "contact":contact.text,
                          "email":email.text,
                        };
                        await database.ref().push().set(data).then((value){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Success")));
                        }).onError((error, stackTrace) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed")));
                        });
                      }
                    },
                    child: Text('Send To Database', style: TextStyle(fontSize: 18, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
