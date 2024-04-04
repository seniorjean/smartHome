import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class SmartDeviceBox extends StatelessWidget {
  final String deviceName;
  final String onIconPath;
  final String offIconPath;
  final bool powerStatus;
  void Function(bool)? onChanged;

  SmartDeviceBox({

    required this.deviceName,
    required this.onIconPath,
    required this.offIconPath,
    required this.powerStatus,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: powerStatus ? Colors.black54 : Colors.grey,
          borderRadius: BorderRadius.circular(35),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 28.0),
          child: Column(children: [
            //* Icon
            Image.asset(
              powerStatus?'assets/icons/${onIconPath}' : 'assets/icons/${offIconPath}',
              color: !powerStatus ? Colors.white : KPrimaryColor,
              height: 120,
            ),

            const SizedBox(
              height: 20,
            ),

            //* Smart Device name
            Text(
              deviceName,
              style: GoogleFonts.aBeeZee(
                  fontWeight: FontWeight.bold,
                  color: !powerStatus ? Colors.white : KPrimaryColor),
            ),

            const SizedBox(
              height: 9,
            ),

            //* Switches
            CupertinoSwitch(
              value: powerStatus,
              onChanged: onChanged,
              activeColor: KPrimaryColor,
              trackColor: Colors.white,
              thumbColor: Colors.grey,
            )
          ]),
        ),
      ),
    );
  }
}
