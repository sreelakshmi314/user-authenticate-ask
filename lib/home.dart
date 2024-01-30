import 'package:flutter/material.dart';
import 'package:flutter_demo_infotura/widgets/dialogue.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _token;

  void _fetchToken() async {
    // initiate specific action. Gets token
    final result = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (ctx) => const CustomDialogue(),
      ),
    );
    // print('result - $result');
    setState(() {
      _token = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeWidget = Center(
      child: TextButton(
        onPressed: _fetchToken,
        child: Text(
          'Click below button to Authenticate',
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
    );

    if (_token != null && _token!.isNotEmpty) {
      activeWidget = Text(
        'Token value : $_token',
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      );
    }

    // print('_token - $_token');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Your Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              activeWidget,
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: (MediaQuery.of(context).size.width) * 0.25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor:
                        Theme.of(context).colorScheme.onPrimaryContainer,
                    foregroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                  ),
                  onPressed: _fetchToken,
                  child: const Text(
                    'Authenticate',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
