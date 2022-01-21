//
// Licensed to the Apache Software Foundation (ASF) under one
// or more contributor license agreements.  See the NOTICE file
// distributed with this work for additional information
// regarding copyright ownership.  The ASF licenses this file
// to you under the Apache License, Version 2.0 (the
// "License"); you may not use this file except in compliance
// with the License.  You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.
//

import 'dart:developer';

import 'package:paas_dashboard_flutter/api/pulsar/pulsar_tenant_api.dart';
import 'package:paas_dashboard_flutter/persistent/po/pulsar_instance_po.dart';
import 'package:paas_dashboard_flutter/vm/base_load_list_page_view_model.dart';
import 'package:paas_dashboard_flutter/vm/pulsar/pulsar_tenant_view_model.dart';

class PulsarInstanceViewModel extends BaseLoadListPageViewModel<PulsarTenantViewModel> {
  final PulsarInstancePo pulsarInstancePo;

  PulsarInstanceViewModel(this.pulsarInstancePo);

  PulsarInstanceViewModel deepCopy() {
    return new PulsarInstanceViewModel(pulsarInstancePo.deepCopy());
  }

  int get id {
    return this.pulsarInstancePo.id;
  }

  String get name {
    return this.pulsarInstancePo.name;
  }

  String get host {
    return this.pulsarInstancePo.host;
  }

  int get port {
    return this.pulsarInstancePo.port;
  }

  String get functionHost {
    return this.pulsarInstancePo.functionHost;
  }

  int get functionPort {
    return this.pulsarInstancePo.functionPort;
  }

  Future<void> fetchTenants() async {
    try {
      final results = await PulsarTenantApi.getTenants(host, port);
      this.fullList = results.map((e) => PulsarTenantViewModel(pulsarInstancePo, e)).toList();
      this.displayList = this.fullList;
      loadSuccess();
    } on Exception catch (e) {
      log('request failed, $e');
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
      this.displayList = this.fullList.where((element) => element.tenant.contains(str)).toList();
    }
    notifyListeners();
  }

  Future<void> createTenant(String tenant) async {
    try {
      await PulsarTenantApi.createTenant(host, port, tenant);
      await fetchTenants();
    } on Exception catch (e) {
      opException = e;
      notifyListeners();
    }
  }

  Future<void> deleteTenants(String tenant) async {
    try {
      await PulsarTenantApi.deleteTenant(host, port, tenant);
      await fetchTenants();
    } on Exception catch (e) {
      opException = e;
      notifyListeners();
    }
  }
}
