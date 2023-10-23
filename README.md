# Time Range Selector Widget

Easily select time range.


# Getting Started

Add TimeRangeSelectorWidget widget to your project

1. Add "flutter_inset_box_shadow" package from pub.dev
2. Add this code in your project.
```dart
TimeRangeSelectorWidget(
    initialTime: 2,
    maxTime: 10,
    stockColor: Colors.green,
    shadowColorLight: Colors.white.withOpacity(0.5),
    shadowColorDark: Theme.of(context).shadowColor.withOpacity(0.5),
    colorGradient: const [
        Color(0xFFF5F5F9),
        Color(0xFFE4E8EE),
    ],
    backgroundColor: const [
        Color(0xFFF5F5F9),
        Color(0xFFE4E8EE),
    ],
    onChangeValue: (currentTime) {
        // TODO: Add your callback function Here
    },
    childBuilder: (currentTime) {
        // TODO: Add your widget Here
        return Center(
            child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
                Text(currentTime.toString(), style: const TextStyle(fontSize: 70, fontWeight: FontWeight.bold, height: 1)),
                Text(currentTime > 1 ? "Hours" : "Hour", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
            ],
            ),
        );
    },
),
```

# Example
![Example](screenshots/1.gif)
