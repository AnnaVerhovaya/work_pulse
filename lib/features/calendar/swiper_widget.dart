import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class SwiperWidget extends StatelessWidget {
  const SwiperWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List images = [
      'assets/photo/1.png',
      'assets/photo/2.png',
      'assets/photo/3.png',
      'assets/photo/4.png',
      'assets/photo/5.png',
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Swiper(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final image = images[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            autoplay: false,
            viewportFraction: 0.7,
            itemCount: images.length,
            control: SwiperControl(
              color: Colors.white.withOpacity(0.5),
              size: 30.0,
            ),
          ),
        ),
      ),
    );
  }
}
