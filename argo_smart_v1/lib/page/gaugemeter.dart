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
          title: Text("Selamat datang! Hallo bapak Emran",
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
                          color: Color(0xffc7f6ce),
                        ),
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xffc7f6ce), Color(0x00c9e2cd)],
                      ),
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
                              color: Colors.green,
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
                            // tambahkan properti ini
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
                          ],
                        )
                      ],
                    )),
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
                          color: Color(0xffc7f6ce),
                        ),
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xffc7f6ce), Color(0x00c9e2cd)],
                      ),
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
                              color: Colors.green, // ubah properti ini
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
                      color: Color(0xffc7f6ce),
                    ),
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xffc7f6ce), Color(0x00c9e2cd)],
                  ),
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
                          color: Colors.green, // ubah properti ini
                          value: temperature, // ubah properti ini
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
                            temperature.toStringAsFixed(2) + "°C",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          angle: 90,
                          positionFactor: 0.1,
                        ),
                      ],
                    )
                  ],
                )),
              ),
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
