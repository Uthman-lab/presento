import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/auth_bloc.dart';
import '../../domain/entities/institution.dart';

class InstitutionSelectionScreen extends StatefulWidget {
  const InstitutionSelectionScreen({super.key});

  @override
  State<InstitutionSelectionScreen> createState() =>
      _InstitutionSelectionScreenState();
}

class _InstitutionSelectionScreenState
    extends State<InstitutionSelectionScreen> {
  Institution? _selectedInstitution;

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(const AuthEvent.getInstitutionsRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Institution')),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            error: (failure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(failure.message)));
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            institutionsLoaded: (institutions) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    DropdownButtonFormField<Institution>(
                      value: _selectedInstitution,
                      items: institutions.map((institution) {
                        return DropdownMenuItem<Institution>(
                          value: institution,
                          child: Text(institution.name),
                        );
                      }).toList(),
                      onChanged: (institution) {
                        setState(() {
                          _selectedInstitution = institution;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Institution',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _selectedInstitution == null
                          ? null
                          : () {
                              context.push(
                                '/login',
                                extra: _selectedInstitution,
                              );
                            },
                      child: const Text('Continue'),
                    ),
                  ],
                ),
              );
            },
            orElse: () =>
                const Center(child: Text('Please select an institution')),
          );
        },
      ),
    );
  }
}
