import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:sic_home/models/create_section_model.dart';
import 'package:sic_home/models/section.dart';
import 'package:sic_home/models/update_section_model.dart';

part 'sections_api.g.dart';

@RestApi()
abstract class SectionsApi {
  factory SectionsApi(Dio dio) = _SectionsApi;

  @GET('/{id}')
  Future<Section> getSection(
    @Path('id') int id,
  );

  @GET('/User/{userId}')
  Future<List<Section>> getSectionsByUser(
    @Path('userId') String userId,
  );

  @GET('/Place/{placeId}')
  Future<List<Section>> getSectionsByPlace(
    @Path('placeId') int placeId,
  );

  @POST('/')
  Future<void> createSection(
    @Body() CreateSectionModel section,
  );

  @PUT('/{id}')
  Future<void> updateSection(
    @Path('id') int id,
    @Body() UpdateSectionModel section,
  );

  @DELETE('/{id}')
  Future<void> deleteSection(
    @Path('id') int id,
  );
}
