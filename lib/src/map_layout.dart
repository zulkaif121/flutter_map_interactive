part of '../map.dart';

/// Builds a widget tree that can depend on the parent widget's size and
/// providers a map coordinates transfom helper to its children.
///
/// Similar to the [LayoutBuilder] widget.


class MapLayout extends InheritedWidget {
  final MapController controller;
  final Widget Function(BuildContext context, MapTransformer transformer) builder;

  MapLayout({
    Key? key,
    required this.controller,
    required this.builder,
    this.tileSize = 256,
  }) : super(
    key: key,
    child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final transformer = MapTransformer._internal(
          controller: controller,
          constraints: constraints,
          tileSize: tileSize,
        );
        return Stack(
          children: [
            builder.call(context, transformer),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    controller.zoomIn();
                  },
                  icon: Icon(Icons.add),
                  color: Colors.black,
                  iconSize: 28,
                ),
                SizedBox(width: 5),
                IconButton(
                  onPressed: () {
                    controller.zoomOut();
                  },
                  icon: Icon(Icons.remove),
                  color: Colors.black,
                  iconSize: 28,
                ),
              ],
            ),



          ],
        );
      },
    ),
  );

  static MapLayout? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MapLayout>();
  }

  final int tileSize;

  @override
  bool updateShouldNotify(covariant MapLayout oldWidget) {
    return oldWidget.tileSize != tileSize ||
        oldWidget.controller != controller ||
        oldWidget.builder != builder;
  }
}

