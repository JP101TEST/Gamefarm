import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'data_controll.dart';

class DetectionTool extends StatefulWidget {
  final ValueChanged<int> update;
  final VoidCallback onMusic;
  final VoidCallback offMusic;
  DetectionTool(
      {required this.update, required this.onMusic, required this.offMusic});

  @override
  _DetectionToolState createState() => _DetectionToolState();
}

class _DetectionToolState extends State<DetectionTool> {
  // Define your grid-related variables and methods here

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //สร้าง toolbar
        Positioned(
          top: 682 + 68.2,
          child: Stack(
            children: [
              Container(
                height: 93,
                width: display_width,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 192, 212, 112)),
                child: Image.asset(
                  'assets/images/UIBut.png',
                  filterQuality: FilterQuality.none,
                  fit: BoxFit
                      .fill, // Use BoxFit.none to prevent scaling or blurring
                ),
              ),
              Container(
                height: 90,
                padding: EdgeInsets.all(15),
                width: display_width,
                child: ListView(
                  //ส่วนปุ่มกด
                  scrollDirection: Axis.horizontal,
                  children: [
                    if (tool_on_hand == 0)
                      toolbar(0, 'Hand')
                    else
                      toolbar(5, 'Hand'),
                    if (tool_on_hand == 1)
                      toolbar(1, 'Tiller')
                    else
                      toolbar(6, 'Tiller'),
                    if (tool_on_hand == 2)
                      toolbar(2, 'Water can')
                    else
                      toolbar(7, 'Water can'),
                    if (tool_on_hand == 3)
                      toolbar(3, 'Seed bag')
                    else
                      toolbar(8, 'Seed bag'),
                    if (tool_on_hand == 4)
                      toolbar(4, 'Sickle')
                    else
                      toolbar(9, 'Sickle'),
                    toolbar(10, 'Market'),
                    toolbar(11, 'Sleep'),
                    if (music_setting == true)
                      toolbar(12, 'Music on')
                    else
                      toolbar(13, 'Music off'),
                    toolbar(16, 'Restart')
                  ],
                ),
              ),
            ],
          ),
        ),
        //หน้าเลือกเมล็ดที่มี
        if (seed_bag_page == true)
          Positioned(
            top: 68.2,
            child: Container(
                height: 682,
                width: display_width,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 64, 69, 107).withOpacity(0.5)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 230,
                                width: 250,
                                child: Image.asset(
                                  'assets/images/UIBut.png',
                                  filterQuality: FilterQuality.none,
                                  fit: BoxFit
                                      .fill, // Use BoxFit.none to prevent scaling or blurring
                                ),
                              ),
                              Positioned(
                                top: 20,
                                left: 15,
                                child: Text(
                                  "My seed",
                                  style: TextStyle(
                                    color: Color.fromARGB(
                                        255, 89, 68, 57), // Set the text color
                                    fontSize: 30,
                                    fontFamily: 'MyFont',
                                  ),
                                ),
                              ),
                              //ปุ่มกดปิดหน้า
                              Positioned(
                                top: 15,
                                left: 190,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      seed_bag_page = false;
                                    });
                                  },
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: Image.asset(
                                      images_tool[14],
                                      filterQuality: FilterQuality.none,
                                      fit: BoxFit
                                          .fill, // Use BoxFit.none to prevent scaling or blurring
                                    ),
                                  ),
                                ),
                              ),
                              ////ปุ่มกดปิดหน้า
                              Positioned(
                                top: 50,
                                left: 30,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          //ตรวจสอบและหยิบเมล็ดขึ้นมือ
                                          getSeedOnHand(0);
                                        });
                                      },
                                      child: Container(
                                        width: 63,
                                        height: 63,
                                        child: Image.asset(
                                          //แสดงรูปเมล็ด
                                          (seed_inventory[0] > 0)
                                              ? images_plant[13]
                                              : images_plant[15],
                                          filterQuality: FilterQuality.none,
                                          fit: BoxFit
                                              .fill, // Use BoxFit.none to prevent scaling or blurring
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      height: 63,
                                      margin: EdgeInsets.only(left: 10),
                                      alignment: Alignment.center,
                                      child: Text(
                                        //แสดงจำนวนเมล็ด
                                        "${seed_inventory[0]}",
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 89, 68,
                                              57), // Set the text color
                                          fontSize: 20,
                                          fontFamily: 'MyFont',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //
                              Positioned(
                                top: 50 + 63,
                                left: 30,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          getSeedOnHand(1);
                                        });
                                      },
                                      child: Container(
                                        width: 63,
                                        height: 63,
                                        child: Image.asset(
                                          (seed_inventory[1] > 0)
                                              ? images_plant[14]
                                              : images_plant[16],
                                          filterQuality: FilterQuality.none,
                                          fit: BoxFit
                                              .fill, // Use BoxFit.none to prevent scaling or blurring
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      height: 63,
                                      margin: EdgeInsets.only(left: 10),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${seed_inventory[1]}",
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 89, 68,
                                              57), // Set the text color
                                          fontSize: 20,
                                          fontFamily: 'MyFont',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )),
          ),
        //หน้าซื้อเมล็ด
        if (market_page == true)
          Positioned(
            top: 68.2,
            child: Container(
                height: 682,
                width: display_width,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 64, 69, 107).withOpacity(0.5)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: 230,
                                width: 250,
                                child: Image.asset(
                                  'assets/images/UIBut.png',
                                  filterQuality: FilterQuality.none,
                                  fit: BoxFit
                                      .fill, // Use BoxFit.none to prevent scaling or blurring
                                ),
                              ),
                              const Positioned(
                                top: 20,
                                left: 15,
                                child: Text(
                                  "Buy seed",
                                  style: TextStyle(
                                    color: Color.fromARGB(
                                        255, 89, 68, 57), // Set the text color
                                    fontSize: 30,
                                    fontFamily: 'MyFont',
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 15,
                                left: 190,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      market_page = false;
                                    });
                                  },
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: Image.asset(
                                      images_tool[14],
                                      filterQuality: FilterQuality.none,
                                      fit: BoxFit
                                          .fill, // Use BoxFit.none to prevent scaling or blurring
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 50,
                                left: 30,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if ((coind - 30) >= 0 &&
                                              seed_inventory[0] < 100) {
                                            coind -= 30;
                                            widget.update(0);
                                            seed_inventory[0] += 1;
                                          }
                                        });
                                      },
                                      child: SizedBox(
                                        width: 63,
                                        height: 63,
                                        child: Image.asset(
                                          images_plant[13],
                                          filterQuality: FilterQuality.none,
                                          fit: BoxFit
                                              .fill, // Use BoxFit.none to prevent scaling or blurring
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 50,
                                      height: 45,
                                      margin: const EdgeInsets.only(left: 10),
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          const Text(
                                            "You:",
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 89, 68,
                                                  57), // Set the text color
                                              fontSize: 15,
                                              fontFamily: 'MyFont',
                                            ),
                                          ),
                                          Text(
                                            "${seed_inventory[0]}",
                                            style: const TextStyle(
                                              color: Color.fromARGB(255, 89, 68,
                                                  57), // Set the text color
                                              fontSize: 15,
                                              fontFamily: 'MyFont',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 50,
                                      height: 45,
                                      margin: const EdgeInsets.only(left: 10),
                                      alignment: Alignment.center,
                                      child: const Column(
                                        children: [
                                          Text(
                                            "Price:",
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 89, 68,
                                                  57), // Set the text color
                                              fontSize: 15,
                                              fontFamily: 'MyFont',
                                            ),
                                          ),
                                          Text(
                                            "30",
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 89, 68,
                                                  57), // Set the text color
                                              fontSize: 15,
                                              fontFamily: 'MyFont',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 50 + 63,
                                left: 30,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if ((coind - 50) >= 0 &&
                                              seed_inventory[1] < 100) {
                                            coind -= 50;
                                            widget.update(coind);
                                            seed_inventory[1] += 1;
                                          }
                                        });
                                      },
                                      child: SizedBox(
                                        width: 63,
                                        height: 63,
                                        child: Image.asset(
                                          images_plant[14],
                                          filterQuality: FilterQuality.none,
                                          fit: BoxFit
                                              .fill, // Use BoxFit.none to prevent scaling or blurring
                                        ),
                                      ),
                                    ),
                                    Container(
                                        width: 50,
                                        height: 45,
                                        margin: const EdgeInsets.only(left: 10),
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [
                                            const Text(
                                              "You:",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255,
                                                    89,
                                                    68,
                                                    57), // Set the text color
                                                fontSize: 15,
                                                fontFamily: 'MyFont',
                                              ),
                                            ),
                                            Text(
                                              "${seed_inventory[1]}",
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255,
                                                    89,
                                                    68,
                                                    57), // Set the text color
                                                fontSize: 15,
                                                fontFamily: 'MyFont',
                                              ),
                                            ),
                                          ],
                                        )),
                                    Container(
                                      width: 50,
                                      height: 45,
                                      margin: const EdgeInsets.only(left: 10),
                                      alignment: Alignment.center,
                                      child: const Column(
                                        children: [
                                          Text(
                                            "Price:",
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 89, 68,
                                                  57), // Set the text color
                                              fontSize: 15,
                                              fontFamily: 'MyFont',
                                            ),
                                          ),
                                          Text(
                                            "50",
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 89, 68,
                                                  57), // Set the text color
                                              fontSize: 15,
                                              fontFamily: 'MyFont',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )),
          ),
      ],
    );
  }

  //เมื่อมีการกด tools
  GestureDetector toolbar(int index, String toolbarTile) {
    return GestureDetector(
      onTap: () {
        setState(() {
          switch (index) {
            case 3: //กดเปิดการดูเมล็ดในคลัง
              seed_bag_page = !seed_bag_page;
              if (market_page == true) {
                market_page = false;
              }
              break;
            case 5: //กดเลือกมือเพื่อเก็บเกี่ยว
              tool_on_hand = 0;
              closePages();
              break;
            case 6: //กดเลือกจอบเพื่อขุดดิน
              tool_on_hand = 1;
              closePages();
              break;
            case 7: //กดเลือกบัวรดน้ำเพื่อรดน้ำ
              tool_on_hand = 2;
              closePages();
              break;
            case 8: //กดเลือกเมล็ดในคลัง
              seed_bag_page = !seed_bag_page;
              if (market_page == true) {
                market_page = false;
              }
              break;
            case 9: //กดเลือกเคียวเพื่อตัดพืชทิ้ง
              tool_on_hand = 4;
              closePages();
              break;
            case 10: //กดเพื่อเปิดหน้าร้านค้า
              market_page = !market_page;
              if (seed_bag_page == true) {
                seed_bag_page = false;
              }
              break;
            case 11: //กดเพื่อเริ่มวันใหม่
              closePages();
              nextDay();
              widget.update(0);
              break;
            case 12: //กดเพื่อปิดเสียง
              music_setting = false;
              widget.offMusic();
              widget.update(0);
              break;
            case 13: //กดเพื่อเปิดเสียง
              music_setting = true;
              closePages();
              widget.onMusic();
              widget.update(0);
              break;
            case 16: //กดเพื่อ restart
              restart_page = true;
              seed_bag_page = false;
              market_page = false;
              widget.update(0);
              break;
            default:
          }
        });
      },
      child: Container(
        width: 68.57,
        height: 68.2,
        margin: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 40.57,
              height: 40.2,
              child: Image.asset(
                images_tool[index],
                filterQuality: FilterQuality.none,
                fit: BoxFit.fill,
              ),
            ),
            Text(
              toolbarTile,
              style: const TextStyle(
                color: Color.fromARGB(255, 89, 68, 57), // Set the text color
                fontSize: 11,
                fontFamily: 'MyFont',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void nextDay() {
    sleep = true;
    for (int x = 0; x < 10; x++) {
      for (int y = 0; y < 6; y++) {
        //ตรวจสอบว่ามีการพรวนดิน
        if (grid?[x][y].make_soild != true) {
          continue;
        }

        //ตรวจสอบว่าดินเปียก
        if (grid?[x][y].floor == images_soil[2]) {
          grid?[x][y].floor = images_soil[1];
        }

        //ตรวจสอบว่ามีพืช
        if (grid?[x][y].have_plant == true && grid?[x][y].die != true) {
          grid?[x][y].weather--;
          if (grid![x][y].weather > -1 &&
              grid?[x][y].growthDone != true &&
              grid?[x][y].die != true) {
            grid?[x][y].growth++;
          }
          int plant = grid![x][y].plant_name;
          switch (plant) {
            case 0:
              plant = 1;
              break;
            case 1:
              plant = 5;
              break;
            default:
          }
          switch (grid?[x][y].growth) {
            case 1:
              grid?[x][y].plant_images = images_plant[plant];
              break;
            case 2:
              grid?[x][y].plant_images = images_plant[plant + 1];
              break;
            case 3:
              grid?[x][y].plant_images = images_plant[plant + 2];
              break;
            case 4:
              grid?[x][y].plant_images = images_plant[plant + 3];
              grid?[x][y].growthDone = true;
              break;
            default:
          }
          //ตรวจสอบว่าพื้นแห้งไหม
          switch (grid?[x][y].weather) {
            case -1:
              grid?[x][y].plant_images = images_plant[9];
              break;
            case -2:
              grid?[x][y].plant_images = images_plant[10];
              grid?[x][y].die = true;
              break;
            default:
          }
        }

        //ตรวจสอบว่ามีพืช
        if (grid?[x][y].have_plant == false) {
          grid?[x][y].no_plant++;
        }

        //ตรวจสอบว่าไม่มีพืชบนพื้นนานยัง
        if (grid?[x][y].no_plant == 2) {
          grid?[x][y].floor_image(3);
        } else if (grid![x][y].no_plant == 3) {
          grid?[x][y].make_soild = false;
        }
        //สุ่มตาย
        if (grid?[x][y].have_plant == true && grid?[x][y].die != true) {
          var intValue = Random().nextInt(100);
          /*if (intValue < 10) {
            intValue = Random().nextInt(100);*/
          bool die = false;
          if (grid?[x][y].plant_name == 0 && intValue <= 2) {
            die = true;
          }
          if (grid?[x][y].plant_name == 1 && intValue <= 5) {
            die = true;
          }
          if (die == true) {
            grid?[x][y].plant_images = images_plant[10];
            grid?[x][y].die = true;
          }
          /*}*/
        }
      }
    }
    startSleep();
  }

  void closePages() {
    if (market_page == true) {
      market_page = false;
    }
    if (seed_bag_page == true) {
      seed_bag_page = false;
    }
  }

  void getSeedOnHand(int index) {
    if (seed_inventory[index] > 0) {
      seed_on_hand = index;
      tool_on_hand = 3;
      seed_bag_page = false;
    }
  }

  late Timer sleepTime;
  int deply = 20;
  void startSleep() {
    sleep = true;
    sleepTime = Timer.periodic(Duration(milliseconds: 60), (timer) {
      deply--;
      if (deply <= 0) {
        openeye -= 0.1;
        if (openeye <= 0) {
          stopSleep();
          sleep = false;
          openeye = 1;
          deply = 20;
        }
      }
      widget.update(0);
    });
  }

  void stopSleep() {
    sleepTime.cancel();
  }
}
