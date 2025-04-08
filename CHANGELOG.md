## Version History

All notable changes to this squircle study and repo are recorded here.


### 1.4.0 - April 8, 2025

* Added Flutter shape `RoundedSuperellipseBorder` to the comparison that is available on master channel `3.31.0-1.0.pre.445,` and later. This is a new shape that implements the iOS super ellipse shape. 
* Updated the readme and findings to include the new shape.
* Reversed to order of the changelog entries, so that the latest version is on top.

### 1.3.2 - March 8, 2025

* Updated the app to use Flutter 3.29.1
* Updated all deps and to new figma_squircle package version 0.6.3.
* Added info about new coming Flutter [RoundSuperEllipse](https://github.com/rydmike/squircle_study?tab=readme-ov-file#flutter-squircle-status-march-8-2025) shape.

### 1.3.0 - August 12, 2023

* Add about box
* Refactor app and rename classes.
* Releases a web build of the Squircle Study app https://rydmike.com/squircle/latest

### 1.2.1 - August 12, 2023

* Moved version history to this CHANGELOG.md file.
* Minor language tweaks and clarifications added to the report.

### 1.2.0 - August 11, 2023

* Study:
    * Added info about if `strokeAlign` works or not for each studied shape.
    * Added info about if shape lerp animation (radius and outline) works or not for each studied shape.
* Fixed `strokeAlign` on `SquircleBorder` and `SquircleStadiumBorder` so that the clipping of the border when used on `Material`, works the same way as it does in Flutter SDK when using `RoundedRectangleBorder` and `StadiumBorder`.
* **Study App Features**:
    * Added display of the used outlined border width. We can use it to visually see what a line of selected width looks like. Used to visually verify that the outline width on the shape is correct.
    * Added optional clipping of the outlined shaped `Material`. Can be used to see how `strokeAlign` works when the shape is used by `Material` and it is clipped.
    * Added removal of the fill from the outlined shaped `Material`. We can now optionally get the same look as in version 1.0.0.

### 1.1.0 - August 10, 2023

* Added a feature to vary the `strokeAlign` on used `BorderSide` on the shape drawn with an outline.
* Added a semitransparent fill also to the shape that has the outline, drawn on top of the filled one.
* Changed **SquircleBorder PR** the `SquircleBorder` to extend `OutlinedBorder`. Added `BorderSide` outline border, it also supports usage of `strokeAlign` on the border.
* Changed **SquircleBorder PR** the `SquircleBorder`, property `radius` that was `double` border radius to use `borderRadius` of type `BorderRadiusGeometry`. It still only supports symmetric corners, despite now using `BorderRadiusGeometry` for the `borderRadius`. The plan is to look into unsymmetrical corner radius support.
* Tuned the max curvature limit the `SquircleBorder` can use, it now supports up to 0.65 of the stadium border ratio. It might have to be reduced a bit. The shape breaks down slightly at this ratio. It is more visible when using borders.
* Modified outline border on **SquircleStadiumBorder PR** the `SquircleStadiumBorder`, it now supports usage of `strokeAlign` on the border.
* Conclusions and findings have not been updated.
* **FOUND FLUTTER AND PACKAGE ISSUES**
  * Noticed that of all the shapes, only Flutter SDK `RoundedRectangleBorder` and `StadiumBorder` correctly support usage of `strokeAlign` on the used `BorderSide`. The Flutter SDK `ContinuousRectangleBorder` does not handle `strokeAlign` on the used `BorderSide` correctly, it does not even try to. The `BeveledRectangleBorder` tries, but fails. The error causes it to draw a border that is much thicker than the one in its specified `borderSide`. These issues should be raised as bugs in the Flutter SDK. None of the used packages implement any support for `BorderSide` and its `strokeAlign` property. Some of them also do not implement lerp for line width and corner radius changes.

### 1.0.0 - August 5, 2023

* The first version communicated and [tweeted](https://twitter.com/RydMike/status/1687813486963724288).
