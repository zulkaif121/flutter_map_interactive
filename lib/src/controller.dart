part of '../map.dart';

class MapController extends ChangeNotifier {
  /// Creates an instance of [MapController].
  MapController({
    required LatLng location,
    double zoom = 14,
    this.projection = const EPSG4326(),
  })  : _center = location,
        _zoom = zoom;

  LatLng _center;
  double _zoom;

  /// [Projection] helps with converting [LatLng] to [TileIndex] and vice-versa.
  final Projection projection;

  /// Gets current center of the [MapLayout].
  LatLng get center {
    return _center;
  }

  /// Sets current center of the [MapLayout].
  set center(LatLng center) {
    _center = center;
    notifyListeners();
  }

  /// Gets current zoom of the [MapLayout].
  double get zoom {
    return _zoom;
  }

  /// Sets current zoom of the [MapLayout].
  set zoom(double zoom) {
    _zoom = zoom;
    notifyListeners();
  }

  /// Increases the zoom level by 1.
  void zoomIn() {
    _zoom++;
    notifyListeners();
  }

  /// Decreases the zoom level by 1.
  void zoomOut() {
    _zoom--;
    notifyListeners();
  }
}
