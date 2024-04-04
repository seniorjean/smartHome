import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_home_wifi/utils/sweetAlert.dart';

import 'constants.dart';
import 'utils/HttpResponseModel.dart';
import 'utils/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //* Grid View Data
  final List _smartDevices = [
    {'name': 'Ventilateur', 'onIcon': 'fan.png', 'offIcon': 'fan.png', 'state': false, 'action': 'fan', 'data': ''},
    {'name': 'Porte', 'onIcon': 'door_open.png', 'offIcon': 'door_close.png', 'state': false, 'action': 'door', 'data': ''},
    {'name': 'Detecteur de mouvement', 'onIcon': 'motion.png', 'offIcon': 'motion.png', 'state': false, 'action': 'motion', 'data': ''},
    {'name': 'Alarme', 'onIcon': 'alarm.png', 'offIcon': 'alarm.png', 'state': false, 'action': 'alarm', 'data': ''},
    {'name': 'Temperature', 'onIcon': 'temperature.png', 'offIcon': 'temperature.png', 'state': false, 'action': 'temperature', 'data': ''},
    {'name': 'Umidité', 'onIcon': 'humidity.png', 'offIcon': 'humidity.png', 'state': false, 'action': 'humidity', 'data': ''},
    {'name': 'ultrasonique', 'onIcon': 'ultrasonic.png', 'offIcon': 'ultrasonic.png', 'state': false, 'action': 'ultrasonic', 'data': ''},
    {'name': 'Lumière 1', 'onIcon': 'bulb.png', 'offIcon': 'light_off.png', 'state': false, 'action': 'lamp1', 'data': ''},
    {'name': 'Lumière 2', 'onIcon': 'bulb.png', 'offIcon': 'light_off.png', 'state': false, 'action': 'lamp2', 'data': ''},
    {'name': 'Lumière 3', 'onIcon': 'bulb.png', 'offIcon': 'light_off.png', 'state': false, 'action': 'lamp3', 'data': ''},
    {'name': 'Lumière 4', 'onIcon': 'bulb.png', 'offIcon': 'light_off.png', 'state': false, 'action': 'lamp4', 'data': ''},
    {'name': 'Lumière 5', 'onIcon': 'bulb.png', 'offIcon': 'light_off.png', 'state': false, 'action': 'lamp5', 'data': ''},
    {'name': 'Lumière 6', 'onIcon': 'bulb.png', 'offIcon': 'light_off.png', 'state': false, 'action': 'lamp6', 'data': ''},
    {'name': 'Lumière 7', 'onIcon': 'bulb.png', 'offIcon': 'light_off.png', 'state': false, 'action': 'lamp7', 'data': ''},
    {'name': 'Lumière 8', 'onIcon': 'bulb.png', 'offIcon': 'light_off.png', 'state': false, 'action': 'lamp8', 'data': ''},
    {'name': 'Lumière 9', 'onIcon': 'bulb.png', 'offIcon': 'light_off.png', 'state': false, 'action': 'lamp9', 'data': ''},
  ];

  final List<String> fetchExtraDataSensor = ['humidity', 'ultrasonic', 'motion', 'temperature'];

  TextEditingController _addressController = TextEditingController();
  bool _connected = false;

  //* Swtich Use Function
  void powerSwitchChanged(int index, bool value) async {
    if (_connected) {
      var device = _smartDevices[index];
      dprint('value', value);
      setState(() {
        _smartDevices[index]['state'] = value;
      });

      if (fetchExtraDataSensor.contains(device['action'])) {
        int counter = 0;
        Timer.periodic(const Duration(seconds: 3), (timer) async {
          bool state = _smartDevices[index]['state'];
          int actionValue = state ? 1 : 0;
          counter++;

          if (state == false) {
            timer.cancel();
          }

          if (counter % 2 == 0) {
            actionValue = 0;
          } else {
            actionValue = 1;
          }

          if(counter == 1){
            showLoader(context);
          }
          HttpResponseModel responseModel = await ApiService.get(url: getApiUrl('?State=${_smartDevices[index]['action']}_${actionValue}'));
          if(counter == 1){
            hideLoader(context);
          }
          if (responseModel.status == true) {
            String fullData = responseModel.response!.body;

            if(fullData.contains('***')){
              int startIndex = fullData.indexOf('***');
              int endIndex = fullData.indexOf('!!!');
              String data = fullData.substring(startIndex + 3, endIndex);

              dprint('data', data);
              setState(() {
                _smartDevices[index]['data'] = data;
              });
            }
          }
        });
      } else {
        int actionValue = value ? 1 : 0;
        showLoader(context);
        HttpResponseModel responseModel = await ApiService.get(url: getApiUrl('?State=${_smartDevices[index]['action']}_${actionValue}'));
        hideLoader(context);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addressController.text = globalAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maison intelligente'),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: ScaffoldBgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 17,right: 17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8,
              ),

              Container(
                height: 45,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _addressController,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.black),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        setState(() {
                          globalAddress = _addressController.text;
                          _connected = false;
                        });

                        HttpResponseModel responseModel = await ApiService.get(url: getApiUrl(''));

                        setState(() {
                          if (responseModel.status == true) {
                            var responseJson = jsonDecode(responseModel.response!.body);
                            if (responseJson['status'] == true) {
                              _connected = true;
                            } else {
                              _connected = false;
                            }
                          } else {
                            _connected = false;
                          }
                        });
                      },
                      color: _connected ? Colors.green : Colors.red,
                      child: Icon(
                        _connected ? Icons.wifi : Icons.wifi_off,
                        color: Colors.white,
                        size: 35,
                      ),
                    )
                  ],
                ),
              ),

              const Divider(
                color: Colors.black,
                thickness: 2,
              ),

              const SizedBox(
                height: 25,
              ),

              //* Smart Devices and Grid

              //? Title
              // Text(
              //   "SMART DEVICES",
              //   style: GoogleFonts.aBeeZee(letterSpacing: 3, fontWeight: FontWeight.bold, fontSize: 20),
              // ),
              const SizedBox(
                height: 15,
              ),

              //? Grid View and its builder

              Expanded(
                child: GridView.builder(
                    itemCount: _smartDevices.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      var device = _smartDevices[index];
                      bool powerStatus = device['state'];
                      String onIcon = device['onIcon'];
                      String offIcon = device['offIcon'];

                      return Container(
                        child: Container(
                          decoration: BoxDecoration(
                            color: powerStatus ? Colors.black54 : Colors.grey,
                            borderRadius: BorderRadius.circular(26),
                          ),
                          child: InkWell(
                            onTap: () {
                              bool oldValue = device['state'];
                              powerSwitchChanged(index, !oldValue);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                //* Icon
                                Image.asset(
                                  powerStatus ? 'assets/icons/${onIcon}' : 'assets/icons/${offIcon}',
                                  color: !powerStatus ? Colors.white : KPrimaryColor,
                                  height: 50,
                                ),

                                const SizedBox(
                                  height: 8,
                                ),

                                //* Smart Device name
                                Text(
                                  _smartDevices[index]['name'],
                                  style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold, color: !powerStatus ? Colors.white : KPrimaryColor),
                                  textAlign: TextAlign.center,
                                ),

                                const SizedBox(
                                  height: 9,
                                ),

                                //* Switches
                                CupertinoSwitch(
                                  value: powerStatus,
                                  onChanged: (value) => powerSwitchChanged(index, value),
                                  activeColor: KPrimaryColor,
                                  trackColor: Colors.white,
                                  thumbColor: Colors.grey,
                                ),

                                if (device['data'].toString().isNotEmpty)
                                  Text(
                                    '${_smartDevices[index]['data']}',
                                    style: GoogleFonts.aBeeZee(color: !powerStatus ? Colors.white : KPrimaryColor),
                                  ),
                              ]),
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
