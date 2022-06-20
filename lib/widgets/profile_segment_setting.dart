import 'package:flutter/material.dart';

class ProfileSegmentSetting extends StatelessWidget {
  const ProfileSegmentSetting({
    Key? key,
    required ThemeData themeData,
    required TextTheme textTheme,
    required this.title,
    required this.settingItems,
  })  : _themeData = themeData,
        _textTheme = textTheme,
        super(key: key);

  final ThemeData _themeData;
  final TextTheme _textTheme;
  final String title;
  final List<MenuSetting> settingItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: _themeData.shadowColor,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 12.0, bottom: 16.0),
            child: Text(title,
                style:
                _textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
                textAlign: TextAlign.start),
          ),
          Column(
            children: settingItems
                .map(
                  (settingItem) => Container(
                margin: EdgeInsets.only(bottom: 24.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      settingItem.uri,
                    );
                  },
                  child: Row(
                    children: [
                      Text(settingItem.name,
                          style: _textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 28.0,
                      ),
                    ],
                  ),
                ),
              ),
            )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class ProfileSetting {
  ProfileSetting({required this.title, required this.listSettingItem});

  final String title;
  final List<MenuSetting> listSettingItem;
}

class MenuSetting {
  MenuSetting({required this.name, required this.uri});

  final String name, uri;
}

List<ProfileSetting> listProfileSetting = [
  ProfileSetting(title: 'Profil', listSettingItem: [
    MenuSetting(name: 'Ubah Data Profil', uri: 'uri'),
    MenuSetting(name: 'Ubah PIN', uri: 'uri'),
    MenuSetting(name: 'Ubah Email', uri: 'uri')
  ]),
  ProfileSetting(
      title: 'Pusat Bantuan',
      listSettingItem: [MenuSetting(name: 'Kontak Kami', uri: 'uri')]),
  ProfileSetting(title: 'Hal Lain', listSettingItem: [
    MenuSetting(name: 'Tentang Artefak', uri: 'uri'),
    MenuSetting(name: 'Syarat & Ketentuan Berlaku', uri: 'uri'),
    MenuSetting(name: 'Kebijakan Privasi', uri: '/policy')
  ]),
];