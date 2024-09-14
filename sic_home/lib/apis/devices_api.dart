import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:sic_home/config.dart';
import 'package:sic_home/models/create_device_model.dart';
import 'package:sic_home/models/device.dart';
import 'package:sic_home/models/update_device_model.dart';

part 'devices_api.g.dart';

@RestApi(baseUrl: '${Config.baseUrl}/Devices/')
abstract class DevicesApi {
  factory DevicesApi(Dio dio) = _DevicesApi;

  @GET('{id}')
  Future<Device> getDevice(
    @Path('id') int id,
  );

  @GET('User/{userId}')
  Future<List<Device>> getDevicesByUser(
    @Path('userId') String userId,
  );

  @GET('Place/{placeId}')
  Future<List<Device>> getDevicesByPlace(
    @Path('placeId') int placeId,
  );

  @GET('Section/{sectionId}')
  Future<List<Device>> getDevicesBySection(
    @Path('sectionId') int sectionId,
  );

  @POST('')
  Future<void> createDevice(
    @Body() CreateDeviceModel device,
  );

  @PUT('{id}')
  Future<void> updateDevice(
    @Path('id') int id,
    @Body() UpdateDeviceModel device,
  );

  @DELETE('{id}')
  Future<void> deleteDevice(
    @Path('id') int id,
  );
}
