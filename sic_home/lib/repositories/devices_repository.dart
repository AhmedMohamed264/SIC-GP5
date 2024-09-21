import 'package:dio/dio.dart';
import 'package:sic_home/apis/devices_api.dart';
import 'package:sic_home/models/create_device_model.dart';
import 'package:sic_home/models/device.dart';
import 'package:sic_home/models/update_device_model.dart';
import 'package:sic_home/repositories/interfaces/i_devices_repository.dart';

class DevicesRepository implements IDevicesRepository {
  final DevicesApi _devicesApi = DevicesApi(Dio());

  @override
  Future<int> createDevice(CreateDeviceModel device) async {
    return await _devicesApi.createDevice(device);
  }

  @override
  Future<void> deleteDevice(int id) async {
    return await _devicesApi.deleteDevice(id);
  }

  @override
  Future<Device> getDeviceById(int id) async {
    return await _devicesApi.getDevice(id);
  }

  @override
  Future<List<Device>> getDevicesByPlace(int placeId) async {
    return await _devicesApi.getDevicesByPlace(placeId);
  }

  @override
  Future<List<Device>> getDevicesBySection(int sectionId) async {
    return await _devicesApi.getDevicesBySection(sectionId);
  }

  @override
  Future<List<Device>> getDevicesByUser(String userId) async {
    return await _devicesApi.getDevicesByUser(userId);
  }

  @override
  Future<void> updateDevice(int id, UpdateDeviceModel device) async {
    return await _devicesApi.updateDevice(id, device);
  }
}
