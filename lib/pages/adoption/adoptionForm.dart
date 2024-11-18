import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AnimalAdoptionForm extends StatefulWidget {
  @override
  _AnimalAdoptionFormState createState() => _AnimalAdoptionFormState();
}

class _AnimalAdoptionFormState extends State<AnimalAdoptionForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _petController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();

  String _caseType = "Adoption"; // Fixed case type

  Future<void> submitAnimalDetails() async {
    // Simulate a successful submission
    await Future.delayed(Duration(seconds: 2)); // Simulating API call delay
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Adoption request submitted successfully!'),
    ));

    // Print the form details
    print("Case Type: $_caseType");
    print("Pet: ${_petController.text}");
    print("Description: ${_descriptionController.text}");
    print("Location: ${_locationController.text}");
    print("Contact: ${_contactController.text}");

    // Reset the form after submission
    _formKey.currentState?.reset();
    _petController.clear();
    _descriptionController.clear();
    _locationController.clear();
    _contactController.clear();

    // Clear image preview
    setState(() {
      _image = null;
    });
  }

  // Method to pick image from gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Method to remove selected image
  void _removeImage() {
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adoption Form"),
        backgroundColor: Colors.pink.shade300,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Case Type (Fixed value "Adoption")
             
              // Pet Field
              Text(
                "Pet (e.g. dog, cat...)",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _petController,
                decoration: InputDecoration(
                  labelText: "Enter a Pet or Name",
                  prefixIcon: Icon(Icons.pets),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  return value!.isEmpty ? "Please Enter Name or Pet" : null;
                },
              ),
              SizedBox(height: 20),
               Text(
                "Case Type",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: _caseType, // Always "Adoption"
                enabled: false, // Disabled as it's fixed
                decoration: InputDecoration(
                  labelText: "Case Type",
                  prefixIcon: Icon(Icons.category),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Mobile Number Field
              Text(
                "Mobile Number",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _contactController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Enter your Mobile No.",
                  prefixIcon: Icon(Icons.phone),
                  filled: true,
                  hintText: "e.g. 785612xxxx (don't write +91)",
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  return value!.isEmpty || value.length != 10
                      ? "Please Enter valid Mobile Number"
                      : null;
                },
              ),
              SizedBox(height: 20),
              // Description Field
              Text(
                "Description",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: "Describe the issue or Problem",
                  prefixIcon: Icon(Icons.description),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                maxLines: 3,
                validator: (value) {
                  return value!.isEmpty ? "Please enter a description" : null;
                },
              ),
              SizedBox(height: 20),
              // Location Field
              Text(
                "Location",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: "Enter the location",
                  prefixIcon: Icon(Icons.location_on),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  return value!.isEmpty ? "Please enter the location" : null;
                },
              ),
              SizedBox(height: 20),
              // Image Upload Section
              Text(
                "Upload Image ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      // Show options for gallery or camera
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Select Image Source"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(Icons.camera),
                                  title: Text("Capture with Camera"),
                                  onTap: () {
                                    Navigator.pop(context);
                                    _pickImage(ImageSource.camera);
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.image),
                                  title: Text("Pick from Gallery"),
                                  onTap: () {
                                    Navigator.pop(context);
                                    _pickImage(ImageSource.gallery);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.camera_alt),
                    label: Text("Pick Image"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade300,
                    ),
                  ),
                  SizedBox(width: 20),
                  _image != null
                      ? Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                _image!,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.remove_circle, color: Colors.red),
                              onPressed: _removeImage,
                            ),
                          ],
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      submitAnimalDetails();
                    }
                  },
                  icon: Icon(Icons.send),
                  label: Text("Submit"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    backgroundColor: Colors.pink.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
