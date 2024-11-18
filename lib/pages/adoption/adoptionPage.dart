import 'package:animalrescueadmin/pages/adoption/adoptionForm.dart';
import 'package:animalrescueadmin/pages/animal_detail_page.dart';
import 'package:flutter/material.dart';

class AdoptionPage extends StatelessWidget {
  final List<Map<String, dynamic>> adoptionData = [
    {
      "id": "1",
      "title": "Adopt a Friendly Dog",
      "description":
          "Looking for a loving home for a friendly Labrador retriever.",
      "status": "available",
      "createdAt": "2024-11-17",
      "image": "assets/images/dog.jpg",
      "caseType": "adoption",
      "location": "City Shelter, Block B",
      "contact": "+911234567890",
      "category": "dog",
    },
    {
      "id": "2",
      "title": "Kitten Ready for Adoption",
      "description": "A playful kitten rescued recently is ready for adoption.",
      "status": "available",
      "createdAt": "2024-11-16",
      "image": "assets/images/cat.jpg",
      "caseType": "adoption",
      "location": "Green Meadows, Apartment 4C",
      "contact": "+911987654321",
      "category": "cat",
    },
    {
      "id": "3",
      "title": "Parrot Looking for a Home",
      "description":
          "A rescued parrot with a beautiful personality needs a new home.",
      "status": "available",
      "createdAt": "2024-11-15",
      "image": "assets/images/parrot.jpg",
      "caseType": "adoption",
      "location": "Palm Avenue, Bird Sanctuary",
      "contact": "+911567890234",
      "category": "bird",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: const Text(
    'Animals for Adoption',
    style: TextStyle(color: Colors.white), // Title text color
  ),
  backgroundColor: Colors.pink,
  actions: [
    IconButton(
      icon: const Icon(Icons.add, color: Colors.white), // Icon color
      onPressed: () {
        // Navigate to the AdoptionForm page when Add button is clicked
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnimalAdoptionForm(),
          ),
        );
      },
    ),
  ],
  iconTheme: const IconThemeData(color: Colors.white), // Ensures back/other icons are white
),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two columns for cards
            crossAxisSpacing: 16, // Space between columns
            mainAxisSpacing: 16, // Space between rows
            childAspectRatio: 0.8, // Aspect ratio for each card
          ),
          itemCount: adoptionData.length,
          itemBuilder: (context, index) {
            final data = adoptionData[index];
            return Card(
              elevation: 8, // Shadow for the floating effect
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: InkWell(
                onTap: () {
                  // Navigate to the details page with specific animal data
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPage(data: data),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(data['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.3),
                                  Colors.black.withOpacity(0.3),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['title'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Status: ${data['status']}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


