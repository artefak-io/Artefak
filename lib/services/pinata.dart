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

  Future<Map<String, dynamic>> pinFile(File image) async {
    MultipartRequest request = MultipartRequest(
        "POST", Uri.parse('https://api.pinata.cloud/pinning/pinFileToIPFS'));
    Map<String, String> headers = {'Authorization': 'Bearer $JWTkey'};
    request.headers.addAll(headers);
    MultipartFile file = await MultipartFile.fromPath("file", image.path);
    request.files.add(file);
    StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String result = await response.stream.bytesToString();
      print(jsonDecode(result));
      return jsonDecode(result) as Map<String, dynamic>;
    } else {
      return Future.error("error in pinFile ${response.reasonPhrase}");
    }
  }

  Future<Map<String, dynamic>> pinJSON(
      String name, String desc, String ipfs) async {
    Map<String, dynamic> body = {
      "name": name,
      "description": desc,
      "image": "ipfs://" + ipfs
    };
    Response response =
        await post(Uri.parse("https://api.pinata.cloud/pinning/pinJSONToIPFS"),
            headers: <String, String>{
              'Authorization': 'Bearer $JWTkey',
              "Content-Type": "application/json",
            },
            body: jsonEncode(body));

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      return Future.error("error in pinJSON ${response.reasonPhrase}");
    }
  }

  Future<Map<String, dynamic>> pinIPFS(
      String name, String desc, File image) async {
    try {
      Map<String, dynamic> resultPinFile = await pinFile(image);

      return pinJSON(name, desc, resultPinFile["IpfsHash"]);
    } catch (error) {
      return Future.error(error);
    }
  }
}
