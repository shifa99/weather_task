import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/methods/close_keypoard.dart';
import 'package:weather_app/core/utills/navigation.dart';
import 'package:weather_app/core/utills/style_manager.dart';
import 'package:weather_app/core/widgets/default_app_bar.dart';
import 'package:weather_app/core/widgets/default_loading.dart';
import 'package:weather_app/core/widgets/default_text_button.dart';
import 'package:weather_app/core/widgets/default_text_field.dart';
import 'package:weather_app/features/auth/presentation/screens/edit_screen/edit_screen.dart';
import 'package:weather_app/features/weather/presentation/cubit/weather_cubit.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar(title: 'Main', actions: [
        IconButton(
            onPressed: () {
              navigateTo(context: context, screen: EditScreen());
            },
            icon: Icon(
              Icons.edit,
              size: 25.sp,
            )),
      ]),
      body: GestureDetector(
        onTap: () {
          closeKeyboard(context);
        },
        child: BlocProvider(
          create: (context) => WeatherCubit()..getWeatherByLocation(),
          lazy: false,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                children: [
                  SizedBox(
                    height: 80.h,
                    child: Form(
                      key: formKey,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: defaultTextField(
                                controller: controller,
                                hint: 'Country or City',
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Please enter country or city name';
                                  }
                                },
                                action: TextInputAction.done,
                                type: TextInputType.name),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Builder(builder: (context) {
                            return defaultTextButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    WeatherCubit.get(context).getWeatherByName(
                                        name: controller.text);
                                  }
                                },
                                textColor: Colors.white,
                                title: 'GET');
                          }),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 120.h,
                  ),
                  BlocBuilder<WeatherCubit, WeatherState>(
                    builder: (context, state) {
                      if (state is WeatherLoading) {
                        return const DefaultLoading();
                      } else if (state is WeatherError) {
                        return Center(
                          child: Text(
                            'Error happen when get data',
                            style: bodyStyle(),
                          ),
                        );
                      } else {
                        WeatherCubit _cubit = WeatherCubit.get(context);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              'City: ${_cubit.weather.location.name}',
                              style: bodyStyle(),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              'Country: ${_cubit.weather.location.country}',
                              style: bodyStyle(),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              'Temp: ${_cubit.weather.current.tempC}',
                              style: bodyStyle(),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
