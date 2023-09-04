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
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
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
  final TextEditingController usernameTextEditingController =
      TextEditingController();
  final TextEditingController rollNumberTextEditingController =
      TextEditingController();

  File? _profileImage;
  String? _userProfileImageURL;
  bool _ableToEditRollNumber = true;
  bool upLoaderState = false;

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
      usernameTextEditingController.text = widget.currentUser!.username ?? "";
      rollNumberTextEditingController.text =
          widget.currentUser!.rollNumber ?? "";
      _userProfileImageURL = widget.currentUser!.profileImage;
      setState(
          () => _ableToEditRollNumber = widget.currentUser!.rollNumber == null);
    }
  }

  @override
  void dispose() {
    nameTextEditingController.dispose();
    usernameTextEditingController.dispose();
    rollNumberTextEditingController.dispose();
    super.dispose();
  }

  void _saveProfile(BuildContext context) {
    UserProfile user = UserProfile(
      fullName: nameTextEditingController.text,
      username: usernameTextEditingController.text,
      rollNumber: rollNumberTextEditingController.text,
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
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          child: Image.asset("images/iiitd.png", height: 200),
        ),
        centerTitle: true,
        leading: context.canPop()
            ? IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(Icons.arrow_back))
            : const SizedBox(width: 50),
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
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned(
                            top: 220,
                            left: context.width * 0.025,
                            right: context.width * 0.025,
                            bottom: 0,
                            child: const CascadeCard(child: SizedBox())),
                        Positioned(
                            left: 0,
                            right: 0,
                            top: 80,
                            child: _userProfileImageURL != null
                                ? SizedBox(
                                    child: CircleAvatar(
                                      radius: 50,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: CachedNetworkImage(
                                            imageUrl: _userProfileImageURL!,
                                            fit: BoxFit.fill,
                                            width: 100,
                                            placeholder: (context, url) => Center(
                                                child:
                                                    LiquidCircularProgressIndicator()),
                                          )),
                                    ),
                                  )
                                : const CircleAvatar(
                                    radius: 50,
                                    child: Icon(Icons.person),
                                  )),
                        Align(
                          alignment: Alignment.center,
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() => upLoaderState = true);
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
                                          upLoaderState = false;
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
                                const SizedBox(height: 10),
                                InductionAppTextFormField(
                                    hintText: "Username",
                                    labelText: "Enter your username",
                                    nameTextEditingController:
                                        usernameTextEditingController,
                                    validationText: "Please enter your username"),
                                const SizedBox(height: 5),
                                const Text(
                                  "Your roll number is final, you won't be able to change it later",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white),
                                ),
                                const SizedBox(height: 10),
                                InductionAppTextFormField(
                                    enabled: _ableToEditRollNumber,
                                    hintText: "Roll number",
                                    labelText: "Enter your roll number",
                                    nameTextEditingController:
                                        rollNumberTextEditingController,
                                    validationText:
                                        "Please enter your rollNumber"),
                                !upLoaderState
                                    ? ElevatedButton(
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            _saveProfile(context);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              InductionAppColor.yellow,
                                        ),
                                        child: const Text('Save Profile'),
                                      )
                                    : const CircularProgressIndicator(),
                              ],
                            ),
                          ),
                        ),
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
