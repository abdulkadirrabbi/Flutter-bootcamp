import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Even Number Filter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EvenNumberFilterScreen(),
    );
  }
}

class EvenNumberFilterScreen extends StatefulWidget {
  @override
  _EvenNumberFilterScreenState createState() => _EvenNumberFilterScreenState();
}

class _EvenNumberFilterScreenState extends State<EvenNumberFilterScreen> {
  final TextEditingController _controller = TextEditingController();
  List<int> _filteredNumbers = [];

  void _filterEvenNumbers() {
    final input = _controller.text;

    // Split the input and parse the integers safely
    final numbers = input
        .split(',')
        .map((e) => int.tryParse(e.trim()))  // Try parsing each entry
        .where((e) => e != null)             // Filter out nulls (invalid inputs)
        .cast<int>()                         // Cast to int to avoid nullable warnings
        .toList();

    setState(() {
      _filteredNumbers = numbers.where((number) => number.isEven).toList()
        ..sort(); // Sorting the even numbers
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Even Number Filters'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter a list of numbers separated by commas (e.g. 1,2,3,4)',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _filterEvenNumbers,
              child: Text('Filter Even Numbers'),
            ),
            SizedBox(height: 20),
            Text(
              'Even Numbers (sorted):',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              _filteredNumbers.isEmpty
                  ? 'No numbers found.'
                  : _filteredNumbers.join(', '),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
