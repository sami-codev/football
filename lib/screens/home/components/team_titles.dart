
import 'package:flutter/material.dart';
import 'package:football/screens/home/components/toggle.dart';


class TeamTitleWidget extends StatelessWidget {
  const TeamTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints) {
        if (constraints.maxWidth > constraints.maxHeight) {
          return landscape();
        } else {
          return potrait();
        }
      }
    );
  }
  potrait(){
    return Container(
      color: Colors.black,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(
          vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Team A
          Row(
            children: [
              const Text(
                'Home',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8.0),
              const Icon(
                Icons.sports_soccer,
                color: Colors.brown,
              ),
              const SizedBox(width: 8.0),
              editIcon()
            ],
          ),
          // Team B
          Row(
            children: [
              editIcon(),
              const SizedBox(width: 8.0),
              const Icon(
                Icons.sports_soccer,
                color: Colors.blue,
              ),
              const SizedBox(width: 8.0),
              const Text(
                'Away',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
 landscape(){
    return Container(
      color: Colors.black,
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(
          vertical: 8.0, horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Team A
          Row(
            children: [
              const Text(
                'Home',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8.0),
              const Icon(
                Icons.sports_soccer,
                color: Colors.brown,
              ),
              const SizedBox(width: 8.0),
              editIcon()
            ],
          ),
          const Expanded(child: CustomToggleButton()),
          Row(
            children: [
              editIcon(),
              const SizedBox(width: 8.0),
              const Icon(
                Icons.sports_soccer,
                color: Colors.blue,
              ),
              const SizedBox(width: 8.0),
              const Text(
                'Away',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
 }
  editIcon(){
    return  const Icon(
      Icons.edit_note,
      color: Colors.white,
      size: 25,
    );
  }
}
