# Flutter Squricle Study

A Flutter study and comparison of different Squircle ShapeBorder options.

>### TODOs
>
>1. Compare performance impact of the used and studied Squircle **ShapeBorder**'s versus vanilla `RoundedRectangleBorder` and `StadiumBorder`.
>2. Compare the shapes that are claimed to be the best match to iOS Squircle below, to **actual** different Squircle shapes drawn by iOS Swift-UI.

This demo allows you to visually compare the difference or similarity between different hyper ellipses, or so-called **Squircle** border rounding on rectangles.

In this study, a package called `figma_squircle` is used as reference. This package is used and regarded by many as the **best Flutter approximation** of the **iOS Squircle** shape. To verify this, it should be compared with actual iOS SwiftUI produced shapes. As a starting point, it is used for comparisons and findings presented in this study. 

With the Flutter **squircle_study** app in this repo, you can cross compare any two selected shapes at different sizes and radius.

The performance impact of using **any** other shape than **RoundedRectangleBorder** has been mentioned in issues and Twitter comments, even for just the SDK **ContinuousRectangleBorder**, but even more so for the `figma_squircle`. The **performance impact** of the shapes should be studied further.

The **Shape** options you can compare with this **squircle_study** app are:

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/shapes.png" alt="shapes"/>

_Studied Squircle like Flutter **ShapeBorder** implementations_

Below we take a closer look at them all, comparing them all to the **FigmaSquircle** from the package `figma_squircle`.

## Circular

The standard circular rounded rectangle border shape with an outline provided by Flutter.

* shortName: RoundedRectangleBorder,
* from: Flutter SDK
* url: https://api.flutter.dev/flutter/painting/RoundedRectangleBorder-class.html
* Shape can break down: **NO**
> Stays at circular stadium shape when radius exceeds its stadium radius.

### Findings
The difference between **Circular** and **FigmaSquircle** is subtle, but still visible to a sharp and keen designer eye. At a border radius < 0.5 times (in the example 96 dp) of the stadium radius (stadium radius would be 200 in the example below), we can see a subtle but clear difference:

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/circular_low.png" alt="circular low"/>

_**ShapeBorder** RoundedRectangleBorder_

It is more obvious when zoomed in:

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/circular_low_zoom.png" alt="circular low zoom"/>

_**ShapeBorder** RoundedRectangleBorder, zoomed for a closer look_

The difference between a standard circular border and the **FigmaSquircle** gets lower as the radius increases, and we get closer to the stadium radius.

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/circular.png" alt="circular"/>

_**ShapeBorder** RoundedRectangleBorder at 0.75x of stadium radius_

When zoomed, it is even more obvious that there is hardly any difference at 0.75 times what would be a stadium border.

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/circular_zoom.png" alt="circular zoom"/>

_**ShapeBorder** RoundedRectangleBorder at 0.75x of stadium radius, zoomed for a closer look_


We will se this effect further when comparing with the circular **StadiumBorder**. It looks like the **FigmaSquircle** does not implement any continuous border effect the closer we get to the stadium radius, and none at all at stadium radius. It is unknown if this is correct behavior, compared to the desired actual **iOS Squircle** border, but it seems unlikely that it would be.

At a radius equal to or greater than the shape's stadium radius, the **RoundedRectangleBorder** produces a **StadiumBorder**:

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/circular_stadium.png" alt="circular_stadium"/>

_**ShapeBorder** RoundedRectangleBorder when radius equals stadium radius is the same as a **StadiumBorder**_


### Conclusion - Circular RoundedRectangleBorder

If **FigmaSquircle** at smoothing **0.6** is a correct representation of the **iOS Swift-UI** Squircle, then 
**Circular RoundedRectangleBorder** is **NOT** an acceptable compromise if high fidelity is desired at mid-border radius. 

For low fidelity it may be acceptable, but keen eyes will feel that something is off.

We also have a first indication that maybe the **FigmaSquircle** is not a correct representation of the **Swift-UI** squircle at border radius approaching or equal to stadium radius, since it then becomes equal to a circular stadium border.


## ContinuousRectangleBorder

The continuous rounded rectangle border shape is provided by Flutter SDK. It was supposed to bring the iOS squircle border to Flutter, but the implementation is very far from it.

* shortName: ContinuousRectangleBorder
* from: Flutter SDK
* url: https://api.flutter.dev/flutter/painting/ContinuousRectangleBorder-class.html
* Shape can break down: **YES**
> The source code mentions limit checks to prevent the `ContinuousRectangleBorder` to get what it calls a "TIE-fighter" shape. In this demo, we can still observe the TIE-fighter shape at higher border radius. The attempt to prevent this shape is thus not completely successful. **TODO(rydmike)**: Consider raising an issue about it.
* Other issues
> It does not come with a Stadium border option. 

