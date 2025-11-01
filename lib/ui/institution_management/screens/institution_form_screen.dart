part of '../institution_management.ui.dart';

class InstitutionFormScreen extends StatefulWidget {
  final Institution? institution;

  const InstitutionFormScreen({super.key, this.institution});

  @override
  State<InstitutionFormScreen> createState() => _InstitutionFormScreenState();
}

class _InstitutionFormScreenState extends State<InstitutionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool _isLoading = false;

  bool get isEditing => widget.institution != null;

  @override
  void initState() {
    super.initState();
    if (widget.institution != null) {
      _nameController.text = widget.institution!.name;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    if (isEditing) {
      context.read<InstitutionManagementBloc>().add(
            UpdateInstitution(
              institutionId: widget.institution!.id,
              name: _nameController.text.trim(),
            ),
          );
    } else {
      context.read<InstitutionManagementBloc>().add(
            CreateInstitution(name: _nameController.text.trim()),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Institution' : 'Create Institution'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: BlocListener<InstitutionManagementBloc,
          InstitutionManagementState>(
        listener: (context, state) {
          if (state is InstitutionOperationSuccess) {
            setState(() {
              _isLoading = false;
            });
            Navigator.pop(context, true);
          } else if (state is InstitutionManagementError) {
            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  isEditing
                      ? 'Update institution details'
                      : 'Enter institution details',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Institution Name',
                    hintText: 'Enter institution name',
                    prefixIcon: Icon(Icons.business),
                    border: OutlineInputBorder(),
                  ),
                  enabled: !_isLoading,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Institution name is required';
                    }
                    if (value.trim().length < 2) {
                      return 'Institution name must be at least 2 characters';
                    }
                    return null;
                  },
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isLoading ? null : _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(isEditing ? 'Update Institution' : 'Create Institution'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

