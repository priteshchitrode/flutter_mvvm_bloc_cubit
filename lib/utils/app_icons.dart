@override
class AppIcons {
  AppIcons._();
  static PngIcons png = PngIcons();
  static SvgIcons svg = SvgIcons();
  static GifIcons gif = GifIcons();
}

/// PNG Icons
class PngIcons {
  // Base
  static const String _pngBasePath = "assets/icons/png/";
  final String brokenImage = "${_pngBasePath}imageBreak.png";

}

/// GIF Icons
class GifIcons {
  static const String _gifBasePath = "assets/icons/gif/";
}

/// SVG Icons
class SvgIcons {
  // Base
  static const String _svgBasePath = "assets/icons/svg/";
  final String search = "${_svgBasePath}search.svg";
  final String goBack = "${_svgBasePath}goBack.svg";
  final String galleryAdd = "${_svgBasePath}galleryAdd.svg";
  final String camera = "${_svgBasePath}camera.svg";
  final String gallery = "${_svgBasePath}gallery.svg";
  final String clearOutline = "${_svgBasePath}clearOutline.svg";

  // App
  final String searchOutline = "${_svgBasePath}searchOutline.svg";
  final String searchFill = "${_svgBasePath}searchFill.svg";
  final String notificationOutline = "${_svgBasePath}notificationOutline.svg";
}

