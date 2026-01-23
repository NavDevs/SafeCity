import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../models/emergency_contact.dart';

class EmergencyContactsScreen extends StatefulWidget {
  const EmergencyContactsScreen({super.key});

  @override
  State<EmergencyContactsScreen> createState() =>
      _EmergencyContactsScreenState();
}

class _EmergencyContactsScreenState extends State<EmergencyContactsScreen> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.black87 : Colors.grey[100];
    final cardColor = isDarkMode ? Colors.grey[900] : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Contacts'),
        backgroundColor: isDarkMode ? Colors.black : Colors.grey[700],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddContactDialog(context),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          final contacts = userProvider.userEmergencyContacts;

          if (contacts.isEmpty) {
            return _buildEmptyState(context, cardColor!);
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return _buildContactCard(
                context,
                contact,
                cardColor!,
                userProvider,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddContactDialog(context),
        backgroundColor: Colors.red[700],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, Color cardColor) {
    return Center(
      child: Card(
        color: cardColor,
        elevation: 4,
        margin: const EdgeInsets.all(24.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.contacts, size: 80, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                'No Emergency Contacts',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Add emergency contacts to notify them during critical situations.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey[500]),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => _showAddContactDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.add),
                label: const Text('Add Contact'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context,
    EmergencyContact contact,
    Color cardColor,
    UserProvider userProvider,
  ) {
    return Card(
      color: cardColor,
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.emergency,
                    color: Colors.red[700],
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contact.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        contact.relationship,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    switch (value) {
                      case 'edit':
                        _showEditContactDialog(context, contact);
                        break;
                      case 'delete':
                        _showDeleteConfirmation(context, contact, userProvider);
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 18),
                          SizedBox(width: 8),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 18, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Delete', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.phone, color: Colors.grey[700], size: 18),
                  const SizedBox(width: 8),
                  Text(
                    contact.phone,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddContactDialog(BuildContext context) {
    _showContactDialog(context, null);
  }

  void _showEditContactDialog(BuildContext context, EmergencyContact contact) {
    _showContactDialog(context, contact);
  }

  void _showContactDialog(BuildContext context, EmergencyContact? contact) {
    final nameController = TextEditingController(text: contact?.name ?? '');

    // For phone, remove +91 prefix if it exists to show only 10 digits
    String phoneValue = contact?.phone ?? '';
    if (phoneValue.startsWith('+91')) {
      phoneValue = phoneValue.substring(3);
    }
    final phoneController = TextEditingController(text: phoneValue);

    final relationshipController = TextEditingController(
      text: contact?.relationship ?? '',
    );
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          contact == null ? 'Add Emergency Contact' : 'Edit Emergency Contact',
        ),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a name';
                  }
                  if (value.trim().length < 2) {
                    return 'Name must be at least 2 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                  hintText: 'Enter 10-digit phone number',
                  prefixText: '+91 ',
                ),
                keyboardType: TextInputType.phone,
                maxLength: 10,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a phone number';
                  }
                  // Remove any spaces or non-digit characters except +
                  String cleanPhone = value.replaceAll(RegExp(r'[^\d]'), '');

                  if (cleanPhone.length != 10) {
                    return 'Phone number must be exactly 10 digits';
                  }

                  if (!RegExp(r'^[6-9][0-9]{9}$').hasMatch(cleanPhone)) {
                    return 'Enter a valid Indian phone number';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: relationshipController,
                decoration: const InputDecoration(
                  labelText: 'Relationship',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.family_restroom),
                  hintText: 'e.g., Mother, Father, Spouse, Friend',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the relationship';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => _saveContact(
              context,
              contact,
              nameController.text,
              phoneController.text,
              relationshipController.text,
              formKey,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[700],
              foregroundColor: Colors.white,
            ),
            child: Text(contact == null ? 'Add' : 'Update'),
          ),
        ],
      ),
    );
  }

  void _saveContact(
    BuildContext context,
    EmergencyContact? existingContact,
    String name,
    String phone,
    String relationship,
    GlobalKey<FormState> formKey,
  ) async {
    if (!formKey.currentState!.validate()) return;

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    // Clean and format phone number
    String cleanPhone = phone.replaceAll(RegExp(r'[^\d]'), '');
    String formattedPhone = '+91$cleanPhone';

    final contact = EmergencyContact(
      id:
          existingContact?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      name: name.trim(),
      phone: formattedPhone,
      relationship: relationship.trim(),
    );

    bool success;
    if (existingContact == null) {
      success = await userProvider.addEmergencyContact(contact);
    } else {
      success = await userProvider.updateEmergencyContact(contact);
    }

    if (success) {
      Navigator.pop(context);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              existingContact == null
                  ? 'Emergency contact added successfully'
                  : 'Emergency contact updated successfully',
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to save emergency contact'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showDeleteConfirmation(
    BuildContext context,
    EmergencyContact contact,
    UserProvider userProvider,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Contact'),
        content: Text(
          'Are you sure you want to delete ${contact.name} from your emergency contacts?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => _deleteContact(context, contact, userProvider),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _deleteContact(
    BuildContext context,
    EmergencyContact contact,
    UserProvider userProvider,
  ) async {
    Navigator.pop(context); // Close confirmation dialog

    final success = await userProvider.removeEmergencyContact(contact.id);

    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Emergency contact deleted successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to delete emergency contact'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
