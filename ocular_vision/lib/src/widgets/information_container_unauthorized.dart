import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ocular_vision/src/APIs/info_fetching.dart';

class InformationContainerUnAuthorized extends StatefulWidget {
  final String result;
  final int noOfObjectsFound;

  final String description;
  final Color primaryColor;
  final List<String> imageUrls;

  const InformationContainerUnAuthorized(
      {super.key,
      required this.result,
      required this.noOfObjectsFound,
      required this.description,
      required this.primaryColor,
      required this.imageUrls});

  @override
  State<InformationContainerUnAuthorized> createState() =>
      _InformationContainerUnAuthorizedState();
}

class _InformationContainerUnAuthorizedState
    extends State<InformationContainerUnAuthorized> {
  bool isSeeMore = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.7,
      padding: const EdgeInsets.fromLTRB(10, 20, 20, 0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.black),
            ),
            const SizedBox(height: 15),
            if (widget.noOfObjectsFound == 0) ...{
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                'assets/img/error.png',
                width: 300,
                height: 300,
              ),
              const Text(
                'No Objects Found',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins'),
              ),
              const SizedBox(height: 10),
            },
            if (widget.noOfObjectsFound != 0) ...{
              Container(
                height: 230,
                child: ListView.builder(
                    itemCount: widget.imageUrls.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.all(5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            widget.imageUrls[index],
                            height: 220,
                            width: 280,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
              ),
            },
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Adjusted alignment
              children: [
                Expanded(
                  child: Text(
                    widget.result,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
              ],
            ),
            if (isSeeMore) ...{
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 22, horizontal: 10),
                child: Text(
                  widget.description,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins",
                      color: Colors.grey[700]),
                ),
              ),
            } else ...{
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 22, horizontal: 10),
                child: Text(
                  widget.description,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins",
                      color: Colors.grey[700]),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            },
            TextButton(
                onPressed: () {
                  setState(() {
                    isSeeMore = !isSeeMore;
                  });
                },
                child: const Text(
                  "See more",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 62, 59, 255),
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      fontFamily: "Poppins"),
                )),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class FoodInformationUnAuthorizedContainer extends StatefulWidget {
  final String result;
  final int noOfObjectsFound;

  final String description;
  final Color primaryColor;
  final List<String> imageUrls;

  const FoodInformationUnAuthorizedContainer(
      {super.key,
      required this.result,
      required this.noOfObjectsFound,
      required this.description,
      required this.primaryColor,
      required this.imageUrls});

  @override
  State<FoodInformationUnAuthorizedContainer> createState() =>
      _FoodInformationUnAuthorizedContainerState();
}

