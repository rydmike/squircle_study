# Flutter Squricle Study

A Flutter study and comparison of different Squircle ShapeBorder options.

This demo allows you to visully compare the difference or similarity between different hyper ellipses, or so called Squircle border rounding on rectangles.

In this study a package called `figma_squircle` is used as reference. This package is used and regarded by many as one of the best approximations of the iOS shape. To verify this it should be compared with actual iOS SwiftUI produced shapes. In any case it used for comparisons in presented findings. With the app you can cross compare any two selected shapes.

The performance impact of using *any** other shape than **RoundedRectangleBorder** has also been mentioned in issues and comments, even for just SDK **ContinuousRectangleBorder** but even more so for `figma_squircle`. **Performance impact** should be studied further.

The **Shape** options you can compare with this repo are:

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/shapes.png" alt="shapes"/>

_Studied Squircle like BorderShapes_

## Circular

The standard circular rounded rectangle border shape with an outline provided by Flutter.

* shortName: RoundedRectangleBorder,
* from: Flutter SDK
* url: https://api.flutter.dev/flutter/painting/RoundedRectangleBorder-class.html
* Shape can break down: **NO**
> Stays circular stadium when radius exceeds its stadium radius.

### Findings
The difference between **Circular** and **FigmaSquircle** are quite subtle, but still visible to a sharp and keen designer eye. At a border radius < 0.5 times (in the example 96 dp) of the stadium radius (stadium radius would be 200 in the example below), we can see a subtle bu clear difference:

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/circular_low.png" alt="circular low"/>

It is more obvious when zoomed in:

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/circular_low_zoom.png" alt="circular low zoom"/>

The difference between a standard circular border and the **FigmaSquircle** get lower as radius increase and we get closer to the stadium radius.

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/circular.png" alt="circular"/>

When zoomed it is even more obvious that there is hardly any difference at 0.75 times what would be a stadium border.

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/circular_zoom.png" alt="circular zoom"/>

We will se this effect further when comparing with the circular stadium border. It looks like the **FigmaSquircle** does not implement any continuous border effect the closer we get to the stadium radius and none at all stadium radius. It is unknown if this is correct behavior when comparing to the desired actual **iOS Squircle** border.

At a radius equal to or greater than the shape's stadium radius, the **RoundedRectangleBorder** produces a **StadiumBorder**:

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/circular_stadium.png" alt="circular_stadium"/>

### Conclusion
If **FigmaSquircle** at smoothing **0.6** is a correct representation of the **iOS Swift-UI** Squircle, then 
**Circular RoundedRectangleBorder** is **NOT** an acceptable compromise if high fidelity is desired at mid border radius. 

For low fidelity it may be acceptable, but keen eyes will feel that something is off.

We also have a first indication of that maybe the **FigmaSquircle** is not a correct representation of the **Swift-UI** squircle at border radius approaching or equal to stadium radius, since it then becomes equal to a circular stadium border.


## ContinuousRectangleBorder

The continuous rounded rectangle border shape is provided by Flutter SDK. It was supposed to bring the iOS squircle border to Flutter, but the implementation is very far from it.

* shortName: ContinuousRectangleBorder
* from: Flutter SDK
* url: https://api.flutter.dev/flutter/painting/ContinuousRectangleBorder-class.html
* Shape can break down: **YES**
> The source code mentions limit checks to prevent the `ContinuousRectangleBorder` to get what it calls a TIE-fighter shape. In this demo we can still observe the TIE-fighter shape with high border radius, so the attempt to prevent this shape is not completely successful. Consider raising an issue about it.
* Other issues
> It does not come with a Stadium border option. 

### Findings
The difference between **ContinuousRectangleBorder** and **FigmaSquircle** are very significant:

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/continuous_rectangle_border.png" alt="continuous_rectangle_border"/>

At high border radius, shown below, the **ContinuousRectangleBorder** creates a TIE-fighter shapes, this is not desirable.

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/continuous_rectangle_border_break.png" alt="continuous_rectangle_border_break"/>

### Conclusion
If **FigmaSquircle** at smoothing **0.6** is a correct representation of the **iOS Swift-UI** Squircle, then
**ContinuousRectangleBorder** is **NOT** at all an acceptable option.

