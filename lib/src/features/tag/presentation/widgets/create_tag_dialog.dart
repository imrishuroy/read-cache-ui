import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_cache_ui/src/core/validators/validators.dart';
import 'package:read_cache_ui/src/core/widgets/widgets.dart';
import 'package:read_cache_ui/src/features/tag/domain/domain.dart';
import 'package:read_cache_ui/src/features/tag/presentation/presentation.dart';

class CreateTagDialog extends StatefulWidget {
  const CreateTagDialog({
    required this.tagBloc,
    super.key,
  });

  final TagBloc tagBloc;

  @override
  State<CreateTagDialog> createState() => _CreateTagDialogState();
}

class _CreateTagDialogState extends State<CreateTagDialog> {
  final _formKey = GlobalKey<FormState>();
  final _tagNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TagBloc, TagState>(
      bloc: widget.tagBloc,
      listener: (context, state) {
        if (state.status == TagStatus.success) {
          Navigator.of(context).pop();
        }

        if (state.status == TagStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.failure?.message}'),
            ),
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: AlertDialog(
            title: const Text('Create Tag'),
            content: state.status == TagStatus.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : CustomTextField(
                    hintText: 'Tag Name',
                    validator: (value) => Validator.validateTagName(value),
                    textEditingController: _tagNameController,
                  ),
            actions: state.status == TagStatus.loading
                ? null
                : [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: _createTag,
                      child: const Text('Create'),
                    ),
                  ],
          ),
        );
      },
    );
  }

  Future<void> _createTag() async {
    if (_formKey.currentState!.validate()) {
      widget.tagBloc.add(
        TagCreated(
          tag: Tag(
            tagName: _tagNameController.text,
          ),
        ),
      );
    }
  }
}
