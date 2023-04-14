import 'package:flutter/material.dart';

import '../../../app/functions.dart';
import '../../../domain/models/project.dart';
import '../../common/responsive.dart';
import '../../resources/sizes_manager.dart';
import '../../resources/strings_manager.dart';

class ProjectListTile extends StatefulWidget {
  const ProjectListTile({Key? key, required this.project, required this.onTap})
      : super(key: key);

  final Project project;
  final Function onTap;

  @override
  State<ProjectListTile> createState() => _ProjectListTileState();
}

class _ProjectListTileState extends State<ProjectListTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          _hovered = true;
        });
      },
      onExit: (event) {
        setState(() {
          _hovered = false;
        });
      },
      onHover: (event) {
        setState(() {
          _hovered = true;
        });
      },
      child: Material(
        elevation: _hovered ? 20 : 0,
        color: Colors.white,
        child: ListTile(
          shape: _hovered
              ? RoundedRectangleBorder(
                  side: BorderSide(
                      width: AppSize.s0_5,
                      color: Theme.of(context).dividerColor),
                  borderRadius: BorderRadius.zero,
                )
              : null,
          hoverColor: Colors.transparent,
          // tileColor: Theme.of(context).colorScheme.secondaryContainer,
          title: _buildTitle(),
          trailing: _buildTrailing(),
          onTap: () {
            // TODO: implement view project
            widget.onTap();
          },
          dense: true,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    if (ResponsiveWidget.isLargeScreen(context)) {
      return Row(
        children: <Widget>[
          SizedBox(
            width: AppSize.s150,
            child: Text(
              widget.project.user?.fullname ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.w300,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: AppSize.s10),
          SizedBox(
            width: AppSize.s80,
            child: Text(
              widget.project.office?.acronym ?? 'N/A',
              style: const TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          const SizedBox(width: AppSize.s10),
          Flexible(
            child: Text(
              widget.project.title,
              style: Theme.of(context).textTheme.titleSmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: AppSize.s20),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.project.office?.acronym ?? 'N/A',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              formatDate(widget.project.updatedAt),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.apply(color: Colors.grey),
            ),
          ],
        ),
        Text(
          widget.project.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          widget.project.description ?? 'No desc',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style:
              Theme.of(context).textTheme.bodySmall?.apply(color: Colors.grey),
        ),
      ],
    );
  }

  Widget? _buildTrailing() {
    return ResponsiveWidget.isLargeScreen(context)
        ? (_hovered
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      //
                    },
                    icon: const Icon(
                      Icons.download_outlined,
                      size: FontSize.xxl,
                    ),
                    tooltip: AppStrings.download,
                    visualDensity: VisualDensity.compact,
                    splashRadius: 20,
                  ),
                  IconButton(
                    onPressed: () {
                      //
                    },
                    icon: const Icon(
                      Icons.mode_edit_outline_outlined,
                      size: FontSize.xxl,
                    ),
                    tooltip: AppStrings.edit,
                    visualDensity: VisualDensity.compact,
                    splashRadius: 20,
                  ),
                  IconButton(
                    onPressed: () {
                      //
                    },
                    icon: const Icon(
                      Icons.delete_outline,
                      size: FontSize.xxl,
                    ),
                    tooltip: AppStrings.delete,
                    visualDensity: VisualDensity.compact,
                    splashRadius: 20,
                  ),
                ],
              )
            : Text(
                formatDate(widget.project.updatedAt),
                style: Theme.of(context).textTheme.bodySmall,
              ))
        : null;
  }
}