The performance impact of the **ContinuousRectangleBorder** over **RoundedRectangleBorder** has also been mentioned as an issue. Performance impacts when using anything else than **RoundedRectangleBorder** should be studied further.


## ContinuousRectangleBorder x 2.3529

A Flutter continuous rounded rectangle border shape using radius multiplied with 2.3529.
It is mentioned in a Flutter issue that a `ContinuousRectangleBorder` that has its border radius multiplied with 2.3529 becomes close to an iOS squircle. 

* shortName: ContinuousRectangleBorder x 2.3529
* from: Flutter SDK x factor
* url: 'https://api.flutter.dev/flutter/painting/ContinuousRectangleBorder-class.html'
* Shape can break down: **YES**
> The TIE fighter shape issue applies here too. It occurs earlier since the radius is multiplied with 2.3529.


### Findings
The difference between **ContinuousRectangleBorder x 2.3529** and **FigmaSquircle** are clear, but not so significant at border radius < 0.5 stadium border. 

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/continuous_rectangle_border_mult_low.png" alt="continuous_rectangle_border_mult_low"/>

Especially not if we change the smoothness of the **FigmaSquircle** from **0.6** to maximum **1.0**. As shown below it then becomes an almost perfect match:  

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/continuous_rectangle_border_mult_low_smooth_1.png" alt="continuous_rectangle_border_mult_low_smooth_1"/>

At higher border radius, e.g. at 0.75x of stadium radius, the gap in visuals become more significant and the smoothing factor on **FigmaSquircle** does not really matter anymore:

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/continuous_rectangle_border_mult.png" alt="continuous_rectangle_border_mult"/>

At this border radius it might also be the **FigmaSquircle** that is the poorer squircle. 

The TIE fighter effect when using **ContinuousRectangleBorder x 2.3529** starts already at 0.6 times the stadium radius.

#### Conclusion
If **FigmaSquircle** at smoothing **0.6** is a correct representation of the **iOS Swift-UI** Squircle, then
**ContinuousRectangleBorder x 2.3529** is **NOT** at an exact match for it, but it is **not** a bad Squircle shape.

At border radius of < 0.5 times the stadium radius, and using smoothness 1.0 for the **FigmaSquircle**, the **ContinuousRectangleBorder x 2.3529** is for practical visual comparisons an exact match.


### SquircleBorder PR

A PR for a Squircle that was rejected in Flutter SDK. It was discussed here https://github.com/flutter/flutter/pull/27523. This is a RydMike code revival of the PR with some mods.


* shortName: SquircleBorder
* from: Flutter rejected PR
* url: https://github.com/jslavitz/flutter/blob/4b2d32f9ebb1192bce695927cc3cab13e94cce39/packages/flutter/lib/src/painting/continuous_rectangle_border.dart
* Shape can break down: **YES**
> The `SquircleBorder` border has poor behavior with higher border radius, it cannot become a stadium, it stops changing shape at higher relative border radius.
* Other issues
> The implementation is not an `OutlinedBorder`, so it has no outline capability. This needs to be added.

### Findings
The difference between **SquircleBorder PR** and **FigmaSquircle** are none existing at border radius < 0.49 of the stadium radius, when using **FigmaSquircle** with smoothness 0.6.

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/squircle_border_pr.png" alt="squircle_border_pr"/>

The **SquircleBorder PR** stops responding to border radius increases when the radius is >= 0.5x the stadium radius and can **not** be used for Squircle shapes where the radius if from 0.5x to 1x of the stadium radius. Up and until that radius it works very well and matches the **FigmaSquircle**. On the other hand it has also been shown that for this radius range the **FigmaSquircle** get closer and closer to plain circular border represented by the **RoundedRectangleBorder**.

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/squircle_border_pr_break.png" alt="squircle_border_pr_break"/>

### Conclusion
If **FigmaSquircle** at smoothing **0.6** is a correct representation of the **iOS Swift-UI** Squircle, then
**SquircleBorder PR** is an **acceptable** option at lower radius than **0.5x Stadium radius**. At higher border radius it stops changing it radius.



## FigmaSquircle

A Flutter package implementation of Figma corner smoothing.

