import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';

import 'mis_detail_list.dart';
import 'mis_drill_down.dart';
import 'mis_report_controller.dart';

const _feeModes = ["Cash", "Cheque", "Online"];
const _studentFilters = {
  "Total Students": "all",
  "Present Students": "present",
  "Absent Students": "absent",
};

/// Icon + accent colour per module key (matches the keys from get_misReport).
const _moduleStyle = <String, (IconData, Color)>{
  "fees": (Icons.currency_rupee, Color(0xFF2E9E6B)),
  "admission": (Icons.person_add_alt_1, Color(0xFF3F7FD8)),
  "student_attendance": (Icons.fact_check, Color(0xFF7B5CD6)),
  "student_leave": (Icons.event_busy, Color(0xFFE08A1E)),
  "staff_attendance": (Icons.badge, Color(0xFF1E9DB0)),
  "staff_leave": (Icons.work_off, Color(0xFFD9627A)),
  "task": (Icons.checklist, Color(0xFF5B6EE1)),
  "visitor": (Icons.directions_walk, Color(0xFF8A6D3B)),
  "complaint": (Icons.report_problem, Color(0xFFE5533D)),
  "parent_communication": (Icons.forum, Color(0xFF2B8ACB)),
  "calendar": (Icons.calendar_month, Color(0xFFB45FD1)),
  "inventory": (Icons.inventory_2, Color(0xFF6C8B3A)),
  "library": (Icons.menu_book, Color(0xFFC0702B)),
};

class MisReportScreen extends StatelessWidget {
  MisReportScreen({super.key});
  final MisReportController _c = Get.put(MisReportController());

