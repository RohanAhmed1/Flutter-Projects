// import 'dart:io';

import 'package:get_ip_address/get_ip_address.dart';

class Network {
  static getLocalIPAddress() async {
    try {
    /// Initialize Ip Address
    var ipAddress = IpAddress(type: RequestType.json);

    /// Get the IpAddress based on requestType.
    dynamic data = await ipAddress.getIpAddress();
    return data.toString();
  } on IpAddressException catch (exception) {
    /// Handle the exception.
    print(exception.message);
  }
  }
  /*
  static Future<String?> getLocalIpAddress() async {
    final interfaces = await NetworkInterface.list(type: InternetAddressType.IPv4, includeLinkLocal: true);

    try {
      // Try VPN connection first
      NetworkInterface vpnInterface = interfaces.firstWhere((element) => element.name == "tun0");
      return vpnInterface.addresses.first.address;
    } on StateError {
      // Try wlan connection next
      try {
        NetworkInterface interface = interfaces.firstWhere((element) => element.name == "wlan0");
        print(interface.addresses);
        return interface.addresses.first.address;
      } catch (ex) {
        // Try any other connection next
        try {
          NetworkInterface interface = interfaces.firstWhere((element) => !(element.name == "tun0" || element.name == "wlan0"));
          return interface.addresses.first.address;
        } catch (ex) {
          return null;
        }
      }
    }
    
  }
  */
}
