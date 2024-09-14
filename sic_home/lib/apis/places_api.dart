import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:sic_home/config.dart';
import 'package:sic_home/models/create_place_model.dart';
import 'package:sic_home/models/place.dart';
import 'package:sic_home/models/update_place_model.dart';

part 'places_api.g.dart';

@RestApi(baseUrl: '${Config.baseUrl}/Places/')
abstract class PlacesApi {
  factory PlacesApi(Dio dio) = _PlacesApi;

  @GET('{id}')
  Future<Place> getPlace(
    @Path('id') int id,
  );

  @GET('User/{userId}')
  Future<List<Place>> getPlacesByUser(
    @Path('userId') String userId,
  );

  @POST('')
  Future<void> createPlace(
    @Body() CreatePlaceModel place,
  );

  @PUT('{id}')
  Future<void> updatePlace(
    @Path('id') int id,
    @Body() UpdatePlaceModel place,
  );

  @DELETE('{id}')
  Future<void> deletePlace(
    @Path('id') int id,
  );
}
