import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_flutter_api/utils/helpers/apihelpers.dart';
import '../../../../utils/model/api_model.dart';
import '../Provider/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String title = "Surat";
  TextEditingController textEditingController = TextEditingController();
  bool isTextFieldFocused = false;

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    return StreamBuilder(
      stream: Connectivity().onConnectivityChanged,
      builder: (
        BuildContext context,
        AsyncSnapshot<ConnectivityResult> snapshot,
      ) {
        return (snapshot.data == ConnectivityResult.mobile ||
                snapshot.data == ConnectivityResult.wifi)
            ? GestureDetector(
                onTap: () {
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                    setState(() {
                      isTextFieldFocused = false;
                    });
                  }
                },
                child: Scaffold(
                  appBar: AppBar(
                    title: TextField(
                      style: TextStyle(
                        color: Colors.blueAccent,
                      ),
                      onTap: () {
                        setState(() {
                          isTextFieldFocused = true;
                        });
                      },
                      controller: textEditingController,
                      decoration: InputDecoration(
                        hintText: 'Enter city name',
                      ),
                    ),
                    leading: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        fetchWeatherData();
                      },
                    ),
                  ),
                  body: FutureBuilder(
                    future: Apihelper.api.getdata(search: title),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("${snapshot.error}"),
                        );
                      } else if (snapshot.hasData) {
                        api_model? apiModel = snapshot.data;
                        return Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    (Provider.of<themeprovider>(context,
                                                    listen: true)
                                                .theme
                                                .isdark ==
                                            true)
                                        ? "https://img.freepik.com/free-vector/gorgeous-clouds-background-with-blue-sky-design_1017-25501.jpg"
                                        : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHeCSVsOBVZFcUHIaUK4sItVXgpN1WfroOPl94BTKNoDPdHG8FkyRVd5LOsARTOn9LVA0&usqp=CAU ",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_sharp,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "${apiModel?.location['name']}, ${apiModel?.location['country']}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        Provider.of<themeprovider>(context,
                                                listen: false)
                                            .changetheme();
                                      },
                                      icon: const Icon(
                                        Icons.bedtime_sharp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    "Today, ${apiModel?.forecast['forecastday'][0]['date']}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    "${apiModel?.current['temp_c']}℃",
                                    style: const TextStyle(
                                      fontSize: 35,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 200,
                                  // Set a fixed height
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text(
                                            "Feelslike",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                          const Text("℃",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white)),
                                          Text(
                                            "${apiModel?.current['feelslike_c']}",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text(
                                            "Wind",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                          const Icon(
                                            Icons.air,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "${apiModel?.current['wind_kph']}",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text(
                                            "Cloud",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                          const Icon(
                                            Icons.cloud,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "${apiModel?.current['cloud']}",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text(
                                            "Humidity",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                          const Icon(
                                            Icons.water_drop,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "${apiModel?.current['humidity']}",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                if (!isTextFieldFocused)
                                  Expanded(
                                    flex: 2,
                                    child: ListView.builder(
                                      itemCount: 24,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) =>
                                          Container(
                                        height: 100,
                                        width: 100,
                                        margin: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "${index}:00",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            ),
                                            Image.network(
                                              "http:${apiModel?.forecast['forecastday'][0]['hour'][index]['condition']['icon']}",
                                            ),
                                            Text(
                                              "${apiModel?.forecast['forecastday'][0]['hour'][index]['temp_c']}℃",
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                const Expanded(child: SizedBox()),
                              ],
                            ),
                          ],
                        );
                      }
                      return Center(
                        child: Container(
                          height: 400,
                          width: 400,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                "https://cdn.dribbble.com/users/205136/screenshots/2582152/ae-fun.gif",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            : Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: Container(
                    height: 450,
                    width: 500,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("lib/Assets/1.gif"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }

  void fetchWeatherData() {
    String enteredCity = textEditingController.text;
    if (enteredCity.isNotEmpty) {
      setState(() {
        title = enteredCity;
      });
    }
  }
}
