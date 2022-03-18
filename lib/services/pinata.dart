import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

class PinataService {
  PinataService._();

  static final PinataService _pinata = PinataService._();

  factory PinataService() {
    return _pinata;
  }

  final String JWTkey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySW5mb3JtYXRpb24iOnsiaWQiOiI0OTQ3ZDNkZS1jMGUzLTQ4MzctYTFlYy0xNzZiMjg0ZjFhYjIiLCJlbWFpbCI6ImN1eW9sMTNAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsInBpbl9wb2xpY3kiOnsicmVnaW9ucyI6W3siaWQiOiJGUkExIiwiZGVzaXJlZFJlcGxpY2F0aW9uQ291bnQiOjF9XSwidmVyc2lvbiI6MX0sIm1mYV9lbmFibGVkIjpmYWxzZX0sImF1dGhlbnRpY2F0aW9uVHlwZSI6InNjb3BlZEtleSIsInNjb3BlZEtleUtleSI6IjI4ZGM1ZTFlZTViMDY2NmU0YmVlIiwic2NvcGVkS2V5U2VjcmV0IjoiYTdhMGU1YTcwMGY1MTdiYzRjOTFkOWIwMzZkNjI5MTVlOGQyMDdiMzgzM2JlMDgxZjU3ODA5NWQ4ZjVhNWMyZSIsImlhdCI6MTY0NzU3MDE5OX0.faUgrTTTfEc-Q8QgdiFeGOenJ245qX-xdQ4UrG_8iDo';

  Future pinFile(File image) async {
    try {
      //multipart/form-data needs boundary
      Response result = await post(
          Uri.parse('https://api.pinata.cloud/pinning/pinFileToIPFS'),
          headers: <String, String>{
            'Authorization': 'Bearer $JWTkey',
            "Content-Type": "multipart/form-data",
          },
          body: {
            "file": image.readAsBytesSync(),
          });
      if (result.statusCode == 200) {
        print(jsonDecode(result.body));
      }
    } catch (error) {
      print(error);
    }
  }
}
