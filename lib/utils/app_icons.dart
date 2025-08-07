@override
class AppIcons {
  AppIcons._();
  static PngIcons png = PngIcons();
  static SvgIcons svg = SvgIcons();
  static GifIcons gif = GifIcons();
}

/// PNG Icons
class PngIcons {
  // Path
  static const String _pngBasePath = "assets/icons/png/";
  // Base
  final String brokenImage = "${_pngBasePath}image_break.png";

}

/// GIF Icons
class GifIcons {
  static const String _gifBasePath = "assets/icons/gif/";
}

/// SVG Icons
class SvgIcons {
  // Path
  static const String _svgBasePath = "assets/icons/svg/";
  // Base
  final String search = "${_svgBasePath}search.svg";
  final String goBack = "${_svgBasePath}go_back.svg";
  final String galleryAdd = "${_svgBasePath}gallery_add.svg";
  final String camera = "${_svgBasePath}camera.svg";
  final String gallery = "${_svgBasePath}gallery.svg";
  final String clearOutline = "${_svgBasePath}clear_outline.svg";
  final String closeCircleOutline = "${_svgBasePath}close_circle_outline.svg";
  final String documentUpload = "${_svgBasePath}document_upload.svg";
  final String forwardArrowOutline = "${_svgBasePath}forward_arrow_outline.svg";
  final String notificationOutline = "${_svgBasePath}notification_outline.svg";
  final String searchOutline = "${_svgBasePath}search_outline.svg";
}

