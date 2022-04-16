import 'package:artefak/screens/app_layout.dart';
import 'package:artefak/services/auth.dart';
import 'package:artefak/services/transfer_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Asset extends StatelessWidget {
  const Asset({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> _data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return AppLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(_data['name']),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(_data['coverImage']),
              const SizedBox(
                height: 40,
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 10.0,
                ),
                child: Text('Description'),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                ),
                child: Text(_data['description']),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 10.0,
                ),
                child: Text('Views'),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                ),
                child: Text(_data['views'].toString()),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 10.0,
                ),
                child: Text('Contract Address'),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                ),
                child: Text(_data['contractAddress']),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 10.0,
                ),
                child: Text('Token ID'),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                ),
                child: Text(_data['tokenId']),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 10.0,
                ),
                child: Text('Price'),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                ),
                child: Text(
                    NumberFormat.currency(locale: 'id').format(_data['price'])),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (AuthService.user == null) {
                    Navigator.pushNamed(context, '/auth');
                  }
                  // else if (check if this user still has active unpaid account or not)

                  else {
                    Navigator.pushNamed(context, '/payment',
                        arguments: <String, dynamic>{
                          'id': _data['id'],
                          'price': _data['price'],
                          'assetName': _data['name'],
                        });
                  }
                },
                child: const Text('Buy'),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 10.0,
                ),
                child: Text(
                  'This "Yoink Button" is extremely fragile. Please use it wisely',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (AuthService.user == null) {
                    Navigator.pushNamed(context, '/auth');
                  } else {
                    TransferService().transferNft(
                        _data['id'],
                        AuthService.user!.uid,
                        _data['name'],
                        _data['description'],
                        _data['coverImage'],
                        _data['contractAddress'],
                        _data['tokenId'],
                        _data['price']);
                  }
                },
                child: const Text('YOINK!!!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
