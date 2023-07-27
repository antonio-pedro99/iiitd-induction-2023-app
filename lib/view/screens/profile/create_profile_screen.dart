import 'package:btech_induction_2023/data/user.dart';
import 'package:btech_induction_2023/extensions/navigation.dart';
import 'package:btech_induction_2023/extensions/system.dart';
import 'package:btech_induction_2023/view/screens/home/home_screen.dart';
import 'package:btech_induction_2023/view/screens/profile/text_form_field.dart';
import 'package:btech_induction_2023/view/theme/colors.dart';
import 'package:btech_induction_2023/view/widgets/custom_card.dart';
import 'package:btech_induction_2023/view/widgets/texture_background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({Key? key}) : super(key: key);

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameTextEditingController =
      TextEditingController();
  final TextEditingController pronounsTextEditingController =
      TextEditingController();
  final TextEditingController usernameTextEditingController =
      TextEditingController();

  File? _profileImage;

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await _imagePicker.pickImage(source: source);

    if (pickedImage != null) {
      _profileImage = File(pickedImage.path);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameTextEditingController.dispose();
    pronounsTextEditingController.dispose();
    usernameTextEditingController.dispose();
    super.dispose();
  }

  void _saveProfile(BuildContext context) {
    if (_profileImage != null) {
      UserProfile user = UserProfile(
        fullName: nameTextEditingController.text,
        pronouns: pronounsTextEditingController.text,
        username: usernameTextEditingController.text,
        profileImage: _profileImage!.path,
        points: 0,
      );

      // update firebase

      context.pushReplacement(
        const InductionAppHomePage(),
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
      body: Stack(
        children: [
          const Positioned.fill(child: TextureBackground()),
          Align(
            alignment: Alignment.center,
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
                          backgroundColor: InductionAppColor.yellow,
                        ),
                        child: const Text('Upload Picture'),
                      ),
                      const SizedBox(height: 20),
                      InductionAppTextFormField(
                          hintText: "Full name",
                          labelText: "My name is",
                          nameTextEditingController: nameTextEditingController,
                          validationText: "Please enter your full name"),
                      const SizedBox(height: 20),
                      InductionAppTextFormField(
                          hintText: "Pronouns",
                          labelText: "Refer to me as...",
                          nameTextEditingController:
                              pronounsTextEditingController,
                          validationText: "Please enter your pronouns"),
                      const SizedBox(height: 20),
                      InductionAppTextFormField(
                          hintText: "Username",
                          labelText: "username",
                          nameTextEditingController:
                              usernameTextEditingController,
                          validationText: "Please enter your username"),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            // Get all the text values from the controller and perform your operation.
                            _saveProfile(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: InductionAppColor.yellow,
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
