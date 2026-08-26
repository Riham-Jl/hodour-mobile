import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../../model/admin/admin_user.dart';
import '../../model/response_status.dart';
import '../base_controlller.dart';

class AdminUsersController extends BaseController {
  List<AdminUser> users = [];

  final TextEditingController searchController = TextEditingController();

  int currentPage = 1;
  int lastPage = 1;

  bool isLoadingMore = false;
  bool isExporting = false;

  @override
  void onInit() {
    getUsers();
    super.onInit();
  }

  Future<void> getUsers({bool refresh = true}) async {
    if (refresh) {
      currentPage = 1;
      users.clear();
      update();
    }

    final value = await networkCaller(
      restClient.adminUsers(
        page: currentPage,
        perPage: 20,
        search: searchController.text.trim().isEmpty
            ? null
            : searchController.text.trim(),
      ),
      withLoading: refresh
    );

    if (value.status == ResponseStatus.success && value.data != null) {
      final paginated = value.data!;

      lastPage = paginated.lastPage;

      if (refresh) {
        users = paginated.data;
      } else {
        users.addAll(paginated.data);
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
    await getUsers(refresh: false);

    isLoadingMore = false;
    update();
  }

  void search(String value) {
    getUsers(refresh: true);
  }

  Future<bool> addUser(Map<String, dynamic> body) async {
    final value = await networkCaller(
      restClient.adminAddUser(body),
    );

    if (value.status == ResponseStatus.success) {
      await getUsers(refresh: true);
      return true;
    }

    if (error != null) {
      errorHandling(error!);
    }

    return false;
  }

  Future<bool> updateUser(AdminUser user, Map<String, dynamic> body) async {
    final value = await networkCaller(
      restClient.adminUpdateUser(user.id, body),
    );

    if (value.status == ResponseStatus.success) {
      await getUsers(refresh: true);
      return true;
    }

    if (error != null) {
      errorHandling(error!);
    }

    return false;
  }

  Future<void> deleteUser(AdminUser user) async {
    final value = await networkCaller(
      restClient.adminDeleteUser(user.id),
    );

    if (value.status == ResponseStatus.success) {
      users.removeWhere((e) => e.id == user.id);
      update();
    } else if (error != null) {
      errorHandling(error!);
    }
  }

  Future<void> exportUsersExcel() async {
    if (isExporting) return;

    isExporting = true;
    update();

    return restClient.adminUsersExcel().then((value) async {
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