This package is used and regarded by many as one of the best approximations of the **iOS squircle shape**. It is an implementation of the **FigmaSquircle** shape. It has a smoothness factor from 0.0 to 1.0, at value **0.6** the Figma shape **claims** to be **identical** to the **iOS squircle shape**. 

At same smoothness, this `figma_squircle` package should also then be identical to the iOS squircle. To **verify** this, it should be compared to **actual** iOS SwiftUI produced shapes.

In this study we use it as a reference to show how others deviate from it.

* shortName: SmoothRectangleBorder
* from: package figma_squircle
* url: https://pub.dev/packages/figma_squircle
* Shape can break down: **YES**
> The shape breaks down with border radius exceeding the shape stadium radius.


### Findings
The **FigmaSquircle** breaks down when border radius exceeds its Stadium border.

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/figma_squircle_breaks.png" alt="figma_squircle_breaks"/>

For border radius > 0.5x and <= 1.0x of the shape's stadium radius, the **FigmaSquircle** gets closer to an ordinary circular rounded rectangle border. At a border radius of > 0.9x and <= 1.0x of the shape's stadium radius we can no lnoger observe any practical difference from a normal circular border made with **RoundedRectangleBorder**: 

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/figma_squircle_equal.png" alt="figma_squircle_equal"/>

### Conclusion
If **FigmaSquircle** at smoothing **0.6** is a correct representation of the **iOS Swift-UI** Squircle, then this is of course a good choice for fidelity with iOS shapes. 

However, **FigmaSquircle** shape breaks down when radius exceeds the stadium a radius. A good shape algo should stay at its equivalent stadium shaped when the stadium radius is exceeded. 

It has also been observed that for border radius of > 0.5x and <= 1.0x of the shape's stadium radius, that the **FigmaSquircle** shape starts to take the shape of just an ordinary circular rounded rectangle border. It is at this stage unkown if this is correct behavior with regards to how actual **iOS** stadium shapes look, but based on a quick look, it probably is not. **This needs to be verified**.

The performance impact of the **FigmaSquircle** has also been mentioned in issues. It should be studied further. 


## SmoothCorner

A rectangular border with variable smoothness imitated from Figma.

This is **another** implementation of the **Figma squircle**. It appears to be shape wise VERY
similar to above **FigmaSquircle**.

* shortName: SmoothRectangleBorder
* from: package smooth_corner
* url: https://pub.dev/packages/smooth_corner
* Shape can break down: **NO**
> Stays correctly shaped when border radius exceeds its stadium radius.

### Findings
The difference between **SmoothCorner** and **FigmaSquircle** appear to be negligible. Visually the results appear to be identical when using same smoothness factor, that **SmoothCorner** also supports. 

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/smooth_corner.png" alt="smooth_corner"/>

The **SmoothCorner** does not not break down when border radius exceeds the shape **Stadium** radius.

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/smooth_corner_no_break.png" alt="smooth_corner_no_break"/>

### Conclusion
If **FigmaSquircle** at smoothing **0.6** is a correct representation of the **iOS Swift-UI** Squircle, then
**SmoothCorner** is **correct** as well. Since they are identical, **SmoothCorner** has the same questionable stadium shape as **FigmaSquircle**.

**SmoothCorner** has one advantage over **FigmaSquircle** and that is that shape does not break down when the radius exceeds the shapes stadium radius. This is a nice and desired feature and matches how **RoundedRectangleBorder** behaves in relations ot its **StadiumBorder** shape, it stay at **stadium** shape when the stadium radius is exceeded.

The performance of **SmoothCorner** has no known feedback as it is not used as much as **FigmaSquircle**. It performance impact should be studied as well.


## CupertinoCorners

A widget and border to make cupertino rounded corners also referred to as squircles using a 
bezier path and having the two points in the corners.

* shortName: Cupertino SquircleBorder
* from: package cupertino_rounded_corners
* url: https://pub.dev/packages/cupertino_rounded_corners

### Findings

The **CupertinoCorners** appears to be visually pretty identical to **ContinuousRectangleBorder**.

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/cupertino_corners.png" alt="cupertino_corners"/>


It has the same TIE-fighter issue too:

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/cupertino_corners_tie_fighter.png" alt="cupertino_corners_tie_fighter"/>

