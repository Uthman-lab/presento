part of '../presentation.dart';

class InstitutionSelectionScreen extends StatefulWidget {
  const InstitutionSelectionScreen({super.key});

  @override
  State<InstitutionSelectionScreen> createState() =>
      _InstitutionSelectionScreenState();
}

class _InstitutionSelectionScreenState
    extends State<InstitutionSelectionScreen> {
  @override
  void initState() {
    super.initState();
    // Load institutions when screen initializes
    context.read<AuthBloc>().add(const InstitutionsLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Icon(
                Icons.school,
                size: 80,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 24),
              Text(
                'Select Institution',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Choose the institution you want to access',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Institution List
              Expanded(
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is InstitutionSelected) {
                      // Navigate to dashboard after institution selection
                      context.go(AppRouter.dashboardRoute);
                    } else if (state is AuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is InstitutionsLoaded) {
                      return _buildInstitutionList(context, state.institutions);
                    } else if (state is AuthError) {
                      return _buildErrorState(context, state.message);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInstitutionList(
    BuildContext context,
    List<Institution> institutions,
  ) {
    return ListView.builder(
      itemCount: institutions.length,
      itemBuilder: (context, index) {
        final institution = institutions[index];

        // Get user role for this institution
        final user = context.read<AuthBloc>().state is Authenticated
            ? (context.read<AuthBloc>().state as Authenticated).user
            : null;

        final userRole =
            user?.getRoleForInstitution(institution.id)?.role ?? 'Unknown';

        return InstitutionCard(
          institution: institution,
          userRole: userRole,
          onTap: () {
            context.read<AuthBloc>().add(
              InstitutionSelectionRequested(institutionId: institution.id),
            );
          },
        );
      },
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red.shade400),
          const SizedBox(height: 16),
          Text(
            'Error Loading Institutions',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().add(const InstitutionsLoadRequested());
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}


