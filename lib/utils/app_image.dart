@override
abstract class AppImage{
  AppImage._();
  static PngImages png = PngImages();
  static SvgImages svg = SvgImages();
  static JpgImage jpg = JpgImage();
}

class PngImages{
  // Path
  static const String _pngImageBasePath = "assets/images/png/";
  // Base
  final String userPlaceHolder = "${_pngImageBasePath}user_place_holder.png";
  final String brokenImage = "${_pngImageBasePath}broken_image.png";
}

class SvgImages{
  // Path
  static const String _svgImageBasePath = "assets/images/svg/";
  // Base
  final String noSearchFound = "${_svgImageBasePath}searchNotFound.svg";

}

class JpgImage {
  // Path
  static const String _jpgImageBasePath = "assets/images/jpg/";

}