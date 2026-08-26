import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/model/admin/admin_course.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../model/course.dart';
import '../../model/response_status.dart';
import '../base_controlller.dart';

class AdminCoursesController extends BaseController {
  List<AdminCourse> courses = [];

  final TextEditingController searchController = TextEditingController();

  int currentPage = 1;
  int lastPage = 1;

  bool isLoadingMore = false;
  bool isExporting = false;

  @override
  void onInit() {
    getCourses();
    super.onInit();
  }

  Future<void> getCourses({bool refresh = true}) async {
    if (refresh) {
      currentPage = 1;
      courses.clear();
      update();
    }

    final value = await networkCaller(
      restClient.adminCourses(
        perPage: 20,
      ),
      withLoading: refresh
    );

    if (value.status == ResponseStatus.success && value.data != null) {
      final paginated = value.data!;

      lastPage = paginated.lastPage;

      List<AdminCourse> loadedCourses = paginated.data;

      if (searchController.text.trim().isNotEmpty) {
        loadedCourses = loadedCourses.where((course) {
          return course.name.toLowerCase().contains(
            searchController.text.trim().toLowerCase(),
          );
        }).toList();
      }

      if (refresh) {
        courses = loadedCourses;
      } else {
        courses.addAll(loadedCourses);
      }

      update();
    } else if (error != null) {
      errorHandling(error!);
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore || currentPage >= lastPage) return;

    isLoadingMore = true;
    update();

    currentPage++;

    await getCourses(refresh: false);

    isLoadingMore = false;
    update();
  }

  void search(String value) {
    getCourses(refresh: true);
  }

  Future<void> deleteCourse(AdminCourse course) async {
    final value = await networkCaller(
      restClient.adminDeleteCourse(course.id),
    );

    if (value.status == ResponseStatus.success) {
      courses.removeWhere((e) => e.id == course.id);
      update();
    } else if (error != null) {
      errorHandling(error!);
    }
  }

  Future<void> exportCoursesExcel() async {
    if (isExporting) return;

    isExporting = true;
    update();

    return restClient.adminCoursesExcel().then((value) async {
      if (value.data != null) {
        Directory directory = await getApplicationDocumentsDirectory();

        File file = File(
          '${directory.path}/Users ${DateTime.now().millisecondsSinceEpoch}.xlsx',
        );

        await file.writeAsBytes(value.data);
        OpenFile.open(file.path);
      }

      isExporting = false;
      update();
    }).catchError((e) {
      isExporting = false;
      update();
      errorHandling(e);
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}