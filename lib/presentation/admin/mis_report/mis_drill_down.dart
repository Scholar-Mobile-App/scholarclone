import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/enum.dart';

import 'mis_report_controller.dart';

String misMoney(num v) => NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹ ',
      decimalDigits: 2,
    ).format(v);

enum MisDrillKind { fees, students }

/// Standard list shown directly below the tapped MIS row. Tapping a standard
/// opens its students right below it; nothing navigates away from the page.
class MisDrillDown extends StatefulWidget {
  const MisDrillDown({
    super.key,
    required this.kind,
    required this.userInfo,
    required this.date,
    this.filter,
  });

  final MisDrillKind kind;
  final Map<String, dynamic> userInfo;
  final DateTime date;

  /// Fees: payment mode (Cash / Cheque / Online) or null for all.
  /// Students: all / present / absent.
  final String? filter;

  @override
  State<MisDrillDown> createState() => _MisDrillDownState();
}

class _MisDrillDownState extends State<MisDrillDown> {
  bool _loading = true;
  List<Map<String, dynamic>> _standards = [];

  final Set<String> _open = {};
  final Set<String> _loadingStd = {};
  final Map<String, List<Map<String, dynamic>>> _students = {};

  bool get _fees => widget.kind == MisDrillKind.fees;

  Map<String, dynamic> get _body {
    final body = misBaseBody(widget.userInfo, widget.date);
    if (widget.filter != null) body[_fees ? "mode" : "filter"] = widget.filter;
    return body;
  }

  @override
  void initState() {
    super.initState();
    _loadStandards();
  }

  Future<List<Map<String, dynamic>>> _fetch(String api,
      Map<String, dynamic> body, Future<void> Function() retry) async {
    final res = await misPost(body, api, retry);
    if (res != null && res[CS.status].toString() == StatusCode.Success) {
      return List<Map<String, dynamic>>.from(
          (res[CS.data] as List).map((e) => Map<String, dynamic>.from(e)));
    }
    return [];
  }

  Future<void> _loadStandards() async {
    final list = await _fetch(
      _fees ? "get_misFeesStandardWise" : "get_misStudentStandardWise",
      _body,
      _loadStandards,
    );
    if (!mounted) return;
    setState(() {
      _standards = list;
      _loading = false;
    });
  }

  Future<void> _toggle(Map<String, dynamic> std) async {
    final id = std["standard_id"].toString();
    if (_open.contains(id)) {
      setState(() => _open.remove(id));
      return;
    }
    setState(() => _open.add(id));
    if (_students.containsKey(id)) return;

    setState(() => _loadingStd.add(id));
    final list = await _fetch(
      _fees ? "get_misFeesStudentWise" : "get_misStudentList",
      _body..["standard_id"] = std["standard_id"],
      () => _toggle(std),
    );
    if (!mounted) return;
    setState(() {
      _students[id] = list;
      _loadingStd.remove(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }
    if (_standards.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(12),
        child: Text("No records", style: TextStyle(color: Colors.grey)),
      );
    }

    return Container(
      margin: const EdgeInsets.only(top: 4, bottom: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F7FC),
        border: Border.all(color: const Color(0xFFDCE6F3)),
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: _standards.map(_standardTile).toList()),
    );
  }

  Widget _standardTile(Map<String, dynamic> s) {
    final id = s["standard_id"].toString();
    final open = _open.contains(id);

    return Column(
      children: [
        InkWell(
          onTap: () => _toggle(s),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Standard ${s["standard_name"]}",
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 13.5),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _fees
                        ? "${s["student_count"]} students"
                        : "${s["student_count"]}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
                if (_fees) ...[
                  const SizedBox(width: 8),
                  Text(misMoney(num.parse(s["amount"].toString())),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Color(0xFF2E9E6B))),
                ],
                Icon(open ? Icons.expand_less : Icons.expand_more, size: 20),
              ],
            ),
          ),
        ),
        if (open) _studentList(id),
        const Divider(height: 1),
      ],
    );
  }

  Widget _studentList(String id) {
    if (_loadingStd.contains(id)) {
      return const Padding(
        padding: EdgeInsets.all(12),
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }
    final list = _students[id] ?? [];
    if (list.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(12),
        child: Text("No students found", style: TextStyle(color: Colors.grey)),
      );
    }

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          for (int i = 0; i < list.length; i++) _studentRow(i, list[i]),
        ],
      ),
    );
  }

  Widget _studentRow(int i, Map<String, dynamic> s) {
    final receipt = (s["receipt_no"] ?? "").toString();
    final details = [
      "Div ${s["division_name"]}",
      if (s["roll_no"] != null) "Roll ${s["roll_no"]}",
      if (_fees && s["payment_mode"] != null) s["payment_mode"],
      if (_fees && receipt.isNotEmpty) "Receipt $receipt",
    ].join("  •  ");

    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFF0F2F6))),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      child: Row(
        children: [
          CircleAvatar(
            radius: 13,
            backgroundColor: const Color(0xFFE6EEF9),
            child: Text("${i + 1}",
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2F7FD0))),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s["student_name"].toString(),
                    style: const TextStyle(
                        fontSize: 13.5, fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(details,
                    style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
          if (_fees)
            Text(misMoney(num.parse(s["amount"].toString())),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Color(0xFF2E9E6B))),
        ],
      ),
    );
  }
}
