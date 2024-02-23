import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/screen/dashboard/widget/pesan_carausel_widget.dart';
import 'package:penyewaan_gedung_triharjo/screen/dashboard/widget/pesan_grid_widget.dart';
import 'package:penyewaan_gedung_triharjo/screen/dashboard/widget/pesan_list_widget.dart';
import 'package:penyewaan_gedung_triharjo/screen/list_harga/list_harga_screen.dart';

class PesanGedungWidget extends StatefulWidget {
  const PesanGedungWidget({super.key});

  @override
  State<PesanGedungWidget> createState() => _PesanGedungWidgetState();
}

class _PesanGedungWidgetState extends State<PesanGedungWidget> {
  int selectedChoice = 1;

  Widget _buildWidgetForChoice(int choice) {
    switch (choice) {
      case 1:
        return const PesanCarauselWidget();
      case 2:
        return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: PesanGridWidget());
      case 3:
        return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: PesanListWidget());
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Pesan Gedung',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ListHargaScreen()));
                  },
                  child: const Row(
                    children: [
                      Text(
                        "List Harga",
                        style: TextStyle(
                          color: Color(0xFF3E70F2),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Color(0xFF3E70F2),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8.0,
                  children: [
                    ChoiceChip(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      labelPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      label: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Text(
                          'Carousel',
                          style: TextStyle(
                            color: selectedChoice == 1
                                ? const Color(0xFF3E70F2)
                                : const Color(0xFF787777),
                          ),
                        ),
                      ),
                      backgroundColor: Colors.transparent,
                      selectedColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.0),
                        side: BorderSide(
                          color: selectedChoice == 1
                              ? const Color(0xFF3E70F2)
                              : const Color(0xFF787777),
                          width: 1.0,
                        ),
                      ),
                      selected: selectedChoice == 1,
                      onSelected: (selected) {
                        setState(() {
                          selectedChoice = selected ? 1 : 0;
                        });
                      },
                    ),
                    ChoiceChip(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      labelPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      label: Text(
                        'Grid',
                        style: TextStyle(
                          color: selectedChoice == 2
                              ? const Color(0xFF3E70F2)
                              : const Color(0xFF787777),
                        ),
                      ),
                      backgroundColor: Colors.transparent,
                      selectedColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.0),
                        side: BorderSide(
                          color: selectedChoice == 2
                              ? const Color(0xFF3E70F2)
                              : const Color(0xFF787777),
                          width: 1.0,
                        ),
                      ),
                      selected: selectedChoice == 2,
                      onSelected: (selected) {
                        setState(() {
                          selectedChoice = selected ? 2 : 0;
                        });
                      },
                    ),
                    ChoiceChip(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      labelPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      label: Text(
                        'List',
                        style: TextStyle(
                          color: selectedChoice == 3
                              ? const Color(0xFF3E70F2)
                              : const Color(0xFF787777),
                        ),
                      ),
                      backgroundColor: Colors.transparent,
                      selectedColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.0),
                        side: BorderSide(
                          color: selectedChoice == 3
                              ? const Color(0xFF3E70F2)
                              : const Color(0xFF787777),
                          width: 1.0,
                        ),
                      ),
                      selected: selectedChoice == 3,
                      onSelected: (selected) {
                        setState(() {
                          selectedChoice = selected ? 3 : 0;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          _buildWidgetForChoice(selectedChoice),
        ],
      ),
    );
  }
}
