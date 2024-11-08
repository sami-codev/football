
import 'package:flutter/services.dart';
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

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver{
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _setSystemUIOverlay();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    _setSystemUIOverlay();
  }

  void _setSystemUIOverlay() {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: LayoutBuilder(
        builder: (context,constraints) {
          if (constraints.maxWidth > constraints.maxHeight) {
             return landscape();
          } else {
            return potrait();
          }
        }
      ),
    );
  }
  landscape(){
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<HomeProvider>(
          builder: (context, homeProvider, child) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Row(
                children: [
                  const TeamTitleWidget(),
                  Expanded(
                      flex: 9,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.asset(
                              'assets/pitch_land.jpg',
                              fit: BoxFit.fill,

                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 30),
                            child: Row(children: [
                              Expanded(
                                  child: Row(
                                    children: [
                                      renderPlayerRowLandscape(homeProvider.home, 15, 15, 2),
                                      renderPlayerRowLandscape(homeProvider.home, 0, 4, 2),
                                      renderPlayerRowLandscape(homeProvider.home, 5, 9, 2),
                                      renderPlayerRowLandscape(homeProvider.home, 10, 14, 2),
                                    ],
                                  )),
                              Expanded(
                                  child: Row(
                                    children: [
                                      renderPlayerRowLandscape(homeProvider.away, 10, 14, 1),
                                      renderPlayerRowLandscape(homeProvider.away, 5, 9, 1),
                                      renderPlayerRowLandscape(homeProvider.away, 0, 4, 1),
                                      renderPlayerRowLandscape(homeProvider.away, 15, 15, 1),
                                    ],
                                  ))
                            ]),
                          )
                        ],
                      )),
                  Container(
                    width: MediaQuery .of(context).size.width * .15,
                    height: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(height: 25,),
                        const Text('Reserve', style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),),
                        const SizedBox(height: 10,),
                        Expanded(
                          child: Row(
                            children: [
                              renderPlayerRowLandscape(homeProvider.res, 0, 1, 0),
                              renderPlayerRowLandscape(homeProvider.res, 2, 3, 0),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              renderPlayerRowLandscape(homeProvider.res, 4, 5, 0),
                              renderPlayerRowLandscape(homeProvider.res, 6, 6, 0),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  potrait(){
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: header(),
      body: Consumer<HomeProvider>(
          builder: (context, homeProvider, child) {
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
                            fit: BoxFit.fill,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: Column(children: [
                              Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
                                    children: [
                                      renderPlayerRow(homeProvider.home, 15, 15, 2),
                                      renderPlayerRow(homeProvider.home, 0, 4, 2),
                                      renderPlayerRow(homeProvider.home, 5, 9, 2),
                                      renderPlayerRow(homeProvider.home, 10, 14, 2),
                                    ],
                                  )),
                              Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
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
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * .15,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Reserve', style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),),
                        renderPlayerRow(homeProvider.res, 0, 6, 0)
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
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
  renderPlayerRowLandscape(List<Player?> players, int start, int end, int type) {
    return Expanded(
      child: Column(
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
          ]),
    );
  }

}
