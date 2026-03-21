enum AppImage {
  appIcon('app_icon'); 
  final String filename;
  const AppImage(this.filename);

  String get path =>
      'assets/images/$filename.png';
}
