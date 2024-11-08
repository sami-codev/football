import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomToggleButton extends StatefulWidget {
  const CustomToggleButton({super.key});

  @override
  _CustomToggleButtonState createState() => _CustomToggleButtonState();
}

class _CustomToggleButtonState extends State<CustomToggleButton> {
  int type=0;

  void toggleView(int newType) {
    setState(() {
      type = newType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      padding: const EdgeInsets.all(6.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.15),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                 toggleView(0);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                decoration: BoxDecoration(
                  color: type==0 ? Colors.white.withOpacity(.2)  :Colors.transparent,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: const Center(
                  child: Text(
                    'Pitch View',
                    style: TextStyle(
                      color:Colors.white ,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                toggleView(1);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                decoration: BoxDecoration(
                  color: type==1 ?Colors.white.withOpacity(.2) :Colors.transparent,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: const Center(
                  child: Text(
                    'List View',
                    style: TextStyle(
                      color: Colors.white ,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
