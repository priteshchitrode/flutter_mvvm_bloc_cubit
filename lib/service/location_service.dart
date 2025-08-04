import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc_cubit/data/model/result.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/custom_log.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'hasInternet/has_internet_connection.dart';


class LocationService {
  LocationService._();

  // Get current position
  Future<Result<geo.Position>> getCurrentLatLong() async {
    try {
      if (HasInternetConnection.isInternet != true) {
        return Error(InternetNetworkError());
      }
      bool serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Error(ErrorWithMessage(message: "Location services are disabled."));
      }
      geo.LocationPermission permission = await geo.Geolocator.checkPermission();
      if (permission == geo.LocationPermission.denied) {
        permission = await geo.Geolocator.requestPermission();
        if (permission == geo.LocationPermission.denied) {
          return Error(ErrorWithMessage(message: "Location permission denied."));
        }
      }
      if (permission == geo.LocationPermission.deniedForever) {
        return Error(ErrorWithMessage(message: "Location permission permanently denied."));
      }
      geo.Position position = await geo.Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high,
      );
      return Success(position);
    } catch (e) {
      CustomLog.error(this, "Failed to fetch location", e);
      return Error(GenericError());
    }
  }


  // Get latitude
  Future<Result<double>> getLatitude() async {
    final result = await getCurrentLatLong();
    if (result is Success<geo.Position>) {
      return Success(result.value.latitude);
    } else {
      return Error(ErrorWithMessage(message: "Failed to get latitude."));
    }
  }


  // Get longitude
  Future<Result<double>> getLongitude() async {
    final result = await getCurrentLatLong();
    if (result is Success<geo.Position>) {
      return Success(result.value.longitude);
    } else {
      return Error(ErrorWithMessage(message: "Failed to get longitude."));
    }
  }


  // Get address from latitude & longitude
  Future<Result<String>> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      if (HasInternetConnection.isInternet != true) {
        return Error(InternetNetworkError());
      }
      List<Placemark> placeMarks = await placemarkFromCoordinates(latitude, longitude);
      debugPrint("Address : $placeMarks");
      if (placeMarks.isNotEmpty) {
        Placemark place = placeMarks.first;
        String address = "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        debugPrint("Address : $address");
        return Success(address);
      }
      return Error(ErrorWithMessage(message: "Failed to fetch address."));
    } catch (e) {
      CustomLog.error(this, "Failed to fetch address", e);
      return Error(ErrorWithMessage(message: "Failed to fetch address."));
    }
  }


  // Fetch complete location data (lat, long, address)
  Future<Result<Map<String, dynamic>>> getCurrentLatLongWithAddress() async {
    final positionResult = await getCurrentLatLong();
    if (positionResult is Success<geo.Position>) {
      final position = positionResult.value;
      final addressResult = await getAddressFromLatLng(position.latitude, position.longitude);
      if (addressResult is Success<String>) {
        return Success({
          "latitude": position.latitude,
          "longitude": position.longitude,
          "address": addressResult.value,
        });
      } else {
        return Error(ErrorWithMessage(message: "Failed to fetch complete location."));
      }
    } else {
      return Error(ErrorWithMessage(message: "Failed to fetch complete location."));
    }
  }


  Future<Result<Placemark>> getPlaceMarkFromCurrentLocation() async {
    try {
      final positionResult = await getCurrentLatLong();
      if (positionResult is Success<geo.Position>) {
        final position = positionResult.value;

        List<Placemark> placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude);
        if (placeMarks.isNotEmpty) {
          return Success(placeMarks.first);
        } else {
          return Error(ErrorWithMessage(message: "No place mark found."));
        }
      } else {
        return Error(ErrorWithMessage(message: "Failed to get current location."));
      }
    } catch (e) {
      CustomLog.error(this, "Failed to fetch place mark", e);
      return Error(ErrorWithMessage(message: "Failed to fetch place mark."));
    }
  }


}
