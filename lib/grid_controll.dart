import 'data_controll.dart';

/*import 'package:flutter/material.dart';



class DetectionGrid extends StatefulWidget {

  @override
  _DetectionGridState createState() => _DetectionGridState();


}

class _DetectionGridState extends State<DetectionGrid> {

  // Define your grid-related variables and methods here
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 70,
        child: Stack(
          children: [
            Column(
              children: [
                for (int x = 0; x < 10; x++)
                  Row(
                    children: [
                      for (int y = 0; y < 6; y++)
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 68.57,
                              height: 68.2,
                              child: Image.asset(
                                images_soil[0],
                                filterQuality: FilterQuality.none,
                                fit: BoxFit.fill,
                              ),
                            ),
                            if (grid?[x][y].make_soild == true)
                              Container(
                                width: 68.57,
                                height: 68.2,
                                child: Image.asset(
                                  '${grid?[x][y].floor}',
                                  filterQuality: FilterQuality.none,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            if (grid?[x][y].have_plant == true)
                              Container(
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
            Column(
              children: [
                for (int x = 0; x < 10; x++)
                  Row(
                    children: [
                      for (int y = 0; y < 6; y++)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              output = 'x: $x, y: $y';
                            });
                            //print('x: $x, y: $y');
                            //print('grid:${grid?[x][y]}');
                            if (tool_on_hand == 1) {
                              grid?[x][y].make_soild = true;
                              grid?[x][y].floor_image(1);
                            }
                            if (tool_on_hand == 2 &&
                                grid?[x][y].make_soild == true) {
                              grid?[x][y].floor_image(2);
                            }
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
                                : BoxDecoration(),
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
*/
class PlantationArea {
  bool have_plant = false;
  int plant_name = -1;
  String? plant_images;
  int growth = 0;
  int no_plant = 0;
  int weather = 0;
  bool die = false;
  bool growthDone = false;
  bool make_soild = false;
  String? floor;

  void floor_image(int index) {
    floor = images_soil[index];
  }

  void plant_image(int index) {
    plant_images = images_soil[index];
  }
}

void toolAction(int x, int y) {
  //เก็บเกี่ยว
  if (tool_on_hand == 0 &&
      grid?[x][y].make_soild == true &&
      grid?[x][y].have_plant == true &&
      grid?[x][y].growthDone == true &&
      grid?[x][y].die != true &&
      grid![x][y].weather > -1) {
    switch (grid![x][y].plant_name) {
      case 0:
        coind += 45;
        break;
      case 1:
        coind += 75;
        break;
    }
    if (coind > 99999) {
      coind = 99999;
    }
    grid?[x][y].have_plant = false;
    grid?[x][y].plant_name = -1;
    grid?[x][y].plant_images = null;
    grid?[x][y].growthDone = false;
    grid?[x][y].growth = 0;
    grid?[x][y].no_plant = 0;
  }
  //ที่พรวนดิน
  if (tool_on_hand == 1 && grid?[x][y].have_plant != true) {
    grid?[x][y].make_soild = true;
    grid?[x][y].floor_image(1);
    grid?[x][y].no_plant = 0;
    return;
  }
  //บัวรดน้ำ
  if (tool_on_hand == 2 &&
      grid?[x][y].make_soild == true &&
      grid?[x][y].floor != images_soil[3]) {
    grid?[x][y].floor_image(2);
    grid?[x][y].weather = 1;
    if (grid![x][y].die != true) {
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
        case 0:
          grid?[x][y].plant_images = images_plant[0];
          break;
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
          grid?[x][y].growthDone == true;
          break;
        default:
      }
    }

    return;
  }
  //ถุงเมล็ด
  if (tool_on_hand == 3 &&
      grid?[x][y].make_soild == true &&
      grid?[x][y].have_plant != true) {
    //ตรวจว่ามีเมล็ดในมือ
    if (seed_on_hand != -1) {
      int seedNum = seed_on_hand;
      seed_inventory[seedNum] -= 1;
      grid?[x][y].have_plant = true;
      grid?[x][y].plant_name = seed_on_hand;
      grid?[x][y].plant_images = images_plant[0];
      grid?[x][y].no_plant = 0;
      if (seed_inventory[seedNum] == 0) {
        seed_on_hand = -1;
      }
      grid?[x][y].growthDone = false;
      grid?[x][y].die = false;
      return;
    } else {
      return;
    }
  }
  //เคียว
  if (tool_on_hand == 4 &&
      grid?[x][y].make_soild == true &&
      grid?[x][y].have_plant == true) {
    grid?[x][y].have_plant = false;
    grid?[x][y].plant_name = -1;
    grid?[x][y].plant_images = null;
    grid?[x][y].growthDone = false;
    grid?[x][y].growth = 0;
    grid?[x][y].no_plant = 0;
  }
}
