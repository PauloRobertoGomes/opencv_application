import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:opencv/opencv.dart';
import 'package:opencv/core/core.dart';

part 'home_service.g.dart';

@Injectable()
class HomeService extends Disposable {
  //dispose will be called automatically

  static Future<dynamic> applyFilter(
      {String selectedFilter, File image}) async {
    dynamic res;
    try {
      switch (selectedFilter) {
        case 'blur':
          res = await ImgProc.blur(await image.readAsBytes(), [45, 45],
              [20, 30], Core.borderReflect);
          break;
        case 'GaussianBlur':
          res = await ImgProc.gaussianBlur(
              await image.readAsBytes(), [45, 45], 0);
          break;
        case 'medianBlur':
          res = await ImgProc.medianBlur(await image.readAsBytes(), 45);
          break;
        case 'bilateralFilter':
          res = await ImgProc.bilateralFilter(
              await image.readAsBytes(), 15, 80, 80, Core.borderConstant);
          break;
        case 'boxFilter':
          res = await ImgProc.boxFilter(await image.readAsBytes(), 50, [45, 45],
              [-1, -1], true, Core.borderConstant);
          break;
        case 'sqrBoxFilter':
          res =
              await ImgProc.sqrBoxFilter(await image.readAsBytes(), -1, [1, 1]);
          break;
        case 'filter2D':
          res = await ImgProc.filter2D(await image.readAsBytes(), -1, [2, 2]);
          break;
        case 'dilate':
          res = await ImgProc.dilate(await image.readAsBytes(), [2, 2]);
          break;
        case 'erode':
          res = await ImgProc.erode(await image.readAsBytes(), [2, 2]);
          break;
        case 'morphologyEx':
          res = await ImgProc.morphologyEx(
              await image.readAsBytes(), ImgProc.morphTopHat, [5, 5]);
          break;
        case 'pyrUp':
          res = await ImgProc.pyrUp(await image.readAsBytes(),
              [563 * 2, 375 * 2], Core.borderDefault);
          break;
        case 'pyrDown':
          res = await ImgProc.pyrDown(await image.readAsBytes(),
              [563 ~/ 2.toInt(), 375 ~/ 2.toInt()], Core.borderDefault);
          break;
        case 'pyrMeanShiftFiltering':
          res = await ImgProc.pyrMeanShiftFiltering(
              await image.readAsBytes(), 10, 15);
          break;
        case 'threshold':
          res = await ImgProc.threshold(
              await image.readAsBytes(), 80, 255, ImgProc.threshBinary);
          break;
        case 'adaptiveThreshold':
          res = await ImgProc.adaptiveThreshold(await image.readAsBytes(), 125,
              ImgProc.adaptiveThreshMeanC, ImgProc.threshBinary, 11, 12);
          break;
        case 'copyMakeBorder':
          res = await ImgProc.copyMakeBorder(
              await image.readAsBytes(), 20, 20, 20, 20, Core.borderConstant);
          break;
        case 'sobel':
          res = await ImgProc.sobel(await image.readAsBytes(), -1, 1, 1);
          break;
        case 'scharr':
          res = await ImgProc.scharr(
              await image.readAsBytes(), ImgProc.cvSCHARR, 0, 1);
          break;
        case 'laplacian':
          res = await ImgProc.laplacian(await image.readAsBytes(), 10);
          break;
        case 'distanceTransform':
          res = await ImgProc.threshold(
              await image.readAsBytes(), 80, 255, ImgProc.threshBinary);
          res = await ImgProc.distanceTransform(await res, ImgProc.distC, 3);
          break;
        case 'resize':
          res = await ImgProc.resize(
              await image.readAsBytes(), [500, 500], 0, 0, ImgProc.interArea);
          break;
        case 'applyColorMap':
          res = await ImgProc.applyColorMap(
              await image.readAsBytes(), ImgProc.colorMapHot);
          break;
        case 'houghLines':
          res = await ImgProc.canny(await image.readAsBytes(), 50, 200);
          res = await ImgProc.houghLines(await res,
              threshold: 300, lineColor: "#ff0000");
          break;
        case 'houghLinesProbabilistic':
          res = await ImgProc.canny(await image.readAsBytes(), 50, 200);
          res = await ImgProc.houghLinesProbabilistic(await res,
              threshold: 50,
              minLineLength: 50,
              maxLineGap: 10,
              lineColor: "#ff0000");
          break;
        case 'houghCircles':
          res = await ImgProc.cvtColor(await image.readAsBytes(), 6);
          res = await ImgProc.houghCircles(await res,
              method: 3,
              dp: 2.1,
              minDist: 0.1,
              param1: 150,
              param2: 100,
              minRadius: 0,
              maxRadius: 0);
          break;
        case 'warpPerspectiveTransform':
          res = await ImgProc.warpPerspectiveTransform(
              await image.readAsBytes(),
              sourcePoints: [113, 137, 260, 137, 138, 379, 271, 340],
              destinationPoints: [0, 0, 612, 0, 0, 459, 612, 459],
              outputSize: [612, 459]);
          break;
        case 'grabCut':
          res = await ImgProc.grabCut(await image.readAsBytes(),
              px: 0, py: 0, qx: 400, qy: 400, itercount: 1);
          break;
        default:
          print("No function selected");
          break;
      }
    } on PlatformException {
      res = 'Failed to get platform version.';
    }
    return res;
  }

  @override
  void dispose() {}
}
