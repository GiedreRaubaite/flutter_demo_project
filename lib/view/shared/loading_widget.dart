import 'package:flutter/widgets.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            height: 50,
            child: LoadingIndicator(
              indicatorType: Indicator.ballBeat,
              colors: [
                Color.fromARGB(255, 192, 102, 96),
                Color.fromARGB(255, 224, 198, 2),
                Color.fromARGB(255, 137, 188, 230)
              ],
              strokeWidth: 2,
            ),
          ),
        ],
      ),
    );
  }
}
