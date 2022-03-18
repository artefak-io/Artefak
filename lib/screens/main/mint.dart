import 'dart:io';

import 'package:artefak/services/pinata.dart';
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
      body: Column(
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
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    if (_mintImage != null) {
                      PinataService().pinFile(_mintImage!);
                    }
                    // needs _mintImage validator
                    // if (_formKey.currentState!.validate() &&
                    //     _mintImage != null) {}
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
