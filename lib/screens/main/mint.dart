import 'dart:io';

import 'package:artefak/services/mint_service.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:artefak/services/image_picker_service.dart';

class Mint extends StatefulWidget {
  const Mint({Key? key}) : super(key: key);

  @override
  State<Mint> createState() => _MintState();
}

class _MintState extends State<Mint> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  File? _mintImage;

  ImageProvider _previewImage() {
    if (_mintImage != null) {
      return FileImage(_mintImage!);
    } else {
      return const AssetImage('assets/mint_placeholder.jpg');
    }
  }

  Future<void> _restrieveLostData() async {
    File? result = await ImagePickerService()
        .retrieveLostData()
        .then((value) => value != null ? File(value.path) : null)
        .catchError((error) => print("error happen $error"));
    if (result != null) {
      setState(() {
        _mintImage = result;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    if (kIsWeb != true && defaultTargetPlatform == TargetPlatform.android) {
      _restrieveLostData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mint'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image(
              image: _previewImage(),
            ),
            ElevatedButton(
              onPressed: () {
                ImagePickerService().retrieveImage().then((value) {
                  setState(() {
                    _mintImage = File(value!.path);
                  });
                }).catchError((error) => print('error happen $error'));
              },
              child: const Text('Select Picture'),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Name',
                      ),
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '*required';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Description',
                      ),
                      controller: _descriptionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '*required';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Price',
                      ),
                      controller: _priceController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '*required';
                        } else if (int.tryParse(value) == null) {
                          return "*not a valid price";
                        } else if (int.parse(value) < 0) {
                          return "*not a valid price";
                        } else if (int.parse(value) < 1000000) {
                          return "*can't be less than 1000000";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  ElevatedButton(
                    child: const Text('Mint'),
                    onPressed: () async {
                      // needs to show loader while this operation takes place
                      // needs pinata directory clean up when error occurs
                      // needs to integrate file meta data and file directory
                      // management on pinata
                      // needs _mintImage validator

                      if (_formKey.currentState!.validate() &&
                          _mintImage != null) {
                        MintService().mint(
                            _mintImage!,
                            _nameController.text,
                            _descriptionController.text,
                            "contractAddress",
                            "",
                            int.parse(_priceController.text));
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
