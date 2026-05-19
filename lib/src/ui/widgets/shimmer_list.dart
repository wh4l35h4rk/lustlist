import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class ShimmerList extends StatelessWidget {
  const ShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Shimmer.fromColors(
          baseColor: Color.fromARGB(134, 235, 235, 235),
          highlightColor: Color.fromARGB(113, 185, 185, 185),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, _) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      height: 50,
                      width: 1,
                      decoration: const BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  color: Colors.white,
                                  width: 2.8
                              )
                          )
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 150,
                          height: 16.0,
                          color: Colors.white,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                        ),
                        Container(
                          width: double.infinity,
                          height: 16.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            itemCount: 6,
          ),
        ),
      );
  }
}