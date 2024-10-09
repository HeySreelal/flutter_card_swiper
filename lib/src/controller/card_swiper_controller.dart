import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_card_swiper/src/controller/controller_event.dart';

/// A controller that can be used to trigger swipes on a CardSwiper widget.
class CardSwiperController {
  final _eventController = StreamController<ControllerEvent>.broadcast();

  /// Stream of events that can be used to swipe the card.
  Stream<ControllerEvent> get events => _eventController.stream;

  /// Swipe the card to a specific direction.
  void swipe(CardSwiperDirection direction) {
    _eventController.add(ControllerSwipeEvent(direction));
  }

  /// Swipe the card to a specific direction.
  ///
  /// - [direction] defines the direction of the swipe.
  /// - [curve] defines the curve that will be applied when animating the card's movement in an arc. If null, [Curves.ease] will be used.
  void swipeArc(
    CardSwiperDirection direction, {
    Curve curve = Curves.ease,
  }) {
    _eventController.add(ControllerArcSwipeEvent(direction, curve));
  }

  // Undo the last swipe
  void undo() {
    _eventController.add(const ControllerUndoEvent());
  }

  // Change the top card to a specific index.
  void moveTo(int index) {
    _eventController.add(ControllerMoveEvent(index));
  }

  Future<void> dispose() async {
    await _eventController.close();
  }
}
