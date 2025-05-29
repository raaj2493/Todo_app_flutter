import 'package:flutter/material.dart';
import 'package:learn/assets/taskcard.dart';
import 'package:learn/screen/addtask.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2A4E4E),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // SEARCH BAR
                SizedBox(height: 12),
                Container(
                  height: 50,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.white),
                        Text(
                          "Search by group or task...",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "My Groups",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 56),
                    Text(
                      "View all",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.30,
                    mainAxisSpacing: 12,
                    shrinkWrap: true,
                    children: [
                      Grouptaskcard(
                        title: "Work",
                        taskCount: 2,
                        color: Colors.pink.shade100,
                        icon: Icons.work,
                      ),
                      Grouptaskcard(
                        title: "Blog",
                        taskCount: 21,
                        color: Colors.green.shade200,
                        icon: Icons.star,
                      ),
                      Grouptaskcard(
                        title: "Personal",
                        taskCount: 12,
                        color: Colors.lightBlue.shade200,
                        icon: Icons.folder,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.40, // collapsed height (25% screen)
            minChildSize: 0.40,
            maxChildSize: 0.9, // fully expanded height
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Today",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          InkWell(
                            onTap:
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddTaskScreen(),
                                  ),
                                ),
                            child: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                    Taskcard(
                      title: "Update a copy of the last article",
                      subtitle: "Shared with Amanda Brown",
                      color: Colors.green,
                      icon: Icons.star,
                    ),
                    Taskcard(
                      title: "Send email to sales agent",
                      subtitle: "Shared with Amanda Brown",
                      color: Colors.purple,
                      icon: Icons.email,
                    ),
                    Taskcard(
                      title: "Call Andy",
                      subtitle: "Ask about delivery time",
                      color: Colors.pink,
                      icon: Icons.call,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
