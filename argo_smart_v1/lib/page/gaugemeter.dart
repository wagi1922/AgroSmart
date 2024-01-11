import 'package:argo_smart_v1/page/sliderBar.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'dart:math' as math;

class Meteran extends StatefulWidget {
  @override
  _PHMeterState createState() => _PHMeterState();
}

class _PHMeterState extends State<Meteran> {
  // PH value
  double ph = 0.0;

  // Humidity value
  double humidity = 0.0;

  // Temperature value
  double temperature = 0.0;

  // Random number generator
  math.Random random = math.Random();

  // Generate random values
  void generateValues() {
    setState(() {
      ph = random.nextDouble() * 14;
      humidity = random.nextDouble() * 100;
      temperature = random.nextDouble() * 50;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xffc7f6ce),
          toolbarHeight: 30,
          title: Text("Selamat datang di ArgoSmart!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ))),
      body: Container(
        width: 400,
        height: 800,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xffc7f6ce), Color(0x00c9e2cd)],
        )),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SliderBar(),
              Padding(padding: EdgeInsets.all(10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.transparent,
                        width: 10,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(4, 4),
                        ),
                      ],
                      color: Color.fromARGB(255, 200, 255, 193),
                      //gradient: LinearGradient(
                      //begin: Alignment.topCenter,
                      //end: Alignment.bottomCenter,
                      //colors: [Colors.white70, Colors.green],
                      //),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100),
                        topRight: Radius.circular(100),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: SizedBox(
                      child: SfRadialGauge(
                        axes: <RadialAxis>[
                          RadialAxis(
                            minimum: 0,
                            maximum: 14,
                            showLabels: false,
                            showTicks: true,
                            axisLineStyle: AxisLineStyle(
                                thickness: 0.2,
                                thicknessUnit: GaugeSizeUnit.factor,
                                cornerStyle: CornerStyle.bothCurve),
                            pointers: <RangePointer>[
                              RangePointer(
                                color: ph < 4
                                    ? Colors.red
                                    : ph < 9
                                        ? Colors.green
                                        : Colors.purple,
                                value: ph,
                                onValueChanged: (value) {},
                                cornerStyle: CornerStyle.bothCurve,
                                onValueChangeEnd: (value) {},
                                enableDragging: true,
                                width: 0.2,
                                sizeUnit: GaugeSizeUnit.factor,
                              )
                            ],
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                widget: Text(
                                  ph.toStringAsFixed(2),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                angle: 90,
                                positionFactor: 0.1,
                              ),
                              GaugeAnnotation(
                                widget: Text(
                                  ph < 4
                                      ? "Asam"
                                      : ph < 9
                                          ? "Normal"
                                          : "Basa",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: ph < 4
                                        ? Colors.red
                                        : ph < 9
                                            ? Colors.green
                                            : Colors.purple,
                                  ),
                                ),
                                angle: 90,
                                positionFactor: 0.5,
                              ),
                              GaugeAnnotation(
                                widget: Text(
                                  'pH Meter',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                angle: 90,
                                positionFactor: 1,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.transparent,
                        width: 10,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(4, 4),
                        ),
                      ],
                      color: Color.fromARGB(255, 200, 255, 193),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                            100), // berikan radius untuk sudut kiri atas
                        // berikan nilai Radius.zero untuk sudut lainnya
                        topRight: Radius.circular(100),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: SizedBox(
                        child: SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                          minimum: 0,
                          maximum: 100,
                          showLabels: false, // tambahkan properti ini
                          showTicks: true, // tambahkan properti ini
                          axisLineStyle: AxisLineStyle(
                              // ubah properti ini
                              thickness: 0.2,
                              thicknessUnit: GaugeSizeUnit.factor,
                              cornerStyle: CornerStyle.bothCurve),
                          pointers: <RangePointer>[
                            RangePointer(
                              color: humidity >= 0 && humidity <= 35
                                  ? Colors.red
                                  : humidity >= 36 && humidity <= 65
                                      ? Colors.green
                                      : humidity >= 67 && humidity <= 100
                                          ? Colors.blue
                                          : Colors.blue, // ubah properti ini
                              value: humidity, // ubah properti ini
                              onValueChanged: (value) {},
                              cornerStyle: CornerStyle.bothCurve,
                              onValueChangeEnd: (value) {},
                              enableDragging: true,
                              width: 0.2,
                              sizeUnit: GaugeSizeUnit.factor,
                            )
                          ],
                          annotations: <GaugeAnnotation>[
                            // tambahkan properti ini
                            GaugeAnnotation(
                              widget: Text(
                                humidity.toStringAsFixed(2) + "%",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              angle: 90,
                              positionFactor: 0.1,
                            ),
                            GaugeAnnotation(
                              widget: Text(
                                humidity >= 0 && humidity <= 35
                                    ? "Kering"
                                    : humidity >= 36 && humidity <= 65
                                        ? "Normal"
                                        : humidity >= 67 && humidity <= 100
                                            ? "Lembab"
                                            : "Lembab",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: humidity >= 0 && humidity <= 35
                                      ? Colors.red
                                      : humidity >= 36 && humidity <= 65
                                          ? Colors.green
                                          : humidity >= 67 && humidity <= 100
                                              ? Colors.blue
                                              : Colors.blue, // uba
                                ),
                              ),
                              angle: 90,
                              positionFactor: 0.5,
                            ),
                            GaugeAnnotation(
                              widget: Text(
                                'Kelembapan',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              angle: 90,
                              positionFactor: 1,
                            )
                          ],
                        )
                      ],
                    )),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(10)),
              Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.transparent,
                      width: 10,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(4, 4),
                      ),
                    ],
                    color: Color.fromARGB(255, 200, 255, 193),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                          100), // berikan radius untuk sudut kiri atas
                      // berikan nilai Radius.zero untuk sudut lainnya
                      topRight: Radius.circular(100),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: SizedBox(
                      child: SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                        minimum: 0,
                        maximum: 100,
                        showLabels: false,
                        showTicks: true,
                        axisLineStyle: AxisLineStyle(
                            thickness: 0.2,
                            thicknessUnit: GaugeSizeUnit.factor,
                            cornerStyle: CornerStyle.bothCurve),
                        pointers: <RangePointer>[
                          RangePointer(
                            color: temperature >= 0 && temperature <= 22
                                ? Colors.blue
                                : temperature >= 23 && temperature <= 35
                                    ? Colors.green
                                    : temperature >= 36 && temperature <= 70
                                        ? Colors.red
                                        : Colors.red[900],
                            value: temperature,
                            onValueChanged: (value) {},
                            cornerStyle: CornerStyle.bothCurve,
                            onValueChangeEnd: (value) {},
                            enableDragging: true,
                            width: 0.2,
                            sizeUnit: GaugeSizeUnit.factor,
                          )
                        ],
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                            widget: Text(
                              temperature.toStringAsFixed(2) + "°C",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            angle: 90,
                            positionFactor: 0.1,
                          ),
                          GaugeAnnotation(
                            widget: Text(
                              temperature >= 0 && temperature <= 22
                                  ? "Dingin"
                                  : temperature >= 23 && temperature <= 35
                                      ? "Normal"
                                      : temperature >= 36 && temperature <= 100
                                          ? "Panas"
                                          : "panas",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: temperature >= 0 && temperature <= 22
                                    ? Colors.blue
                                    : temperature >= 23 && temperature <= 35
                                        ? Colors.green
                                        : temperature >= 36 &&
                                                temperature <= 100
                                            ? Colors.red
                                            : Colors.red[900],
                              ),
                            ),
                            angle: 90,
                            positionFactor: 0.5,
                          ),
                          GaugeAnnotation(
                            widget: Text(
                              'Suhu',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            angle: 90,
                            positionFactor: 1,
                          )
                        ],
                      )
                    ],
                  ))),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: generateValues,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
