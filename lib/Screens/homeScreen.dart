import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:splash_and_firebase/Authen/classAuth.dart';
import 'package:splash_and_firebase/Authen/signIn.dart';
import 'package:splash_and_firebase/Widgets/customTextField.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  var _firstname = TextEditingController();
  var _lastname = TextEditingController();
  var _phonenumber = TextEditingController();
  var _address = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<String> _addUser() async {
    await firebase_storage.FirebaseStorage.instance
        .ref('upload/${_image!.path.split("/").last}')
        .putFile(_image!);
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref('upload/${_image!.path.split("/").last}')
        .getDownloadURL();
    print("down:$downloadURL");
    return users
        .add({
          'firstName': _firstname.text,
          'lastName': _lastname.text,
          'phoneNumber': _phonenumber.text,
          'address': _address.text,
          'url': downloadURL
        })
        .then((value) => 'Data has been submited!')
        .catchError((error) => 'Failed to add user: $error');
  }

  Future<void> _alterDailogBuilder(String message) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Message'),
          content: Container(
            child: Text(message),
          ),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                _firstname.clear();
                _lastname.clear();
                _phonenumber.clear();
                _address.clear();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _submit() async {
    String dataFeedback = await _addUser();
    if (dataFeedback.isNotEmpty) {
      _alterDailogBuilder(dataFeedback);
    }
  }

  //============== image ===============
  File? _image;
  final _picker = ImagePicker();
  Future<void> _fromGallery() async {
    final PickedFile? pickedFile =
        await _picker.getImage(source: ImageSource.gallery);
    setState(() => _image = File(pickedFile!.path));
  }

  Future<void> _fromCamera() async {
    final PickedFile? pickedFile =
        await _picker.getImage(source: ImageSource.camera);
    setState(() => _image = File(pickedFile!.path));
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () {
                      _fromGallery();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    _fromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  get _buildPickerImage {
    return Center(
      child: GestureDetector(
        onTap: () {
          _showPicker(context);
        },
        child: CircleAvatar(
          radius: 55,
          backgroundColor: Colors.red,
          child: _image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.file(
                    _image!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  width: 100,
                  height: 100,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.grey[800],
                  ),
                ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('DashBoard'),
        actions: [
          InkWell(
            onTap: () {
              AuthClass().signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignIn()),
                  (route) => false);
            },
            child: Icon(Icons.logout_rounded),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextFiel(
                textEditingController: _firstname,
                hasPassword: false,
                circular: 20,
                color: Colors.white,
                hintText: 'Enter firsname',
                prefixIcon: Icon(Icons.person),
              ),
              CustomTextFiel(
                textEditingController: _lastname,
                hasPassword: false,
                circular: 20,
                color: Colors.white,
                hintText: 'Enter lastname',
                prefixIcon: Icon(Icons.person),
              ),
              CustomTextFiel(
                textEditingController: _phonenumber,
                hasPassword: false,
                circular: 20,
                color: Colors.white,
                hintText: 'Enter phone number',
                prefixIcon: Icon(Icons.person),
                textInputType: TextInputType.phone,
              ),
              CustomTextFiel(
                textEditingController: _address,
                hasPassword: false,
                circular: 20,
                color: Colors.white,
                hintText: 'Enter address',
                prefixIcon: Icon(Icons.person),
              ),
              _buildPickerImage,
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _submit(),
          child: Text('Save Information'),
        ),
      ),
    );
  }
}
