import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:neat/Screens/chat/widgets/emojis_services.dart';

import 'package:neat/utlis/constants/colors.dart';

class EmojisWidget extends StatefulWidget {
  final Function addEmojiToTextController;

  const EmojisWidget({super.key, required this.addEmojiToTextController});

  @override
  State<EmojisWidget> createState() => _EmojisWidgetState();
}

class _EmojisWidgetState extends State<EmojisWidget>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  EmojisServices emojisServices = EmojisServices();
  Map<Category, List<Emoji>> emojiMap = {};

  List<Emoji> smileyEmojis = [];
  List<Emoji> petEmojis = [];
  List<Emoji> foodEmojis = [];
  List<Emoji> sportsEmojis = [];
  List<Emoji> vehiclesEmojis = [];
  List<Emoji> objectsEmojis = [];
  List<Emoji> toolsEmojis = [];
  List<Emoji> flagsEmojis = [];

  @override
  void initState() {
    tabController = TabController(length: 8, vsync: this);

    for (var emojiSet in defaultEmojiSet) {
      emojisServices.getCategoryEmojis(category: emojiSet).then((e) async =>
      await emojisServices.filterUnsupported(data: [e]).then((filtered) {
        for (var element in filtered) {
          switch (emojiSet.category) {
            case Category.SMILEYS:
              setState(() {
                smileyEmojis = element.emoji;
              });
              break;
            case Category.ANIMALS:
              setState(() {
                petEmojis = element.emoji;
              });
              break;
            case Category.FOODS:
              setState(() {
                foodEmojis = element.emoji;
              });
              break;
            case Category.ACTIVITIES:
              setState(() {
                sportsEmojis = element.emoji;
              });
              break;
            case Category.TRAVEL:
              setState(() {
                vehiclesEmojis = element.emoji;
              });
              break;
            case Category.SYMBOLS:
              setState(() {
                toolsEmojis = element.emoji;
              });
              break;
            case Category.OBJECTS:
              setState(() {
                objectsEmojis = element.emoji;
              });
              break;
            case Category.FLAGS:
              setState(() {
                flagsEmojis = element.emoji;
              });
              break;
            default:
          }
        }
      }));
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
        right: 5,
        bottom: 5,
      ),
      child: Container(
        height: MediaQuery
            .of(context)
            .size
            .height * 0.4,
        decoration: BoxDecoration(
          color: TColors.backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            TabBar(
                controller: tabController,
                isScrollable: false,
                labelColor: TColors.primaryColor,
                indicatorSize: TabBarIndicatorSize.label,

                unselectedLabelColor: TColors.primaryColor.withOpacity(0.6),
                tabs: [
                  Icon(Icons.emoji_emotions_outlined),
                  Icon(Ionicons.paw),
                  Icon(Ionicons.fast_food),
                  Icon(Ionicons.football),
                  Icon(Ionicons.boat),
                  Icon(Ionicons.bulb),
                  Icon(Icons.emoji_symbols_rounded),
                  Icon(Ionicons.flag),
                ]),
            Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    buildEmojis(emojis: smileyEmojis),
                    buildEmojis(emojis: petEmojis),
                    buildEmojis(emojis: foodEmojis),
                    buildEmojis(emojis: sportsEmojis),
                    buildEmojis(emojis: vehiclesEmojis),
                    buildEmojis(emojis: objectsEmojis),
                    buildEmojis(emojis: toolsEmojis),
                    buildEmojis(emojis: flagsEmojis),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget buildEmojis({required List<Emoji> emojis}) {
    return emojis.isEmpty
        ? Center(
      child: CircularProgressIndicator(),
    )
        : GridView.builder(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        itemCount: emojis.length,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
        itemBuilder: (context, index) {
          Emoji emoji = emojis[index];
          return Center(
            child: GestureDetector(
              onTap: () {
                widget.addEmojiToTextController(emoji: emoji);
              },
              child: Text(
                emoji.emoji,
                style: TextStyle(color: TColors.primaryColor, fontSize: 32),
              ),
            ),
          );
        });
  }
}
