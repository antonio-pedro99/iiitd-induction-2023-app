import 'package:btech_induction_2023/extensions/navigation.dart';
import 'package:btech_induction_2023/extensions/system.dart';
import 'package:btech_induction_2023/view/screens/home/home_screen.dart';
import 'package:btech_induction_2023/view/widgets/custom_card.dart';
import 'package:btech_induction_2023/view/widgets/texture_background.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:btech_induction_2023/data/user.dart'; // Import the UserProfile class

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({Key? key}) : super(key: key);

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameTextEdittingController =
      TextEditingController();

  String? _username;
  String? _fullName;
  String? _pronouns;
  File? _profileImage;

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await _imagePicker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _profileImage = File(pickedImage.path);
      });
    }
  }

  void _saveProfile(BuildContext context) {
    if (_username != null &&
        _username!.isNotEmpty &&
        _profileImage != null &&
        _fullName != null &&
        _fullName!.isNotEmpty &&
        _pronouns != null &&
        _pronouns!.isNotEmpty) {
      final userProfile = UserProfile(
        username: _username!,
        fullName: _fullName!,
        pronouns: _pronouns!,
        profileImage: _profileImage!.path,
      );

      // Navigate to the HomePage with the profile data
      context.pushReplacement(
        const InductionAppHomePage(),
      // Pass user profile data as arguments
      );
    } else {
      context.showSnackBar(
          'Please fill in the fields and upload a profile picture');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
      drawer: const Drawer(), // drawersidebar
      body: Stack(
        children: [
          const Positioned.fill(child: TextureBackground()),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: CascadeCard(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      if (_profileImage != null)
                        CircleAvatar(
                          radius: 80,
                          backgroundImage: FileImage(_profileImage!),
                        ),
                      ElevatedButton(
                        onPressed: () {
                          _pickImage(ImageSource.gallery);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFAC018),
                        ),
                        child: const Text('Upload Picture'),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: nameTextEdittingController,
                        onChanged: (value) {
                          setState(() {
                            _fullName = value;
                          });
                        },
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          labelText: 'My name is',
                          hintText: 'Full Name',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Set labelText color to white
                          ),
                          hintStyle: TextStyle(
                            color: Colors.white, // Set hintText color to white
                          ),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _pronouns = value;
                          });
                        },
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          labelText: 'Refer to me as...',
                          hintText: 'Pronouns',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Set labelText color to white
                          ),
                          hintStyle: TextStyle(
                            color: Colors.white, // Set hintText color to white
                          ),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _username = value;
                          });
                        },
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          labelText: 'and I like to go by',
                          hintText: 'Username',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Set labelText color to white
                          ),
                          hintStyle: TextStyle(
                            color: Colors.white, // Set hintText color to white
                          ),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            // Get all the text values from the controller and perform your operation.
                            _saveProfile(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFAC018),
                        ),
                        child: const Text('Save and Move to Home Page'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
