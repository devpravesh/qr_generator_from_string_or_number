import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'constants.dart';

class NumberToQR extends StatefulWidget {
  @override
  _NumberToQRState createState() => _NumberToQRState();
}

class _NumberToQRState extends State<NumberToQR> {
  final TextEditingController _numberController = TextEditingController();
  String _generatedQRCode = '';
  final GlobalKey _formkey = GlobalKey<FormState>();

  void _generateQRCode() {
    setState(() {
      if (_numberController.text.isNotEmpty) {
        if (isbase64) {
          _generatedQRCode =
              "https://www.meetag.in/h-s/${_numberController.text.trim()}";
        } else {
          var base64String = numberTobase64(_numberController.text.trim());
          if (base64String != null) {
            _generatedQRCode = "https://www.meetag.in/h-s/$base64String";
          }
        }
      }
    });
  }

  bool isbase64 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number to QR Code'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formkey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                validator: (value) {
                  if (isbase64) {
                    final RegExp base64RegExp = RegExp(
                        r'^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=)?$');
                    if (!base64RegExp.hasMatch(value ?? '')) {
                      return 'Invalid Base64 string';
                    }
                  } else {
                    final RegExp numericRegExp = RegExp(r'^-?[0-9]+$');
                    if (!numericRegExp.hasMatch(value ?? '')) {
                      return 'Invalid number';
                    }
                  }
                  return null; // Return null if validation succeeds
                },
                controller: _numberController,
                keyboardType:
                    isbase64 ? TextInputType.text : TextInputType.number,
                decoration: InputDecoration(
                  labelText:
                      !isbase64 ? 'Enter a number' : "Enter a Base64 String",
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _generateQRCode,
                  child: const Text('Generate QR Code'),
                ),
                const Text("NO."),
                CupertinoSwitch(
                    trackColor: Colors.blue,
                    value: isbase64,
                    onChanged: (value) {
                      setState(() {
                        isbase64 = value;
                      });
                    }),
                const Text("Base64")
              ],
            ),
            const SizedBox(height: 20),
            _generatedQRCode.isNotEmpty
                ? Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          QrImageView(
                            data: _generatedQRCode,
                            version: QrVersions.auto,
                            size: 200.0,
                          ),
                          Text(_generatedQRCode)
                        ],
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
