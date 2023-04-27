import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class DeliverTo extends StatelessWidget {
  const DeliverTo({Key? key, required this.selectedAddress}) : super(key: key);

  final String selectedAddress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 1,
      child: Card(
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Deliver To",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: HexColor("#175244"),
                    fontSize: 18),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'images/map.png',
                    height: 100,
                    width: 100,
                    alignment: Alignment.centerLeft,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(selectedAddress,
                        softWrap: false,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16) //new
                        ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
