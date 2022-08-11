import 'package:equatable/equatable.dart';

//TODO: Still not sure about this ArtefakUser members could be null in the firebase
//TODO: but they shouldn't be null in this class because of equatable or comparison reason
//TODO: and this needs empty constructor too which could be the default contructor instead.

class ArtefakUser extends Equatable {
  final String id;
  final String displayName;
  final String publicKey;
  final bool isVerified;
  final String profilePicture;
  final String pin;
  const ArtefakUser({
    this.id = '',
    this.displayName = '',
    this.publicKey = '',
    this.isVerified = false,
    this.profilePicture = '',
    this.pin = '',
  });

  factory ArtefakUser.empty() {
    return const ArtefakUser(
      id: '',
      displayName: '',
      publicKey: '',
      isVerified: false,
      profilePicture: '',
      pin: '',
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      displayName,
      publicKey,
      isVerified,
      profilePicture,
      pin,
    ];
  }

  //TODO: would be used later probably
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'displayName': displayName,
      'publicKey': publicKey,
      'isVerified': isVerified,
      'profilePicture': profilePicture,
      'pin': pin,
    };
  }

  factory ArtefakUser.fromMap(
      {required Map<String, dynamic> map, required String id}) {
    return ArtefakUser(
      id: id,
      displayName: map['displayName'] as String,
      publicKey: map['publicKey'] as String,
      isVerified: map['isVerified'] as bool,
      profilePicture: map['profilePicture'] as String,
      pin: map['pin'] as String,
    );
  }

  ArtefakUser copyWith({
    String? id,
    String? displayName,
    String? publicKey,
    bool? isVerified,
    String? profilePicture,
    String? pin,
  }) {
    return ArtefakUser(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      publicKey: publicKey ?? this.publicKey,
      isVerified: isVerified ?? this.isVerified,
      profilePicture: profilePicture ?? this.profilePicture,
      pin: pin ?? this.pin,
    );
  }
}
