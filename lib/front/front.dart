import 'package:flutter/material.dart';
import '../back/peremen.dart';
import '../back/getweather.dart';

class frontView extends StatelessWidget {
  const frontView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

       // width: MediaQuery.of(context).size.width,
       // height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/fon.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            SizedBox(
              height: 70,
            ),
            Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      locationMap, // Отображение геопозиции
                      style: const TextStyle(
                          color: Color(0xff075E7A),
                          fontWeight: FontWeight.w600,
                          fontSize: 50,
                          fontFamily: 'Suisse Intl'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          temperature, // Отображение температуры
                          style: const TextStyle(
                              color: Color(0xff075E7A),
                              fontWeight: FontWeight.w600,
                              fontSize: 200,
                              fontFamily: 'Suisse Intl'),
                        ),
                        const Icon(
                          Icons.thermostat,
                          color: Color(0xff075E7A),
                          size: 80.0,
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff74C6382).withOpacity(0.51),
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                      ),
                      width: 345,
                      height: 148,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            weatherDescription, // Отображение погодных условий
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 23,
                                fontFamily: 'Suisse Intl'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff74C6382).withOpacity(0.51),
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                      ),
                      width: 345,
                      height: 148,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            windSpeed, // отображение скорости ветра
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 70,
                                fontFamily: 'Suisse Intl'),
                          ),
                          const Text(
                            "Скорость \nветра м/с",
                            style: TextStyle(
                                color: Color(0xff075E7A),
                                fontWeight: FontWeight.w600,
                                fontSize: 35,
                                fontFamily: 'Suisse Intl'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),

    );
  }
}