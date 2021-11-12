import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:opencv/opencv.dart';
import 'package:opencv_application/app/modules/home/services/home_service.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  @observable
  String platformVersion = 'Unknown';
  @observable
  dynamic res;
  @observable
  File image;
  @observable
  Image processedImage;
  @observable
  File file;
  @observable
  bool preloaded = false;
  @observable
  bool loaded = false;
  @observable
  HomeState state = HomeState.init;

  final TextEditingController controllerFilters = new TextEditingController();
  final TextEditingController controllerURLImage = new TextEditingController();
  final ImagePicker picker = ImagePicker();
  final List<String> filters = <String>[
    'Nenhum',
    'blur',
    'GaussianBlur',
    'medianBlur',
    'bilateralFilter',
    'boxFilter',
    'sqrBoxFilter',
    'filter2D',
    'dilate',
    'erode',
    'morphologyEx',
    'pyrUp',
    'pyrDown',
    'pyrMeanShiftFiltering',
    'threshold',
    'adaptiveThreshold',
    'copyMakeBorder',
    'sobel',
    'scharr',
    'laplacian',
    'distanceTransform',
    'resize',
    'applyColorMap',
    'houghLines',
    'houghLinesProbabilistic',
    'houghCircles',
    'warpPerspectiveTransform',
    'grabCut'
  ];

  @action
  Future<void> init() async {
    try {
      platformVersion = await OpenCV.platformVersion;
      state = HomeState.ready;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
      state = HomeState.error;
    }
  }

  @action
  Future<void> applyFilter(String selectedFilter) async {
    controllerFilters.text = selectedFilter;
    if (image != null && state == HomeState.readyToProcess) {
      state = HomeState.loading;
      if (selectedFilter == "Nenhum") {
        processedImage = Image.file(image);
      } else {
        try {
          dynamic newImage = await HomeService.applyFilter(
            image: image,
            selectedFilter: selectedFilter,
          );
          processedImage = Image.memory(newImage);
          state = HomeState.processed;
        } catch (e) {
          state = HomeState.errorProcess;
          processedImage = null;
          print(e);
        }
      }
    }
  }

  @action
  Future<void> loadImageFromGallery() async {
    try {
      final pickedImage = await picker.getImage(source: ImageSource.gallery);
      image = File(pickedImage.path);
      state = HomeState.readyToProcess;
    } catch (e) {
      state = HomeState.erroLoadImage;
      image = null;
    }
  }

  @action
  Future<void> loadImageFromCamera() async {
    try {
      final pickedImage = await picker.getImage(source: ImageSource.camera);
      image = File(pickedImage.path);
      state = HomeState.readyToProcess;
    } catch (e) {
      state = HomeState.erroLoadImage;
      image = null;
    }
  }
}

enum HomeState {
  init,
  loading,
  error,
  readyToProcess,
  ready,
  processed,
  errorProcess,
  erroLoadImage
}
