import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_demo_infotura/model/url.dart';
import 'package:http/http.dart' as http;

class CustomDialogue extends StatefulWidget {
  const CustomDialogue({super.key});

  @override
  State<CustomDialogue> createState() => _CustomDialogueState();
}

class _CustomDialogueState extends State<CustomDialogue> {
  String? _tokenValue;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    void fetchData() async {
      var email = 'eve.holt@reqres.in';
      var password = 'pistol';

      var url = Uri.https(baseUrl, registerUrl);

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'email': email,
            'password': password,
          },
        ),
      );
      // print(response);
      final Map<String, dynamic> resData = jsonDecode(response.body);
      // print(tokenValue);
      setState(() {
        _tokenValue = resData['token'];
        _isLoading = false;
      });

      if (!context.mounted) {
        return;
      }

      Navigator.of(context).pop(_tokenValue.toString());
    }

    return Scaffold(
      body: Center(
        child: SimpleDialog(
          title: const Text('Fetch your details!'),
          children: [
            SimpleDialogOption(
              child: ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () {
                        setState(() {
                          _isLoading = true;
                        });
                        fetchData();
                      },
                child: _isLoading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(),
                      )
                    : const Text('Fetch'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
