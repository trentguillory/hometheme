![HomeTheme Animations](animation.gif)

# HomeTheme
## Replicating the App Store "Today" Page opening and closing animations

This project attempts to recreate the App Store Today page's card open and close animations. To achieve the animations found here, I made use of `GeometryReader`, `PreferenceKey`s, and custom `CoordinateSpace`s. 

## How it works

1. A `PreferenceKey` keeps track of the coordinate details of every rendered element in the list.
2. On tap, the selected item's location is noted, and a replication of that card is rendered on top of it, but outside of the `ScrollView`.
3. After this duplicate card is rendered, it triggers an expand animation that enlarges it to full screen. Herein is the reason for needing a duplicate card - scaling the selected card in place pushed all other elements out of view as well. 
4. To achieve the closing animation, a `DragGesture` is initialized when the user has already scrolled to the top of the screen. If an upwards drag is recognized, it begins to scale down the page, eventually triggering the dismiss sequence. 