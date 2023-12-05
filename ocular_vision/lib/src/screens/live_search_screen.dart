import 'dart:convert';
import 'package:flutter/material.dart';

class LiveSearchScreen extends StatefulWidget {
  final dynamic responseData;

  LiveSearchScreen({Key? key, required this.responseData}) : super(key: key);

  @override
  _LiveSearchScreenState createState() => _LiveSearchScreenState();
}

class _LiveSearchScreenState extends State<LiveSearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> items = [];
  List<String> filteredItems = [];
  List<String> imageNames = [];

  void initState() {
  super.initState();

  List<dynamic> decodedResponseData = [];
  if (widget.responseData != null) {
    try {
      decodedResponseData = jsonDecode(widget.responseData);
      print("decodedResponseData: $decodedResponseData");

      // Extract 'imageData' from the first item in the list
      List<Map<String, dynamic>> imageDataList = [];
      if (decodedResponseData.isNotEmpty && decodedResponseData.first.containsKey('imageData')) {
        imageDataList = List<Map<String, dynamic>>.from(decodedResponseData.first['imageData']);
      }

      // Extract image names
      imageNames = imageDataList.map((item) => item['imageName'] as String).toList();
      print("imageNames: $imageNames");

      // Use the extracted image names for filtering
      items = imageDataList.isNotEmpty ? imageDataList : [];
      filteredItems = imageNames.isNotEmpty ? imageNames : [];
    } catch (e) {
      print("Error decoding responseData: $e");
    }
  }
}

void filterSearchResults(String query) {
  List<Map<String, dynamic>> searchResults = [];
  if (query.isNotEmpty) {

    searchResults = items.where((item) => item['imageName'].toLowerCase().contains(query.toLowerCase())).toList();
  } else {
    searchResults = List.from(items);
  }
  setState(() {
    filteredItems = searchResults.map((item) => item['imageName'] as String).toList();
  });
  print("Filtered Items: $filteredItems");
}

@override
Widget build(BuildContext context) {
  print("items: $items");
  return Scaffold(
    appBar: AppBar(
      title: Text(''),
    ),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            onChanged: filterSearchResults,
            decoration: InputDecoration(
              labelText: 'Search',
              prefixIcon: Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey[200], 
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), 
                borderSide: BorderSide.none, 
              ),
            ),
            style: TextStyle(
              fontFamily: 'Poppins', 
              fontWeight: FontWeight.w600, 
              fontSize: 16, 
            ),
          ),
        ),

        Expanded(
          child: ListView.builder(
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  filteredItems[index],
                  style: TextStyle(
                    fontFamily: 'Poppins', 
                    fontWeight: FontWeight.w600, 
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}


}