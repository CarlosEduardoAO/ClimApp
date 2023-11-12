import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp/controllers/global_controller.dart';
import 'package:weatherapp/utils/custom_colors.dart';
import 'package:weatherapp/widgets/comfort_level.dart';
import 'package:weatherapp/widgets/current_weather.dart';
import 'package:weatherapp/widgets/daily_data_forecast.dart';
import 'package:weatherapp/widgets/header_widget.dart';
import 'package:weatherapp/widgets/hourly_data_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => globalController.checkLoading().isTrue
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const HeaderWidget(),
                    CurrentWeather(
                      weatherDataCurrent:
                          globalController.getWeather().getCurrentWeather(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    HourlyDataWidget(
                        weatherDataHourly:
                            globalController.getWeather().getHourlyWeather()),
                    DailyDataForecast(
                      weatherDataDaily:
                          globalController.getWeather().getDailyWeather(),
                    ),
                    Container(
                      height: 1,
                      color: CustomColors.dividerLine,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ComfortLevel(
                        weatherDataCurrent:
                            globalController.getWeather().getCurrentWeather()),
                  ],
                ),
              )),
      ),
    );
  }
}
