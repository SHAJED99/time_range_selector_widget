# Time Range Selector Widget

Easily select time range.


# Getting Started

Add TimeRangeSelectorWidget widget to your project

1. Add this code in your project.
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
<img src="https://raw.githubusercontent.com/SHAJED99/time_range_selector_widget/main/screenshots/1.gif" alt="Example of time_range_selector_widget" />
<img src="https://raw.githubusercontent.com/SHAJED99/time_range_selector_widget/main/screenshots/4.gif" alt="Example of time_range_selector_widget" />
<img src="https://raw.githubusercontent.com/SHAJED99/time_range_selector_widget/main/screenshots/5.gif" alt="Example of time_range_selector_widget" />


### Handler Builder
```dart
handleBuilder: (itemIndex, offset) {
    return Container(
    width: stockWidth - 8,
    height: stockWidth - 8,
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
    ),
    child: FittedBox(child: Text((itemIndex + minTime).toString(), style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold))),
    );
},
```
\n
\n
<img src="https://raw.githubusercontent.com/SHAJED99/time_range_selector_widget/main/screenshots/2.gif" alt="Example - Handler Builder" />
\nExample - Handler Builder


### Index Builder
```dart
positionalDotBuilder: (itemIndex, offset) {
    return FittedBox(child: Text((itemIndex + minTime).toString()));
},
```
\n
\n
<img src="https://raw.githubusercontent.com/SHAJED99/time_range_selector_widget/main/screenshots/3.gif" alt="Example - Index Builder" />
\nExample - Index Builder


### Child Builder for hour
```dart
childBuilder: (currentTime) {
    return Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
        colors: [
            Colors.black.withOpacity(0.05),
            Colors.black.withOpacity(0.1)
        ],
        ),
    ),
    child: Center(
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
            Text(currentTime.toString(), style: const TextStyle(fontSize: 70, fontWeight: FontWeight.bold, height: 1)),
            Text(currentTime > 1 ? "Hours" : "Hour", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
        ],
        ),
    ),
    );
},
```
\n
\n
<img src="https://raw.githubusercontent.com/SHAJED99/time_range_selector_widget/main/screenshots/4.gif" alt="Example - Child Builder for hour" />
\nExample - Child Builder for hour


### Child Builder for minute
```dart
childBuilder: (currentTime) {
    return Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
        colors: [
            Colors.black.withOpacity(0.05),
            Colors.black.withOpacity(0.1)
        ],
        ),
    ),
    child: Center(
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
            Text((currentTime * 5).toString(), style: const TextStyle(fontSize: 70, fontWeight: FontWeight.bold, height: 1)),
            Text(currentTime > 0 ? "Minutes" : "Minute", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
        ],
        ),
    ),
    );
},
```
\n
\n
<img src="https://raw.githubusercontent.com/SHAJED99/time_range_selector_widget/main/screenshots/6.gif" alt="Example - Child Builder for minute" />
\nExample - Child Builder for minute


### Easily customizable
<img src="https://raw.githubusercontent.com/SHAJED99/time_range_selector_widget/main/screenshots/6.gif" alt="Example - Child Builder for minute" />
