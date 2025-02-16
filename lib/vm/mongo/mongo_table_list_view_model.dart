import 'package:paas_dashboard_flutter/api/mongo/mongo_tables_api.dart';
import 'package:paas_dashboard_flutter/module/mongo/mongo_database.dart';
import 'package:paas_dashboard_flutter/persistent/po/mongo_instance_po.dart';
import 'package:paas_dashboard_flutter/vm/base_load_list_page_view_model.dart';
import 'package:paas_dashboard_flutter/vm/mongo/mongo_table_view_model.dart';

class MongoTableListViewModel extends BaseLoadListPageViewModel<MongoTableViewModel> {
  final MongoInstancePo mongoInstancePo;
  final DatabaseResp databaseResp;

  MongoTableListViewModel(this.mongoInstancePo, this.databaseResp);

  MongoTableListViewModel deepCopy() {
    return new MongoTableListViewModel(mongoInstancePo.deepCopy(), databaseResp.deepCopy());
  }

  Future<void> fetchTables() async {
    try {
      final results = await MongoTablesApi.getTableList(
          mongoInstancePo.addr, mongoInstancePo.username, mongoInstancePo.password, databaseResp.databaseName);
      this.fullList = results.map((e) => MongoTableViewModel(mongoInstancePo, databaseResp, e)).toList();
      this.displayList = this.fullList;
      loadSuccess();
    } on Exception catch (e) {
      loadException = e;
      loading = false;
    }
    notifyListeners();
  }

  Future<void> filter(String str) async {
    if (str == "") {
      this.displayList = this.fullList;
      notifyListeners();
      return;
    }
    if (!loading && loadException == null) {
      this.displayList = this.fullList.where((element) => element.databaseName.contains(str)).toList();
    }
    notifyListeners();
  }
}
