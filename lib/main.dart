/*
จัดทำโดย
นายชนกานต์ คำพิลา รหัสนักศึกษา 64172310302-8
นางสาวสุรินทร เทพบุตร รหัสนักศึกษา 64172310166-7
 */

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini/sounds_controll.dart';
import 'package:mini/tool_controll.dart';

import 'data_controll.dart';
import 'grid_controll.dart';

void main() {
  //กำหนดให้ไม่สามารถหมุนหน้าจอได้
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  //เริ่มแอป
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.deepPurple), // Fixed the colorScheme property
        // useMaterial3: true, // Removed this line as it's not a valid property
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title})
      : super(key: key); // Fixed the constructor

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  //update setState
  void update(int newValue) {
    setState(() {});
  }

  //กำหนดคำสั่งเริ่มต้นที่ทำเมื่อเริ่ม app  ครั้งแรก
  @override
  void initState() {
    super.initState();
    //สร้างตาราง PlantationArea
    grid = List.generate(grid_y, (col) {
      return List.generate(grid_x, (row) {
        return new PlantationArea();
      });
    });
    //เริ่มเพลง
    if (music_setting == true) {
      //backGround();
    }
  }

  @override
  void dispose() {
    background.my_player.dispose();
    super.dispose();
  }

  //เวลา
  late Timer backGroundTime;
  //funtion เล่นเพลง
  void backGround() {
    //เล่นเพลง
    background.play_sound(sounds_list[0]);
    //Timer ทุก 60 วินาทีทำ funtion
    backGroundTime = Timer.periodic(const Duration(seconds: 60), (timer) {
      background.play_sound(sounds_list[0]);
    });
  }

  //funtion หยุดเล่นเพลง
  void backGround_off() {
    background.stop_sound(); //หยุดเล่นเพลง
    backGroundTime.cancel(); //หยุด Timer
  }

  @override
  Widget build(BuildContext context) {
    display_width = MediaQuery.of(context).size.width; // Gives the width
    display_height = MediaQuery.of(context).size.height; // Gives the height
    return Scaffold(
      body: Stack(
        children: [
          //ส่วน bar สำหรับแสดง เงิน
          Positioned(
            top: 0,
            child: Stack(
              children: [
                //แสดงทะเล
                Row(children: [
                  for (int y = 0; y < 6; y++)
                    SizedBox(
                      width: 68.57,
                      height: 68.2 + 3,
                      child: Image.asset(
                        'assets/images/gass_sea_1.png',
                        filterQuality: FilterQuality.none,
                        fit: BoxFit.fill,
                      ),
                    ),
                ]),
                //กล่องพื้นหลัง
                Positioned(
                  top: 32,
                  child: Stack(children: [
                    Container(
                      margin: const EdgeInsets.only(left: 30),
                      width: 155.57,
                      height: 35.2 + 3,
                      child: Image.asset(
                        'assets/images/UIBut.png',
                        filterQuality: FilterQuality.none,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 3,
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 30),
                            width: 20.57,
                            height: 25.2 + 3,
                            child: Image.asset(
                              'assets/images/coind.png',
                              filterQuality: FilterQuality.none,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(left: 10),
                            width: 100.57,
                            height: 25.2 + 3,
                            child: Text(
                              '$coind',
                              style: const TextStyle(
                                color: Color.fromARGB(
                                    255, 89, 68, 57), // Set the text color
                                fontSize: 20,
                                fontFamily: 'MyFont',
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              ],
            ),
          ),
          //สร้าง grid พื้นหลังและการตรวจสอบว่าเกิดอะไรขึ้นบน grid
          gridDraw(),
          //สร้าง tool bar
          DetectionTool(
            update: update,
            offMusic: backGround_off,
            onMusic: backGround,
          ),
          //หน้านอนหลับ
          if (sleep == true)
            Positioned(
              top: 0,
              child: Container(
                alignment: Alignment.center,
                width: display_width,
                height: display_height,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(38, 55, 87, 1).withOpacity(openeye)),
                child: Text(
                  'Sleep',
                  style: TextStyle(
                    color: const Color.fromRGBO(112, 160, 211, 1)
                        .withOpacity(openeye), // Set the text color
                    fontSize: 50,
                    fontFamily: 'MyFont',
                  ),
                ),
              ),
            ),
          //หน้า restart
          if (restart_page == true)
            Positioned(
              top: 0,
              child: Container(
                  alignment: Alignment.center,
                  width: display_width,
                  height: display_height,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(38, 55, 87, 1)
                          .withOpacity(openeye)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Restart game',
                        style: TextStyle(
                          color: const Color.fromRGBO(112, 160, 211, 1)
                              .withOpacity(openeye),
                          fontSize: 50,
                          fontFamily: 'MyFont',
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(20),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  restart_page = false;
                                });
                              },
                              child: SizedBox(
                                width: 60,
                                height: 60,
                                child: Image.asset(
                                  images_tool[14],
                                  filterQuality: FilterQuality.none,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(20),
                            child: GestureDetector(
                              onTap: () {
                                //reset ค่าทั้งหมดเป็นเริ่มต้น
                                setState(() {
                                  restart_page = false;
                                  coind = 200;
                                  tool_on_hand = 0;
                                  seed_on_hand = -1;
                                  seed_inventory = [0, 0];
                                  for (int x = 0; x < 10; x++) {
                                    for (int y = 0; y < 6; y++) {
                                      grid?[x][y].have_plant = false;
                                      grid?[x][y].plant_name = -1;
                                      grid?[x][y].plant_images = null;
                                      grid?[x][y].growth = 0;
                                      grid?[x][y].no_plant = 0;
                                      grid?[x][y].weather = 0;
                                      grid?[x][y].die = false;
                                      grid?[x][y].growthDone = false;
                                      grid?[x][y].make_soild = false;
                                      grid?[x][y].floor = null;
                                    }
                                  }
                                });
                              },
                              child: SizedBox(
                                width: 60,
                                height: 60,
                                child: Image.asset(
                                  images_tool[15],
                                  filterQuality: FilterQuality.none,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            )
        ],
      ),
    );
  }

  //สร้าง grid
  Positioned gridDraw() {
    return Positioned(
        top: 70,
        child: Stack(
          children: [
            //สร้าง grid เพื่อแสดงภาพ
            Column(
              children: [
                for (int x = 0; x < 10; x++)
                  Row(
                    children: [
                      for (int y = 0; y < 6; y++)
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            //แสดงพื้นหลังสนามหญ้า
                            SizedBox(
                              width: 68.57,
                              height: 68.2,
                              child: Image.asset(
                                images_soil[0],
                                filterQuality: FilterQuality.none,
                                fit: BoxFit.fill,
                              ),
                            ),
                            //แสดงพื้นที่ขุด
                            if (grid?[x][y].make_soild == true)
                              SizedBox(
                                width: 68.57,
                                height: 68.2,
                                child: Image.asset(
                                  '${grid?[x][y].floor}',
                                  filterQuality: FilterQuality.none,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            //แสดงพืชที่ปลูก
                            if (grid?[x][y].have_plant == true)
                              SizedBox(
                                width: 68.57,
                                height: 68.2,
                                child: Image.asset(
                                  '${grid?[x][y].plant_images}',
                                  filterQuality: FilterQuality.none,
                                  fit: BoxFit.fill,
                                ),
                              ),
                          ],
                        ),
                    ],
                  ),
              ],
            ),
            //สร้างกล่องการกดบน grid
            Column(
              children: [
                for (int x = 0; x < 10; x++)
                  Row(
                    children: [
                      for (int y = 0; y < 6; y++)
                        GestureDetector(
                          onTap: () {
                            //ส่งพิกัดกล่องเพื่อตรวจสอบว่า grid จะต้องเกิดอะไรขึ้น
                            toolAction(x, y);
                            setState(() {});
                          },
                          child: Container(
                            width: 68.57,
                            height: 68.2,
                            decoration: show_grid == true
                                ? BoxDecoration(
                                    border: Border.all(
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                      width: 1.0,
                                    ),
                                  )
                                : const BoxDecoration(),
                          ),
                        )
                    ],
                  ),
              ],
            ),
          ],
        ));
  }
}
