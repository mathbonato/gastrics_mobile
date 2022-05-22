import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:glp_manager_mobile/components/progress_line.dart';
import 'package:glp_manager_mobile/shared/themes/appcollors.dart';

class CustomCard extends StatefulWidget {
  const CustomCard(
      {Key? key,
      required this.title,
      required this.maxWeight,
      required this.currentWeight,
      required this.percentage,
      required this.date})
      : super(key: key);

  final String title;
  final int maxWeight;
  final int currentWeight;
  final int percentage;
  final String date;

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.background,
                  fontSize: 18)),
          Center(
            child: Text('${widget.percentage}%',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.background,
                    fontSize: 18)),
          ),
          ProgressLine(
              color: widget.percentage <= 10 ? Colors.red : Colors.green,
              percentage: widget.percentage),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Peso atual: ${widget.currentWeight} Kg",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.background,
                    fontSize: 14),
              ),
              Text(
                "Capacidade: ${widget.maxWeight} Kg",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.background,
                    fontSize: 14),
              ),
              Text(
                "Atualizado em: ${widget.date}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.background,
                    fontSize: 14),
              ),
            ],
          )
        ],
      ),
    );
  }
}