  static final Color _headerColor = CU.tprimaryColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F9),
      appBar: teacherAppBar(text: "MIS Report"),
      body: Obx(() {
        return RefreshIndicator(
          onRefresh: _c.load,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              _header(),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 20),
                child: Column(
                  children: [
                    if (_c.expanded.value.startsWith("top:"))
                      _drillCard(
                        _c.expanded.value == "top:fees"
                            ? MisDrillKind.fees
                            : MisDrillKind.students,
                        _c.expanded.value == "top:fees" ? null : "all",
                      ),
                    if (_c.isLoading.value)
                      const Padding(
                        padding: EdgeInsets.all(40),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    else if (_c.modules.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(40),
                        child: Text("No data",
                            style: TextStyle(color: CU.textColorDark)),
                      )
                    else
                      ..._c.modules.map(_moduleCard),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  double _feesTotal() {
    for (final m in _c.modules) {
      if (m["key"] == "fees" && m["total_amount"] != null) {
        return double.tryParse(m["total_amount"].toString()) ?? 0;
      }
    }
    return 0;
  }

  Widget _header() {
    final fmt = DateFormat('dd MMM yyyy');
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 54),
      margin: const EdgeInsets.only(bottom: 0),
      decoration: BoxDecoration(
        // Starts with the exact app bar colour so the two read as one surface.
        gradient: LinearGradient(
          colors: [
            _headerColor,
            Color.lerp(_headerColor, Colors.white, 0.18)!,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _c.instituteName.isEmpty
                      ? "Today at a glance"
                      : _c.instituteName.value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              InkWell(
                onTap: _c.pickDate,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          size: 14, color: Colors.white),
                      const SizedBox(width: 6),
                      Text(fmt.format(_c.date.value),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _heroTile(
                  icon: Icons.currency_rupee,
                  label: "Fees Collected",
                  value: misMoney(_feesTotal()),
                  open: _c.expanded.value == "top:fees",
                  onTap: () => _c.toggle("top:fees"),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _heroTile(
                  icon: Icons.groups,
                  label: "Total Students",
                  value: "${_c.totalStudents.value}",
                  open: _c.expanded.value == "top:all",
                  onTap: () => _c.toggle("top:all"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _heroTile({
    required IconData icon,
    required String label,
    required String value,
    required bool open,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      elevation: 3,
      shadowColor: Colors.black26,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: _headerColor.withValues(alpha: 0.12),
                child: Icon(icon, size: 18, color: _headerColor),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label,
                        style:
                            TextStyle(fontSize: 11, color: CU.textColorlight)),
                    const SizedBox(height: 2),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(value,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: CU.textColorDark)),
                    ),
                  ],
                ),
              ),
              Icon(open ? Icons.expand_less : Icons.expand_more,
                  size: 18, color: CU.textColorlight),
            ],
          ),
        ),
      ),
    );
  }

  /// Keyed by date + row so a date change or a different row starts fresh.
  Widget _drill(MisDrillKind kind, String? filter) => MisDrillDown(
        key: ValueKey("${kind.name}|$filter|${_c.date.value}"),
        kind: kind,
        userInfo: _c.userInfo,
        date: _c.date.value,
        filter: filter,
      );

  Widget _drillCard(MisDrillKind kind, String? filter) => Container(
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.all(6),
        decoration: _cardDecoration(),
        child: _drill(kind, filter),
      );

  BoxDecoration _cardDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Color(0x14000000), blurRadius: 10, offset: Offset(0, 3)),
        ],
      );

  Widget _moduleCard(Map<String, dynamic> m) {
    final moduleKey = m["key"].toString();
    final style =
        _moduleStyle[moduleKey] ?? (Icons.insights, const Color(0xFF607D8B));
    final color = style.$2;
    final rows = List<Map<String, dynamic>>.from(
        (m["rows"] as List).map((e) => Map<String, dynamic>.from(e)));

    return Container(
      margin: const EdgeInsets.only(top: 12),
      decoration: _cardDecoration(),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: color.withValues(alpha: 0.08),
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 17,
                  backgroundColor: color,
                  child: Icon(style.$1, size: 18, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(m["name"],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: CU.textColorDark)),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    m["total_amount"] != null
                        ? misMoney(num.parse(m["total_amount"].toString()))
                        : "${m["total"]}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: Column(
              children: [
                for (int i = 0; i < rows.length; i++) ...[
                  if (i > 0 && rows[i]["is_child"] != true)
                    const Divider(height: 1, indent: 8, endIndent: 8),
                  _row(moduleKey, rows[i], color),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String moduleKey, Map<String, dynamic> r, Color color) {
    final label = r["label"].toString();
    final amount = r["amount"];
    final isChild = r["is_child"] == true;

    MisDrillKind? kind;
    String? filter;
    if (moduleKey == "fees" && !label.startsWith("Cancelled")) {
      kind = MisDrillKind.fees;
      filter = _feeModes.contains(label) ? label : null;
    } else if (moduleKey == "student_attendance" &&
        _studentFilters.containsKey(label)) {
      kind = MisDrillKind.students;
      filter = _studentFilters[label];
    }

    // Every other row lists its records straight from get_misDetail; only the
    // cancelled-fees row has no detail source.
    final isDetail = kind == null && !label.startsWith("Cancelled");
    final tappable = kind != null || isDetail;

    final rowKey = "$moduleKey:$label";
    final isOpen = _c.expanded.value == rowKey;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: tappable ? () => _c.toggle(rowKey) : null,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
              color: isOpen ? color.withValues(alpha: 0.08) : null,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.fromLTRB(isChild ? 22 : 8, 11, 8, 11),
            child: Row(
              children: [
                if (isChild)
                  Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.only(right: 8),
                    decoration:
                        BoxDecoration(color: color, shape: BoxShape.circle),
                  ),
                Expanded(
                  child: Text(label,
                      style: TextStyle(
                          fontSize: 13.5,
                          color: CU.textColorDark,
                          fontWeight:
                              isChild ? FontWeight.normal : FontWeight.w500)),
                ),
                Container(
                  constraints: const BoxConstraints(minWidth: 30),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F2F6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text("${r["count"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: CU.textColorDark)),
                ),
                if (amount != null)
                  SizedBox(
                    width: 100,
                    child: Text(
                      misMoney(num.parse(amount.toString())),
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                  ),
                if (tappable)
                  Icon(isOpen ? Icons.expand_less : Icons.chevron_right,
                      size: 20, color: color)
                else
                  const SizedBox(width: 20),
              ],
            ),
          ),
        ),
        if (isOpen && kind != null) _drill(kind, filter),
        if (isOpen && isDetail)
          MisDetailList(
            key: ValueKey("detail|$rowKey|${_c.date.value}"),
            module: moduleKey,
            row: label,
            userInfo: _c.userInfo,
            date: _c.date.value,
            color: color,
          ),
      ],
    );
  }
}
