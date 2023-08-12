import 'package:flutter/material.dart';

import '../../app/models/shape_borders.dart';
import '../../app/widgets/app/link_text_span.dart';
import '../../app/widgets/universal/color_scheme_box.dart';
import '../../app/widgets/universal/list_tile_reveal.dart';

/// Widget used to select used AdaptiveTheme using a popup menu.
///
/// Uses index out out of range of [ShapeBorders] to represent
/// and select no selection of [ShapeBorders] which sets its
/// value to null in parent, so we can use a selectable item as null input,
/// to represent default value via no value definition.
class ShapeBorderPopupMenu extends StatelessWidget {
  const ShapeBorderPopupMenu({
    super.key,
    required this.type,
    this.onChanged,
    this.title,
    this.subtitle,
    this.contentPadding,
  });
  final ShapeBorders type;
  final ValueChanged<ShapeBorders>? onChanged;
  final Widget? title;
  final Widget? subtitle;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    final TextStyle txtStyle = theme.textTheme.labelLarge!;

    final TextStyle spanTextStyle = theme.textTheme.bodySmall!;
    final TextStyle linkStyle = theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primary, fontWeight: FontWeight.bold);

    final bool enabled = onChanged != null;
    final String tileLabel =
        '${type.type} (${type.shortName} from ${type.from})';
    final String styleDescribe = type.describe;
    final IconThemeData selectedIconTheme =
        theme.iconTheme.copyWith(color: scheme.onPrimary.withAlpha(0xE5));
    final IconThemeData unSelectedIconTheme =
        theme.iconTheme.copyWith(color: scheme.primary);

    return PopupMenuButton<ShapeBorders>(
      initialValue: type,
      tooltip: '',
      padding: EdgeInsets.zero,
      onSelected: (ShapeBorders selected) {
        onChanged?.call(selected);
      },
      enabled: enabled,
      itemBuilder: (BuildContext context) => <PopupMenuItem<ShapeBorders>>[
        for (int i = 0; i < ShapeBorders.values.length; i++)
          PopupMenuItem<ShapeBorders>(
            value: ShapeBorders.values[i],
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: type == ShapeBorders.values[i]
                  ? IconTheme(
                      data: selectedIconTheme,
                      child: ColorSchemeBox(
                        backgroundColor: scheme.primary,
                        borderColor: Colors.transparent,
                        child: _TooltipIcon(index: i),
                      ),
                    )
                  : IconTheme(
                      data: unSelectedIconTheme,
                      child: ColorSchemeBox(
                        backgroundColor: Colors.transparent,
                        borderColor: scheme.primary,
                        child: _TooltipIcon(index: i),
                      ),
                    ),
              title: Text(ShapeBorders.values[i].type, style: txtStyle),
            ),
          )
      ],
      child: ListTileReveal(
        enabled: enabled,
        contentPadding: contentPadding,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (title != null) title!,
            Text(tileLabel),
          ],
        ),
        subtitleDense: true,
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // if (subtitle != null) subtitle!,
            Text(styleDescribe),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    style: spanTextStyle,
                    text: 'See ',
                  ),
                  LinkTextSpan(
                    style: linkStyle,
                    uri: Uri.parse(type.url),
                    text: 'here',
                  ),
                  TextSpan(
                    style: spanTextStyle,
                    text: ' for more information.',
                  ),
                ],
              ),
            ),
          ],
        ),
        trailing: Padding(
          padding: const EdgeInsetsDirectional.only(end: 5.0),
          child: IconTheme(
            data: selectedIconTheme,
            child: ColorSchemeBox(
              backgroundColor: scheme.primary,
              borderColor: Colors.transparent,
              child: _TooltipIcon(index: type.index),
            ),
          ),
        ),
      ),
    );
  }
}

class _TooltipIcon extends StatelessWidget {
  const _TooltipIcon({required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    final String message = ShapeBorders.values[index].type;
    final IconData icon = ShapeBorders.values[index].icon;
    return Tooltip(
      message: message,
      child: Icon(icon),
    );
  }
}
