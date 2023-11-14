import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController planId = TextEditingController();

  initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userId');
    user = await profileService?.getData(1);
    setState(() {
      user = user;
      firstNameController.text = user?.firstName ?? '';
      lastNameController.text = user?.lastName ?? '';
      usernameController.text = user?.userName ?? '';
      phoneController.text = user?.phone ?? '';
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}