import 'package:animalrescueadmin/pages/animal_detail_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  final List<Map<String, dynamic>> sampleData = [
    {
      "id": "1",
      "title": "Injured Dog on Highway",
      "description":
          "A stray dog injured near the city highway requires immediate medical attention.",
      "status": "pending",
      "createdAt": "2024-11-17",
      "image": "assets/images/dog.jpg",
      "caseType": "rescue",
      "location": "City Highway, Sector 4",
      "contact": "+911234567890",
      "category": "dog",
    },
    {
      "id": "2",
      "title": "Adoption of a Kitten",
      "description": "Looking for a loving home for a rescued kitten.",
      "status": "pending",
      "createdAt": "2024-11-16",
      "image": "assets/images/cat.jpg",
      "caseType": "rescue",
      "location": "Green Valley, Block A",
      "contact": "+911987654321",
      "category": "cat",
    },
    {
      "id": "3",
      "title": "Missing Bird",
      "description": "A pet parrot has gone missing in the residential area.",
      "status": "pending",
      "createdAt": "2024-11-15",
      "image": "assets/images/parrot.jpg",
      "caseType": "rescue",
      "location": "Palm Avenue, Villa 12",
      "contact": "+911567890234",
      "category": "bird",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rescue Cases',
          style: TextStyle(color: Colors.white), // White text color
        ),
        backgroundColor: Colors.pink,
        iconTheme: const IconThemeData(
            color: Colors.white), // Ensures icons are white as well
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
          itemCount: sampleData.length,
          itemBuilder: (context, index) {
            final data = sampleData[index];
            return Card(
              elevation: 8, // Shadow for the floating effect
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: InkWell(
                onTap: () {
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
