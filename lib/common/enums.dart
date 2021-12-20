enum SortOption {
  experienceHighToLow,
  experienceLowToHigh,
  priceHighToLow,
  priceLowToHigh,
}

extension SortOptionExtension on SortOption {
  String get name {
    return [
      'Experience high to low',
      'Experience low to high',
      'Price high to low',
      'Price low to high',
    ][index];
  }
}
