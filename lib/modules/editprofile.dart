import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart' as path;

// ignore: use_key_in_widget_constructors
class Profileedit extends StatefulWidget {
  @override
  State<Profileedit> createState() => _ProfileeditState();
}

class _ProfileeditState extends State<Profileedit> {
  bool showPassword = false;
  late String imgPath;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  pickImage() async {
    // final ImagePicker _picker = ImagePicker();
    // // ignore: deprecated_member_use
    // final image = await _picker.getImage(source: ImageSource.gallery);
    // // ignore: unused_local_variable
    // String imgName = path.basename(imgPath);

    // setState(() {
    //   imgPath = image!.path;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        toolbarHeight: 67,
        title: const Text('Edit Profile'),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5, color: Colors.indigo),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 20,
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0, 10))
                        ],
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                            ))),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: Colors.deepPurple,
                          ),
                          color: Colors.deepPurple,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            pickImage();
                          },
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 35.0),
              child: TextField(
                // obscureText: showPassword,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: 'Email',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "abc@email.com",
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 35.0),
              child: TextField(
                obscureText: showPassword,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: const Icon(
                        Icons.remove_red_eye,
                        color: Colors.grey,
                      ),
                    ),
                    contentPadding: const EdgeInsets.only(bottom: 3),
                    labelText: 'Password',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "**********",
                    hintStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 35.0),
              child: TextField(
                obscureText: showPassword,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: 'Bio',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "Something that defines you",
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 35.0),
              child: TextField(
                obscureText: showPassword,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: 'Location',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "Pakistan",
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                  onPressed: () {},
                  child: const Text("EDIT",
                      style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 2.2,
                          color: Colors.black)),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text(
                    "SAVE",
                    style: TextStyle(
                        fontSize: 16, letterSpacing: 2.2, color: Colors.white),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
