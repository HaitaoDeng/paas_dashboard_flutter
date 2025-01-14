import 'package:flutter/material.dart';
import 'package:paas_dashboard_flutter/generated/l10n.dart';
import 'package:paas_dashboard_flutter/vm/sql/sql_view_model.dart';
import 'package:provider/provider.dart';

class SqlExecuteWidget extends StatefulWidget {
  SqlExecuteWidget();

  @override
  State<StatefulWidget> createState() {
    return new SqlExecuteWidgetState();
  }
}

class SqlExecuteWidgetState extends State<SqlExecuteWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<SqlViewModel>(context);
    var body = ListView(
      children: [
        Container(
          height: 50,
          child: Text(vm.sql),
        ),
        TextButton(
            onPressed: () {
              setState(() {});
            },
            child: Text(S.of(context).submit)),
      ],
    );
    return body;
  }
}
