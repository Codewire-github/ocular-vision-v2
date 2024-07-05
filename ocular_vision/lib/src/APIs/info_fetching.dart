import 'package:http/http.dart' as http;

Future<String> fetchAnimalInfo(String result) async {
  try {
    print("==========================================Hello$result");
    const String apiKey = "BKRT30EFf5yD4jVdYxDeD2Afdogsttr7QFm6Q0UF";
    String apiUrl = 'https://api.api-ninjas.com/v1/animals?name=$result';
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'X-Api-Key': apiKey,
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print("HTTP Error: ${response.statusCode}");
      return "";
    }
  } catch (e) {
    print("Error: $e");
    return "";
  }
}

Future<String> fetchNutritionInfo(String result) async {
  try {
    const String apiKey = "BKRT30EFf5yD4jVdYxDeD2Afdogsttr7QFm6Q0UF";
    String apiUrl = 'https://api.api-ninjas.com/v1/nutrition?query=$result';
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'X-Api-Key': apiKey,
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  } catch (e) {
    print("Error: $e");
    return "";
  }
}

Future<String> fetchRecipeInfo(String result) async {
  try {
    const String apiKey = "BKRT30EFf5yD4jVdYxDeD2Afdogsttr7QFm6Q0UF";
    String apiUrl = 'https://api.api-ninjas.com/v1/recipe?query=$result';
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'X-Api-Key': apiKey,
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  } catch (e) {
    print("Error: $e");
    return "";
  }
}
