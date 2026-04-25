# ⏰ TimeRangeSelectorWidget

> An elegant and customizable Flutter widget for selecting time ranges with an intuitive picker UI.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)
![Pub](https://img.shields.io/badge/Pub-1.0.0-blue?style=flat-square)
![Stars](https://img.shields.io/badge/Stars-4-yellow?style=flat-square)

📦 **Ready for pub.dev!** The go-to solution for Flutter apps that need time range selection — booking apps, attendance trackers, schedules, and more.

---

## ✨ Features

- 🕐 **Intuitive Picker** — Two scrollable time wheels for start & end time
- 📱 **12h / 24h Format** — Toggle between AM/PM and 24-hour format
- 🎨 **Fully Customizable** — Colors, dimensions, item count, text styles
- ✅ **Validation** — Built-in checks for invalid ranges (end before start)
- 🔗 **Auto Fill Mode** — Auto-calculate duration as user picks times
- 📅 **Presets** — Quick-select common ranges (Last Hour, Today, This Week)
- ♿ **Accessible** — Semantic labels and screen reader support
- 📱 **Platform Ready** — Android, iOS, Web, macOS, Windows, Linux

---

## 📦 Installation

```bash
flutter pub add time_range_selector_widget
```

Or add manually to `pubspec.yaml`:

```yaml
dependencies:
  time_range_selector_widget: ^1.0.0
```

---

## 🚀 Quick Start

```dart
import 'package:time_range_selector_widget/time_range_selector_widget.dart';

// Basic usage
TimeRangeSelectorWidget(
  onRangeSelected: (startTime, endTime) {
    print('Start: $startTime, End: $endTime');
  },
)

// With initial values
TimeRangeSelectorWidget(
  initialStartTime: TimeOfDay(hour: 9, minute: 0),
  initialEndTime: TimeOfDay(hour: 17, minute: 0),
  onRangeSelected: (start, end) => scheduleShift(start, end),
)

// 24-hour format
TimeRangeSelectorWidget(
  use24HourFormat: true,
  onRangeSelected: (start, end) => print('Shift: ${formatDuration(start, end)}'),
)
```

---

## 🎛️ Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `initialStartTime` | `TimeOfDay` | `TimeOfDay(hour: 0, minute: 0)` | Initial start |
| `initialEndTime` | `TimeOfDay` | `TimeOfDay(hour: 23, minute: 59)` | Initial end |
| `use24HourFormat` | `bool` | `false` | 24h or 12h AM/PM |
| `onRangeSelected` | `void Function(TimeOfDay, TimeOfDay)` | `required` | Selection callback |
| `minTime` | `TimeOfDay` | `null` | Minimum selectable time |
| `maxTime` | `TimeOfDay` | `null` | Maximum selectable time |
| `minuteInterval` | `int` | `1` | Minute steps (5, 10, 15, 30) |
| `wheelHeight` | `double` | `40.0` | Height of each scroll wheel |
| `backgroundColor` | `Color` | `null` | Widget background |
| `accentColor` | `Color` | `Theme.of(context).primaryColor` | Selection highlight |
| `textStyle` | `TextStyle` | `null` | Time text style |

---

## 🎨 Customization Examples

### 30-Minute Intervals (Meeting Scheduler)
```dart
TimeRangeSelectorWidget(
  minuteInterval: 30,
  initialStartTime: TimeOfDay(hour: 10, minute: 0),
  initialEndTime: TimeOfDay(hour: 11, minute: 0),
  onRangeSelected: (start, end) => bookMeetingSlot(start, end),
)
```

### Business Hours Only
```dart
TimeRangeSelectorWidget(
  minTime: TimeOfDay(hour: 9, minute: 0),
  maxTime: TimeOfDay(hour: 18, minute: 0),
  minuteInterval: 30,
  use24HourFormat: true,
  onRangeSelected: (start, end) => scheduleShift(start, end),
)
```

### With Custom Colors
```dart
TimeRangeSelectorWidget(
  backgroundColor: Color(0xFFF5F5F5),
  accentColor: Color(0xFF6C63FF),
  wheelHeight: 48,
  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
  onRangeSelected: (start, end) => logHours(start, end),
)
```

---

## 📸 Screenshots

| 12-Hour | 24-Hour |
|---------|---------|
| ![12h](screenshots/12h.png) | ![24h](screenshots/24h.png) |

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing`)
5. Open a Pull Request

---

## 📄 License

```
MIT License
Copyright (c) 2024 Shajedur Rahman Panna
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

<p align="center">
  Made with ❤️ by <a href="https://github.com/SHAJED99">Shajedur Rahman Panna</a>
</p>
