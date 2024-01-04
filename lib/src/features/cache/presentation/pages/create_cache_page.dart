import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:read_cache_ui/src/core/config/injection_container.dart';
import 'package:read_cache_ui/src/core/validators/validators.dart';
import 'package:read_cache_ui/src/core/widgets/widgets.dart';
import 'package:read_cache_ui/src/features/cache/presentation/presentation.dart';

class CreateCacheListPage extends StatefulWidget {
  const CreateCacheListPage({
    super.key,
  });

  @override
  State<CreateCacheListPage> createState() => _CreateCacheListPageState();
}

class _CreateCacheListPageState extends State<CreateCacheListPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _linkController = TextEditingController();

  final _cacheBloc = getIt<CacheBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Cache'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocConsumer<CacheBloc, CacheState>(
        bloc: _cacheBloc,
        listener: (context, state) {
          if (state.status == CacheStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Cache Created'),
              ),
            );
            context.go('/caches');
          }
          if (state.status == CacheStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.failure?.message}'),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status == CacheStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    textEditingController: _titleController,
                    hintText: 'Cache Title',
                    validator: (value) => Validator.validateCacheTitle(value),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  CustomTextField(
                    textEditingController: _linkController,
                    hintText: 'Cache Link',
                    validator: (value) => Validator.validateLink(value),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(380, 55),
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: _addCache,
                    child: const Text('Create Cache'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _addCache() {
    if (_formKey.currentState!.validate()) {
      _cacheBloc.add(
        CacheCreated(
          title: _titleController.text,
          link: _linkController.text,
        ),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _linkController.dispose();
    super.dispose();
  }
}
