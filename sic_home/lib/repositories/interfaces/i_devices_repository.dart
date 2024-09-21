import 'package:sic_home/models/create_device_model.dart';
import 'package:sic_home/models/device.dart';
import 'package:sic_home/models/update_device_model.dart';

abstract class IDevicesRepository {
  Future<Device> getDeviceById(int id);

  Future<List<Device>> getDevicesByUser(String userId);

  Future<List<Device>> getDevicesByPlace(int placeId);

  Future<List<Device>> getDevicesBySection(int sectionId);

  Future<int> createDevice(CreateDeviceModel device);

  Future<void> updateDevice(int id, UpdateDeviceModel device);

  Future<void> deleteDevice(int id);
}
