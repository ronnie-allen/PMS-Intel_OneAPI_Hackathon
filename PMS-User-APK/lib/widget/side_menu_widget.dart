import 'package:flutter/material.dart';
import 'package:patient_management_system/data/side_menu_data.dart';

class SideMenuWidget extends StatefulWidget {
  const SideMenuWidget({super.key});

  @override
  State<SideMenuWidget> createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  @override
  Widget build(BuildContext context) {
    final data = SideMenuData();


    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: ListView.builder(
        itemCount: data.menu.length,
        itemBuilder: (context,index) => buildMenuEntry(data,index)
        ),
    );
  }
  

  Widget buildMenuEntry(SideMenuData data, int index){
    return Row(
      children: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 7),
        child: Icon(
          data.menu[index].icon,
          color: Colors.grey,
        )
        ),
        Text(
          data.menu[index].title,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontWeight: FontWeight.normal
          ),)
      ],
    );
  }
}