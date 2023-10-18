import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/core/network/api_constants.dart';
import 'package:movies/core/utils/enums.dart';
import 'package:movies/modules/movies/presentation/screens/movies_screen/cubit/cubit.dart';
import 'package:movies/modules/movies/presentation/screens/movies_screen/cubit/states.dart';
import 'package:shimmer/shimmer.dart';

Widget buildGetNowPlayingSlider() {
  return BlocBuilder<MovieBloc, MoviesState>(
    buildWhen: (previous, current) =>
        previous.nowPlayingStates != current.nowPlayingStates,
    builder: (context, state) {
      switch (state.nowPlayingStates) {
        case RequestStates.loading:
          return const SizedBox(
            width: 400,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        case RequestStates.loaded:
          return FadeIn(
            duration: const Duration(milliseconds: 500),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 400.0,
                viewportFraction: 1.0,
                onPageChanged: (index, reason) {},
              ),
              items: state.nowPlayingMovies.map(
                (item) {
                  return GestureDetector(
                    key: const Key('openMovieMinimalDetail'),
                    onTap: () {
                      /// TODO : NAVIGATE TO MOVIE DETAILS
                    },
                    child: Stack(
                      children: [
                        ShaderMask(
                          shaderCallback: (rect) {
                            return const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                // fromLTRB
                                Colors.transparent,
                                Colors.black,
                                Colors.black,
                                Colors.transparent,
                              ],
                              stops: [0, 0.3, 0.5, 1],
                            ).createShader(
                              Rect.fromLTRB(0, 0, rect.width, rect.height),
                            );
                          },
                          blendMode: BlendMode.dstIn,
                          child: CachedNetworkImage(
                            height: 560.0,
                            imageUrl: ApiConstant.imageUrl(item.backdropPath),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.circle,
                                      color: Colors.redAccent,
                                      size: 16.0,
                                    ),
                                    const SizedBox(width: 4.0),
                                    Text(
                                      'Now Playing'.toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Text(
                                  item.title,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
          );
        case RequestStates.error:
          return Center(
            child: Text(state.nowPlayingMessage),
          );
      }
    },
  );
}

Widget buildPopularAndTopRatedSeeMoreMoviesList({
  required String title,
  required void Function()? onTap,
}) {
  return Container(
    margin: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 19,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.15,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('See More'),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.0,
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildPopularAndTopRatedItem({
  required void Function()? onTap,
  required String imageUrl,
}) {
  return Container(
    padding: const EdgeInsets.only(right: 8.0),
    child: InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        child: CachedNetworkImage(
          width: 120.0,
          fit: BoxFit.cover,
          imageUrl: ApiConstant.imageUrl(imageUrl),
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[850]!,
            highlightColor: Colors.grey[800]!,
            child: Container(
              height: 170.0,
              width: 120.0,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    ),
  );
}