class _FoodInformationUnAuthorizedContainerState
    extends State<FoodInformationUnAuthorizedContainer> {
  List<dynamic> nutritionInformation = [];
  List<dynamic> recipeInformation = [];
  List<String> ingredients = [];
  List<String> instructions = [];
  List<String> dishesList = [];
  int selectedOption = 0;
  bool isShowRecipe = false;
  bool isSeeMore = false;
  @override
  void initState() {
    super.initState();
    firstThingsTodo();
  }

  Future<void> firstThingsTodo() async {
    try {
      String info = await fetchNutritionInfo(widget.result);
      String info2 = await fetchRecipeInfo(widget.result);
      if (info.isNotEmpty || info2.isNotEmpty) {
        setState(() {
          nutritionInformation = jsonDecode(info) ?? [];
          recipeInformation = jsonDecode(info2) ?? [];
        });
      } else {
        print("Error: Fetched data is empty");
      }
    } catch (e) {
      print("Error: $e");
    }

    setState(() {
      ingredients = recipeInformation.isNotEmpty
          ? recipeInformation[0]['ingredients'].toString().split('|').toList()
          : [];
      instructions = recipeInformation.isNotEmpty
          ? recipeInformation[0]['instructions'].toString().split('.').toList()
          : [];
      dishesList = recipeInformation.isNotEmpty
          ? recipeInformation
              .map((recipe) => recipe['title'].toString())
              .toList()
          : [];
    });
  }

  void handleOptionPressed(int val) {
    setState(() {
      selectedOption = val;
      ingredients = recipeInformation.isNotEmpty
          ? recipeInformation[selectedOption]['ingredients']
              .toString()
              .split('|')
              .toList()
          : [];
      instructions = recipeInformation.isNotEmpty
          ? recipeInformation[selectedOption]['instructions']
              .toString()
              .split('.')
              .toList()
          : [];
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.7,
      padding: const EdgeInsets.fromLTRB(10, 20, 20, 0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        color: Color.fromARGB(255, 233, 232, 239),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.black),
            ),
            const SizedBox(height: 15),
            if (widget.noOfObjectsFound == 0) ...{
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                'assets/img/error.png',
                width: 300,
                height: 300,
              ),
              const Text(
                'No Objects Found',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins'),
              ),
              const SizedBox(height: 10),
            },
            if (widget.noOfObjectsFound != 0) ...{
              Container(
                height: 230,
                child: ListView.builder(
                    itemCount: widget.imageUrls.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.all(5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            widget.imageUrls[index],
                            height: 220,
                            width: 280,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
              ),
            },
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween, // Adjusted alignment
                    children: [
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          widget.result,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (isSeeMore) ...{
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 22, horizontal: 7),
                      child: Text(
                        widget.description,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                            color: Colors.grey[700]),
                      ),
                    ),
                  } else ...{
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 22, horizontal: 7),
                      child: Text(
                        widget.description,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                            color: Colors.grey[700]),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  },
                  TextButton(
                      onPressed: () {
                        setState(() {
                          isSeeMore = !isSeeMore;
                        });
                      },
                      child: const Text(
                        "See more",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 62, 59, 255),
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            fontFamily: "Poppins"),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (widget.noOfObjectsFound != 0) ...{
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 235, 255, 107),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Nutritions",
                          style: TextStyle(
                              fontSize: 25.5,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Poppins"),
                        ),
                        Text(
                          "per 100g serving",
                          style: TextStyle(
                              fontSize: 13,
                              color: Color.fromARGB(255, 90, 90, 90),
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        nutritionTextContainer("CALORIES", "calories"),
                        nutritionTextContainer("PROTIEN", "protein_g"),
                        nutritionTextContainer("CHOLESTEROL", "cholesterol_mg")
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        nutritionTextContainer(
                            "CARBS", 'carbohydrates_total_g'),
                        nutritionTextContainer('FAT', 'fat_total_g'),
                        nutritionTextContainer('SUGAR', 'sugar_g'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Want to prepare?",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(25)),
                          child: TextButton.icon(
                              onPressed: () {
                                setState(() {
                                  isShowRecipe = !isShowRecipe;
                                });
                              },
                              icon: Icon(
                                isShowRecipe
                                    ? Icons.expand_less_rounded
                                    : Icons.expand_more_rounded,
                                color: Colors.white,
                              ),
                              label: const Text(
                                "Show recipe",
                                style: TextStyle(color: Colors.white),
                              )),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (isShowRecipe) ...{
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            "Select any of the dishes below:",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 38,
                            alignment: Alignment.center,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: dishesList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  bool isSelected = selectedOption == index;

                                  return Container(
                                    alignment: Alignment.center,
                                    padding:
                                        const EdgeInsetsDirectional.symmetric(
                                      horizontal: 15,
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 2.5,
                                    ),
                                    decoration: BoxDecoration(
                                        color: isSelected
                                            ? Colors.black
                                            : Colors.grey[300],
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: TextButton(
                                      onPressed: () {
                                        handleOptionPressed(index);
                                      },
                                      child: Text(dishesList[index],
                                          style: TextStyle(
                                              color: isSelected
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Poppins",
                                              fontSize: 15)),
                                    ),
                                  );
                                }),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            "🥗 Ingredients",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Poppins"),
                          ),
                          Text(
                            "For ${recipeInformation.isNotEmpty ? recipeInformation[selectedOption]['servings'] ?? "" : ""}",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[700],
                                fontFamily: "Poppins"),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: ingredients.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 8),
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  ingredients[index],
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins",
                                      color: Colors.black),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            "🍲 Instructions",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Poppins"),
                          ),
                          const SizedBox(height: 5),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: instructions.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 8),
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  "${index + 1}) ${instructions[index]}",
                                  style: const TextStyle(
                                      fontSize: 15.5,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins",
                                      color: Colors.black),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    },
                  ],
                ),
              )
            },
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget nutritionTextContainer(String title, String attribute) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              (nutritionInformation.isNotEmpty
                  ? '${nutritionInformation[0][attribute]!}'
                  : "00"),
              style: const TextStyle(
                fontSize: 25,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              attribute != "calories" ? "g" : "",
              style: const TextStyle(
                fontSize: 26,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(
              fontSize: 13.5,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w800,
              color: Color.fromARGB(255, 43, 43, 43)),
        )
      ],
    );
  }
}

