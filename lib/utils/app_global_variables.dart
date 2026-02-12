import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

// Platform
var isAndroid = Platform.isAndroid;
var isIOS = Platform.isIOS;

// Animation
var fadeAnimation = [FadeEffect(duration: 400.ms)];

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
