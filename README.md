# Time Range Selector Widget

Easily select a time range.

### NOTE
Now Material 3 theme is enabled.

## Getting Started

To use the `TimeRangeSelectorWidget` widget in your project, follow these steps:

1. Add the following code to your project:

   ```dart
   TimeRangeSelectorWidget(
       onChangeValue: (currentTime) {
           // TODO: Add your callback function here
       },
       childBuilder: (currentTime) {
           // TODO: Add your widget here
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
   )
   ```

## Example

![Example](https://raw.githubusercontent.com/SHAJED99/time_range_selector_widget/main/screenshots/1.gif)

## Handler Builder

```dart
handleBuilder: (itemIndex, offset) {
    return Container(
        width: stockWidth - 8,
        height: stockWidth - 8,
        padding: const EdgeInsets(8),
        decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape circle,
        ),
        child: FittedBox(child: Text((itemIndex + minTime).toString(), style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold))),
    );
}
```

### Example - Handler Builder

![Example - Handler Builder](https://raw.githubusercontent.com/SHAJED99/time_range_selector_widget/main/screenshots/2.gif)

## Index Builder

```dart
positionalDotBuilder: (itemIndex, offset) {
    return FittedBox(child: Text((itemIndex + minTime).toString()));
}
```

![Example - Index Builder](https://raw.githubusercontent.com/SHAJED99/time_range_selector_widget/main/screenshots/3.gif)

### Example - Index Builder

## Child Builder for Hour

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
}
```

![Example - Child Builder for Hour](https://raw.githubusercontent.com/SHAJED99/time_range_selector_widget/main/screenshots/4.gif)

### Example - Child Builder for Hour

## Child Builder for Minute

```dart
childBuilder: (currentTime) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                    Colors.black.withOpacity(0.05),
                    Colors black.withOpacity(0.1)
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
}
```

![Example - Child Builder for Minute](https://raw.githubusercontent.com/SHAJED99/time_range_selector_widget/main/screenshots/6.gif)

### Example - Child Builder for Minute

## Easily Customizable

![Easily Customizable](https://raw.githubusercontent.com/SHAJED99/time_range_selector_widget/main/screenshots/5.gif)