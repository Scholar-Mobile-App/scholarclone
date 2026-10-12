import 'package:flutter/material.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/enum.dart';

import 'mis_report_controller.dart';

/// Records behind one MIS row (any module without a standard-wise drill-down),
/// shown directly below the tapped row.
class MisDetailList extends StatefulWidget {
  const MisDetailList({
    super.key,
    required this.module,
    required this.row,
    required this.userInfo,
    required this.date,
    required this.color,
  });

  final String module;
  final String row;
  final Map<String, dynamic> userInfo;
  final DateTime date;
  final Color color;

  @override
  State<MisDetailList> createState() => _MisDetailListState();
}

class _MisDetailListState extends State<MisDetailList> {
  bool _loading = true;
  String? _error;
  List<Map<String, dynamic>> _items = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final body = misBaseBody(widget.userInfo, widget.date)
      ..["module"] = widget.module
      ..["row"] = widget.row;
    final res = await misPost(body, "get_misDetail", _load);
    if (!mounted) return;

    setState(() {
      _loading = false;
      if (res != null && res[CS.status].toString() == StatusCode.Success) {
        _items = List<Map<String, dynamic>>.from(
            (res[CS.data] as List).map((e) => Map<String, dynamic>.from(e)));
      } else {
        _items = [];
        final msg = (res?[CS.message] ?? "").toString();
        // "No Record" is a normal empty state, anything else is worth showing.
        _error = msg == "No Record" ? null : msg;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (_loading) {
      body = const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    } else if (_items.isEmpty) {
      body = Padding(
        padding: const EdgeInsets.all(14),
        child: Text(_error?.isNotEmpty == true ? _error! : "No records",
            style: const TextStyle(color: Colors.grey)),
      );
    } else {
      body = Column(
        children: [for (int i = 0; i < _items.length; i++) _tile(i, _items[i])],
      );
    }

    return Container(
      margin: const EdgeInsets.only(top: 4, bottom: 8),
      decoration: BoxDecoration(
        color: widget.color.withValues(alpha: 0.05),
        border: Border.all(color: widget.color.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: body,
    );
  }

  Widget _tile(int i, Map<String, dynamic> item) {
    final subtitle = (item["subtitle"] ?? "").toString();
    final extra = (item["extra"] ?? "").toString();

    return Container(
      decoration: BoxDecoration(
        border: i == 0
            ? null
            : Border(
                top: BorderSide(color: widget.color.withValues(alpha: 0.12))),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      child: Row(
        children: [
          CircleAvatar(
            radius: 13,
            backgroundColor: widget.color.withValues(alpha: 0.15),
            child: Text("${i + 1}",
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: widget.color)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item["title"].toString(),
                    style: const TextStyle(
                        fontSize: 13.5, fontWeight: FontWeight.w500)),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: const TextStyle(fontSize: 11, color: Colors.grey)),
                ],
              ],
            ),
          ),
          if (extra.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: widget.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(extra,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: widget.color)),
            ),
        ],
      ),
    );
  }
}
