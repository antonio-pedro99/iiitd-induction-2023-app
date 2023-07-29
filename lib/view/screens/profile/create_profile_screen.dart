import 'dart:io';

import 'package:btech_induction_2023/data/user.dart';
import 'package:btech_induction_2023/extensions/navigation.dart';
import 'package:btech_induction_2023/extensions/system.dart';
import 'package:btech_induction_2023/service/firebase.dart';
import 'package:btech_induction_2023/view/screens/home/home_screen.dart';
import 'package:btech_induction_2023/view/screens/profile/text_form_field.dart';
import 'package:btech_induction_2023/view/theme/colors.dart';
import 'package:btech_induction_2023/view/widgets/custom_card.dart';
import 'package:btech_induction_2023/view/widgets/texture_background.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({Key? key, this.currentUser}) : super(key: key);

  final UserProfile? currentUser;
  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameTextEditingController =
      TextEditingController();
  final TextEditingController phoneTextEditingController =
      TextEditingController();
  final TextEditingController usernameTextEditingController =
      TextEditingController();

  File? _profileImage;
  String? _userProfileImageURL;

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
    if (widget.currentUser != null) {
      nameTextEditingController.text = widget.currentUser!.fullName;
      phoneTextEditingController.text = widget.currentUser!.phone ?? "";
      usernameTextEditingController.text = widget.currentUser!.username;
    }
  }

  @override
  void dispose() {
    nameTextEditingController.dispose();
    phoneTextEditingController.dispose();
    usernameTextEditingController.dispose();
    super.dispose();
  }

  void _saveProfile(BuildContext context) {
    UserProfile user = UserProfile(
      fullName: nameTextEditingController.text,
      phone: phoneTextEditingController.text,
      username: usernameTextEditingController.text,
      profileImage: _userProfileImageURL ?? widget.currentUser!.profileImage,
      points: widget.currentUser!.points ?? 0,
    );

    // update firebase
    Provider.of<FirebaseFirestoreService>(context, listen: false)
        .addUserData(user);

    context.pushReplacement(
      const InductionAppHomePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final upLoaderState = context.read<FirebaseStorageService>().isUploading;
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          child: Image.asset("images/iiitd.png", height: 200),
        ),
        centerTitle: true,
        actions: const [
          SizedBox(
            width: 50,
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          const Positioned.fill(child: TextureBackground()),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned(
                            top: 220,
                            left: context.width * 0.025,
                            right: 0,
                            bottom: 0,
                            child: const CascadeCard(child: SizedBox())),

                        Positioned(
                        left: 0,
                        right: 0,
                        top: 80,
                        child:   _profileImage != null ?
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundImage: FileImage(_profileImage!),
                                  ) : const CircleAvatar(
                                    radius: 50,
                                   child: Icon(Icons.person),
                                  )
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                              
                                ElevatedButton(
                                  onPressed: () {
                                    _pickImage(ImageSource.gallery)
                                        .whenComplete(() {
                                      Provider.of<FirebaseStorageService>(
                                              context,
                                              listen: false)
                                          .uploadProfilePicture(
                                              _profileImage!.path)
                                          .then((value) {
                                        setState(() {
                                          _userProfileImageURL = value;
                                        });
                                      });
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: InductionAppColor.yellow,
                                  ),
                                  child: const Text('Upload Picture'),
                                ),
                                const SizedBox(height: 14),
                                InductionAppTextFormField(
                                    hintText: "Full name",
                                    labelText: "My name is",
                                    nameTextEditingController:
                                        nameTextEditingController,
                                    validationText:
                                        "Please enter your full name"),
                                const SizedBox(height: 20),
                                InductionAppTextFormField(
                                    hintText: "Mobile number",
                                    labelText: "Enter your mobile number",
                                    nameTextEditingController:
                                        phoneTextEditingController,
                                    validationText: "Please enter your phone"),
                                const SizedBox(height: 20),
                                InductionAppTextFormField(
                                    hintText: "Username",
                                    labelText: "username",
                                    nameTextEditingController:
                                        usernameTextEditingController,
                                    validationText:
                                        "Please enter your username"),

                                         ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        _saveProfile(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: InductionAppColor.yellow,
                    ),
                    child: const Text('Save Profile'),
                  ),
                  upLoaderState
                      ? const CircularProgressIndicator()
                      : const SizedBox.shrink(),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