At border radius > shortest side, the TIE-fighter shapes do diverge. The **ContinuousRectangleBorder** stops taking on increased TIE-fighter shape, but with the **CupertinoCorners** it becomes even more pronounced and doubled:

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/cupertino_corners_tie_fighter_dual.png" alt="cupertino_corners_tie_fighter_dual"/>


### Conclusion

There is no reason to use **CupertinoCorners** over the **ContinuousRectangleBorder** that exists in the Flutter SDK. It also as a poor match for the **FigmaSquircle** and thus presumably **iOS squircle**, as the **ContinuousRectangleBorder**.

 
### SuperEllipse

The **SuperEllipse** is a package for creating superellipse shapes in flutter. A superellipse is a shape constituting a transition between a rectangle and a circle.

* shortName: SuperellipseShape
* from: package superellipse_shape,
* url: https://pub.dev/packages/superellipse_shape

### Findings

The **SuperEllipse** appears to be visually pretty identical to **ContinuousRectangleBorder**.

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/super_ellipse.png" alt="super_ellipse"/>

It has the same TIE-fighter issue too, but unlike **CupertinoCorners** it is identical to **ContinuousRectangleBorder** at any given border radius, also **very** high ones.

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/super_ellipse_tie_fighter.png" alt="super_ellipse_tie_fighter"/>


### Conclusion

There is no reason to use **SuperEllipse** over the **ContinuousRectangleBorder** that exists in the Flutter SDK. It also as a poor match for the **FigmaSquircle** and thus presumably **iOS squircle**, as the **ContinuousRectangleBorder**.

### StadiumBorder

The Flutter standard circular stadium border. It fits a stadium-shaped border, a box with 
semicircles on the ends, within the rectangle of the widget it is applied to.

* shortName: StadiumBorder
* from: Flutter SDK
* url: https://api.flutter.dev/flutter/painting/StadiumBorder-class.html

### Findings

There is **NO** visible difference between a **FigmaSquircle** and standard Flutter SDK circular **StadiumBorder** when using a border radius that equals the shapes stadium radius.

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/stadium.png" alt="stadium"/>

The smoothness factor also has no impact on the **FigmaSquircle** when the border radius equals the stadium radius.

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/stadium_figma.png" alt="stadium_figma"/>

### Conclusion

There is no point in using the **FigmaSquircle** for a **stadium** shape, it is identical to **StadiumBorder** at any radius that equals the shapes' stadium radius. Already at a radius about 0.6x of the stadium radius, we are beginning to look at negligible visual differences between **FigmaSquircle** and circular **RoundedRectangleBorder**. 

## SquircleStadiumBorder PR

A PR for a Stadium Squircle that was rejected in Flutter SDK. It was discussed 
here https://github.com/flutter/flutter/pull/27523. This is a RydMike code 
revival of the PR with some mods.

* shortName: SquircleStadiumBorder
* from: Flutter rejected PR
* url: https://github.com/jslavitz/flutter/blob/4b2d32f9ebb1192bce695927cc3cab13e94cce39/packages/flutter/lib/src/painting/continuous_stadium_border.dart',

* Shape can break down: **YES**
> The shape shrinks its height when width approaches height, and wise versa, this is **NOT** desired behavior.
* Other issues
> The implementation is not an `OutlinedBorder`, so it has no outline capability. This needs to be added.

### Findings

The **SquircleStadiumBorder PR** appears to be the **stadium** shape that has a nice looking squircle shape. It may be more correct for an iOS stadium squircle shape them **FigmaSquircle** since it is identical to normal circular stadium border.

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/squircle_stadium_border.png" alt="squircle_stadium_border"/>



## SimonSquircle

A squircle implementation by Simon Lightfoot provided in a Gist.

* shortName: 'SimonSquircleBorder',
* from: 'slightfoot gist',
* url: 'https://gist.github.com/slightfoot/e35e8d5877371417e9803143e2501b0a',

###

## Beveled

A rectangular border with flattened or "beveled" corners.

* shortName: BeveledRectangleBorder
* from: Flutter SDK
* url: https://api.flutter.dev/flutter/painting/BeveledRectangleBorder-class.html'

For obvious reason this shape is not compared, it is only included in the demo to show an alternative corner shape that exists but is rarely used in the Flutter SDK.
