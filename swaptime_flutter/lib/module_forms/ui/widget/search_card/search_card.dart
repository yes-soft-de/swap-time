import 'package:flutter/material.dart';
import 'package:swaptime_flutter/module_forms/model/search_model/search_model.dart';
import 'package:swaptime_flutter/module_forms/service/rawg_service/rawg_service.dart';
import 'package:swaptime_flutter/module_theme/service/theme_service/theme_service.dart';
import 'package:swaptime_flutter/utils/icon_helper/icon_helper.dart';

class SearchCard extends StatefulWidget {
  final SearchModel searchModel;
  final bool gameActive;
  final GamePlatform platformActive;
  final Function(String name, String image) onGameSelected;
  final Function(GamePlatform) onPlatformSelected;

  SearchCard({
    this.searchModel,
    this.onGameSelected,
    this.onPlatformSelected,
    this.gameActive,
    this.platformActive,
  });

  @override
  State<StatefulWidget> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  bool active = false;
  GamePlatform selectedPlatform;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 196,
      child: GestureDetector(
        onTap: () {
          active = !active;
          if (active) {
            widget.onGameSelected(
              widget.searchModel.name,
              widget.searchModel.image,
            );
          }
          setState(() {});
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                widget.searchModel.image,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                color: Colors.black26,
              ),
            ),
            AnimatedContainer(
                duration: Duration(seconds: 1),
                child: getOverlay(widget.searchModel)),
          ],
        ),
      ),
    );
  }

  Widget getOverlay(SearchModel item) {
    if (!widget.gameActive) {
      return Positioned.fill(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.searchModel.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      );
    } else {
      return Positioned.fill(
          child: Center(
        child: Wrap(
          direction: Axis.horizontal,
          children: getPlatforms(item),
        ),
      ));
    }
  }

  List<Widget> getPlatforms(SearchModel model) {
    var flexWidgets = <Widget>[];
    model.platforms.forEach((element) {
      flexWidgets.add(GestureDetector(
        onTap: () {
          selectedPlatform = element;
          widget.onPlatformSelected(selectedPlatform);
          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: element == selectedPlatform
                  ? SwapThemeDataService.getPrimary()
                  : Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconHelper.getIcon(element),
            ),
          ),
        ),
      ));
    });

    return flexWidgets;
  }
}
