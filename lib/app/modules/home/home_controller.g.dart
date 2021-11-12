// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $HomeController = BindInject(
  (i) => HomeController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$platformVersionAtom =
      Atom(name: '_HomeControllerBase.platformVersion');

  @override
  String get platformVersion {
    _$platformVersionAtom.reportRead();
    return super.platformVersion;
  }

  @override
  set platformVersion(String value) {
    _$platformVersionAtom.reportWrite(value, super.platformVersion, () {
      super.platformVersion = value;
    });
  }

  final _$resAtom = Atom(name: '_HomeControllerBase.res');

  @override
  dynamic get res {
    _$resAtom.reportRead();
    return super.res;
  }

  @override
  set res(dynamic value) {
    _$resAtom.reportWrite(value, super.res, () {
      super.res = value;
    });
  }

  final _$imageAtom = Atom(name: '_HomeControllerBase.image');

  @override
  File get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(File value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  final _$processedImageAtom = Atom(name: '_HomeControllerBase.processedImage');

  @override
  Image get processedImage {
    _$processedImageAtom.reportRead();
    return super.processedImage;
  }

  @override
  set processedImage(Image value) {
    _$processedImageAtom.reportWrite(value, super.processedImage, () {
      super.processedImage = value;
    });
  }

  final _$fileAtom = Atom(name: '_HomeControllerBase.file');

  @override
  File get file {
    _$fileAtom.reportRead();
    return super.file;
  }

  @override
  set file(File value) {
    _$fileAtom.reportWrite(value, super.file, () {
      super.file = value;
    });
  }

  final _$preloadedAtom = Atom(name: '_HomeControllerBase.preloaded');

  @override
  bool get preloaded {
    _$preloadedAtom.reportRead();
    return super.preloaded;
  }

  @override
  set preloaded(bool value) {
    _$preloadedAtom.reportWrite(value, super.preloaded, () {
      super.preloaded = value;
    });
  }

  final _$loadedAtom = Atom(name: '_HomeControllerBase.loaded');

  @override
  bool get loaded {
    _$loadedAtom.reportRead();
    return super.loaded;
  }

  @override
  set loaded(bool value) {
    _$loadedAtom.reportWrite(value, super.loaded, () {
      super.loaded = value;
    });
  }

  final _$stateAtom = Atom(name: '_HomeControllerBase.state');

  @override
  HomeState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(HomeState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$initAsyncAction = AsyncAction('_HomeControllerBase.init');

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  final _$applyFilterAsyncAction =
      AsyncAction('_HomeControllerBase.applyFilter');

  @override
  Future<void> applyFilter(String selectedFilter) {
    return _$applyFilterAsyncAction
        .run(() => super.applyFilter(selectedFilter));
  }

  final _$loadImageFromGalleryAsyncAction =
      AsyncAction('_HomeControllerBase.loadImageFromGallery');

  @override
  Future<void> loadImageFromGallery() {
    return _$loadImageFromGalleryAsyncAction
        .run(() => super.loadImageFromGallery());
  }

  final _$loadImageFromCameraAsyncAction =
      AsyncAction('_HomeControllerBase.loadImageFromCamera');

  @override
  Future<void> loadImageFromCamera() {
    return _$loadImageFromCameraAsyncAction
        .run(() => super.loadImageFromCamera());
  }

  @override
  String toString() {
    return '''
platformVersion: ${platformVersion},
res: ${res},
image: ${image},
processedImage: ${processedImage},
file: ${file},
preloaded: ${preloaded},
loaded: ${loaded},
state: ${state}
    ''';
  }
}
