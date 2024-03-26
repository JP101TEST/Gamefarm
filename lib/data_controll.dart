import 'package:shared_preferences/shared_preferences.dart';

import 'grid_controll.dart';

//data display
double? display_width;
double? display_height;
//data
int grid_x = 6; // Number of rows
int grid_y = 10; // Number of columns
List<List<PlantationArea>>? grid;
String? output;
/*
tool_on_hand
-0 = มือ
-1 = ที่พรวนดิน
-2 = บัวรดน้ำ
-3 = ถุงปลูก
-4 = เคียว
*/
int tool_on_hand = 0;
/*
-0 = เมล็ดข้าว
-1 = เมล็ดผลไม้
*/
int seed_on_hand = -1;

int coind = 200;

bool seed_bag_page = false; //หน้า ถงเมล็ด
bool market_page = false; //หน้า ตลาด
bool sleep = false;
double openeye = 1;
bool music_setting = true;
bool restart_page = false; //หน้า restart
/*
0 wheat
1 fruit
*/
List<int> seed_inventory = [0, 0];

//data debugging
bool show_grid = false;

//data assets
List<String> images_soil = [
  'assets/images/gass_1.png',
  'assets/images/soil_1.png',
  'assets/images/soil_2.png',
  'assets/images/soil_have_gass.png'
];

List<String> images_plant = [
  'assets/images/seed_on.png', //0 -> seed
  'assets/images/plant_1-01.png', //1 -> wheat-1
  'assets/images/plant_1-02.png', //2 -> wheat-2
  'assets/images/plant_1-03.png', //3 -> wheat-3
  'assets/images/plant_1-04.png', //4 -> wheat-4
  'assets/images/plant_2-01.png', //5 -> fruit-1
  'assets/images/plant_2-02.png', //6 -> fruit-2
  'assets/images/plant_2-03.png', //7 -> fruit-3
  'assets/images/plant_2-04.png', //8 -> fruit-4
  'assets/images/need_water.png', //9 -> neew water
  'assets/images/die.png', //10 -> ide
  'assets/images/plant_1_done.png', //11
  'assets/images/plant_2_done.png', //12
  'assets/images/seed_1.png', //13
  'assets/images/seed_2.png', //14
  'assets/images/seed_1_c.png', //15
  'assets/images/seed_2_c.png' //16
];

//0-4 are 5-9
List<String> images_tool = [
  'assets/images/tool_0.png', //0
  'assets/images/tool_1.png', //1
  'assets/images/tool_2.png', //2
  'assets/images/tool_3.png', //3
  'assets/images/tool_4.png', //4
  'assets/images/tool_0_c.png', //5
  'assets/images/tool_1_c.png', //6
  'assets/images/tool_2_c.png', //7
  'assets/images/tool_3_c.png', //8
  'assets/images/tool_4_c.png', //9
  'assets/images/market.png', //10
  'assets/images/sleep.png', //11
  'assets/images/sound_on.png', //12
  'assets/images/sound_off.png', //13
  'assets/images/close.png', //14
  'assets/images/unclose.png', //15
  'assets/images/restart.png' //16
];

List<String> sounds_list = ['StardewValleyOverture.mp3'];

// Saving data
Future<void> saveData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('key', 'value-85');
}

// Retrieving data
Future<String?> getData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('key');
}
