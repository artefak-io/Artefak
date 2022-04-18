import 'package:artefak/services/tatum_wallet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WalletFirestore {
  static final WalletFirestore _wallet = WalletFirestore._();

  WalletFirestore._();

  factory WalletFirestore() {
    return _wallet;
  }

  final CollectionReference<Map<String, dynamic>> _walletdb =
      FirebaseFirestore.instance.collection('User');

  Future<void> _saveWallet(
      Map<String, dynamic> fromTatum, String userId) async {
    _walletdb.doc(userId).set({
      "mnemonic": fromTatum["mnemonic"],
      "publicKey": fromTatum["publicKey"],
      "privateKey": fromTatum["privateKey"],
    });
  }

  Future<bool> checkWallet(String userId) async {
    try {
      return _walletdb.doc(userId).get().then((value) => value.exists);
    } catch (e) {
      return false;
    }
  }

  Future<String> getBaseAddress() async {
    DocumentSnapshot<Map<String, dynamic>> result =
        await _walletdb.doc("base").get();
    return result.data()!["publicKey"];
  }

  Future<String> getBaseKey() async {
    DocumentSnapshot<Map<String, dynamic>> result =
        await _walletdb.doc("base").get();
    return result.data()!["privateKey"];
  }

  Future<void> createWallet(String userId) async {
    try {
      if (await checkWallet(userId) == false) {
        Map<String, dynamic> fromTatum =
            await TatumWalletService().createWalletBSC();
        _saveWallet(fromTatum, userId);
      }
    } catch (error) {
      print("error happens $error");
    }
  }

  Future<String> getWalletWithWalletCreation(String userId) async {
    createWallet(userId);
    DocumentSnapshot<Map<String, dynamic>> result =
        await _walletdb.doc(userId).get();
    return result.data()!["publicKey"];
  }

  Future<String> getWallet(String userId) async {
    DocumentSnapshot<Map<String, dynamic>> result =
        await _walletdb.doc(userId).get();
    return result.data()!["publicKey"];
  }
}
