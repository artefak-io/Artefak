import 'package:artefak/logic/pin/pin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePin extends StatelessWidget {
  const CreatePin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() async => false),
      child: BlocProvider(
        create: (context) => CreatePinCubit(context.read<PinService>()),
        child: Scaffold(
          appBar: AppBar(title: const Text("Create Pin")),
          body: SingleChildScrollView(
              child: Column(
            children: <Widget>[],
          )),
        ),
      ),
    );
  }
}