// Container for animals and birds
class AnimalInformationUnAuthorizedContainer extends StatefulWidget {
  final String result;
  final int noOfObjectsFound;

  final String description;
  final List<String> imageUrls;

  const AnimalInformationUnAuthorizedContainer({
    super.key,
    required this.result,
    required this.noOfObjectsFound,
    required this.description,
    required this.imageUrls,
  });

  @override
  State<AnimalInformationUnAuthorizedContainer> createState() =>
      _AnimalInformationUnAuthorizedContainerState();
}

class _AnimalInformationUnAuthorizedContainerState
    extends State<AnimalInformationUnAuthorizedContainer> {
  int selectedOption = 0;
  List<dynamic> animalExtraInformation = [];
  List<String> animalTypeList = [];
  String result = "";
  bool isSeeMore = false;
  TextStyle titleStyle = const TextStyle(
    fontSize: 17.5,
    fontWeight: FontWeight.w600,
    fontFamily: "Poppins",
  );
  TextStyle subTitleStyle = TextStyle(
      fontSize: 15.5,
      fontWeight: FontWeight.w500,
      fontFamily: "Poppins",
      color: Colors.grey[700]);
  TextStyle normalStyle = const TextStyle(
    fontSize: 15.5,
    fontWeight: FontWeight.w500,
    fontFamily: "Poppins",
  );

  @override
  void initState() {
    super.initState();

    result = widget.result;

    print("Hello i am from init state: ${widget.result}");
    firstThingsTodo();
  }

  Future<void> firstThingsTodo() async {
    try {
      print("************************************************${widget.result}");
      print("$result ==================================");
      String info = await fetchAnimalInfo(result);
      print("************************************************${widget.result}");
      if (info.isNotEmpty) {
        setState(() {
          animalExtraInformation = jsonDecode(info) ?? [];
        });
      } else {
        print("Error: Empty response");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
    setState(() {
      animalTypeList = animalExtraInformation.isNotEmpty
          ? animalExtraInformation
              .map((animal) => animal['name'].toString())
              .toList()
          : [];
    });
  }

  void handleOptionPressed(int val) {
    setState(() {
      selectedOption = val;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.7,
      padding: const EdgeInsets.fromLTRB(10, 20, 20, 0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        color: Color.fromARGB(255, 233, 232, 239),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.black),
            ),
            const SizedBox(height: 15),
            if (widget.noOfObjectsFound == 0) ...{
              const Text(
                'No Objects Found',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins'),
              ),
              const SizedBox(height: 10),
            },
            Container(
              height: 230,
              child: ListView.builder(
                  itemCount: widget.imageUrls.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          widget.imageUrls[index],
                          height: 220,
                          width: 280,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween, // Adjusted alignment
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.result,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins",
                              ),
                            ),
                            Text(
                              animalExtraInformation.isNotEmpty
                                  ? animalExtraInformation[selectedOption]
                                          ['taxonomy']['scientific_name'] ??
                                      ""
                                  : "",
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (isSeeMore) ...{
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 22, horizontal: 12.5),
                      child: Text(
                        widget.description,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                            color: Colors.grey[700]),
                      ),
                    ),
                  } else ...{
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 22, horizontal: 12.5),
                      child: Text(
                        widget.description,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                            color: Colors.grey[700]),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  },
                  TextButton(
                      onPressed: () {
                        setState(() {
                          isSeeMore = !isSeeMore;
                        });
                      },
                      child: const Text(
                        "See more",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 62, 59, 255),
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            fontFamily: "Poppins"),
                      ))
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (animalTypeList.length > 1) ...{
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(height: 10),
                Text(
                  "Select a type of $result:",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600]),
                ),
                const SizedBox(height: 15),
                Container(
                  height: 55,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: animalTypeList.length,
                      itemBuilder: (BuildContext context, int index) {
                        bool isSelected = selectedOption == index;

                        return Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 15,
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 2.5,
                          ),
                          decoration: BoxDecoration(
                              color:
                                  isSelected ? Colors.black : Colors.grey[300],
                              borderRadius: BorderRadius.circular(25)),
                          child: TextButton(
                            onPressed: () {
                              handleOptionPressed(index);
                            },
                            child: Text(animalTypeList[index],
                                style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Poppins",
                                    fontSize: 15)),
                          ),
                        );
                      }),
                ),
              ]),
              const SizedBox(height: 15),
            },
            if (animalExtraInformation.isNotEmpty) ...{
              Text(
                "'${animalExtraInformation[selectedOption]['characteristics']['slogan'] ?? ""}'",
                style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                    color: Colors.grey[800]),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.55,
                    padding: EdgeInsets.all(17),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Estimated population:", style: titleStyle),
                        const SizedBox(height: 10),
                        Text(
                            animalExtraInformation[selectedOption]
                                        ['characteristics']
                                    ['estimated_population_size'] ??
                                "",
                            style: normalStyle)
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.55),
                    padding: EdgeInsets.all(17),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("🧬 Taxonomy", style: titleStyle),
                          const SizedBox(height: 5),
                          infoTextContainer("Kingdom", 'kingdom'),
                          infoTextContainer("Phylum", 'phylum'),
                          infoTextContainer("Class", 'class'),
                          infoTextContainer("Order", 'order'),
                          infoTextContainer("Family", 'family'),
                          infoTextContainer("Genus", 'genus'),
                        ]),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    padding: EdgeInsets.all(17),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "📍Locations",
                          style: titleStyle,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          animalExtraInformation[selectedOption]['locations']!
                              .toString(),
                          style: normalStyle,
                        ),
                        Text(
                          animalExtraInformation[selectedOption]
                                      ['characteristics']["location"] !=
                                  null
                              ? animalExtraInformation[selectedOption]
                                  ['characteristics']["location"]!
                              : "",
                          style: normalStyle,
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(17),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("🐾 Characteristics", style: titleStyle),
                    const SizedBox(height: 5),
                    characteristicsTextContainer(
                        'Name of young', 'name_of_young'),
                    characteristicsTextContainer(
                        'Group behavior', 'group_behavior'),
                    characteristicsTextContainer("Habitat", 'habitat'),
                    characteristicsTextContainer('Prey', 'prey'),
                    characteristicsTextContainer('Diet', 'diet'),
                    characteristicsTextContainer('Predators', 'predators'),
                    characteristicsTextContainer('Skin type', 'skin_type'),
                    characteristicsTextContainer('Color', 'color'),
                    characteristicsTextContainer(
                        'Distinctive feature', 'most_distinctive_feature')
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(17),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    characteristicsTextContainer('Top speed', 'top_speed'),
                    characteristicsTextContainer('Lifespan', 'lifespan'),
                    characteristicsTextContainer('Weight', 'weight'),
                    characteristicsTextContainer('Length', 'length'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            } else ...{
              Container(
                child: Text("Additional information not loaded"),
              ),
            }
          ],
        ),
      ),
    );
  }

  Widget infoTextContainer(String subTitle, String attribute) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.grey[300]!, width: 2))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "$subTitle:  ",
            style: subTitleStyle,
          ),
          Flexible(
            flex: 1,
            child: Text(
              animalExtraInformation.isNotEmpty
                  ? animalExtraInformation[selectedOption]['taxonomy']
                          [attribute] ??
                      ""
                  : "",
              style: normalStyle,
            ),
          )
        ],
      ),
    );
  }

  Widget characteristicsTextContainer(String subTitle, String attribute) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.grey[300]!, width: 2))),
      child: Row(
        children: [
          Text(
            "$subTitle:  ",
            style: subTitleStyle,
          ),
          Flexible(
            flex: 1,
            child: Text(
              animalExtraInformation.isNotEmpty
                  ? animalExtraInformation[selectedOption]['characteristics']
                          [attribute] ??
                      ""
                  : "",
              style: normalStyle,
            ),
          )
        ],
      ),
    );
  }
}
