import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:plastic_punk/services/location/ip_location_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ip_location_service.g.dart';

@riverpod
IpLocationService ipLocationService(IpLocationServiceRef ref) {
  return IpLocationService.instance;
}

class IpLocationService {
  IpLocationService();

  static final instance = IpLocationService();

  IpLocationData? _cachedIpLocation;

  Future<IpLocationData?> getIpLocation() async {
    if (_cachedIpLocation != null) return _cachedIpLocation;

    try {
      // http://ip-api.com/json/
      // final Uri url = Uri.http('ip-api.com', '/json/');
      // final response = await http.get(url);

      // https://api.ipgeolocation.io/ipgeo?apiKey=API_KEY
      const apiKey = '6a96553d2aae41ad980b324d37e2bf87';
      final Uri url = Uri.https('api.ipgeolocation.io', '/ipgeo', {'apiKey': apiKey});
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is! Map<String, dynamic>) return null;
        _cachedIpLocation = IpLocationData.fromJson(data);
        return _cachedIpLocation;
      }
    } catch (_) {}
    return null;
  }
}
