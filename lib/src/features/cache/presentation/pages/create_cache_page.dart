import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:read_cache_ui/src/core/config/injection_container.dart';
import 'package:read_cache_ui/src/core/validators/validators.dart';
import 'package:read_cache_ui/src/core/widgets/widgets.dart';
import 'package:read_cache_ui/src/features/cache/domain/domain.dart';
import 'package:read_cache_ui/src/features/cache/presentation/presentation.dart';
import 'package:read_cache_ui/src/features/tag/presentation/presentation.dart';
import 'package:read_cache_ui/src/services/services.dart';

class CreateCachePage extends StatefulWidget {
  const CreateCachePage({
    super.key,
  });

  static const name = 'CreateCachePage';
  @override
  State<CreateCachePage> createState() => _CreateCachePageState();
}

class _CreateCachePageState extends State<CreateCachePage> {
  @override
  void initState() {
    FirebaseAnalyticsService.logScreenViewEvent(CreateCachePage.name);
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _cacheBloc = getIt<CacheBloc>();
  final _tagBloc = getIt<TagBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Cache'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocConsumer<CacheBloc, CacheState>(
        bloc: _cacheBloc
          ..add(
            const UpdateCacheInitialized(
              cache: Cache(
                title: '',
                content: '',
              ),
            ),
          ),
        listener: (context, state) {
          if (state.status == CacheStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Cache Created'),
              ),
            );

            context.goNamed(CachesPage.name);
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      textEditingController: _contentController,
                      hintText: 'Cache Content',
                      validator: (value) =>
                          Validator.validateCacheContent(value),
                    ),
                    const SizedBox(height: 28),
                    AnimatedToggleSwitch<bool>.dual(
                      current: state.updateCache?.isPublic ?? false,
                      first: false,
                      second: true,
                      spacing: 52,
                      style: const ToggleStyle(
                        borderColor: Colors.transparent,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1.5),
                          ),
                        ],
                      ),
                      borderWidth: 4,
                      height: 48,
                      onChanged: (value) {
                        _cacheBloc.add(
                          CachePublicToggled(),
                        );
                      },
                      styleBuilder: (b) => ToggleStyle(
                        indicatorColor: b ? Colors.blue : Colors.green,
                      ),
                      iconBuilder: (value) => value
                          ? const Icon(
                              Icons.public_rounded,
                              size: 20,
                            )
                          : const Icon(
                              Icons.lock_rounded,
                              size: 20,
                            ),
                      textBuilder: (value) => value
                          ? const Center(child: Text('Public'))
                          : const Center(child: Text('Private')),
                    ),
                    const SizedBox(height: 28),
                    Tags(
                      tagBloc: _tagBloc,
                    ),
                    const SizedBox(height: 62),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(380, 55),
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () => _addCache(
                          isPublic: state.updateCache?.isPublic ?? false,
                        ),
                        child: const Text('Create Cache'),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _addCache({required bool isPublic}) {
    if (_formKey.currentState!.validate()) {
      debugPrint('isPublic: $isPublic');
      final cache = Cache(
        title: _titleController.text,
        content: _contentController.text,
        isPublic: isPublic,
      );
      _cacheBloc.add(
        CacheCreated(
          cache: cache,
          tags: _tagBloc.state.selectedTags.keys.toList(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
