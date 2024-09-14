import 'package:sic_home/models/create_place_model.dart';
import 'package:sic_home/models/place.dart';
import 'package:sic_home/models/update_place_model.dart';

abstract class IPlacesRepository {
  Future<Place> getPlaceById(int id);

  Future<List<Place>> getPlacesByUser(String userId);

  Future<void> createPlace(CreatePlaceModel place);

  Future<void> updatePlace(int id, UpdatePlaceModel place);

  Future<void> deletePlace(int id);
}
