import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../database/user_db.dart';

class Rewarddetails extends StatefulWidget {
  const Rewarddetails({Key? key}) : super(key: key);

  @override
  State<Rewarddetails> createState() => _RewarddetailsState();
}

List<Map<String, dynamic>> usernames = [];

class _RewarddetailsState extends State<Rewarddetails> {
  late String text = '';
  late Color color = Colors.brown;
  double rewards = 0;

  UserDB udb = UserDB();

  getUser() async {
    usernames = await udb.getUserData();
    rewards = usernames[0]['rewards']!;
    color = text == 'bronze'
        ? Colors.brown
        : text == 'silver'
            ? Colors.grey
            : Colors.amberAccent;
    setState(() {});
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  List<dynamic> bronzemaindata = [
    'Rewards upto 10% of your billing amount.',
    'Buy giftcards using reward points'
  ];
  List<String> silvermaindata = [
    'Earn 1.5x rewards',
    'Free delivery on orders abover \$50.Free delivery on orders abover \$50.Free delivery on orders abover \$50.Free delivery on orders abover \$50.Free delivery on orders abover \$50.',
    'Free drink on your BirthdayFree drink on your BirthdayFree drink on your BirthdayFree drink on your BirthdayFree drink on your Birthday'
  ];
  List<String> goldmaindata = [
    'Earn 2x rewards',
    'Free delivery on all orders.',
    'Free drink on your Birthday',
    'Free drink on Every order above \$50'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: HexColor("#175244"),
        backgroundColor: Colors.white,
        title: const Text('Tier Benefits'),
      ),
      body: usernames.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      elevation: 0,
                      child: Column(
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 10),
                              child: Card(
                                color: HexColor("#175244"),
                                margin: const EdgeInsets.only(top: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                shadowColor: Colors.black,
                                elevation: 4,
                                child: SizedBox(
                                  height: 200,
                                  child: Center(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.365,
                                          ),
                                          const Icon(
                                            Icons.stars_sharp,
                                            color: Colors.brown,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.365,
                                            child: LinearProgressIndicator(
                                              // color: Colors.white,
                                              backgroundColor: Colors.white,
                                              valueColor:
                                                  const AlwaysStoppedAnimation<
                                                      Color>(Colors.brown),
                                              value: rewards < 5
                                                  ? rewards / 5
                                                  : 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Text(
                                        "Bronze",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      )
                                    ],
                                  )),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 0,
                            ),
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.all(20),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.stars_sharp,
                                    size: 30,
                                    color: Colors.brown,
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Text(
                                      "Bronze Tier",
                                      style: TextStyle(
                                        color: HexColor("#036635"),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: UnderTile(
                              maintext: bronzemaindata,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      elevation: 0,
                      child: Column(
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 10),
                              child: Card(
                                color: HexColor("#175244"),
                                margin: const EdgeInsets.only(top: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                shadowColor: Colors.black,
                                elevation: 4,
                                child: SizedBox(
                                  height: 200,
                                  child: Center(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.365,
                                            child: LinearProgressIndicator(
                                              // color: Colors.white,
                                              backgroundColor: Colors.white,
                                              valueColor:
                                                  const AlwaysStoppedAnimation<
                                                      Color>(Colors.brown),
                                              value: rewards > 5.0
                                                  ? rewards / 10.0
                                                  : 0,
                                            ),
                                          ),
                                          const Icon(Icons.stars_sharp,
                                              color: Colors.grey),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.365,
                                            child: LinearProgressIndicator(
                                              // color: Colors.white,
                                              backgroundColor: Colors.white,
                                              valueColor:
                                                  const AlwaysStoppedAnimation<
                                                      Color>(Colors.grey),
                                              value: rewards > 10.0
                                                  ? rewards / 10.0
                                                  : 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Text(
                                        "Silver",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      )
                                    ],
                                  )),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 0,
                            ),
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.all(20),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.stars_sharp,
                                    size: 30,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Text(
                                      'Silver Tier',
                                      style: TextStyle(
                                        color: HexColor("#036635"),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: UnderTile(
                              maintext: silvermaindata,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      elevation: 0,
                      child: Column(
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 10),
                              child: Card(
                                color: HexColor("#175244"),
                                margin: const EdgeInsets.only(top: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                shadowColor: Colors.black,
                                elevation: 4,
                                child: SizedBox(
                                  height: 200,
                                  child: Center(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.365,
                                            child: LinearProgressIndicator(
                                              // color: Colors.white,
                                              backgroundColor: Colors.white,
                                              valueColor:
                                                  const AlwaysStoppedAnimation<
                                                      Color>(Colors.grey),
                                              value: rewards > 15.0
                                                  ? rewards / 20.0
                                                  : 0,
                                            ),
                                          ),
                                          const Icon(Icons.stars_sharp,
                                              color: Colors.amberAccent),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.365,
                                          )
                                        ],
                                      ),
                                      const Text(
                                        "Gold",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      )
                                    ],
                                  )),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 0,
                            ),
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.all(20),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.stars_sharp,
                                    size: 30,
                                    color: Colors.amberAccent,
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Text(
                                      "Gold Tier",
                                      style: TextStyle(
                                        color: HexColor("#036635"),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: UnderTile(
                              maintext: goldmaindata,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class UnderTile extends StatelessWidget {
  const UnderTile({
    Key? key,
    required this.maintext,
  }) : super(key: key);

  final List maintext;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemCount: maintext.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: ListTile(
              title: Text(
                maintext[index],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {},
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            thickness: 2,
          );
        });
  }
}
