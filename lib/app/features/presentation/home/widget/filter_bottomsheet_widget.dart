import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/app/features/presentation/home/bloc/home_bloc.dart';
import 'package:crypto_lens/app/features/presentation/home/bloc/home_event.dart';

class FilterBottomSheetWidget extends StatefulWidget {
  final String initialOrderBy;
  final String initialDirection;

  const FilterBottomSheetWidget({
    super.key,
    required this.initialOrderBy,
    required this.initialDirection,
  });

  // FilterBottomSheetWidget içinde
  static Future<void> show(
    BuildContext context,
    HomeBloc homeBloc,
    String orderBy,
    String direction,
  ) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.midnightBlue,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (_) => BlocProvider.value(
        value: homeBloc,
        child: FilterBottomSheetWidget(
          initialOrderBy: orderBy,
          initialDirection: direction,
        ),
      ),
    );
  }

  @override
  State<FilterBottomSheetWidget> createState() =>
      _FilterBottomSheetWidgetState();
}

class _FilterBottomSheetWidgetState extends State<FilterBottomSheetWidget> {
  late String localOrderBy;
  late String localDirection;

  @override
  void initState() {
    super.initState();
    localOrderBy = widget.initialOrderBy;
    localDirection = widget.initialDirection;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Sort Options",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(color: Colors.white10, height: 30),

          // Yön Seçimi
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildDirectionChip("Descending", "desc", Icons.trending_down),
              _buildDirectionChip("Ascending", "asc", Icons.trending_up),
            ],
          ),
          const SizedBox(height: 20),

          // Seçenekler
          _buildOption("Market Cap", "marketCap", Icons.pie_chart),
          _buildOption("Price", "price", Icons.attach_money),
          _buildOption("24h Volume", "24hVolume", Icons.bar_chart),
          _buildOption("Change (%)", "change", Icons.percent),
          _buildOption("Listing Date", "listedAt", Icons.calendar_today),

          const SizedBox(height: 25),

          // UYGULA BUTONU (İstediğin buton burası)
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.neonBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                // Seçimleri Bloc'a gönderiyoruz
                context.read<HomeBloc>().add(
                  Filtered(
                    orderBy: localOrderBy,
                    orderDirection: localDirection,
                  ),
                );
                Navigator.pop(context); // Sheet'i kapat
              },
              child: const Text(
                "Apply Filters",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDirectionChip(String label, String value, IconData icon) {
    final bool isSelected = localDirection == value;
    return GestureDetector(
      onTap: () => setState(
        () => localDirection = value,
      ), // Sadece içerideki durumu değiştirir
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.neonBlue.withOpacity(0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? AppColor.neonBlue : Colors.white10,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColor.neonBlue : Colors.white60,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColor.neonBlue : Colors.white60,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(String title, String value, IconData icon) {
    final bool isSelected = localOrderBy == value;
    return ListTile(
      onTap: () => setState(
        () => localOrderBy = value,
      ), // Sadece içerideki durumu değiştirir
      leading: Icon(
        icon,
        color: isSelected ? AppColor.neonBlue : Colors.white60,
      ),
      title: Text(
        title,
        style: TextStyle(color: isSelected ? Colors.white : Colors.white70),
      ),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: AppColor.neonBlue)
          : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
  }
}
