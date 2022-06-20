/*
 * Copyright © 2020 Birju Vachhani
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:flutter/material.dart';

import 'adaptive_theme_mode.dart';

/// Entry point to change/modify theme or access theme related information
/// from [AdaptiveTheme].
/// An instance of this can be retrieved by calling [AdaptiveTheme.of].
mixin AdaptiveThemeManager<T extends Object> {
  /// provides current theme
  T get theme;

  /// provides the light theme
  T get lightTheme;

  /// provides the dark theme
  T get darkTheme;

  /// Returns current theme mode
  AdaptiveThemeMode get mode;

  /// Allows to listen to changes in them mode.
  ValueNotifier<AdaptiveThemeMode> get modeChangeNotifier;

  /// checks whether current theme is default theme or not. Default theme
  /// refers to he themes provided at the time of initialization
  /// of [MaterialApp].
  bool get isDefault;

  /// provides brightness of the current theme
  Brightness? get brightness;

  /// Sets light theme as current
  /// Uses [AdaptiveThemeMode.light].
  void setLight() => setThemeMode(AdaptiveThemeMode.light);

  /// Sets dark theme as current
  /// Uses [AdaptiveThemeMode.dark].
  void setDark() => setThemeMode(AdaptiveThemeMode.dark);

  /// Sets theme based on the theme of the underlying OS.
  /// Uses [AdaptiveThemeMode.system].
  void setSystem() => setThemeMode(AdaptiveThemeMode.system);

  /// Allows to set/change theme mode.
  void setThemeMode(AdaptiveThemeMode mode);

  /// Allows to set/change the entire theme.
  /// [notify] when set to true, will update the UI to use the new theme..
  void setTheme({
    required T light,
    T? dark,
    bool notify = true,
  });

  /// Allows to toggle between theme modes [AdaptiveThemeMode.light],
  /// [AdaptiveThemeMode.dark] and [AdaptiveThemeMode.system].
  void toggleThemeMode() {
    final nextModeIndex = (mode.index + 1) % AdaptiveThemeMode.values.length;
    final nextMode = AdaptiveThemeMode.values[nextModeIndex];
    setThemeMode(nextMode);
  }

  /// Saves the configuration to the shared-preferences. This can be useful
  /// when you want to persist theme settings after clearing
  /// shared-preferences. e.g. when user logs out, usually, preferences
  /// are cleared. Call this method after clearing preferences to
  /// persist theme mode.
  Future<bool> persist();

  /// Resets configuration to default configuration which has been provided
  /// while initializing [MaterialApp].
  /// If [setTheme] method has been called with [isDefault] to true, Calling
  /// this method afterwards will use theme provided by [setTheme] as default
  /// themes.
  Future<bool> reset();
}
