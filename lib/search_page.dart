import 'package:flutter/material.dart';
import 'package:flutter_app_javascript/main3.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('주소검색기')
      ),
      body: Row(
        children: [
          SizedBox(
              width: 340,
              child: TextField(
                controller: _controller,
                onChanged: (text) => _controller.text,
              )
          ),
          ElevatedButton(onPressed: () {
            _navigateAndDisplaySelection(context);
          },
            child: Text('검색'),
          )
        ],
      ),
    );
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
    setState(() {
      return _controller.text = result;
    }
    );
  }
}