### Findings
The difference between **ContinuousRectangleBorder** and **FigmaSquircle** is very significant:

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/continuous_rectangle_border.png" alt="continuous_rectangle_border"/>

_**ShapeBorder** ContinuousRectangleBorder_

At high border radius, shown below, the **ContinuousRectangleBorder** creates a TIE-fighter shape. This is not desirable.

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/continuous_rectangle_border_break.png" alt="continuous_rectangle_border_break"/>

_**ShapeBorder** ContinuousRectangleBorder getting TIE-fighter shape_

### Conclusion - ContinuousRectangleBorder

If **FigmaSquircle** at smoothing **0.6** is a correct representation of the **iOS Swift-UI** Squircle, then
**ContinuousRectangleBorder** is **NOT** at all an acceptable option.

The performance impact of the **ContinuousRectangleBorder** over **RoundedRectangleBorder** has also been mentioned as an issue. Performance impacts when using anything else than **RoundedRectangleBorder** should be studied further.


## ContinuousRectangleBorder x 2.3529

A Flutter continuous rounded rectangle border shape using radius multiplied with 2.3529.
It is mentioned in a Flutter issue that a `ContinuousRectangleBorder` that has its border radius multiplied with 2.3529 becomes close to an iOS squircle. 

> This is mentioned and claimed in [issue 91523](https://github.com/flutter/flutter/issues/91523) where it is said "Currently, `ContinuousRectangleBorder` requires a `borderRadius` of ~24 to resemble the `RoundedRectangle` with a `cornerRadius` of ~10.2". So basically 24/10.2 = 2.3529, as used here. 

* shortName: ContinuousRectangleBorder x 2.3529
* from: Flutter SDK x factor
* url: 'https://api.flutter.dev/flutter/painting/ContinuousRectangleBorder-class.html'
* Shape can break down: **YES**
> The TIE fighter shape issue applies here too. It occurs earlier since the radius is multiplied by 2.3529.


### Findings
The difference between **ContinuousRectangleBorder x 2.3529** and **FigmaSquircle** is clear, but not so significant at border radius < 0.5 stadium border. 

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/continuous_rectangle_border_mult_low.png" alt="continuous_rectangle_border_mult_low"/>

_**ShapeBorder** ContinuousRectangleBorder x 2.3529 vs. FigmaSquircle at smoothing 0.6_


Especially not if we change the smoothness of the **FigmaSquircle** from **0.6** to maximum **1.0**. As shown below, it then becomes an almost perfect match:  

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/continuous_rectangle_border_mult_low_smooth_1.png" alt="continuous_rectangle_border_mult_low_smooth_1"/>

_**ShapeBorder** ContinuousRectangleBorder x 2.3529 vs. FigmaSquircle at smoothing 1.0_

At higher border radius, e.g. at 0.75x of stadium radius, the gap in visuals becomes more significant and the smoothing factor on **FigmaSquircle** does not really matter anymore:

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/continuous_rectangle_border_mult.png" alt="continuous_rectangle_border_mult"/>

_**ShapeBorder** ContinuousRectangleBorder x 2.3529, at 0.75x of its stadium border radius_

At this border radius, it might also be the **FigmaSquircle** that is the **poorer** squircle shape. 

The TIE fighter effect when using **ContinuousRectangleBorder x 2.3529** starts already at 0.6 times the stadium radius.

#### Conclusion - ContinuousRectangleBorder x 2.3529

If **FigmaSquircle** at smoothing **0.6** is a correct representation of the **iOS Swift-UI** Squircle, then
**ContinuousRectangleBorder x 2.3529** is **NOT** at an exact match for it, but it is **not** a bad Squircle shape.

At border radius of < 0.5 times the stadium radius, and using smoothness 1.0 for the **FigmaSquircle**, the **ContinuousRectangleBorder x 2.3529** is for practical visual comparisons a good fit.


### SquircleBorder PR

A PR for a Squircle that was rejected in Flutter SDK. It was discussed here https://github.com/flutter/flutter/pull/27523. This is a RydMike code revival of the PR with some minor mods.

* shortName: SquircleBorder
* from: Flutter rejected PR
* url: https://github.com/jslavitz/flutter/blob/4b2d32f9ebb1192bce695927cc3cab13e94cce39/packages/flutter/lib/src/painting/continuous_rectangle_border.dart
* Shape can break down: **YES**
> The `SquircleBorder` border has poor behavior with higher border radius, it cannot become a stadium, it stops changing shape at higher relative border radius.
* Other issues
> The implementation is not an `OutlinedBorder`, so it has no outline capability. This needs to be added.

### Findings

The difference between **SquircleBorder PR** and **FigmaSquircle** is none existing at border radius < 0.49 of the stadium radius, when using **FigmaSquircle** with smoothness 0.6.

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/squircle_border_pr.png" alt="squircle_border_pr"/>

_**ShapeBorder** SquircleBorder PR at radius < 0.5x of its stadium radius_

The **SquircleBorder PR** stops responding to border radius increases when the radius is >= 0.5x the stadium radius and can **not** be used for Squircle shapes where the radius if from 0.5x to 1x of the stadium radius. 

Up and until that radius, it works very well and matches the **FigmaSquircle**. On the other hand, it has also been shown that for a radius range that exceeded 0.5x stadium radius, that the **FigmaSquircle** gets closer and closer to the plain circular border represented by the **RoundedRectangleBorder**. 



<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/squircle_border_pr_break.png" alt="squircle_border_pr_break"/>

_**ShapeBorder** SquircleBorder PR at radius < 0.75x of its stadium radius_

It could also be argued that the **SquircleBorder PR** refrains from drawing shapes for a radius for which it no longer produces a correct squircle result. Whereas, the **FigmaSquircle** then instead approaches a vanilla circular border, as the stadium radius is approached.

### Conclusion - SquircleBorder PR

If **FigmaSquircle** at smoothing **0.6** is a correct representation of the **iOS Swift-UI** Squircle, then
**SquircleBorder PR** is an **acceptable** option at lower radius than **0.5x Stadium radius**. At higher border radius it visually stops changing it radius, since it cannot draw a squircle shape any higher radius than that.


## FigmaSquircle

A Flutter package implementation of Figma corner smoothing.

This package is used and regarded by many as one of the best approximations of the **iOS squircle shape**. It is an implementation of the **FigmaSquircle** shape. It has a smoothness factor from 0.0 to 1.0, at value **0.6** the Figma shape **claims** to be **identical** to the **iOS squircle shape**. 

At same smoothness, this `figma_squircle` package should also then be identical to the iOS squircle. To **verify** this, it should be compared to **actual** iOS SwiftUI produced shapes.

In this study, we use it as a reference to show how others deviate from it.

* shortName: SmoothRectangleBorder
* from: package figma_squircle
* url: https://pub.dev/packages/figma_squircle
* Shape can break down: **YES**
> The shape breaks down with border radius exceeding the shape stadium radius.


### Findings

The **FigmaSquircle** breaks down when border radius exceeds its Stadium border.

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/figma_squircle_breaks.png" alt="figma_squircle_breaks"/>

_**ShapeBorder** FigmaSquircle (SmoothRectangleBorder) at radius > than its stadium radius_

For border radius > 0.5x and <= 1.0x of the shape's stadium radius, the **FigmaSquircle** gets closer to an ordinary circular rounded rectangle border. At a border radius of > 0.9x and <= 1.0x of the shape's stadium radius, we can no longer observe any practical difference from a normal circular border made with **RoundedRectangleBorder**: 

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/figma_squircle_equal.png" alt="figma_squircle_equal"/>

_**ShapeBorder** FigmaSquircle (SmoothRectangleBorder) at radius 0.9x of its stadium radius_


### Conclusion - FigmaSquircle

If **FigmaSquircle** at smoothing **0.6** is a correct representation of the **iOS Swift-UI** Squircle, then this is a good choice for fidelity with iOS shapes. 

However, **FigmaSquircle** shape breaks down when the radius exceeds the shape's stadium radius. A good shape algorithm should stay at its equivalent stadium shaped when the stadium radius is exceeded. 

It has also been observed that for border radius of > 0.5x and <= 1.0x of the shape's stadium radius, that the **FigmaSquircle** shape starts to take the shape of just an ordinary circular rounded rectangle border. It is at this stage unknown if this is correct compared to how actual **iOS** stadium shapes look. Based on a quick look, it probably is not. **This needs to be verified**.

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

The difference between **SmoothCorner** and **FigmaSquircle** appears to be negligible. Visually, the results appear to be identical when using the same smoothness factor. **SmoothCorner** also supports the smoothness factor that **FigmaSquircle** has.

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/smooth_corner.png" alt="smooth_corner"/>

_**ShapeBorder** SmoothCorner and FigmaSquircle are visually identical_

The **SmoothCorner** does not break down when border radius exceeds the shape **Stadium** radius.

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/smooth_corner_no_break.png" alt="smooth_corner_no_break"/>

_**ShapeBorder** SmoothCorner does not break down like FigmaSquircle at radius > stadium radius_

### Conclusion - SmoothCorner

If **FigmaSquircle** at smoothing **0.6** is a correct representation of the **iOS Swift-UI** Squircle, then
**SmoothCorner** is **correct** as well. Since they are identical, **SmoothCorner** has the same questionable stadium shape as **FigmaSquircle**.

**SmoothCorner** has one advantage over **FigmaSquircle** and that is that shape does not break down when the radius exceeds the shape's stadium radius. This is a nice and desired feature and matches how **RoundedRectangleBorder** behaves in relations to its **StadiumBorder** shape, it stays at **stadium** shape when the stadium radius is exceeded.

The performance of **SmoothCorner** has no known feedback, since it is not used as much as the **FigmaSquircle**. Its performance impact should be studied as well.


## CupertinoCorners

A widget and border used to make cupertino rounded corners also referred to as squircle, using a bezier path and having the two points in the corners.

* shortName: Cupertino SquircleBorder
* from: package cupertino_rounded_corners
* url: https://pub.dev/packages/cupertino_rounded_corners

### Findings

The **CupertinoCorners** appears to be visually pretty identical to **ContinuousRectangleBorder**.

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/cupertino_border.png" alt="cupertino_border"/>

_**ShapeBorder** CupertinoCorners and ContinuousRectangleBorder are visually identical_

It has the same TIE-fighter issue too:

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/cupertino_border_tie_fighter.png" alt="cupertino_border_tie_fighter"/>

_**ShapeBorder** CupertinoCorners has the same TIE-fighter shape breakdown as ContinuousRectangleBorder_


At a border radius larger than the shortest side, the TIE-fighter shapes do diverge. The **ContinuousRectangleBorder** stops taking on increased TIE-fighter shape, but with the **CupertinoCorners** it becomes even more pronounced and doubled:

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/cupertino_border_tie_fighter_dual.png" alt="cupertino_border_tie_fighter_dual"/>

_**ShapeBorder** CupertinoCorners TIE-fighter shape gets more aggressive than ContinuousRectangleBorder_

### Conclusion - CupertinoCorners

There is no reason to use **CupertinoCorners** over the **ContinuousRectangleBorder** that exists in the Flutter SDK. It is also as a poor match for the **FigmaSquircle** as the **ContinuousRectangleBorder**.

 
### SuperEllipse

The **SuperEllipse** is a package for creating superellipse shapes in flutter. A superellipse is a shape constituting a transition between a rectangle and a circle.

* shortName: SuperellipseShape
* from: package superellipse_shape,
* url: https://pub.dev/packages/superellipse_shape

### Findings

The **SuperEllipse** appears to be visually pretty identical to **ContinuousRectangleBorder**.

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/super_ellipse.png" alt="super_ellipse"/>

_**ShapeBorder** SuperEllipse and ContinuousRectangleBorder are visually identical_


It has the same TIE-fighter issue too, but unlike **CupertinoCorners** it is identical to **ContinuousRectangleBorder** at any given border radius, also **very** high ones.

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/super_ellipse_tie_fighter.png" alt="super_ellipse_tie_fighter"/>

_**ShapeBorder** CupertinoSuperEllipse has the same TIE-fighter shape breakdown as ContinuousRectangleBorder_

### Conclusion - SuperEllipse

There is no reason to use **SuperEllipse** over the **ContinuousRectangleBorder** that exists in the Flutter SDK. It is also as a poor match for the **FigmaSquircle** as the **ContinuousRectangleBorder**.

### StadiumBorder

The Flutter standard circular stadium border. It fits a stadium-shaped border, a box with 
semicircles on the ends, within the rectangle of the widget it is applied to.

* shortName: StadiumBorder
* from: Flutter SDK
* url: https://api.flutter.dev/flutter/painting/StadiumBorder-class.html

### Findings

There is **NO** visible difference between a **FigmaSquircle** and the standard Flutter SDK circular **StadiumBorder** when using a border radius that equals the shape's stadium radius.

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/stadium.png" alt="stadium"/>

_**ShapeBorder** StadiumBorder and FigmaSquircle are visually identical_

The smoothness factor also has no impact on the **FigmaSquircle** when the border radius equals the stadium radius.

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/stadium_figma.png" alt="stadium_figma"/>

_**ShapeBorder** StadiumBorder and FigmaSquircle are visually identical, also when taking a closer zoomed in look_

### Conclusion - StadiumBorder

There is no point in using the **FigmaSquircle** for a **stadium** shape, it is identical to **StadiumBorder** at any radius that equals the shapes' stadium radius. Already at a radius about 0.6x of the stadium radius, we are beginning to look at negligible visual differences between **FigmaSquircle** and circular **RoundedRectangleBorder**. 

## SquircleStadiumBorder PR

A PR for a Stadium Squircle that was rejected in Flutter SDK. It was discussed 
here https://github.com/flutter/flutter/pull/27523. This is a RydMike code 
revival of the PR with some mods.

* shortName: SquircleStadiumBorder
* from: Flutter rejected PR
* url: https://github.com/jslavitz/flutter/blob/4b2d32f9ebb1192bce695927cc3cab13e94cce39/packages/flutter/lib/src/painting/continuous_stadium_border.dart',

* Shape can break down: **YES**
> The shape shrinks its height when width approaches height, and wise versa. This is **NOT** a desired behavior.
* Other issues
> The implementation is not an `OutlinedBorder`, so it has no outline capability. This needs to be added.

### Findings

The **SquircleStadiumBorder PR** looks better than **FigmaSquircle**:

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/squircle_stadium_border.png" alt="squircle_stadium_border"/>

_**ShapeBorder** SquircleStadiumBorder is a nice looking stadium Squircle than FigmaSquircle_

There is a clear difference between **SquircleStadiumBorder PR** and **FigmaSquircle** when zoomed:

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/squircle_stadium_border_zoom.png" alt="squircle_stadium_border_zoom"/>

_**ShapeBorder** SquircleStadiumBorder and FigmaSquircle zoomed in for a closer look_

The **FigmaSquircle** at stadium border is just equal to **StadiumBorder**. Comparing **SquircleStadiumBorder PR** to a **StadiumBorder** is thus the same as comparing it to **FigmaSquircle**:

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/squircle_stadium_border_stadium.png" alt="squircle_stadium_border_stadium"/>

_**ShapeBorder** SquircleStadiumBorder vs StadiumBorder is same as comparing to FigmaSquircle_


The **SquircleStadiumBorder** behaves differently for the **StadiumBorder** when the longer side approaches the same width as the shorter side. The width shrinks, before the shortest and longest sides change, and thus on which edges the stadium curve is drawn on, is swapped. This **behavior is not desired**, it should behave as the **StadiumBorder** does. 


<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/squircle_stadium.gif" alt="squircle_stadium"/>

_**ShapeBorder** SquircleStadiumBorder vs StadiumBorder when edge length changes_


### Conclusion - SquircleStadiumBorder PR

The **SquircleStadiumBorder PR** appears to be the **only stadium** shape that has a nice looking squircle shape. It **may be more correct** for an iOS stadium squircle shape, than the **FigmaSquircle**. This is based on that the **FigmaSquircle** is just identical to a normal circular stadium border, which an **iOS squircle** stadium shape may not be.


## SimonSquircle

A squircle implementation by Simon Lightfoot provided in a Gist.

* shortName: 'SimonSquircleBorder',
* from: 'slightfoot gist',
* url: 'https://gist.github.com/slightfoot/e35e8d5877371417e9803143e2501b0a',
* Shape can break down: **YES**
> The shape cannot handle border radius from 0 to less than 1.0, it draws very odd shapes then.

### Findings

Draws weird shapes for border radius from 0 to less than 1. The shape is **not** a squircle, it is something entirely different. Examples for different border radius shown below.

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/simon0.png" alt="simon0"/>

_**ShapeBorder** SimonSquircle at border radius 0.57_

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/simon1.png" alt="simon1"/>

_**ShapeBorder** SimonSquircle at border radius 1.36_

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/simon2.png" alt="simon2"/>

_**ShapeBorder** SimonSquircle at border radius 2.62_

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/simon3.png" alt="simon3"/>

_**ShapeBorder** SimonSquircle at border radius 26_

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/simon4.png" alt="simon4"/>

_**ShapeBorder** SimonSquircle at border radius 80_

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/simon5.png" alt="simon5"/>

_**ShapeBorder** SimonSquircle at border radius 133_

### Conclusion - SimonSquircle

Do not use this shape for iOS squircle shapes, it is **not** a match.

## Beveled

A rectangular border with flattened or "beveled" corners.

* shortName: BeveledRectangleBorder
* from: Flutter SDK
* url: https://api.flutter.dev/flutter/painting/BeveledRectangleBorder-class.html'

For obvious reason this shape is not compared, it is only included in the demo to show an alternative corner shape that exists, but is rarely used in the Flutter SDK.
