// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

class Tile extends StatefulWidget {
  final String name;
  final String price;
  const Tile({super.key, required this.name, required this.price});

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        height: expanded ? 120 : 80,
        duration: Duration(
          milliseconds: 800,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                expanded
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              // overflow: TextOverflow.ellipsis,
                            ),
                            // softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Text(
                                  "Price : ",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  widget.price,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    // overflow: TextOverflow.ellipsis,
                                  ),
                                  // softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          // overflow: TextOverflow.ellipsis,
                        ),
                        // softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      expanded = !expanded;
                    });
                  },
                  icon: Icon(
                    expanded ? Icons.arrow_upward : Icons.arrow_downward,
                    color: Colors.white,
                    size: 10,
                  ),
                )
              ],
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(20),
          // color: Color.fromRGBO(100, 120, 255, 1),
          // border: Border.all(
          //   color: Colors.white,
          //   width: 2,
          // ),
        ),
      ),
    );
  }
}
