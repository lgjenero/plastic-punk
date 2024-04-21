import 'dart:async';

import 'package:flame_audio/flame_audio.dart';

enum SfxType {
  click("sfx/click.mp3"),
  close("sfx/close.mp3"),
  open("sfx/open.mp3"),
  select("sfx/select.mp3"),
  finished("sfx/finished.mp3"),
  alert("sfx/alert.mp3"),
  error("sfx/error.mp3"),
  ;

  final String path;
  const SfxType(this.path);
}

enum SfxLoop {
  construction("sfx_loops/construction.mp3"),
  cleanup("sfx_loops/cleanup.mp3"),
  waterCleanup("sfx_loops/water_cleanup.mp3"),
  waterTreatment("sfx_loops/water_treatment.mp3"),
  research("sfx_loops/research.mp3"),
  park("sfx_loops/park.mp3"),
  education("sfx_loops/education.mp3"),
  plasticsEnergy("sfx_loops/plastics_energy.mp3"),
  plasticsFactory("sfx_loops/plastics_factory.mp3"),
  solarPanels("sfx_loops/solar_panels.mp3"),
  badHousing("sfx_loops/bad_housing.mp3"),
  garden("sfx_loops/garden.mp3"),
  townHall("sfx_loops/diplomacy.mp3"),
  house("sfx_loops/house.mp3"),
  wind("sfx_loops/wind.mp3"),
  forest("sfx_loops/forest.mp3"),
  meadow("sfx_loops/meadow.mp3");

  final String path;
  const SfxLoop(this.path);
}

class Sfx {
  static double _musicVolume = 0.2;
  static double _effectsVolume = 0.4;

  static bool _initialized = false;
  static int _step = 0;
  // static final Map<SfxType,  AudioPool> _sfxPools = {};
  static final Map<SfxLoop, AudioPlayer> _sfxPlayers = {};
  static final Map<SfxLoop, Completer<void>> _sfxPlayerWork = {};
  static final Map<SfxLoop, double> _sfxVolumes = {};

  static setup() {
    if (_initialized) return;
    _initialized = true;
    // SfxType.values.map((e) => FlameAudio.createPool(e.path, maxPlayers: 1).then((pool) => _sfxPools[e] = pool));
    for (final loop in SfxLoop.values) {
      FlameAudio.loop(loop.path, volume: 0).then((player) {
        player.stop();
        player.seek(Duration.zero);
        _sfxPlayers[loop] = player;
      });
    }
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.stop();
  }

  static playBackground() {
    FlameAudio.bgm.play('background.mp3', volume: _musicVolume);
  }

  static stopBackground() {
    FlameAudio.bgm.stop();
  }

  static stopAllEffects() {
    resetEffects();
    playEffects(force: true);
  }

  static resetEffects() {
    _sfxVolumes.clear();
  }

  static setEffectVolume(SfxLoop effect, double volume) {
    if (volume <= 0) return;
    final sfxVolume = _sfxVolumes[effect] ?? 0;
    if (volume > sfxVolume) _sfxVolumes[effect] = volume;
  }

  static playEffects({bool force = false}) {
    if (!force && _step++ % 10 != 0) return;

    // scheduleMicrotask(() {
    for (final effect in SfxLoop.values) {
      final player = _sfxPlayers[effect];
      if (player == null) continue;

      final volume = _sfxVolumes[effect] ?? 0;

      if (volume == 0) {
        // EasyDebounce.debounce(effect.name, const Duration(milliseconds: 100), () {
        if (player.state == PlayerState.playing) {
          player.stop().then((_) => player.seek(Duration.zero));
        }
        // });
      } else {
        // EasyDebounce.debounce(effect.name, const Duration(milliseconds: 100), () {
        if (player.volume != volume * _effectsVolume) {
          player.setVolume(volume * _effectsVolume).then((_) {
            if (player.state != PlayerState.playing) {
              player.resume();
            }
          });
        }
        // });
      }
    }
    // });
  }

  static double get musicVolume => _musicVolume;

  static void updateMusicVolume(double volume) {
    _musicVolume = volume;
    FlameAudio.bgm.audioPlayer.setVolume(volume);
  }

  static double get effectsVolume => _effectsVolume;

  static void updateEffectsVolume(double volume) {
    _effectsVolume = volume;
  }
}
