import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';

class HomeSwiper extends StatelessWidget {
  final List<String> imageList;

  const HomeSwiper({super.key, required this.imageList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 12),
      child: SizedBox(
        height: 220,
        width: double.infinity,
        child: Swiper(
          loop: false,
          index: 0,
          onIndexChanged: (index) {},
          pagination: const SwiperPagination(
            builder: DotSwiperPaginationBuilder(
              color: Color(0xffffffff),
              activeColor: Color(0xffEB6733),
              space: 4,
            ),
          ),
          itemCount: imageList.length,
          itemBuilder: (BuildContext context, int index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                imageList[index],
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}
