import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_reserve/Components/events_card.dart';
import 'package:on_reserve/Controllers/theme_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.find();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          GetBuilder<ThemeController>(builder: (themeController) {
            return IconButton(
                onPressed: () {
                  themeController.toggle();
                },
                icon: Icon(
                    !themeController.dark ? Icons.dark_mode : Icons.sunny));
          }),
          PopupMenuButton<String>(
            onSelected: (value) {
              // handle menu item selection
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'menu_item_1',
                child: Text('Sort by Price'),
              ),
              const PopupMenuItem<String>(
                value: 'menu_item_2',
                child: Text('Sort by Date'),
              ),
              const PopupMenuItem<String>(
                value: 'menu_item_3',
                child: Text('Filter by Category'),
              ),
            ],
            icon: const Icon(Icons.more_vert),
          ),
          // IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
        title: const SafeArea(
          child: Text("OnReserve-Events",
              style: TextStyle(fontWeight: FontWeight.normal)),
        ),
      ),
      body: Column(
        children: [
          Card(
            child: TextFormField(
              controller: searchController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search...',
                border: InputBorder.none,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              child: ListView.builder(
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return const EventCard();
                  }),
            ),
          )
        ],
      ),
    );
  }
}
