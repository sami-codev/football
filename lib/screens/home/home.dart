import 'package:football/providers/home.dart';
import 'package:provider/provider.dart';

import '../../models/player.dart';
import 'package:flutter/material.dart';

import 'components/empty_slot.dart';
import 'components/player.dart';
import 'components/team_titles.dart';
import 'components/toggle.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: header(),
        body: Consumer<HomeProvider>(builder: (context, homeProvider, child) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                const TeamTitleWidget(),
                Expanded(
                    flex: 9,
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/pitch.jpg',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: Column(children: [
                            Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    renderPlayerRow(homeProvider.home, 15, 15, 2),
                                    renderPlayerRow(homeProvider.home, 0, 4, 2),
                                    renderPlayerRow(homeProvider.home, 5, 9, 2),
                                    renderPlayerRow(homeProvider.home, 10, 14, 2),
                                  ],
                                )),
                            Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    renderPlayerRow(homeProvider.away, 10, 14, 1),
                                    renderPlayerRow(homeProvider.away, 5, 9, 1),
                                    renderPlayerRow(homeProvider.away, 0, 4, 1),
                                    renderPlayerRow(homeProvider.away, 15, 15, 1),
                                  ],
                                ))
                          ]),
                        )
                      ],
                    )),
                Container(
                  height: MediaQuery.of(context).size.height*.1,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Reserve',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      renderPlayerRow(homeProvider.res, 0, 6, 0)
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
  header(){
    return AppBar(
      backgroundColor: Colors.black,
      leading: const Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
      actions: [
        Stack(
          children: [
            const Icon(
              Icons.notifications_outlined,
              color: Colors.white,
            ),
            Positioned(
                right: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.cyan),
                ))
          ],
        ),
        const SizedBox(
          width: 20,
        ),
        const Icon(Icons.chat_outlined, color: Colors.white),
        const SizedBox(
          width: 20,
        ),
        const Icon(Icons.more_vert, color: Colors.white),
        const SizedBox(
          width: 20,
        ),
      ],
      bottom:  PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Column(
          children: [
            const TabBar(
              isScrollable: false,
              indicatorColor: Colors.cyan,
              indicatorWeight: 3.0,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              tabs: [
                Tab(text: 'SUMMARY'),
                Tab(text: 'AVAILABILITY'),
                Tab(text: 'LINEUP'),
                Tab(text: 'PAYMENTS'),
              ],
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey,
            ),
            const CustomToggleButton()
          ],
        ),
      ),
    );
  }
  renderPlayerRow(List<Player?> players, int start, int end, int type) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
      for (int i = start; i <= end; i++)
        Expanded(
            child: Center(
          child: players[i] == null
              ? EmptyPosition(
                  onAcceptPlayer: (player) {
                    context.read<HomeProvider>().emptyFill(
                        player,
                        i,
                        type == 0
                            ? PlayerType.substitute
                            : type == 1
                                ? PlayerType.away
                                : PlayerType.home);
                  },
                )
              : DraggablePlayer(
                  player: players[i]!,
                  onAccept: (incomingPlayer) {
                    context
                        .read<HomeProvider>()
                        .playerSwap(incomingPlayer, players[i]!, i);
                  }),
        ))
    ]);
  }
}
