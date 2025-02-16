import 'package:flutter/material.dart';
import 'package:paas_dashboard_flutter/generated/l10n.dart';
import 'package:paas_dashboard_flutter/ui/pulsar/widget/pulsar_partitioned_topic_basic.dart';
import 'package:paas_dashboard_flutter/ui/pulsar/widget/pulsar_partitioned_topic_consumer.dart';
import 'package:paas_dashboard_flutter/ui/pulsar/widget/pulsar_partitioned_topic_detail.dart';
import 'package:paas_dashboard_flutter/ui/pulsar/widget/pulsar_partitioned_topic_producer.dart';
import 'package:paas_dashboard_flutter/ui/pulsar/widget/pulsar_partitioned_topic_subscription.dart';
import 'package:paas_dashboard_flutter/vm/pulsar/pulsar_partitioned_topic_basic_view_model.dart';
import 'package:paas_dashboard_flutter/vm/pulsar/pulsar_partitioned_topic_consumer_view_model.dart';
import 'package:paas_dashboard_flutter/vm/pulsar/pulsar_partitioned_topic_detail_view_model.dart';
import 'package:paas_dashboard_flutter/vm/pulsar/pulsar_partitioned_topic_producer_view_model.dart';
import 'package:paas_dashboard_flutter/vm/pulsar/pulsar_partitioned_topic_subscription_view_model.dart';
import 'package:paas_dashboard_flutter/vm/pulsar/pulsar_partitioned_topic_view_model.dart';
import 'package:provider/provider.dart';

import 'package:paas_dashboard_flutter/vm/pulsar/pulsar_partitioned_topic_produce_view_model.dart';
import 'package:paas_dashboard_flutter/ui/pulsar/widget/pulsar_partitioned_topic_produce.dart';

class PulsarPartitionedTopic extends StatefulWidget {
  PulsarPartitionedTopic();

  @override
  State<StatefulWidget> createState() {
    return new _PulsarPartitionedTopicState();
  }
}

class _PulsarPartitionedTopicState extends State<PulsarPartitionedTopic> {
  _PulsarPartitionedTopicState();

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PulsarPartitionedTopicViewModel>(context);
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              'Pulsar Partitioned Topic ${S.of(context).tenant} ${vm.tenant} -> ${S.of(context).namespace} ${vm.namespace} -> Topic ${vm.topic}'),
          bottom: TabBar(
            tabs: [
              Tab(text: S.of(context).basic),
              Tab(text: S.of(context).detail),
              Tab(text: S.of(context).subscription),
              Tab(text: S.of(context).consumer),
              Tab(text: S.of(context).producer),
              Tab(text: S.of(context).produce),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ChangeNotifierProvider(
              create: (context) => PulsarPartitionedTopicBasicViewModel(
                  vm.pulsarInstancePo, vm.tenantResp, vm.namespaceResp, vm.topicResp),
              child: PulsarPartitionedTopicBasicWidget(),
            ).build(context),
            ChangeNotifierProvider(
              create: (context) => new PulsarPartitionedTopicDetailViewModel(
                  vm.pulsarInstancePo, vm.tenantResp, vm.namespaceResp, vm.topicResp),
              child: PulsarPartitionedTopicDetailWidget(),
            ).build(context),
            ChangeNotifierProvider(
              create: (context) => new PulsarPartitionedTopicSubscriptionViewModel(
                  vm.pulsarInstancePo, vm.tenantResp, vm.namespaceResp, vm.topicResp),
              child: PulsarPartitionedTopicSubscriptionWidget(),
            ).build(context),
            ChangeNotifierProvider(
              create: (context) => PulsarPartitionedTopicConsumerViewModel(
                  vm.pulsarInstancePo, vm.tenantResp, vm.namespaceResp, vm.topicResp),
              child: PulsarPartitionedTopicConsumerWidget(),
            ).build(context),
            ChangeNotifierProvider(
              create: (context) => PulsarPartitionedTopicProducerViewModel(
                  vm.pulsarInstancePo, vm.tenantResp, vm.namespaceResp, vm.topicResp),
              child: PulsarPartitionedTopicProducerWidget(),
            ).build(context),
            ChangeNotifierProvider(
              create: (context) => PulsarPartitionedTopicProduceViewModel(
                  vm.pulsarInstancePo, vm.tenantResp, vm.namespaceResp, vm.topicResp),
              child: PulsarPartitionedTopicProduceWidget(),
            ).build(context),
          ],
        ),
      ),
    );
  }
}
