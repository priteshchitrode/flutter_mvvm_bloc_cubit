// String Extensions
extension StringExtensions on String? {

  /// Capitalizes the entire string, making the first letter of each word uppercase
  String get capitalize {
    if (this == null || this!.isEmpty) return '';
    return this!.split(' ').map((word) => word.capitalizeFirst).join(' ');
  }

  /// Capitalizes only the first letter of the string
  String get capitalizeFirst {
    if (this == null || this!.isEmpty) return '';
    return this![0].toUpperCase() + this!.substring(1).toLowerCase();
  }

  /// Formats vehicle number with proper spacing for display
  /// Example: "QW45TH4567" becomes "QW 45 TH 4567"
  String get formatVehicleNumberForDisplay {
    if (this == null || this!.isEmpty) return '';
    
    final vehicleNumber = this!.toUpperCase().trim();
    
    // Handle different vehicle number formats
    // Pattern 1: XX00XX0000 (e.g., QW45TH4567)
    final pattern1 = RegExp(r'^([A-Z]{2})(\d{1,2})([A-Z]{1,2})(\d{1,4})$');
    final match1 = pattern1.firstMatch(vehicleNumber);
    
    if (match1 != null) {
      final stateCode = match1.group(1)!;
      final districtCode = match1.group(2)!;
      final seriesCode = match1.group(3)!;
      final numberCode = match1.group(4)!;
      
      return '$stateCode $districtCode $seriesCode $numberCode';
    }
    
    // Pattern 2: XX00XX0000 (e.g., MH12AB1234)
    final pattern2 = RegExp(r'^([A-Z]{2})(\d{2})([A-Z]{2})(\d{4})$');
    final match2 = pattern2.firstMatch(vehicleNumber);
    
    if (match2 != null) {
      final stateCode = match2.group(1)!;
      final districtCode = match2.group(2)!;
      final seriesCode = match2.group(3)!;
      final numberCode = match2.group(4)!;
      
      return '$stateCode $districtCode $seriesCode $numberCode';
    }
    
    // Pattern 3: XX0XX0000 (e.g., DL1AB1234)
    final pattern3 = RegExp(r'^([A-Z]{2})(\d{1})([A-Z]{2})(\d{4})$');
    final match3 = pattern3.firstMatch(vehicleNumber);
    
    if (match3 != null) {
      final stateCode = match3.group(1)!;
      final districtCode = match3.group(2)!;
      final seriesCode = match3.group(3)!;
      final numberCode = match3.group(4)!;
      
      return '$stateCode $districtCode $seriesCode $numberCode';
    }
    
    // If no pattern matches, return the original string
    return vehicleNumber;
  }
}
