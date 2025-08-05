@override
abstract class AppImage{
  AppImage._();
  static PngImages png = PngImages();
  static SvgImages svg = SvgImages();
  static JpgImage jpg = JpgImage();
}

class PngImages{
  static const String _pngImageBasePath = "assets/images/png/";
  final String appLogoPng = "${_pngImageBasePath}appLogo.png";
  final String userProfileError = "${_pngImageBasePath}userPlaceHolder.png";
  final String backgroundImagePng = "${_pngImageBasePath}backgroundImage.png";
  final String femalePlaceHolder = "${_pngImageBasePath}femalePlaceHolder.png";
  final String malePlaceholder = "${_pngImageBasePath}malePlaceHolder.png";
  final String brokenImage = "${_pngImageBasePath}brokenImage.png";
}

class SvgImages{
  static const String _svgImageBasePath = "assets/images/svg/";
  final String appLogo = "${_svgImageBasePath}appLogo.svg";
  final String noSearchFound = "${_svgImageBasePath}searchNotFound.svg";

}

class JpgImage {
  static const String _jpgImageBasePath = "assets/images/jpg/";

}