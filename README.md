# Flutter Squricle Study (v1.2.0)

A study and comparison of different Squircle `ShapeBorder` options in **Flutter**, using a Flutter app to compare available Squircle shapes visually.

## Version history

See [CHANGELOG](https://github.com/rydmike/squircle_study/blob/master/CHANGELOG.md) for a list of updates to this study and Flutter squricle demo app.

## Overview

There currently is no known rounded rectangle in **Flutter** that would be verified to be an exact match for the rounded rectangle shape created e.g. in Swift-UI with `RoundedRectangle(cornerRadius: myRadius, style: .continuous)` that would also be without issues in Flutter. This type of rounded rectangle with a continuous curvature is also known as a super ellipses shape or squircle.

In this study, a package called `figma_squircle` is used as reference. This package is used and regarded by many as the **best Flutter approximation** of the **iOS Squircle** shape. To verify this, it should be compared with actual iOS SwiftUI produced shapes. As a starting point, it is used for comparisons and for findings presented in this study.

With the Flutter **squircle_study** app in this repo used for this study, you can cross compare any two selected shapes at different sizes and curvature, with or without border.

In the Flutter GitHub repo, the [issue #91523](https://github.com/flutter/flutter/issues/91523) is used to track the implementation of an iOS matching continuously rounded rectangle.

## Summary of Findings

The `ContinuousRectangleBorder` in Flutter SDK is a super ellipses shape, but it is not a match for the one used in iOS on UI elements. 

The package `figma_squircle` is an implementation of the squircle used in **Figma**. The Figma Squircle claims to be a match for the iOS shape when used with smoothing factor **0.6**. It may be a good match when used border radius is lower than half of the shape's stadium radius, this should still be verified. At a higher radius than 0.5x of the shape's stadium radius, the shape starts to approach a standard circular border curvature. At stadium (also sometimes referred to as capsule or pill) radius, it is identical to a circular stadium shape. Which is not a continuously rounded stadium shape. The shape also **breaks down** at border radius higher than the shape's stadium radius.

There is a less known package called `smooth_corner`, that produces identical shapes to `figma_squircle`. It does **not** break down at border radius higher than the shape's stadium radius. However, it does not lerp animate radius and border width changes.

The performance impact of using **any** other shape than **RoundedRectangleBorder** has been mentioned, at least in X/Twitter posts and comments. They typically mention the **FigmaSquircle**, but also the SDK `ContinuousRectangleBorder`, but more often the `figma_squircle` package. The **performance impact** of the shapes should be studied further. See **Appendix A** at the end of the study report for more info about reported performance issue.

Some shapes may not implement linear interpolation correctly, and probably none of them implement shape transform from one `ShapeBorder` to another Flutter SDK `ShapeBorder`, like most Flutter SDK `ShapeBorder`s do. A proper Flutter iOS squircle shape should do all of these things correctly. 

Currently only shapes `RoundedRectangleBorder`, `StadiumBorder`, `BeveledRectangleBorder` and the updated `SquircleBorder` and `SquircleStadiumBorder` appears to handle `strokeAlign` on the used `BorderSide` correctly.


### TODOs

1. Compare performance impact of the used and studied Squircle **ShapeBorder**'s versus vanilla `RoundedRectangleBorder` and `StadiumBorder`.
2. Compare the shapes that are claimed to be the best match to iOS Squircle below, to **actual** different Squircle shapes drawn by iOS Swift-UI.

## Studied and Available Shapes

This demo allows you to visually compare the difference or similarity between different hyper ellipses, or so-called **Squircle** border rounding on rectangles.

The **Shape** options you can compare with this **squircle_study** app are:

* **Circular** aka **RoundedRectangleBorder** from: [Flutter SDK](https://api.flutter.dev/flutter/painting/RoundedRectangleBorder-class.html)
* **ContinuousRectangleBorder** from [Flutter SDK](https://api.flutter.dev/flutter/painting/ContinuousRectangleBorder-class.html)
* **ContinuousRectangleBorder x 2.3529** from [Flutter SDK x factor]('https://api.flutter.dev/flutter/painting/ContinuousRectangleBorder-class.html)
* **SquircleBorder PR** from [Flutter rejected PR code](https://github.com/jslavitz/flutter/blob/4b2d32f9ebb1192bce695927cc3cab13e94cce39/packages/flutter/lib/src/painting/continuous_rectangle_border.dart)
* **FigmaSquircle** from package [figma_squircle](https://pub.dev/packages/figma_squircle)
* **SmoothCorner** from package [smooth_corner](https://pub.dev/packages/smooth_corner)
* **CupertinoSquircleBorder** aka **CupertinoCorners** from package [cupertino_rounded_corners](https://pub.dev/packages/cupertino_rounded_corners)
* **SuperellipseShape** from package [superellipse_shape](https://pub.dev/packages/superellipse_shape)
* **StadiumBorder** from: [Flutter SDK](https://api.flutter.dev/flutter/painting/StadiumBorder-class.html)
* **SquircleStadiumBorder PR** from [Flutter rejected PR](https://github.com/jslavitz/flutter/blob/4b2d32f9ebb1192bce695927cc3cab13e94cce39/packages/flutter/lib/src/painting/continuous_stadium_border.dart)
* **SimonSquircleBorder** from [Slightfoot gist](https://gist.github.com/slightfoot/e35e8d5877371417e9803143e2501b0a)
* **BeveledRectangleBorder** from [Flutter SDK](https://api.flutter.dev/flutter/painting/BeveledRectangleBorder-class.html)

All are obviously not hyper ellipses or squircles, but included for comparison reasons.

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/shapes.png" alt="shapes"/>

_Studied Squircle like Flutter **ShapeBorder** implementations_


Below we take a closer look at them all, comparing them all to the **FigmaSquircle** from the package `figma_squircle`.

## Circular aka RoundedRectangleBorder

The standard circular rounded rectangle border shape with an outline, provided by Flutter SDK.

* Name: **RoundedRectangleBorder**
* From [Flutter SDK](https://api.flutter.dev/flutter/painting/RoundedRectangleBorder-class.html)
* Outline border stroke align correct: **YES**
* Shape lerp animates correctly: **YES**
* Shape can break down: **NO**
    * Correctly stays at circular stadium shape when radius exceeds its stadium radius.

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

* Name: **ContinuousRectangleBorder**
* From [Flutter SDK](https://api.flutter.dev/flutter/painting/ContinuousRectangleBorder-class.html)
* Outline border stroke align correct: **NO** 
    * **ISSUE**: Does center regardless of what BorderSide uses, that actually defaults to inside.  
    * **TODO**: Raise Flutter SDK issue.
* Shape lerp animates correctly: **YES**
* Shape can break down: **YES**
    * **ISSUE**: The source code mentions limit checks to prevent the `ContinuousRectangleBorder` to get what it calls a "TIE-fighter" shape. In this demo, we can still observe the TIE-fighter shape at higher border radius. The attempt to prevent this shape is thus not completely successful.
    * **TODO**: Raise Flutter SDK issue.
* Other issues
    * It does not have a Stadium border option. 

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

A Flutter continuous rounded rectangle border shape using radius multiplied with 2.3529. It is mentioned in a Flutter issue that a `ContinuousRectangleBorder` that has its border radius multiplied with 2.3529 becomes close to an iOS squircle. 

> The mentioned claim of fit with iOS border is in [issue 91523](https://github.com/flutter/flutter/issues/91523) where it is said "Currently, `ContinuousRectangleBorder` requires a `borderRadius` of ~24 to resemble the `RoundedRectangle` with a `cornerRadius` of ~10.2". So basically 24/10.2 = 2.3529, as used here, should be a match. 

* Name: **ContinuousRectangleBorder x 2.3529**
* From [Flutter SDK x factor]('https://api.flutter.dev/flutter/painting/ContinuousRectangleBorder-class.html)
* Outline border stroke align correct: **NO**
    * **ISSUE**: Does center regardless of what BorderSide uses, that actually defaults to inside.
    * **TODO**: Raise Flutter SDK issue.
* Shape lerp animates correctly: **YES**
* Shape can break down: **YES**
    * **ISSUE**: The source code mentions limit checks to prevent the `ContinuousRectangleBorder` to get what it calls a "TIE-fighter" shape. In this demo, we can still observe the TIE-fighter shape at higher border radius. The attempt to prevent this shape is thus not completely successful. The TIE fighter shape issue occurs earlier since the radius `ContinuousRectangleBorder` is multiplied by 2.3529.
    * **TODO**: Raise Flutter SDK issue.
* Other issues
    * It does not have a Stadium border option.
* Shape can break down: **YES**
> 


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

### Conclusion - ContinuousRectangleBorder x 2.3529

If **FigmaSquircle** at smoothing **0.6** is a correct representation of the **iOS Swift-UI** Squircle, then
**ContinuousRectangleBorder x 2.3529** is **NOT** at an exact match for it, but it is **not** a bad Squircle shape.

At border radius of < 0.5 times the shape's stadium radius, and when using smoothness 1.0 for the **FigmaSquircle**, the **ContinuousRectangleBorder x 2.3529** is for practical visual comparisons a fairly good fit.


### SquircleBorder PR

This shape is based on a PR for a Squircle that was rejected in Flutter SDK. It was discussed here https://github.com/flutter/flutter/pull/27523. This is a @rydmike code revival of the PR with some minor modifications. Changes include adding `BorderSide` support, with `strokeAlign` and supporting slightly higher relative radius in relation to the shape's stadium radius, updated lerp overrides and migration to null-safe code.

* Name: **SquircleBorder PR**
* From [Flutter rejected PR code](https://github.com/jslavitz/flutter/blob/4b2d32f9ebb1192bce695927cc3cab13e94cce39/packages/flutter/lib/src/painting/continuous_rectangle_border.dart)
* Outline border stroke align correct: **YES** (in @rydmike version)
* Shape lerp animates correctly: **YES** (in @rydmike version)
* Shape can break down: **YES**
    * The `SquircleBorder` border has poor behavior with higher border radius, it cannot become a stadium, it stops changing shape at higher relative border radius. Now on purpose limited to 0.65x of the shape's stadium radius, since it breaks down after that. One solution might be to switch a circular border radius like **Figma Squricle** and **Smooth Corner** do-  

### Findings

The difference between **SquircleBorder PR** and **FigmaSquircle** is none existing at border radius < 0.49 of the stadium radius, when using **FigmaSquircle** with smoothness 0.6.

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/squircle_border_pr.png" alt="squircle_border_pr"/>

_**ShapeBorder** SquircleBorder PR at radius < 0.5x of its stadium radius_

The **SquircleBorder PR** stops responding to border radius increases when the radius is >= 0.65x the stadium radius and can **not** be used for Squircle shapes where the radius is from 0.65x to 1x of the stadium radius. Up and until that radius, it works very well and matches the **FigmaSquircle**.

On the other hand, it has also been shown that for a radius range that exceeded 0.5x stadium radius, that the **FigmaSquircle** gets closer and closer to the plain circular border represented by the **RoundedRectangleBorder**. 

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/squircle_border_pr_break.png" alt="squircle_border_pr_break"/>

_**ShapeBorder** SquircleBorder PR at radius < 0.75x of its stadium radius_

It could also be argued that the **SquircleBorder PR** refrains from drawing shapes for a radius for which it no longer produces a correct squircle result. Whereas, the **FigmaSquircle** then instead approaches a vanilla circular border, as the stadium radius is approached.

### Conclusion - SquircleBorder PR

If **FigmaSquircle** at smoothing **0.6** is a correct representation of the **iOS Swift-UI** Squircle, then
**SquircleBorder PR** is an **acceptable** option at lower radius than **0.65x Stadium radius**. At higher border radius it visually stops changing it radius, since it cannot draw a squircle shape any higher radius than that.


## FigmaSquircle

A Flutter package implementation of Figma corner smoothing.

This package is used and regarded by many as one of the best approximations of the **iOS squircle shape**. It is an implementation of the **FigmaSquircle** shape. It has a smoothness factor from 0.0 to 1.0, at value **0.6** the Figma shape **claims** to be **identical** to the **iOS squircle shape**. 

At same smoothness, this `figma_squircle` package should also then be identical to the iOS squircle. To **verify** this, it should be compared to **actual** iOS SwiftUI produced shapes.

In this study, we use it as a reference to show how others deviate from it.

* Name: **FigmaSquircle**
* From package [figma_squircle](https://pub.dev/packages/figma_squircle)
* Outline border stroke align correct: **NO**
    * **ISSUE**: Does center regardless of what BorderSide uses, that actually defaults to inside.
* Shape lerp animates correctly: **YES**
* Shape can break down: **YES**
    * The shape breaks down with border radius exceeding the shape stadium radius. It should implement a limiter like e.g. **Smooth Corner** does.


### Findings

The **FigmaSquircle** breaks down when set border radius exceeds its Stadium radius.

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/figma_squircle_breaks.png" alt="figma_squircle_breaks"/>

_**ShapeBorder** FigmaSquircle (SmoothRectangleBorder) at radius > than its stadium radius, shape breaks down_

For border radius > 0.6x and <= 1.0x of the shape's stadium radius, the **FigmaSquircle** gets closer to an ordinary circular rounded rectangle border. At a border radius of > 0.9x and <= 1.0x of the shape's stadium radius, we can no longer observe any practical difference from a normal circular border made with **RoundedRectangleBorder**: 

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/figma_squircle_equal.png" alt="figma_squircle_equal"/>

_**ShapeBorder** FigmaSquircle (SmoothRectangleBorder) at radius 0.9x of its stadium radius, pretty identical to circular **RoundedRectangleBorder**_


### Conclusion - FigmaSquircle

If **FigmaSquircle** at smoothing **0.6** is a correct representation of the **iOS Swift-UI** Squircle, then this is a good choice for fidelity with iOS shapes. 

However, **FigmaSquircle** shape breaks down when the radius exceeds the shape's stadium radius. A good shape algorithm should stay at its equivalent stadium shaped when the stadium radius is exceeded. 

It has also been observed that for border radius of > 0.5x and <= 1.0x of the shape's stadium radius, that the **FigmaSquircle** shape starts to take the shape of just an ordinary circular rounded rectangle border. It is at this stage unknown if this is correct compared to how actual **iOS** stadium shapes look. Based on a quick look, it probably is not. **This needs to be verified**.

The performance impact of the **FigmaSquircle** has also been mentioned in issues. It should be studied further. 


## SmoothCorner

A rectangular border with variable smoothness imitated from Figma.

This is **another** implementation of the **Figma squircle**. It appears to be shape wise identical to above **FigmaSquircle**.

* Name: **SmoothCorner**
* From package [smooth_corner](https://pub.dev/packages/smooth_corner)
* Outline border stroke align correct: **NO**
    * **ISSUE**: Does inside regardless of what BorderSide uses, that actually defaults to inside.
* Shape lerp animates correctly: **NO**
    * **ISSUE**: The shape and border changes instantly, it appears it does not provide lerp overrides.
* Shape can break down: **NO**
    * Stays correctly shaped when border radius exceeds its stadium radius.

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


##  CupertinoSquircleBorder aka CupertinoCorners

A widget and border used to make cupertino rounded corners also referred to as squircle, using a bezier path and having the two points in the corners.

* Name: **CupertinoSquircleBorder**
* From package [cupertino_rounded_corners](https://pub.dev/packages/cupertino_rounded_corners)
* Outline border stroke align correct: **NO**
    * **ISSUE**: Does inside regardless of what BorderSide uses, that actually defaults to inside.
* Shape lerp animates correctly: **NO**
    * **ISSUE**: The shape and border changes instantly, it appears it does not provide lerp overrides.
* Shape can break down: **YES**
    * **ISSUE**: Gets same "TIE-fighter" shape as the `ContinuousRectangleBorder`. It gets even more pronounced at very large border radius. It lacks the attempt of a limiter that the `ContinuousRectangleBorder` has. 


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

* Name: **SuperellipseShape**
* From package [superellipse_shape](https://pub.dev/packages/superellipse_shape)
* Outline border stroke align correct: **NO**
    * **ISSUE**: Does center regardless of what BorderSide uses, that defaults to inside.
* Shape lerp animates correctly: **NO**
    * **ISSUE**: The shape and border changes instantly, it appears it does not provide lerp overrides.
* Shape can break down: **YES**
    * **ISSUE**: Gets same "TIE-fighter" shape as the `ContinuousRectangleBorder`.

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

* Name: **StadiumBorder**
* From [Flutter SDK](https://api.flutter.dev/flutter/painting/StadiumBorder-class.html)
* Outline border stroke align correct: **YES**
* Shape lerp animates correctly: **YES**
* Shape can break down: **NO**

### Findings

There is **NO** visible difference between a **FigmaSquircle** and the standard Flutter SDK circular **StadiumBorder** when using a border radius that equals the shape's stadium radius.

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/stadium.png" alt="stadium"/>

_**ShapeBorder** StadiumBorder and FigmaSquircle are visually identical_

The smoothness factor also has no impact on the **FigmaSquircle** when the border radius equals the stadium radius.

<img src="https://raw.githubusercontent.com/rydmike/squircle_study/master/assets/stadium_figma.png" alt="stadium_figma"/>

_**ShapeBorder** StadiumBorder and FigmaSquircle are visually identical, also when taking a closer zoomed in look_

### Conclusion - StadiumBorder

There is no point in using the **FigmaSquircle** for a **stadium** shape, it is identical to **StadiumBorder** at any radius that equals the shape's stadium radius. Already at a radius about 0.6x of the stadium radius, we are beginning to look at negligible visual differences between **FigmaSquircle** and circular **RoundedRectangleBorder**. 

## SquircleStadiumBorder PR

A PR for a Stadium Squircle that was rejected in Flutter SDK. It was discussed 
here https://github.com/flutter/flutter/pull/27523. This is a @rydmike code 
revival of the PR with some modifications. Changes include correct `strokeAlign` implementation, updated lerp overrides and migration to null-safe code.

* Name: **SquircleStadiumBorder**
* From [Flutter rejected PR](https://github.com/jslavitz/flutter/blob/4b2d32f9ebb1192bce695927cc3cab13e94cce39/packages/flutter/lib/src/painting/continuous_stadium_border.dart)
* Outline border stroke align correct: **YES** (in @rydmike version)
* Shape lerp animates correctly: **YES** (in @rydmike version)
* Shape can break down: **YES**
    * The shape shrinks its height when width approaches height, and wise versa. This is **NOT** a desired behavior. An attempt to increase the short/long side ratio at which this starts to happen is made in this modified version, we can go to aspect ratio 0.79. It is not ideal. While we can now approach less rectangular squircle stadium shapes, meaning approach a circular shape, it slightly breaks down and gets a bit skewed at higher aspect ratios. One solution could be to switch to use a circular stadium border at close to equal height and width values. A circle is a continuous curvature, and we are approaching that, which is why the squircle shaped one breaks down. It needs to transition to circular.

### Findings

The **SquircleStadiumBorder PR** looks better than **FigmaSquircle**, when width / height is 1.5 or more.

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

* Name: **SimonSquircleBorder**
* From [Slightfoot gist](https://gist.github.com/slightfoot/e35e8d5877371417e9803143e2501b0a)
* Outline border stroke align correct: **NO**
    * **ISSUE**: Does center regardless of what BorderSide uses, that defaults to inside.
* Shape lerp animates correctly: **YES**
* Shape can break down: **YES**
    * **ISSUE**: The shape cannot handle border radius from 0 to less than 1.0, it draws very odd shapes then.

### Findings

Draws weird shapes for border radius from 0 to less than 1. The shape is **not** an iOS squircle, it is something entirely different. Examples of produced shapes at different border radius are shown below.

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

* Name: **BeveledRectangleBorder**
* From [Flutter SDK](https://api.flutter.dev/flutter/painting/BeveledRectangleBorder-class.html)
* Outline border stroke align correct: **NO**
    * **ISSUE**: Tries to compensate and adjust for used `strokeAlign` but fails. It draws two joined outlined borders, and the border becomes too thick. End result is that it draws an incorrect border in relation to what is asked in its `borderSide`.
    * **TODO**: Raise Flutter SDK issue.
* Shape lerp animates correctly: **YES**
* Shape can break down: **NO**

For obvious reasons, this shape is not compared. It is only included in the study app to show an alternative corner shape that exists, but is rarely used in the Flutter SDK.

## Appendix A - Tweets About Performance Issues

Some links to Tweets about performance issues when using Figma Squircle and ContinuousRectangleBorder.

### Figma Squircle 
* https://twitter.com/lets4r/status/1630843536739295232?s=20
* https://twitter.com/lets4r/status/1668240937225539586?s=20

### Continuous Rectangle Border
* https://twitter.com/andrewpmoore/status/1668223930878836738?s=20
* https://twitter.com/andrewpmoore/status/1668243655314882567?s=20
* https://twitter.com/RydMike/status/1668275006919278592?s=20 Contains a performance comparison recording and link to repo used for it.
