import 'package:triberly/generated/assets.dart';

class InterestsHelper {
  static String getInterestAssetByName(String interestName) {
    switch (interestName.toLowerCase()) {
      case 'adventure films':
        return InterestsAssets.svgsAdventure;
      case 'aerobics':
        return InterestsAssets.svgsAerobics;
      case 'bbq':
        return InterestsAssets.svgsBBQ;
      case 'bollywood':
        return InterestsAssets.svgsBollywood;
      case 'church events':
        return InterestsAssets.svgsChurchEvents;
      case 'gym':
        return InterestsAssets.svgsGym;
      case 'cinema':
        return InterestsAssets.svgsCinema;
      case 'gaming':
        return InterestsAssets.svgsGaming;
      case 'tech geek':
        return InterestsAssets.svgsTechGeek;
      case 'afrobeats':
        return InterestsAssets.svgsAfrobeats;
      case 'football':
        return InterestsAssets.svgsFootball;
      case 'gospel music':
        return InterestsAssets.svgsGospelMusic;
      case 'long distance travel':
        return InterestsAssets.svgsLongDistanceTravel;
      case 'rap music':
        return InterestsAssets.svgsRapMusic;
      case 'art':
        return InterestsAssets.svgsArt;
      case 'walking & hiking':
        return InterestsAssets.svgsWalkingHiking;
      case 'ghanaian food':
        return InterestsAssets.svgsGhanaianFood;
      case 'vr gaming':
        return InterestsAssets.svgsVRGaming;
      case 'karaoke':
        return InterestsAssets.svgsKaraoke;
      case 'running':
        return InterestsAssets.svgsRunning;
      case 'sweet tooth':
        return InterestsAssets.svgsSweetTooth;
      case 'swimming':
        return InterestsAssets.svgsSwimming;
      case 'fine dining':
        return InterestsAssets.svgsFineDining;
      case 'city travel':
        return InterestsAssets.svgsCityTravel;
      case 'comedy films':
        return InterestsAssets.svgsComedyFilms;
      default:
      // You can return a default asset or throw an exception for unknown interests.
        return   Assets.svgsCategory; // Replace with a default asset or throw an exception.
    }
  }
}
