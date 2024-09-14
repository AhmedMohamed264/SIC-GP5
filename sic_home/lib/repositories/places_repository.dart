import 'package:dio/dio.dart';
import 'package:sic_home/apis/places_api.dart';
import 'package:sic_home/models/create_place_model.dart';
import 'package:sic_home/models/place.dart';
import 'package:sic_home/models/update_place_model.dart';
import 'package:sic_home/repositories/interfaces/i_places_repository.dart';

class PlacesRepository implements IPlacesRepository {
  final PlacesApi _placesApi = PlacesApi(Dio());

  @override
  Future<void> createPlace(CreatePlaceModel place) async {
    return await _placesApi.createPlace(place);
  }

  @override
  Future<void> deletePlace(int id) async {
    return await _placesApi.deletePlace(id);
  }

  @override
  Future<void> updatePlace(int id, UpdatePlaceModel place) async {
    return await _placesApi.updatePlace(id, place);
  }

  @override
  Future<Place> getPlaceById(int id) async {
    return await _placesApi.getPlace(id);
  }

  @override
  Future<List<Place>> getPlacesByUser(String userId) async {
    return await _placesApi.getPlacesByUser(userId);
  }
}
