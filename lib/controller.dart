import 'dart:math';

import 'package:flare_flutter/flare.dart';
import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';

typedef void OnUpdated();

class AnimationHouseController extends FlareController {
  static const FPS = 60;

  final OnUpdated animationUpdated;

  AnimationHouseController({this.animationUpdated});

  int _rooms = 3;
  FlutterActorArtboard _artboard;
  FlareAnimationLayer _skyAnimation;

  final List<FlareAnimationLayer> _roomAnimations = [];

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    _skyAnimation.time = (_skyAnimation.time + elapsed) % _skyAnimation.duration;
    _skyAnimation.apply(artboard);

    int len = _roomAnimations.length - 1;

    for(int i = len; i >= 0; i--){
      FlareAnimationLayer layer = _roomAnimations[i];
      layer.time += elapsed;

      layer.mix = min(1.0, layer.time / 0.07);
      layer.apply(artboard);

      if(layer.isDone){
        _roomAnimations.removeAt(i);
      }
    };

    return true;
  }

  @override
  void initialize(FlutterActorArtboard artboard) {
   _artboard = artboard;
   _skyAnimation = FlareAnimationLayer()
   ..animation = _artboard.getAnimation("Sun Rotate")
   ..mix = 1.0;
  }

  @override
  void setViewTransform(Mat2D viewTransform) {}

_enqueueAnimation(String name) {
    ActorAnimation animation = _artboard.getAnimation(name);
    if (animation != null) {
      _roomAnimations.add(FlareAnimationLayer()..animation = animation);
    }
  }

  set rooms(int value) {
    if (_rooms == value) {
      return;
    }
    if (_artboard != null) {
      _enqueueAnimation("to $value");
      if ((_rooms > 4 && value < 5) || (_rooms < 5 && value > 4)) {
        _enqueueAnimation("Center Window Highlight");
      }
      if (_rooms == 3 || value == 3) {
        _enqueueAnimation("Outer Windows Highlight");
      }
      if (value == 6 || _rooms == 6) {
        _enqueueAnimation("Inner Windows Highlight");
      }
    }
    _rooms = value;
  }

  int get rooms => _rooms;
}