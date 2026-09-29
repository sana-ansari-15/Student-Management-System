import 'package:flutter/material.dart';
class Student {
  String id;
  String name;
  String email;
  String phone;
  String dob;
  String gender;
  String course;
  String semester;
  String division;
  String address;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.dob,
    required this.gender,
    required this.course,
    required this.semester,
    required this.division,
    required this.address,
  });
}

List<Student> students = [
  Student(
    id: '101',
    name: 'Sana Ansari',
    email: 'sana@gmail.com',
    phone: '9876543210',
    dob: '10/05/2005',
    gender: 'Female',
    course: 'BSc IT',
    semester: 'Semester 3',
    division: 'A',
    address: 'Mumbai',
  ),

  Student(
    id: '102',
    name: 'Aisha Khan',
    email: 'aisha@gmail.com',
    phone: '9876543211',
    dob: '15/07/2005',
    gender: 'Female',
    course: 'BSc IT',
    semester: 'Semester 3',
    division: 'A',
    address: 'Mumbai',
  ),
];

void main() {
  runApp(StudentManagementSystem());
}

class StudentManagementSystem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Management System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Arial',
      ),
      home: LoginScreen(),
    );
  }
}

// ================= LOGIN SCREEN =================

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String selectedRole = 'Admin';
  bool hidePassword = true;

  void login() {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (selectedRole == 'Admin' &&
        username == 'admin@vesasc.com' &&
        password == 'admin') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AdminDashboard(),
        ),
      );
    } else if (selectedRole == 'Student') {
      // Student username is generated from the student's name.
      // Example: Priyanka -> priyanka@vesasc.com
      String enteredUsername = username.toLowerCase();

      Student? loggedInStudent;

      for (Student student in students) {
        String generatedUsername = student.name
            .trim()
            .toLowerCase()
            .replaceAll(RegExp(r'[^a-z0-9]'), '') +
            '@vesasc.com';

        if (enteredUsername == generatedUsername && password == 'student') {
          loggedInStudent = student;
          break;
        }
      }

      if (loggedInStudent != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => StudentDashboard(
              student: loggedInStudent!,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Invalid student username or password',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid username or password'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F7FB),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 420,
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              children: [

                // Logo
                Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    color: Color(0xFF123456),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Icon(
                    Icons.school,
                    color: Colors.white,
                    size: 42,
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  'STUDENT MANAGEMENT SYSTEM',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF123456),
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  'Login to continue',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),

                SizedBox(height: 30),

                // Role
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Login As',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 8),

                DropdownButtonFormField<String>(
                  value: selectedRole,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.person),
                  ),
                  items: [
                    DropdownMenuItem(
                      value: 'Admin',
                      child: Text('Admin'),
                    ),
                    DropdownMenuItem(
                      value: 'Student',
                      child: Text('Student'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedRole = value!;
                    });
                  },
                ),

                SizedBox(height: 20),

                // Username
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Username',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 8),

                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: selectedRole == 'Student'
                        ? 'name@vesasc.com'
                        : 'Enter username',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Password
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 8),

                TextField(
                  controller: passwordController,
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                    hintText: 'Enter password',
                    prefixIcon: Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        hidePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                SizedBox(height: 28),

                // Login button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedRole == 'Admin'
                          ? Color(0xFF123456)
                          : Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  'College Student Management System',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ================= ADMIN DASHBOARD =================

class AdminDashboard extends StatefulWidget {
  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {

  Widget currentPage = AdminHomePage();



  String selectedMenu = 'Dashboard';

  void openPage(String menu, Widget page) {
    setState(() {
      selectedMenu = menu;
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),

      body: Row(
        children: [

          // ================= SIDEBAR =================

          Container(
            width: 230,
            color: Color(0xFF071A2B),

            child: SingleChildScrollView(
              child: Column(
                children: [

                  // =========================
                  // LOGO AREA
                  // =========================

                  Container(
                    height: 90,
                    padding: EdgeInsets.all(15),

                    child: Row(
                      children: [

                        Icon(
                          Icons.school,
                          color: Colors.white,
                          size: 35,
                        ),

                        SizedBox(width: 10),

                        Expanded(
                          child: Text(
                            'Student\nManagement System',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Divider(
                    color: Colors.white24,
                  ),

                  // =========================
                  // DASHBOARD
                  // =========================

                  adminMenuItem(
                    icon: Icons.dashboard,
                    title: 'Dashboard',
                    page: AdminHomePage(),
                  ),

                  // =========================
                  // STUDENT MANAGEMENT
                  // =========================

                  adminMenuItem(
                    icon: Icons.person_add,
                    title: 'Add Student',
                    page: AddStudentPage(),
                  ),

                  adminMenuItem(
                    icon: Icons.people,
                    title: 'All Students',
                    page: AllStudentsPage(),
                  ),

                  adminMenuItem(
                    icon: Icons.search,
                    title: 'Search Student',
                    page: AllStudentsPage(),
                  ),

                  // =========================
                  // ACADEMICS
                  // =========================

                  adminMenuItem(
                    icon: Icons.school,
                    title: 'Manage Marks',
                    page: ManageMarksPage(),
                  ),

                  // =========================
                  // FEES
                  // =========================

                  adminMenuItem(
                    icon: Icons.account_balance_wallet,
                    title: 'Fees Management',
                    page: FeesManagementPage(),
                  ),

                  // =========================
                  // NOTICES
                  // =========================

                  adminMenuItem(
                    icon: Icons.notifications,
                    title: 'Notices',
                    page: NoticesPage(),
                  ),

                  // =========================
                  // SERVICES
                  // =========================

                  adminMenuItem(
                    icon: Icons.description,
                    title: 'Certificate Requests',
                    page: CertificateRequestsPage(),
                  ),

                  // =========================
                  // EXAMINATION
                  // =========================

                  adminMenuItem(
                    icon: Icons.assignment,
                    title: 'Examination',
                    page: ExaminationPage(),
                  ),

                  // =========================
                  // REPORTS
                  // =========================

                  adminMenuItem(
                    icon: Icons.bar_chart,
                    title: 'Reports',
                    page: ReportsPage(),
                  ),

                  adminMenuItem(
                    icon: Icons.account_tree,
                    title: 'Data Structures',
                    page: DataStructuresPage(),
                  ),


                  Divider(
                    color: Colors.white24,
                  ),

                  // =========================
                  // DATA STRUCTURES
                  // =========================

                  /*
        adminMenuItem(
          icon: Icons.grid_view,
          title: 'Array Operations',
          page: ArrayOperationsPage(),
        ),

        adminMenuItem(
          icon: Icons.account_tree,
          title: 'Linked List',
          page: LinkedListPage(),
        ),

        adminMenuItem(
          icon: Icons.queue,
          title: 'Queue',
          page: QueuePage(),
        ),

        adminMenuItem(
          icon: Icons.sort,
          title: 'Sorting',
          page: SortingPage(),
        ),

        adminMenuItem(
          icon: Icons.manage_search,
          title: 'Searching',
          page: SearchingPage(),
        ),
        */

                  SizedBox(height: 10),

                  Divider(
                    color: Colors.white24,
                  ),

                  // =========================
                  // LOGOUT
                  // =========================

                  InkWell(
                    onTap: () {

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                            (route) => false,
                      );

                    },

                    child: Container(
                      width: double.infinity,

                      padding: EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 15,
                      ),

                      child: Row(
                        children: [

                          Icon(
                            Icons.logout,
                            color: Colors.white70,
                          ),

                          SizedBox(width: 15),

                          Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 15),
                ],
              ),
            ),
          ),

          // ================= MAIN CONTENT =================

          Expanded(
            child: Column(
              children: [

                // Top bar

                Container(
                  height: 60,
                  color: Colors.white,

                  padding: EdgeInsets.symmetric(
                    horizontal: 25,
                  ),

                  child: Row(
                    children: [

                      Text(
                        selectedMenu,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF123456),
                        ),
                      ),

                      Spacer(),

                      Icon(
                        Icons.notifications_none,
                        color: Colors.grey,
                      ),

                      SizedBox(width: 20),

                      CircleAvatar(
                        radius: 17,
                        backgroundColor: Color(0xFF123456),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 19,
                        ),
                      ),

                      SizedBox(width: 8),

                      Text(
                        'Admin',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // Selected page

                Expanded(
                  child: currentPage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= MENU ITEM =================

  Widget adminMenuItem({
    required IconData icon,
    required String title,
    required Widget page,
  }) {

    bool selected = selectedMenu == title;

    return InkWell(

      onTap: () {
        openPage(title, page);
      },

      child: Container(

        margin: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 3,
        ),

        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),

        decoration: BoxDecoration(
          color: selected
              ? Color(0xFF1976D2)
              : Colors.transparent,

          borderRadius: BorderRadius.circular(7),
        ),

        child: Row(
          children: [

            Icon(
              icon,
              color: Colors.white,
              size: 19,
            ),

            SizedBox(width: 13),

            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: selected
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ManageMarksPage extends StatefulWidget {
  @override
  State<ManageMarksPage> createState() => _ManageMarksPageState();
}

class _ManageMarksPageState extends State<ManageMarksPage> {

  // =====================================================
  // STUDENT DETAILS
  // =====================================================

  TextEditingController studentIdController =
  TextEditingController();

  TextEditingController studentNameController =
  TextEditingController();

  TextEditingController academicYearController =
  TextEditingController(text: '2026-27');

  String selectedCourse = 'B.Sc.';

  String selectedDepartment = 'Information Technology';

  String selectedSemester = 'Semester 3';

  String selectedDivision = 'A';

  // =====================================================
  // MARKS
  // =====================================================

  TextEditingController internalController =
  TextEditingController();

  TextEditingController externalController =
  TextEditingController();

  String? selectedSubject;

  List<Map<String, dynamic>> subjectMarks = [];

  List<Map<String, dynamic>> savedStudents = [];

  // =====================================================
  // COURSES
  // =====================================================

  List<String> courses = [
    'B.A.',
    'B.Com.',
    'B.Sc.',
    'B.Tech.',
    'B.Ed.',
  ];

  // =====================================================
  // DEPARTMENTS
  // =====================================================

  Map<String, List<String>> departments = {

    'B.A.': [
      'Arts',
    ],

    'B.Com.': [
      'Commerce',
    ],

    'B.Sc.': [
      'Information Technology',
      'Computer Science',
      'Physics',
      'Chemistry',
      'Mathematics',
    ],

    'B.Tech.': [
      'Computer Science',
      'Information Technology',
      'Mechanical',
      'Civil',
      'Electronics',
      'Electrical',
    ],

    'B.Ed.': [
      'Education',
    ],
  };

  // =====================================================
  // SEMESTERS
  // =====================================================

  Map<String, List<String>> courseSemesters = {

    'B.A.': [
      'Semester 1',
      'Semester 2',
      'Semester 3',
      'Semester 4',
      'Semester 5',
      'Semester 6',
    ],

    'B.Com.': [
      'Semester 1',
      'Semester 2',
      'Semester 3',
      'Semester 4',
      'Semester 5',
      'Semester 6',
    ],

    'B.Sc.': [
      'Semester 1',
      'Semester 2',
      'Semester 3',
      'Semester 4',
      'Semester 5',
      'Semester 6',
    ],

    'B.Tech.': [
      'Semester 1',
      'Semester 2',
      'Semester 3',
      'Semester 4',
      'Semester 5',
      'Semester 6',
      'Semester 7',
      'Semester 8',
    ],

    'B.Ed.': [
      'Semester 1',
      'Semester 2',
      'Semester 3',
      'Semester 4',
    ],
  };

  // =====================================================
  // SUBJECTS
  // =====================================================

  Map<String, List<String>> subjects = {

    // ===================================================
    // B.A. - ARTS
    // ===================================================

    'B.A.|Arts|Semester 1': [
      'English',
      'Marathi',
      'History',
      'Political Science',
      'Economics',
    ],

    'B.A.|Arts|Semester 2': [
      'English',
      'Marathi',
      'History',
      'Political Science',
      'Economics',
    ],

    'B.A.|Arts|Semester 3': [
      'English',
      'History',
      'Political Science',
      'Economics',
      'Sociology',
    ],

    'B.A.|Arts|Semester 4': [
      'English',
      'History',
      'Political Science',
      'Economics',
      'Sociology',
    ],

    'B.A.|Arts|Semester 5': [
      'History',
      'Political Science',
      'Economics',
      'Sociology',
      'Psychology',
    ],

    'B.A.|Arts|Semester 6': [
      'History',
      'Political Science',
      'Economics',
      'Sociology',
      'Psychology',
    ],

    // ===================================================
    // B.COM. - COMMERCE
    // ===================================================

    'B.Com.|Commerce|Semester 1': [
      'Financial Accounting',
      'Business Economics',
      'Business Communication',
      'Commerce',
      'Business Mathematics',
    ],

    'B.Com.|Commerce|Semester 2': [
      'Financial Accounting',
      'Business Economics',
      'Business Communication',
      'Business Law',
      'Business Mathematics',
    ],

    'B.Com.|Commerce|Semester 3': [
      'Cost Accounting',
      'Business Law',
      'Marketing Management',
      'Corporate Accounting',
      'Business Economics',
    ],

    'B.Com.|Commerce|Semester 4': [
      'Cost Accounting',
      'Corporate Accounting',
      'Auditing',
      'Marketing Management',
      'Business Law',
    ],

    'B.Com.|Commerce|Semester 5': [
      'Advanced Accounting',
      'Taxation',
      'Financial Management',
      'Auditing',
      'Cost Accounting',
    ],

    'B.Com.|Commerce|Semester 6': [
      'Advanced Accounting',
      'Income Tax',
      'Financial Management',
      'Auditing',
      'Business Management',
    ],

    // ===================================================
    // B.SC. - INFORMATION TECHNOLOGY
    // ===================================================

    'B.Sc.|Information Technology|Semester 1': [
      'Programming Fundamentals',
      'Digital Logic',
      'Mathematics',
      'Communication Skills',
      'Computer Fundamentals',
    ],

    'B.Sc.|Information Technology|Semester 2': [
      'Object Oriented Programming',
      'Database Management System',
      'Web Programming',
      'Mathematics',
      'Operating System',
    ],

    'B.Sc.|Information Technology|Semester 3': [
      'Data Structures',
      'DBMS',
      'Operating System',
      'MPMC',
      'Flutter',
    ],

    'B.Sc.|Information Technology|Semester 4': [
      'Computer Networks',
      'Software Engineering',
      'Python Programming',
      'Web Technology',
      'Computer Graphics',
    ],

    'B.Sc.|Information Technology|Semester 5': [
      'Advanced Web Development',
      'Network Security',
      'Cloud Computing',
      'Data Analytics',
      'Software Testing',
    ],

    'B.Sc.|Information Technology|Semester 6': [
      'Artificial Intelligence',
      'Machine Learning',
      'Cyber Security',
      'Project',
      'Internet of Things',
    ],

    // ===================================================
    // B.SC. - COMPUTER SCIENCE
    // ===================================================

    'B.Sc.|Computer Science|Semester 1': [
      'Programming in C',
      'Digital Logic',
      'Mathematics',
      'Computer Fundamentals',
      'Communication Skills',
    ],

    'B.Sc.|Computer Science|Semester 2': [
      'Object Oriented Programming',
      'Database Management System',
      'Operating System',
      'Mathematics',
      'Web Programming',
    ],

    'B.Sc.|Computer Science|Semester 3': [
      'Data Structures',
      'DBMS',
      'Operating System',
      'Computer Networks',
      'Python Programming',
    ],

    'B.Sc.|Computer Science|Semester 4': [
      'Java Programming',
      'Computer Networks',
      'Software Engineering',
      'Computer Graphics',
      'Web Technology',
    ],

    'B.Sc.|Computer Science|Semester 5': [
      'Artificial Intelligence',
      'Machine Learning',
      'Cyber Security',
      'Cloud Computing',
      'Data Analytics',
    ],

    'B.Sc.|Computer Science|Semester 6': [
      'Advanced Java',
      'Machine Learning',
      'Project',
      'Big Data',
      'Cyber Security',
    ],

    // ===================================================
    // B.SC. - PHYSICS
    // ===================================================

    'B.Sc.|Physics|Semester 1': [
      'Mechanics',
      'Mathematical Physics',
      'Physics Practical',
      'Chemistry',
      'Mathematics',
    ],

    'B.Sc.|Physics|Semester 2': [
      'Electricity and Magnetism',
      'Thermal Physics',
      'Physics Practical',
      'Mathematics',
      'Chemistry',
    ],

    'B.Sc.|Physics|Semester 3': [
      'Electromagnetism',
      'Optics',
      'Thermodynamics',
      'Physics Practical',
      'Mathematics',
    ],

    'B.Sc.|Physics|Semester 4': [
      'Quantum Physics',
      'Electronics',
      'Optics',
      'Physics Practical',
      'Mathematics',
    ],

    'B.Sc.|Physics|Semester 5': [
      'Quantum Mechanics',
      'Nuclear Physics',
      'Solid State Physics',
      'Electronics',
      'Practical',
    ],

    'B.Sc.|Physics|Semester 6': [
      'Particle Physics',
      'Astrophysics',
      'Nuclear Physics',
      'Electronics',
      'Project',
    ],

    // ===================================================
    // B.SC. - CHEMISTRY
    // ===================================================

    'B.Sc.|Chemistry|Semester 1': [
      'Inorganic Chemistry',
      'Organic Chemistry',
      'Physical Chemistry',
      'Chemistry Practical',
      'Mathematics',
    ],

    'B.Sc.|Chemistry|Semester 2': [
      'Inorganic Chemistry',
      'Organic Chemistry',
      'Physical Chemistry',
      'Chemistry Practical',
      'Mathematics',
    ],

    'B.Sc.|Chemistry|Semester 3': [
      'Organic Chemistry',
      'Inorganic Chemistry',
      'Physical Chemistry',
      'Analytical Chemistry',
      'Practical',
    ],

    'B.Sc.|Chemistry|Semester 4': [
      'Organic Chemistry',
      'Inorganic Chemistry',
      'Physical Chemistry',
      'Analytical Chemistry',
      'Practical',
    ],

    'B.Sc.|Chemistry|Semester 5': [
      'Advanced Organic Chemistry',
      'Advanced Inorganic Chemistry',
      'Physical Chemistry',
      'Analytical Chemistry',
      'Practical',
    ],

    'B.Sc.|Chemistry|Semester 6': [
      'Advanced Organic Chemistry',
      'Advanced Inorganic Chemistry',
      'Biochemistry',
      'Industrial Chemistry',
      'Project',
    ],

    // ===================================================
    // B.SC. - MATHEMATICS
    // ===================================================

    'B.Sc.|Mathematics|Semester 1': [
      'Calculus',
      'Algebra',
      'Geometry',
      'Statistics',
      'Mathematical Practical',
    ],

    'B.Sc.|Mathematics|Semester 2': [
      'Calculus',
      'Algebra',
      'Differential Equations',
      'Statistics',
      'Mathematical Practical',
    ],

    'B.Sc.|Mathematics|Semester 3': [
      'Real Analysis',
      'Abstract Algebra',
      'Differential Equations',
      'Statistics',
      'Numerical Methods',
    ],

    'B.Sc.|Mathematics|Semester 4': [
      'Real Analysis',
      'Linear Algebra',
      'Numerical Methods',
      'Statistics',
      'Mathematical Practical',
    ],

    'B.Sc.|Mathematics|Semester 5': [
      'Complex Analysis',
      'Number Theory',
      'Operations Research',
      'Statistics',
      'Numerical Analysis',
    ],

    'B.Sc.|Mathematics|Semester 6': [
      'Advanced Algebra',
      'Complex Analysis',
      'Operations Research',
      'Statistics',
      'Project',
    ],

    // ===================================================
    // B.TECH. - COMPUTER SCIENCE
    // ===================================================

    'B.Tech.|Computer Science|Semester 1': [
      'Engineering Mathematics',
      'Programming in C',
      'Engineering Physics',
      'Engineering Chemistry',
      'Communication Skills',
    ],

    'B.Tech.|Computer Science|Semester 2': [
      'Engineering Mathematics',
      'Object Oriented Programming',
      'Digital Logic',
      'Data Structures',
      'Computer Organization',
    ],

    'B.Tech.|Computer Science|Semester 3': [
      'Data Structures',
      'DBMS',
      'Operating System',
      'Computer Networks',
      'Object Oriented Programming',
    ],

    'B.Tech.|Computer Science|Semester 4': [
      'Design and Analysis of Algorithms',
      'Software Engineering',
      'Computer Architecture',
      'Web Technology',
      'Theory of Computation',
    ],

    'B.Tech.|Computer Science|Semester 5': [
      'Artificial Intelligence',
      'Machine Learning',
      'Compiler Design',
      'Cloud Computing',
      'Cyber Security',
    ],

    'B.Tech.|Computer Science|Semester 6': [
      'Big Data',
      'Distributed Systems',
      'Data Mining',
      'Network Security',
      'Mobile Computing',
    ],

    'B.Tech.|Computer Science|Semester 7': [
      'Deep Learning',
      'Natural Language Processing',
      'Blockchain',
      'Project',
      'Elective',
    ],

    'B.Tech.|Computer Science|Semester 8': [
      'Project',
      'Internship',
      'Professional Ethics',
      'Technical Seminar',
      'Elective',
    ],

    // ===================================================
    // B.TECH. - INFORMATION TECHNOLOGY
    // ===================================================

    'B.Tech.|Information Technology|Semester 1': [
      'Engineering Mathematics',
      'Programming in C',
      'Engineering Physics',
      'Communication Skills',
      'Engineering Chemistry',
    ],

    'B.Tech.|Information Technology|Semester 2': [
      'Object Oriented Programming',
      'Data Structures',
      'Digital Logic',
      'Computer Organization',
      'Mathematics',
    ],

    'B.Tech.|Information Technology|Semester 3': [
      'Data Structures',
      'DBMS',
      'Operating System',
      'Web Technology',
      'Computer Networks',
    ],

    'B.Tech.|Information Technology|Semester 4': [
      'Software Engineering',
      'Java Programming',
      'Computer Networks',
      'Web Technology',
      'Theory of Computation',
    ],

    'B.Tech.|Information Technology|Semester 5': [
      'Cloud Computing',
      'Artificial Intelligence',
      'Cyber Security',
      'Data Analytics',
      'Software Engineering',
    ],

    'B.Tech.|Information Technology|Semester 6': [
      'Machine Learning',
      'Big Data',
      'Mobile Computing',
      'Network Security',
      'Project',
    ],

    'B.Tech.|Information Technology|Semester 7': [
      'Cloud Security',
      'Advanced Web Technology',
      'Machine Learning',
      'Project',
      'Elective',
    ],

    'B.Tech.|Information Technology|Semester 8': [
      'Project',
      'Internship',
      'Professional Ethics',
      'Technical Seminar',
      'Elective',
    ],

    // ===================================================
    // B.TECH. - MECHANICAL
    // ===================================================

    'B.Tech.|Mechanical|Semester 1': [
      'Engineering Mathematics',
      'Engineering Physics',
      'Engineering Chemistry',
      'Engineering Drawing',
      'Programming',
    ],

    'B.Tech.|Mechanical|Semester 2': [
      'Engineering Mathematics',
      'Engineering Mechanics',
      'Manufacturing Process',
      'Material Science',
      'Basic Electrical Engineering',
    ],

    'B.Tech.|Mechanical|Semester 3': [
      'Thermodynamics',
      'Fluid Mechanics',
      'Manufacturing Technology',
      'Material Science',
      'Engineering Mechanics',
    ],

    'B.Tech.|Mechanical|Semester 4': [
      'Heat Transfer',
      'Machine Design',
      'Fluid Mechanics',
      'Manufacturing Technology',
      'Theory of Machines',
    ],

    'B.Tech.|Mechanical|Semester 5': [
      'Dynamics of Machines',
      'Machine Design',
      'CAD',
      'Industrial Engineering',
      'Thermal Engineering',
    ],

    'B.Tech.|Mechanical|Semester 6': [
      'Robotics',
      'Automobile Engineering',
      'Production Management',
      'Refrigeration',
      'Project',
    ],

    'B.Tech.|Mechanical|Semester 7': [
      'Advanced Manufacturing',
      'Robotics',
      'Industrial Automation',
      'Project',
      'Elective',
    ],

    'B.Tech.|Mechanical|Semester 8': [
      'Project',
      'Internship',
      'Professional Ethics',
      'Seminar',
      'Elective',
    ],

    // ===================================================
    // B.TECH. - CIVIL
    // ===================================================

    'B.Tech.|Civil|Semester 1': [
      'Engineering Mathematics',
      'Engineering Physics',
      'Engineering Chemistry',
      'Engineering Drawing',
      'Programming',
    ],

    'B.Tech.|Civil|Semester 2': [
      'Engineering Mathematics',
      'Engineering Mechanics',
      'Building Materials',
      'Surveying',
      'Basic Electrical Engineering',
    ],

    'B.Tech.|Civil|Semester 3': [
      'Structural Analysis',
      'Fluid Mechanics',
      'Surveying',
      'Concrete Technology',
      'Geotechnical Engineering',
    ],

    'B.Tech.|Civil|Semester 4': [
      'Structural Engineering',
      'Hydraulics',
      'Transportation Engineering',
      'Environmental Engineering',
      'Surveying',
    ],

    'B.Tech.|Civil|Semester 5': [
      'Design of Structures',
      'Foundation Engineering',
      'Transportation Engineering',
      'Environmental Engineering',
      'Construction Management',
    ],

    'B.Tech.|Civil|Semester 6': [
      'Advanced Structural Design',
      'Water Resources',
      'Construction Technology',
      'Environmental Engineering',
      'Project',
    ],

    'B.Tech.|Civil|Semester 7': [
      'Advanced Construction',
      'Project Management',
      'Structural Design',
      'Project',
      'Elective',
    ],

    'B.Tech.|Civil|Semester 8': [
      'Project',
      'Internship',
      'Professional Ethics',
      'Seminar',
      'Elective',
    ],

    // ===================================================
    // B.TECH. - ELECTRONICS
    // ===================================================

    'B.Tech.|Electronics|Semester 1': [
      'Engineering Mathematics',
      'Engineering Physics',
      'Engineering Chemistry',
      'Basic Electronics',
      'Programming',
    ],

    'B.Tech.|Electronics|Semester 2': [
      'Engineering Mathematics',
      'Digital Electronics',
      'Circuit Theory',
      'Signals and Systems',
      'Programming',
    ],

    'B.Tech.|Electronics|Semester 3': [
      'Analog Electronics',
      'Digital Electronics',
      'Microprocessors',
      'Signals and Systems',
      'Network Theory',
    ],

    'B.Tech.|Electronics|Semester 4': [
      'Microcontrollers',
      'Communication Systems',
      'Control Systems',
      'Digital Signal Processing',
      'Electronics Devices',
    ],

    'B.Tech.|Electronics|Semester 5': [
      'Embedded Systems',
      'VLSI',
      'Digital Communication',
      'Antenna Theory',
      'Microprocessors',
    ],

    'B.Tech.|Electronics|Semester 6': [
      'Wireless Communication',
      'Embedded Systems',
      'VLSI Design',
      'Signal Processing',
      'Project',
    ],

    'B.Tech.|Electronics|Semester 7': [
      'Advanced Embedded Systems',
      'IoT',
      'VLSI',
      'Project',
      'Elective',
    ],

    'B.Tech.|Electronics|Semester 8': [
      'Project',
      'Internship',
      'Professional Ethics',
      'Seminar',
      'Elective',
    ],

    // ===================================================
    // B.TECH. - ELECTRICAL
    // ===================================================

    'B.Tech.|Electrical|Semester 1': [
      'Engineering Mathematics',
      'Engineering Physics',
      'Engineering Chemistry',
      'Basic Electrical Engineering',
      'Programming',
    ],

    'B.Tech.|Electrical|Semester 2': [
      'Engineering Mathematics',
      'Circuit Theory',
      'Electrical Machines',
      'Digital Electronics',
      'Programming',
    ],

    'B.Tech.|Electrical|Semester 3': [
      'Electrical Machines',
      'Power Systems',
      'Network Theory',
      'Control Systems',
      'Electronics',
    ],

    'B.Tech.|Electrical|Semester 4': [
      'Power Electronics',
      'Electrical Machines',
      'Control Systems',
      'Power Systems',
      'Measurements',
    ],

    'B.Tech.|Electrical|Semester 5': [
      'Power System Analysis',
      'Electrical Drives',
      'Power Electronics',
      'Control Systems',
      'Microprocessors',
    ],

    'B.Tech.|Electrical|Semester 6': [
      'High Voltage Engineering',
      'Power System Protection',
      'Electrical Drives',
      'Renewable Energy',
      'Project',
    ],

    'B.Tech.|Electrical|Semester 7': [
      'Smart Grid',
      'Power System Planning',
      'Renewable Energy',
      'Project',
      'Elective',
    ],

    'B.Tech.|Electrical|Semester 8': [
      'Project',
      'Internship',
      'Professional Ethics',
      'Seminar',
      'Elective',
    ],

    // ===================================================
    // B.ED. - EDUCATION
    // ===================================================

    'B.Ed.|Education|Semester 1': [
      'Childhood and Growing Up',
      'Contemporary India and Education',
      'Learning and Teaching',
      'Language Across Curriculum',
    ],

    'B.Ed.|Education|Semester 2': [
      'Knowledge and Curriculum',
      'Assessment for Learning',
      'Creating an Inclusive School',
      'Educational Technology',
    ],

    'B.Ed.|Education|Semester 3': [
      'Pedagogy of School Subject',
      'Gender, School and Society',
      'Knowledge and Curriculum',
      'School Internship',
    ],

    'B.Ed.|Education|Semester 4': [
      'Assessment for Learning',
      'Guidance and Counselling',
      'Educational Technology',
      'School Internship',
    ],
  };

  // =====================================================
  // GET CURRENT SUBJECTS
  // =====================================================

  List<String> getCurrentSubjects() {

    String key =
        '$selectedCourse|$selectedDepartment|$selectedSemester';

    return subjects[key] ?? [];
  }

  // =====================================================
  // ADD SUBJECT MARKS
  // =====================================================

  void addSubjectMarks() {

    if (selectedSubject == null) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a subject'),
        ),
      );

      return;
    }

    if (internalController.text.isEmpty ||
        externalController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter internal and external marks',
          ),
        ),
      );

      return;
    }

    int internal =
        int.tryParse(internalController.text) ?? 0;

    int external =
        int.tryParse(externalController.text) ?? 0;

    if (internal < 0 ||
        internal > 40 ||
        external < 0 ||
        external > 60) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Internal must be 0-40 and External must be 0-60',
          ),
        ),
      );

      return;
    }

    int total = internal + external;

    setState(() {

      subjectMarks.add({
        'subject': selectedSubject,
        'internal': internal,
        'external': external,
        'total': total,
      });

      selectedSubject = null;
    });

    internalController.clear();
    externalController.clear();
  }

  // =====================================================
  // DELETE SUBJECT
  // =====================================================

  void deleteSubject(int index) {

    setState(() {

      subjectMarks.removeAt(index);

    });
  }

  // =====================================================
  // SAVE STUDENT
  // =====================================================

  void saveStudentMarks() {

    if (studentIdController.text.isEmpty ||
        studentNameController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter Student ID and Student Name',
          ),
        ),
      );

      return;
    }

    if (subjectMarks.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please add at least one subject mark',
          ),
        ),
      );

      return;
    }

    setState(() {

      savedStudents.add({

        'id': studentIdController.text,

        'name': studentNameController.text,

        'course': selectedCourse,

        'department': selectedDepartment,

        'semester': selectedSemester,

        'division': selectedDivision,

        'academicYear':
        academicYearController.text,

        'marks': List<Map<String, dynamic>>.from(
          subjectMarks,
        ),
      });

      studentIdController.clear();

      studentNameController.clear();

      subjectMarks.clear();

      selectedSubject = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Student and marks saved successfully!',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  // =====================================================
  // INPUT FIELD
  // =====================================================

  Widget inputField(
      String label,
      TextEditingController controller,
      IconData icon,
      ) {

    return TextField(

      controller: controller,

      style: TextStyle(
        color: Colors.white,
      ),

      decoration: InputDecoration(

        labelText: label,

        labelStyle: TextStyle(
          color: Colors.grey,
        ),

        prefixIcon: Icon(
          icon,
          color: Colors.lightBlueAccent,
        ),

        filled: true,

        fillColor: Color(0xFF071A2B),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  // =====================================================
  // DROPDOWN FIELD
  // =====================================================

  Widget dropdownField(
      String label,
      String value,
      List<String> items,
      Function(String?) onChanged,
      ) {

    return DropdownButtonFormField<String>(

      value: value,

      dropdownColor: Color(0xFF102A43),

      style: TextStyle(
        color: Colors.white,
      ),

      decoration: InputDecoration(

        labelText: label,

        labelStyle: TextStyle(
          color: Colors.grey,
        ),

        filled: true,

        fillColor: Color(0xFF071A2B),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),

      items: items.map((item) {

        return DropdownMenuItem<String>(

          value: item,

          child: Text(
            item,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        );

      }).toList(),

      onChanged: onChanged,
    );
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(

      padding: EdgeInsets.all(25),

      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          // =================================================
          // PAGE TITLE
          // =================================================

          Text(
            'Manage Marks',
            style: TextStyle(
              color: Color(0xFF163B60),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 8),

          Text(
            'Add student details and subject-wise marks',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),

          SizedBox(height: 25),

          // =================================================
          // STUDENT DETAILS
          // =================================================

          Container(

            padding: EdgeInsets.all(25),

            decoration: BoxDecoration(

              color: Color(0xFF102A43),

              borderRadius:
              BorderRadius.circular(15),
            ),

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  'Student Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 20),

                // STUDENT ID + NAME

                Row(
                  children: [

                    Expanded(
                      child: inputField(
                        'Student ID',
                        studentIdController,
                        Icons.badge,
                      ),
                    ),

                    SizedBox(width: 15),

                    Expanded(
                      child: inputField(
                        'Student Name',
                        studentNameController,
                        Icons.person,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 18),

                // COURSE + DEPARTMENT

                Row(
                  children: [

                    Expanded(
                      child: dropdownField(
                        'Course',
                        selectedCourse,
                        courses,
                            (value) {

                          setState(() {

                            selectedCourse =
                            value!;

                            selectedDepartment =
                            departments[
                            selectedCourse]![0];

                            selectedSemester =
                            courseSemesters[
                            selectedCourse]![0];

                            selectedSubject =
                            null;
                          });
                        },
                      ),
                    ),

                    SizedBox(width: 15),

                    Expanded(
                      child: dropdownField(
                        'Department',
                        selectedDepartment,
                        departments[
                        selectedCourse]!,
                            (value) {

                          setState(() {

                            selectedDepartment =
                            value!;

                            selectedSubject =
                            null;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 18),

                // SEMESTER + DIVISION

                Row(
                  children: [

                    Expanded(
                      child: dropdownField(
                        'Semester',
                        selectedSemester,
                        courseSemesters[
                        selectedCourse]!,
                            (value) {

                          setState(() {

                            selectedSemester =
                            value!;

                            selectedSubject =
                            null;
                          });
                        },
                      ),
                    ),

                    SizedBox(width: 15),

                    Expanded(
                      child: dropdownField(
                        'Division',
                        selectedDivision,
                        [
                          'A',
                          'B',
                          'C',
                        ],
                            (value) {

                          setState(() {

                            selectedDivision =
                            value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 18),

                // ACADEMIC YEAR

                inputField(
                  'Academic Year',
                  academicYearController,
                  Icons.calendar_month,
                ),
              ],
            ),
          ),

          SizedBox(height: 25),

          // =================================================
          // SUBJECT MARKS
          // =================================================

          Container(

            padding: EdgeInsets.all(25),

            decoration: BoxDecoration(

              color: Color(0xFF102A43),

              borderRadius:
              BorderRadius.circular(15),
            ),

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  'Subject-wise Marks',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 20),

                // SUBJECT

                DropdownButtonFormField<String>(

                  value: selectedSubject,

                  dropdownColor:
                  Color(0xFF102A43),

                  style: TextStyle(
                    color: Colors.white,
                  ),

                  decoration:
                  InputDecoration(

                    labelText:
                    'Select Subject',

                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),

                    prefixIcon: Icon(
                      Icons.book,
                      color:
                      Colors.lightBlueAccent,
                    ),

                    filled: true,

                    fillColor:
                    Color(0xFF071A2B),

                    border:
                    OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                  ),

                  items:
                  getCurrentSubjects()
                      .map((subject) {

                    return DropdownMenuItem<
                        String>(

                      value: subject,

                      child: Text(
                        subject,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );

                  }).toList(),

                  onChanged: (value) {

                    setState(() {

                      selectedSubject =
                          value;
                    });
                  },
                ),

                SizedBox(height: 18),

                // INTERNAL + EXTERNAL

                Row(
                  children: [

                    Expanded(
                      child: inputField(
                        'Internal Marks (0-40)',
                        internalController,
                        Icons.edit,
                      ),
                    ),

                    SizedBox(width: 15),

                    Expanded(
                      child: inputField(
                        'External Marks (0-60)',
                        externalController,
                        Icons.assignment,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 18),

                // ADD SUBJECT

                SizedBox(
                  width: double.infinity,

                  child:
                  ElevatedButton.icon(

                    onPressed:
                    addSubjectMarks,

                    icon: Icon(
                      Icons.add,
                    ),

                    label: Text(
                      'Add Subject Marks',
                    ),

                    style:
                    ElevatedButton.styleFrom(

                      backgroundColor:
                      Color(0xFF1976D2),

                      foregroundColor:
                      Colors.white,

                      padding:
                      EdgeInsets.symmetric(
                        vertical: 15,
                      ),

                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // =================================================
                // MARKS TABLE
                // =================================================

                subjectMarks.isEmpty

                    ? Text(
                  'No subject marks added yet.',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )

                    : SingleChildScrollView(

                  scrollDirection:
                  Axis.horizontal,

                  child: DataTable(

                    headingRowColor:
                    MaterialStateProperty
                        .all(
                      Color(0xFF1976D2),
                    ),

                    columns: [

                      DataColumn(
                        label: Text(
                          'Subject',
                          style: TextStyle(
                            color:
                            Colors.white,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),

                      DataColumn(
                        label: Text(
                          'Internal',
                          style: TextStyle(
                            color:
                            Colors.white,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),

                      DataColumn(
                        label: Text(
                          'External',
                          style: TextStyle(
                            color:
                            Colors.white,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),

                      DataColumn(
                        label: Text(
                          'Total',
                          style: TextStyle(
                            color:
                            Colors.white,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),

                      DataColumn(
                        label: Text(
                          'Action',
                          style: TextStyle(
                            color:
                            Colors.white,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ],

                    rows:
                    List.generate(
                      subjectMarks.length,
                          (index) {

                        var mark =
                        subjectMarks[
                        index];

                        return DataRow(

                          cells: [

                            DataCell(
                              Text(
                                mark[
                                'subject'],
                                style:
                                TextStyle(
                                  color:
                                  Colors.white,
                                ),
                              ),
                            ),

                            DataCell(
                              Text(
                                '${mark['internal']}',
                                style:
                                TextStyle(
                                  color:
                                  Colors.white,
                                ),
                              ),
                            ),

                            DataCell(
                              Text(
                                '${mark['external']}',
                                style:
                                TextStyle(
                                  color:
                                  Colors.white,
                                ),
                              ),
                            ),

                            DataCell(
                              Text(
                                '${mark['total']}',
                                style:
                                TextStyle(
                                  color:
                                  Colors.greenAccent,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),
                            ),

                            DataCell(

                              IconButton(

                                icon:
                                Icon(
                                  Icons.delete,
                                  color:
                                  Colors.redAccent,
                                ),

                                onPressed: () {

                                  deleteSubject(
                                      index);
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),

                SizedBox(height: 25),

                // =================================================
                // SAVE STUDENT
                // =================================================

                SizedBox(
                  width: double.infinity,

                  child:
                  ElevatedButton.icon(

                    onPressed:
                    saveStudentMarks,

                    icon: Icon(
                      Icons.save,
                    ),

                    label: Text(
                      'Save Student & Marks',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    style:
                    ElevatedButton.styleFrom(

                      backgroundColor:
                      Colors.green,

                      foregroundColor:
                      Colors.white,

                      padding:
                      EdgeInsets.symmetric(
                        vertical: 17,
                      ),

                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 30),

          // =================================================
          // SAVED RECORDS
          // =================================================

          Text(
            'Saved Student Records',
            style: TextStyle(
              color: Color(0xFF163B60),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 15),

          savedStudents.isEmpty

              ? Container(

            width: double.infinity,

            padding:
            EdgeInsets.all(25),

            decoration:
            BoxDecoration(

              color:
              Color(0xFF102A43),

              borderRadius:
              BorderRadius.circular(12),
            ),

            child: Text(
              'No student records saved yet.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          )

              : Column(

            children:
            List.generate(

              savedStudents.length,

                  (index) {

                var student =
                savedStudents[index];

                return Container(

                  width:
                  double.infinity,

                  margin:
                  EdgeInsets.only(
                    bottom: 15,
                  ),

                  padding:
                  EdgeInsets.all(20),

                  decoration:
                  BoxDecoration(

                    color:
                    Color(0xFF102A43),

                    borderRadius:
                    BorderRadius.circular(
                        12),
                  ),

                  child: Column(

                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      Text(
                        student['name'],
                        style:
                        TextStyle(
                          color:
                          Colors.white,
                          fontSize: 19,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 8),

                      Text(
                        'ID: ${student['id']}',
                        style:
                        TextStyle(
                          color:
                          Colors.white70,
                        ),
                      ),

                      SizedBox(height: 5),

                      Text(
                        '${student['course']} | ${student['department']} | ${student['semester']} | Division ${student['division']}',
                        style:
                        TextStyle(
                          color:
                          Colors.white70,
                        ),
                      ),

                      SizedBox(height: 5),

                      Text(
                        'Academic Year: ${student['academicYear']}',
                        style:
                        TextStyle(
                          color:
                          Colors.white70,
                        ),
                      ),

                      SizedBox(height: 15),

                      Divider(
                        color:
                        Colors.white24,
                      ),

                      SizedBox(height: 10),

                      ...List.generate(

                        student['marks']
                            .length,

                            (markIndex) {

                          var mark =
                          student[
                          'marks']
                          [markIndex];

                          return Padding(

                            padding:
                            EdgeInsets
                                .symmetric(
                              vertical: 5,
                            ),

                            child: Row(

                              children: [

                                Expanded(
                                  child:
                                  Text(
                                    mark[
                                    'subject'],
                                    style:
                                    TextStyle(
                                      color:
                                      Colors.white,
                                    ),
                                  ),
                                ),

                                Text(
                                  'Internal: ${mark['internal']}',
                                  style:
                                  TextStyle(
                                    color:
                                    Colors.white70,
                                  ),
                                ),

                                SizedBox(
                                  width: 15,
                                ),

                                Text(
                                  'External: ${mark['external']}',
                                  style:
                                  TextStyle(
                                    color:
                                    Colors.white70,
                                  ),
                                ),

                                SizedBox(
                                  width: 15,
                                ),

                                Text(
                                  'Total: ${mark['total']}',
                                  style:
                                  TextStyle(
                                    color:
                                    Colors.greenAccent,
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ================= FEES MANAGEMENT =================

class FeesManagementPage extends StatefulWidget {
  @override
  State<FeesManagementPage> createState() => _FeesManagementPageState();
}

class _FeesManagementPageState extends State<FeesManagementPage> {

  List<Map<String, dynamic>> fees = [
    {
      'id': '101',
      'name': 'Sana Ansari',
      'course': 'BSc IT',
      'total': 60000,
      'paid': 60000,
      'pending': 0,
      'status': 'Paid',
    },
    {
      'id': '102',
      'name': 'Aisha Khan',
      'course': 'BSc IT',
      'total': 60000,
      'paid': 45000,
      'pending': 15000,
      'status': 'Pending',
    },
    {
      'id': '103',
      'name': 'Rahul Sharma',
      'course': 'BSc CS',
      'total': 55000,
      'paid': 35000,
      'pending': 20000,
      'status': 'Pending',
    },
    {
      'id': '104',
      'name': 'Aditya Verma',
      'course': 'BCA',
      'total': 50000,
      'paid': 50000,
      'pending': 0,
      'status': 'Paid',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF5F7FA),
      padding: EdgeInsets.all(20),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            'Fees Management',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF123456),
            ),
          ),

          SizedBox(height: 5),

          Text(
            'Manage student fees and payment status',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),

          SizedBox(height: 20),

          Row(
            children: [

              Expanded(
                child: _feeCard(
                  'Total Fees',
                  '₹2,25,000',
                  Icons.account_balance_wallet,
                ),
              ),

              SizedBox(width: 15),

              Expanded(
                child: _feeCard(
                  'Fees Collected',
                  '₹1,80,000',
                  Icons.payments,
                ),
              ),

              SizedBox(width: 15),

              Expanded(
                child: _feeCard(
                  'Pending Fees',
                  '₹45,000',
                  Icons.pending_actions,
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          Expanded(
            child: Card(
              elevation: 2,

              child: Column(
                children: [

                  Container(
                    padding: EdgeInsets.all(15),

                    child: Row(
                      children: [

                        Expanded(
                          child: Text(
                            'ID',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: Text(
                            'Student',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: Text(
                            'Course',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Expanded(
                          child: Text(
                            'Total',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Expanded(
                          child: Text(
                            'Paid',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Expanded(
                          child: Text(
                            'Pending',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Expanded(
                          child: Text(
                            'Status',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Divider(),

                  Expanded(
                    child: ListView.builder(
                      itemCount: fees.length,

                      itemBuilder: (context, index) {

                        final fee = fees[index];

                        return Container(
                          padding: EdgeInsets.all(15),

                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade200,
                              ),
                            ),
                          ),

                          child: Row(
                            children: [

                              Expanded(
                                child: Text(fee['id']),
                              ),

                              Expanded(
                                flex: 2,
                                child: Text(fee['name']),
                              ),

                              Expanded(
                                flex: 2,
                                child: Text(fee['course']),
                              ),

                              Expanded(
                                child: Text(
                                  '₹${fee['total']}',
                                ),
                              ),

                              Expanded(
                                child: Text(
                                  '₹${fee['paid']}',
                                ),
                              ),

                              Expanded(
                                child: Text(
                                  '₹${fee['pending']}',
                                  style: TextStyle(
                                    color: fee['pending'] == 0
                                        ? Colors.green
                                        : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              Expanded(
                                child: Text(
                                  fee['status'],
                                  style: TextStyle(
                                    color: fee['status'] == 'Paid'
                                        ? Colors.green
                                        : Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(15),

                    child: ElevatedButton.icon(
                      onPressed: () {

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Fee details updated successfully!',
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );

                      },

                      icon: Icon(Icons.save),

                      label: Text('Update Fees'),

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1976D2),
                        foregroundColor: Colors.white,

                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _feeCard(
      String title,
      String value,
      IconData icon,
      ) {

    return Card(
      elevation: 2,

      child: Padding(
        padding: EdgeInsets.all(18),

        child: Row(
          children: [

            Icon(
              icon,
              size: 35,
              color: Color(0xFF1976D2),
            ),

            SizedBox(width: 15),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF123456),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ================= ADMIN DRAWER =================

class AdminDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [

          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF123456),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.school,
                  color: Colors.white,
                  size: 40,
                ),
                SizedBox(height: 10),
                Text(
                  'Student Management',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'ADMIN PANEL',
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Dashboard'),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.person_add),
            title: Text('Add Student'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddStudentPage(),
                ),
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.people),
            title: Text('All Students'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AllStudentsPage(),
                ),
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.search),
            title: Text('Search Student'),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Update Student'),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete Student'),
            onTap: () {},
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.account_tree),
            title: Text('Linked List'),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.grid_view),
            title: Text('Array Operations'),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.queue),
            title: Text('Queue'),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.sort),
            title: Text('Sorting'),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.search),
            title: Text('Searching'),
            onTap: () {},
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
                    (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}

// ================= STUDENT DASHBOARD =================



// ================= STUDENT DRAWER =================

class StudentDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [

          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green.shade700,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.school,
                  color: Colors.white,
                  size: 40,
                ),
                SizedBox(height: 10),
                Text(
                  'Student Portal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'STUDENT PANEL',
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Dashboard'),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.person),
            title: Text('My Profile'),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.badge),
            title: Text('My ID Card'),
            onTap: () {},
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.book),
            title: Text('Registered Subjects'),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.grade),
            title: Text('My Marks'),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Attendance'),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.assessment),
            title: Text('Result'),
            onTap: () {},
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.receipt_long),
            title: Text('Hall Ticket'),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Fees Paid'),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notices'),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.description),
            title: Text('Certificate Requests'),
            onTap: () {},
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
                    (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}

// ================= DASHBOARD CARD =================

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  DashboardCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 120,
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [

          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: color,
              size: 27,
            ),
          ),

          SizedBox(width: 15),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),

              SizedBox(height: 6),

              Text(
                value,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ================= STUDENT ROW =================

class StudentRow extends StatelessWidget {
  final String id;
  final String name;
  final String course;
  final String semester;

  StudentRow({
    required this.id,
    required this.name,
    required this.course,
    required this.semester,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
      ),
      child: Row(
        children: [

          Expanded(
            flex: 1,
            child: Text(id),
          ),

          Expanded(
            flex: 3,
            child: Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Text(course),
          ),

          Expanded(
            flex: 1,
            child: Text(semester),
          ),

          Icon(
            Icons.visibility,
            size: 20,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}

// ================= MARK ROW =================

class StudentMarkRow extends StatelessWidget {
  final String subject;
  final String marks;
  final String grade;

  StudentMarkRow({
    required this.subject,
    required this.marks,
    required this.grade,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 14,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
      ),
      child: Row(
        children: [

          Expanded(
            flex: 3,
            child: Text(subject),
          ),

          Expanded(
            child: Text(marks),
          ),

          Expanded(
            child: Text(
              grade,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= FEATURE CARD =================

class FeatureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  FeatureCard({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 7,
          ),
        ],
      ),
      child: Row(
        children: [

          Icon(
            icon,
            size: 32,
            color: Colors.blue,
          ),

          SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ================= ADD STUDENT PAGE =================

class AddStudentPage extends StatefulWidget {
  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {

  TextEditingController studentIdController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String gender = 'Male';
  String course = 'BSc IT';
  String semester = 'Semester 3';
  String division = 'A';

  void addStudent() {
    String studentId = studentIdController.text.trim();
    String studentName = nameController.text.trim();
    String studentEmail = emailController.text.trim();
    String studentPhone = phoneController.text.trim();

    if (studentId.isEmpty ||
        studentName.isEmpty ||
        studentEmail.isEmpty ||
        studentPhone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    bool idExists = students.any(
          (student) => student.id.toLowerCase() == studentId.toLowerCase(),
    );

    if (idExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Student ID already exists!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Student newStudent = Student(
      id: studentId,
      name: studentName,
      email: studentEmail,
      phone: studentPhone,
      dob: dobController.text.trim(),
      gender: gender,
      course: course,
      semester: semester,
      division: division,
      address: addressController.text.trim(),
    );

    setState(() {
      students.add(newStudent);
    });

    // Username is automatically based on the student's name.
    String username = studentName
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]'), '') +
        '@vesasc.com';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Student added successfully!\nUsername: $username | Password: student',
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 4),
      ),
    );

    studentIdController.clear();
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    dobController.clear();
    addressController.clear();

    setState(() {
      gender = 'Male';
      course = 'BSc IT';
      semester = 'Semester 3';
      division = 'A';
    });
  }

  Widget inputField(
      String label,
      String hint,
      IconData icon,
      TextEditingController controller,
      ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Color(0xFFF5F7FA),

      appBar: AppBar(
        backgroundColor: Color(0xFF123456),
        foregroundColor: Colors.white,
        title: Text('Add Student'),
      ),

      body: SingleChildScrollView(

        padding: EdgeInsets.all(25),

        child: Center(

          child: Container(

            width: 850,

            padding: EdgeInsets.all(25),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                ),
              ],
            ),

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(
                  'Add New Student',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF123456),
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  'Enter student details below',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),

                SizedBox(height: 30),

                // Student ID

                inputField(
                  'Student ID *',
                  'Enter student ID',
                  Icons.badge,
                  studentIdController,
                ),

                SizedBox(height: 20),

                // Name

                inputField(
                  'Full Name *',
                  'Enter full name',
                  Icons.person,
                  nameController,
                ),

                SizedBox(height: 20),

                // Email

                inputField(
                  'Email *',
                  'Enter email address',
                  Icons.email,
                  emailController,
                ),

                SizedBox(height: 20),

                // Phone

                inputField(
                  'Phone Number *',
                  'Enter phone number',
                  Icons.phone,
                  phoneController,
                ),

                SizedBox(height: 20),

                // Date of Birth

                inputField(
                  'Date of Birth',
                  'DD/MM/YYYY',
                  Icons.calendar_today,
                  dobController,
                ),

                SizedBox(height: 20),

                // Gender

                Text(
                  'Gender',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Row(
                  children: [

                    Radio<String>(
                      value: 'Male',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),

                    Text('Male'),

                    Radio<String>(
                      value: 'Female',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),

                    Text('Female'),

                    Radio<String>(
                      value: 'Other',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),

                    Text('Other'),
                  ],
                ),

                SizedBox(height: 20),

                // Course

                DropdownButtonFormField<String>(
                  value: course,

                  decoration: InputDecoration(
                    labelText: 'Course',
                    prefixIcon: Icon(Icons.school),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  items: [
                    DropdownMenuItem(
                      value: 'BSc IT',
                      child: Text('BSc IT'),
                    ),
                    DropdownMenuItem(
                      value: 'BSc CS',
                      child: Text('BSc CS'),
                    ),
                    DropdownMenuItem(
                      value: 'BCA',
                      child: Text('BCA'),
                    ),
                    DropdownMenuItem(
                      value: 'BCom',
                      child: Text('BCom'),
                    ),
                  ],

                  onChanged: (value) {
                    setState(() {
                      course = value!;
                    });
                  },
                ),

                SizedBox(height: 20),

                // Semester

                DropdownButtonFormField<String>(
                  value: semester,

                  decoration: InputDecoration(
                    labelText: 'Semester',
                    prefixIcon: Icon(Icons.menu_book),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  items: [
                    DropdownMenuItem(
                      value: 'Semester 1',
                      child: Text('Semester 1'),
                    ),
                    DropdownMenuItem(
                      value: 'Semester 2',
                      child: Text('Semester 2'),
                    ),
                    DropdownMenuItem(
                      value: 'Semester 3',
                      child: Text('Semester 3'),
                    ),
                    DropdownMenuItem(
                      value: 'Semester 4',
                      child: Text('Semester 4'),
                    ),
                    DropdownMenuItem(
                      value: 'Semester 5',
                      child: Text('Semester 5'),
                    ),
                    DropdownMenuItem(
                      value: 'Semester 6',
                      child: Text('Semester 6'),
                    ),
                  ],

                  onChanged: (value) {
                    setState(() {
                      semester = value!;
                    });
                  },
                ),

                SizedBox(height: 20),

                // Division

                DropdownButtonFormField<String>(
                  value: division,

                  decoration: InputDecoration(
                    labelText: 'Division',
                    prefixIcon: Icon(Icons.groups),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  items: [
                    DropdownMenuItem(
                      value: 'A',
                      child: Text('Division A'),
                    ),
                    DropdownMenuItem(
                      value: 'B',
                      child: Text('Division B'),
                    ),
                    DropdownMenuItem(
                      value: 'C',
                      child: Text('Division C'),
                    ),
                  ],

                  onChanged: (value) {
                    setState(() {
                      division = value!;
                    });
                  },
                ),

                SizedBox(height: 20),

                // Address

                TextField(
                  controller: addressController,

                  maxLines: 3,

                  decoration: InputDecoration(
                    labelText: 'Address',
                    hintText: 'Enter student address',
                    prefixIcon: Icon(Icons.location_on),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                SizedBox(height: 30),

                // Buttons

                Row(
                  children: [

                    Expanded(
                      child: SizedBox(
                        height: 50,

                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },

                          child: Text(
                            'CANCEL',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 15),

                    Expanded(
                      child: SizedBox(
                        height: 50,

                        child: ElevatedButton(
                          onPressed: addStudent,

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF123456),
                            foregroundColor: Colors.white,

                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(10),
                            ),
                          ),

                          child: Text(
                            'ADD STUDENT',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ================= ALL STUDENTS PAGE =================

class AllStudentsPage extends StatefulWidget {
  @override
  State<AllStudentsPage> createState() => _AllStudentsPageState();
}

class _AllStudentsPageState extends State<AllStudentsPage> {

  TextEditingController searchController =
  TextEditingController();

  String searchText = '';

  void deleteStudent(int index) {

    Student student = students[index];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(

          title: Text('Delete Student'),

          content: Text(
            'Are you sure you want to delete ${student.name}?',
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('CANCEL'),
            ),

            ElevatedButton(
              onPressed: () {

                setState(() {
                  students.removeAt(index);
                });

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Student deleted successfully',
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),

              child: Text('DELETE'),
            ),
          ],
        );
      },
    );
  }

  void editStudent(Student student) {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditStudentPage(
          student: student,
        ),
      ),
    ).then((value) {

      if (value == true) {
        setState(() {});
      }

    });
  }

  @override
  Widget build(BuildContext context) {

    List<Student> filteredStudents = students
        .where(
          (student) =>
      student.name
          .toLowerCase()
          .contains(searchText.toLowerCase()) ||
          student.id
              .toLowerCase()
              .contains(searchText.toLowerCase()),
    )
        .toList();

    return Padding(

      padding: EdgeInsets.all(25),

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Text(
            'All Students',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFF123456),
            ),
          ),

          SizedBox(height: 5),

          Text(
            '${students.length} students registered',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),

          SizedBox(height: 20),

          // Search

          TextField(
            controller: searchController,

            decoration: InputDecoration(
              hintText: 'Search by student name or ID',
              prefixIcon: Icon(Icons.search),

              suffixIcon: IconButton(
                icon: Icon(Icons.clear),

                onPressed: () {

                  searchController.clear();

                  setState(() {
                    searchText = '';
                  });

                },
              ),

              filled: true,
              fillColor: Colors.white,

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),

            onChanged: (value) {

              setState(() {
                searchText = value;
              });

            },
          ),

          SizedBox(height: 20),

          // Student List

          Expanded(

            child: Container(

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),

              child: filteredStudents.isEmpty

                  ? Center(
                child: Text(
                  'No students found',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              )

                  : ListView.builder(

                itemCount: filteredStudents.length,

                itemBuilder: (context, index) {

                  Student student =
                  filteredStudents[index];

                  int originalIndex =
                  students.indexOf(student);

                  return Container(

                    margin: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),

                    padding: EdgeInsets.all(12),

                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),

                    child: Row(

                      children: [

                        // Avatar

                        CircleAvatar(
                          radius: 25,

                          backgroundColor:
                          Color(0xFF123456),

                          child: Text(
                            student.name[0]
                                .toUpperCase(),

                            style: TextStyle(
                              color: Colors.white,
                              fontWeight:
                              FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),

                        SizedBox(width: 15),

                        // Student information

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,

                            children: [

                              Text(
                                student.name,

                                style: TextStyle(
                                  fontWeight:
                                  FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),

                              SizedBox(height: 5),

                              Text(
                                'ID: ${student.id}   |   '
                                    '${student.course}   |   '
                                    '${student.semester}',

                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),

                            ],
                          ),
                        ),

                        // VIEW

                        IconButton(
                          tooltip: 'View',

                          icon: Icon(
                            Icons.visibility,
                            color: Colors.blue,
                          ),

                          onPressed: () {

                            Navigator.push(
                              context,

                              MaterialPageRoute(
                                builder: (context) =>
                                    StudentDetailsPage(
                                      student: student,
                                    ),
                              ),
                            );

                          },
                        ),

                        // EDIT

                        IconButton(
                          tooltip: 'Edit',

                          icon: Icon(
                            Icons.edit,
                            color: Colors.orange,
                          ),

                          onPressed: () {
                            editStudent(student);
                          },
                        ),

                        // DELETE

                        IconButton(
                          tooltip: 'Delete',

                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),

                          onPressed: () {
                            deleteStudent(
                              originalIndex,
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= STUDENT DETAILS PAGE =================

class StudentDetailsPage extends StatelessWidget {

  final Student student;

  StudentDetailsPage({
    required this.student,
  });

  Widget detailRow(
      String title,
      String value,
      IconData icon,
      ) {

    return Container(

      padding: EdgeInsets.symmetric(
        vertical: 15,
      ),

      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
      ),

      child: Row(

        children: [

          Icon(
            icon,
            color: Color(0xFF123456),
          ),

          SizedBox(width: 15),

          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),

          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Color(0xFFF5F7FA),

      appBar: AppBar(
        backgroundColor: Color(0xFF123456),
        foregroundColor: Colors.white,
        title: Text('Student Details'),
      ),

      body: SingleChildScrollView(

        padding: EdgeInsets.all(25),

        child: Center(

          child: Container(

            width: 800,

            padding: EdgeInsets.all(25),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),

            child: Column(

              children: [

                CircleAvatar(
                  radius: 45,

                  backgroundColor:
                  Color(0xFF123456),

                  child: Text(
                    student.name[0].toUpperCase(),

                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 15),

                Text(
                  student.name,

                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  'Student ID: ${student.id}',

                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),

                SizedBox(height: 25),

                detailRow(
                  'Student ID',
                  student.id,
                  Icons.badge,
                ),

                detailRow(
                  'Full Name',
                  student.name,
                  Icons.person,
                ),

                detailRow(
                  'Email',
                  student.email,
                  Icons.email,
                ),

                detailRow(
                  'Phone',
                  student.phone,
                  Icons.phone,
                ),

                detailRow(
                  'Date of Birth',
                  student.dob,
                  Icons.calendar_today,
                ),

                detailRow(
                  'Gender',
                  student.gender,
                  Icons.people,
                ),

                detailRow(
                  'Course',
                  student.course,
                  Icons.school,
                ),

                detailRow(
                  'Semester',
                  student.semester,
                  Icons.menu_book,
                ),

                detailRow(
                  'Division',
                  student.division,
                  Icons.groups,
                ),

                detailRow(
                  'Address',
                  student.address,
                  Icons.location_on,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// ================= ADMIN HOME PAGE =================

class AdminHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(

      padding: EdgeInsets.all(25),

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Text(
            'Welcome back, Admin! 👋',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFF123456),
            ),
          ),

          SizedBox(height: 5),

          Text(
            'Overview of Student Management System',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),

          SizedBox(height: 25),

          Wrap(
            spacing: 15,
            runSpacing: 15,

            children: [

              DashboardCard(
                title: 'Total Students',
                value: '${students.length}',
                icon: Icons.people,
                color: Colors.blue,
              ),

              DashboardCard(
                title: 'Total Courses',
                value: '8',
                icon: Icons.book,
                color: Colors.green,
              ),

              DashboardCard(
                title: "Today's Attendance",
                value: '92%',
                icon: Icons.calendar_today,
                color: Colors.orange,
              ),

              DashboardCard(
                title: 'Pending Requests',
                value: '5',
                icon: Icons.pending_actions,
                color: Colors.red,
              ),
            ],
          ),

          SizedBox(height: 30),

          Container(
            width: double.infinity,

            padding: EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                ),
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(
                  'Recent Students',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 15),

                ...students.map(
                      (student) => StudentRow(
                    id: student.id,
                    name: student.name,
                    course: student.course,
                    semester: student.semester,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 30),

          Text(
            'Data Structure Operations',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 15),

          Wrap(
            spacing: 15,
            runSpacing: 15,

            children: [

              FeatureCard(
                title: 'Array Operations',
                subtitle: 'Insert, Delete, Traverse, Search',
                icon: Icons.grid_view,
              ),

              FeatureCard(
                title: 'Linked List',
                subtitle: 'Insert, Delete, Traverse',
                icon: Icons.account_tree,
              ),

              FeatureCard(
                title: 'Queue Operations',
                subtitle: 'Enqueue, Dequeue, Front, Rear',
                icon: Icons.queue,
              ),

              FeatureCard(
                title: 'Searching',
                subtitle: 'Linear Search, Binary Search',
                icon: Icons.search,
              ),

              FeatureCard(
                title: 'Sorting',
                subtitle: 'Bubble, Selection, Insertion',
                icon: Icons.sort,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ================= EDIT STUDENT PAGE =================

class EditStudentPage extends StatefulWidget {

  final Student student;

  EditStudentPage({
    required this.student,
  });

  @override
  State<EditStudentPage> createState() =>
      _EditStudentPageState();
}

class _EditStudentPageState
    extends State<EditStudentPage> {

  late TextEditingController idController;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController dobController;
  late TextEditingController addressController;

  late String gender;
  late String course;
  late String semester;
  late String division;

  @override
  void initState() {
    super.initState();

    idController =
        TextEditingController(text: widget.student.id);

    nameController =
        TextEditingController(text: widget.student.name);

    emailController =
        TextEditingController(text: widget.student.email);

    phoneController =
        TextEditingController(text: widget.student.phone);

    dobController =
        TextEditingController(text: widget.student.dob);

    addressController =
        TextEditingController(text: widget.student.address);

    gender = widget.student.gender;
    course = widget.student.course;
    semester = widget.student.semester;
    division = widget.student.division;
  }

  void updateStudent() {

    setState(() {

      widget.student.id =
          idController.text;

      widget.student.name =
          nameController.text;

      widget.student.email =
          emailController.text;

      widget.student.phone =
          phoneController.text;

      widget.student.dob =
          dobController.text;

      widget.student.gender =
          gender;

      widget.student.course =
          course;

      widget.student.semester =
          semester;

      widget.student.division =
          division;

      widget.student.address =
          addressController.text;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Student updated successfully!',
        ),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context, true);
  }

  Widget inputField(
      String label,
      String hint,
      IconData icon,
      TextEditingController controller,
      ) {

    return TextField(

      controller: controller,

      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Color(0xFFF5F7FA),

      appBar: AppBar(
        backgroundColor: Color(0xFF123456),
        foregroundColor: Colors.white,
        title: Text('Update Student'),
      ),

      body: SingleChildScrollView(

        padding: EdgeInsets.all(25),

        child: Center(

          child: Container(

            width: 850,

            padding: EdgeInsets.all(25),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  'Update Student',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF123456),
                  ),
                ),

                SizedBox(height: 25),

                inputField(
                  'Student ID',
                  'Enter student ID',
                  Icons.badge,
                  idController,
                ),

                SizedBox(height: 20),

                inputField(
                  'Full Name',
                  'Enter full name',
                  Icons.person,
                  nameController,
                ),

                SizedBox(height: 20),

                inputField(
                  'Email',
                  'Enter email',
                  Icons.email,
                  emailController,
                ),

                SizedBox(height: 20),

                inputField(
                  'Phone',
                  'Enter phone number',
                  Icons.phone,
                  phoneController,
                ),

                SizedBox(height: 20),

                inputField(
                  'Date of Birth',
                  'DD/MM/YYYY',
                  Icons.calendar_today,
                  dobController,
                ),

                SizedBox(height: 20),

                Text(
                  'Gender',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Row(
                  children: [

                    Radio<String>(
                      value: 'Male',
                      groupValue: gender,

                      onChanged: (value) {

                        setState(() {
                          gender = value!;
                        });

                      },
                    ),

                    Text('Male'),

                    Radio<String>(
                      value: 'Female',
                      groupValue: gender,

                      onChanged: (value) {

                        setState(() {
                          gender = value!;
                        });

                      },
                    ),

                    Text('Female'),

                    Radio<String>(
                      value: 'Other',
                      groupValue: gender,

                      onChanged: (value) {

                        setState(() {
                          gender = value!;
                        });

                      },
                    ),

                    Text('Other'),
                  ],
                ),

                SizedBox(height: 20),

                DropdownButtonFormField<String>(

                  value: course,

                  decoration: InputDecoration(
                    labelText: 'Course',
                    prefixIcon:
                    Icon(Icons.school),

                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                  ),

                  items: [

                    DropdownMenuItem(
                      value: 'BSc IT',
                      child: Text('BSc IT'),
                    ),

                    DropdownMenuItem(
                      value: 'BSc CS',
                      child: Text('BSc CS'),
                    ),

                    DropdownMenuItem(
                      value: 'BCA',
                      child: Text('BCA'),
                    ),

                    DropdownMenuItem(
                      value: 'BCom',
                      child: Text('BCom'),
                    ),
                  ],

                  onChanged: (value) {

                    setState(() {
                      course = value!;
                    });

                  },
                ),

                SizedBox(height: 20),

                DropdownButtonFormField<String>(

                  value: semester,

                  decoration: InputDecoration(
                    labelText: 'Semester',
                    prefixIcon:
                    Icon(Icons.menu_book),

                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                  ),

                  items: [

                    DropdownMenuItem(
                      value: 'Semester 1',
                      child: Text('Semester 1'),
                    ),

                    DropdownMenuItem(
                      value: 'Semester 2',
                      child: Text('Semester 2'),
                    ),

                    DropdownMenuItem(
                      value: 'Semester 3',
                      child: Text('Semester 3'),
                    ),

                    DropdownMenuItem(
                      value: 'Semester 4',
                      child: Text('Semester 4'),
                    ),

                    DropdownMenuItem(
                      value: 'Semester 5',
                      child: Text('Semester 5'),
                    ),

                    DropdownMenuItem(
                      value: 'Semester 6',
                      child: Text('Semester 6'),
                    ),
                  ],

                  onChanged: (value) {

                    setState(() {
                      semester = value!;
                    });

                  },
                ),

                SizedBox(height: 20),

                DropdownButtonFormField<String>(

                  value: division,

                  decoration: InputDecoration(
                    labelText: 'Division',
                    prefixIcon:
                    Icon(Icons.groups),

                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                  ),

                  items: [

                    DropdownMenuItem(
                      value: 'A',
                      child: Text('Division A'),
                    ),

                    DropdownMenuItem(
                      value: 'B',
                      child: Text('Division B'),
                    ),

                    DropdownMenuItem(
                      value: 'C',
                      child: Text('Division C'),
                    ),
                  ],

                  onChanged: (value) {

                    setState(() {
                      division = value!;
                    });

                  },
                ),

                SizedBox(height: 20),

                TextField(

                  controller: addressController,

                  maxLines: 3,

                  decoration: InputDecoration(
                    labelText: 'Address',
                    hintText:
                    'Enter student address',
                    prefixIcon:
                    Icon(Icons.location_on),

                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                  ),
                ),

                SizedBox(height: 30),

                Row(
                  children: [

                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },

                        child: Text('CANCEL'),
                      ),
                    ),

                    SizedBox(width: 15),

                    Expanded(
                      child: ElevatedButton(

                        onPressed: updateStudent,

                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor:
                          Color(0xFF123456),
                          foregroundColor:
                          Colors.white,
                        ),

                        child: Text(
                          'UPDATE STUDENT',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ================= NOTICES =================

class NoticesPage extends StatefulWidget {
  @override
  State<NoticesPage> createState() => _NoticesPageState();
}

class _NoticesPageState extends State<NoticesPage> {

  List<Map<String, String>> notices = [
    {
      'title': 'Semester 3 Examination',
      'date': '10 September 2026',
      'description':
      'Semester 3 examination timetable will be announced soon.',
    },
    {
      'title': 'Attendance Notice',
      'date': '08 September 2026',
      'description':
      'Students are required to maintain minimum attendance.',
    },
    {
      'title': 'Fee Payment Reminder',
      'date': '05 September 2026',
      'description':
      'Students with pending fees are requested to complete payment.',
    },
  ];

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  void addNotice() {

    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter notice details'),
        ),
      );

      return;
    }

    setState(() {

      notices.insert(0, {
        'title': titleController.text,
        'date': '11 September 2026',
        'description': descriptionController.text,
      });

    });

    titleController.clear();
    descriptionController.clear();

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Notice added successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void showAddNoticeDialog() {

    showDialog(
      context: context,

      builder: (context) {

        return AlertDialog(

          title: Text('Add New Notice'),

          content: SizedBox(
            width: 450,

            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [

                TextField(
                  controller: titleController,

                  decoration: InputDecoration(
                    labelText: 'Notice Title',
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: 15),

                TextField(
                  controller: descriptionController,

                  maxLines: 4,

                  decoration: InputDecoration(
                    labelText: 'Notice Description',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: Text('CANCEL'),
            ),

            ElevatedButton(
              onPressed: addNotice,

              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1976D2),
                foregroundColor: Colors.white,
              ),

              child: Text('ADD NOTICE'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Color(0xFFF5F7FA),

      padding: EdgeInsets.all(20),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Row(
            children: [

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(
                    'Notices',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF123456),
                    ),
                  ),

                  SizedBox(height: 5),

                  Text(
                    'Create and manage student notices',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),

              Spacer(),

              ElevatedButton.icon(
                onPressed: showAddNoticeDialog,

                icon: Icon(Icons.add),

                label: Text('Add Notice'),

                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1976D2),
                  foregroundColor: Colors.white,

                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              itemCount: notices.length,

              itemBuilder: (context, index) {

                final notice = notices[index];

                return Card(
                  elevation: 2,

                  margin: EdgeInsets.only(bottom: 15),

                  child: Padding(
                    padding: EdgeInsets.all(18),

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        Container(
                          padding: EdgeInsets.all(12),

                          decoration: BoxDecoration(
                            color: Color(0xFFE3F2FD),
                            borderRadius: BorderRadius.circular(10),
                          ),

                          child: Icon(
                            Icons.notifications,
                            color: Color(0xFF1976D2),
                            size: 28,
                          ),
                        ),

                        SizedBox(width: 15),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,

                            children: [

                              Text(
                                notice['title']!,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF123456),
                                ),
                              ),

                              SizedBox(height: 5),

                              Text(
                                notice['date']!,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),

                              SizedBox(height: 10),

                              Text(
                                notice['description']!,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),

                        IconButton(
                          onPressed: () {

                            setState(() {
                              notices.removeAt(index);
                            });

                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Notice deleted',
                                ),
                              ),
                            );
                          },

                          icon: Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ================= CERTIFICATE REQUESTS =================

class CertificateRequestsPage extends StatefulWidget {
  @override
  State<CertificateRequestsPage> createState() =>
      _CertificateRequestsPageState();
}

class _CertificateRequestsPageState
    extends State<CertificateRequestsPage> {

  List<Map<String, String>> requests = [
    {
      'id': 'REQ001',
      'studentId': '101',
      'name': 'Sana Ansari',
      'certificate': 'Bonafide Certificate',
      'date': '10 September 2026',
      'status': 'Pending',
    },
    {
      'id': 'REQ002',
      'studentId': '102',
      'name': 'Aisha Khan',
      'certificate': 'Transfer Certificate',
      'date': '09 September 2026',
      'status': 'Approved',
    },
    {
      'id': 'REQ003',
      'studentId': '103',
      'name': 'Rahul Sharma',
      'certificate': 'Character Certificate',
      'date': '08 September 2026',
      'status': 'Pending',
    },
    {
      'id': 'REQ004',
      'studentId': '104',
      'name': 'Aditya Verma',
      'certificate': 'Bonafide Certificate',
      'date': '07 September 2026',
      'status': 'Rejected',
    },
  ];

  void updateStatus(int index, String status) {

    setState(() {
      requests[index]['status'] = status;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Request ${status.toLowerCase()} successfully!',
        ),
        backgroundColor:
        status == 'Approved' ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Color(0xFFF5F7FA),

      padding: EdgeInsets.all(20),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Text(
            'Certificate Requests',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF123456),
            ),
          ),

          SizedBox(height: 5),

          Text(
            'Manage student certificate requests',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),

          SizedBox(height: 20),

          Expanded(
            child: Card(
              elevation: 2,

              child: Column(
                children: [

                  Container(
                    padding: EdgeInsets.all(15),

                    child: Row(
                      children: [

                        Expanded(
                          child: Text(
                            'Request ID',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Expanded(
                          child: Text(
                            'Student ID',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: Text(
                            'Student',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: Text(
                            'Certificate',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Expanded(
                          child: Text(
                            'Date',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Expanded(
                          child: Text(
                            'Status',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: Text(
                            'Action',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Divider(),

                  Expanded(
                    child: ListView.builder(
                      itemCount: requests.length,

                      itemBuilder: (context, index) {

                        final request = requests[index];

                        return Container(
                          padding: EdgeInsets.all(15),

                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade200,
                              ),
                            ),
                          ),

                          child: Row(
                            children: [

                              Expanded(
                                child: Text(
                                  request['id']!,
                                ),
                              ),

                              Expanded(
                                child: Text(
                                  request['studentId']!,
                                ),
                              ),

                              Expanded(
                                flex: 2,
                                child: Text(
                                  request['name']!,
                                ),
                              ),

                              Expanded(
                                flex: 2,
                                child: Text(
                                  request['certificate']!,
                                ),
                              ),

                              Expanded(
                                child: Text(
                                  request['date']!,
                                ),
                              ),

                              Expanded(
                                child: Text(
                                  request['status']!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                    request['status'] ==
                                        'Approved'
                                        ? Colors.green
                                        : request['status'] ==
                                        'Rejected'
                                        ? Colors.red
                                        : Colors.orange,
                                  ),
                                ),
                              ),

                              Expanded(
                                flex: 2,

                                child: Row(
                                  children: [

                                    IconButton(
                                      tooltip: 'Approve',

                                      onPressed:
                                      request['status'] ==
                                          'Approved'
                                          ? null
                                          : () {
                                        updateStatus(
                                          index,
                                          'Approved',
                                        );
                                      },

                                      icon: Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      ),
                                    ),

                                    IconButton(
                                      tooltip: 'Reject',

                                      onPressed:
                                      request['status'] ==
                                          'Rejected'
                                          ? null
                                          : () {
                                        updateStatus(
                                          index,
                                          'Rejected',
                                        );
                                      },

                                      icon: Icon(
                                        Icons.cancel,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= EXAMINATION / HALL TICKET =================

class ExaminationPage extends StatefulWidget {
  @override
  State<ExaminationPage> createState() => _ExaminationPageState();
}

class _ExaminationPageState extends State<ExaminationPage> {

  List<Map<String, String>> exams = [
    {
      'id': '101',
      'name': 'Sana Ansari',
      'course': 'BSc IT',
      'semester': 'Semester 3',
      'exam': 'Data Structures',
      'date': '20 September 2026',
      'status': 'Generated',
    },
    {
      'id': '102',
      'name': 'Aisha Khan',
      'course': 'BSc IT',
      'semester': 'Semester 3',
      'exam': 'Database Management',
      'date': '22 September 2026',
      'status': 'Generated',
    },
    {
      'id': '103',
      'name': 'Rahul Sharma',
      'course': 'BSc CS',
      'semester': 'Semester 3',
      'exam': 'Programming in C',
      'date': '24 September 2026',
      'status': 'Pending',
    },
    {
      'id': '104',
      'name': 'Aditya Verma',
      'course': 'BCA',
      'semester': 'Semester 3',
      'exam': 'Mathematics',
      'date': '26 September 2026',
      'status': 'Generated',
    },
  ];

  void generateHallTicket(int index) {

    setState(() {
      exams[index]['status'] = 'Generated';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Hall ticket generated successfully!',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Color(0xFFF5F7FA),

      padding: EdgeInsets.all(20),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Text(
            'Examination',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF123456),
            ),
          ),

          SizedBox(height: 5),

          Text(
            'Manage examinations and hall tickets',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),

          SizedBox(height: 20),

          Row(
            children: [

              Expanded(
                child: _examCard(
                  'Total Students',
                  exams.length.toString(),
                  Icons.people,
                ),
              ),

              SizedBox(width: 15),

              Expanded(
                child: _examCard(
                  'Hall Tickets Generated',
                  exams
                      .where(
                        (exam) => exam['status'] == 'Generated',
                  )
                      .length
                      .toString(),
                  Icons.confirmation_number,
                ),
              ),

              SizedBox(width: 15),

              Expanded(
                child: _examCard(
                  'Pending',
                  exams
                      .where(
                        (exam) => exam['status'] == 'Pending',
                  )
                      .length
                      .toString(),
                  Icons.pending_actions,
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          Expanded(
            child: Card(
              elevation: 2,

              child: Column(
                children: [

                  Container(
                    padding: EdgeInsets.all(15),

                    child: Row(
                      children: [

                        Expanded(
                          child: Text(
                            'Student ID',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: Text(
                            'Student',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: Text(
                            'Course',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Expanded(
                          child: Text(
                            'Semester',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: Text(
                            'Exam',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Expanded(
                          child: Text(
                            'Date',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Expanded(
                          child: Text(
                            'Status',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: Text(
                            'Action',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Divider(),

                  Expanded(
                    child: ListView.builder(
                      itemCount: exams.length,

                      itemBuilder: (context, index) {

                        final exam = exams[index];

                        return Container(
                          padding: EdgeInsets.all(15),

                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade200,
                              ),
                            ),
                          ),

                          child: Row(
                            children: [

                              Expanded(
                                child: Text(
                                  exam['id']!,
                                ),
                              ),

                              Expanded(
                                flex: 2,
                                child: Text(
                                  exam['name']!,
                                ),
                              ),

                              Expanded(
                                flex: 2,
                                child: Text(
                                  exam['course']!,
                                ),
                              ),

                              Expanded(
                                child: Text(
                                  exam['semester']!,
                                ),
                              ),

                              Expanded(
                                flex: 2,
                                child: Text(
                                  exam['exam']!,
                                ),
                              ),

                              Expanded(
                                child: Text(
                                  exam['date']!,
                                ),
                              ),

                              Expanded(
                                child: Text(
                                  exam['status']!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                    exam['status'] ==
                                        'Generated'
                                        ? Colors.green
                                        : Colors.orange,
                                  ),
                                ),
                              ),

                              Expanded(
                                flex: 2,
                                child: ElevatedButton(
                                  onPressed: () {
                                    generateHallTicket(index);
                                  },

                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                    Color(0xFF1976D2),
                                    foregroundColor: Colors.white,
                                  ),

                                  child: Text(
                                    'Generate',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _examCard(
      String title,
      String value,
      IconData icon,
      ) {

    return Card(
      elevation: 2,

      child: Padding(
        padding: EdgeInsets.all(18),

        child: Row(
          children: [

            Icon(
              icon,
              size: 35,
              color: Color(0xFF1976D2),
            ),

            SizedBox(width: 15),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF123456),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ================= REPORTS =================

class ReportsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Color(0xFFF5F7FA),
      padding: EdgeInsets.all(20),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Text(
            'Reports',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF123456),
            ),
          ),

          SizedBox(height: 5),

          Text(
            'View student management system reports',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),

          SizedBox(height: 25),

          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,

              children: [

                _reportCard(
                  context,
                  'Student Report',
                  'View complete student records',
                  Icons.people,
                ),

                _reportCard(
                  context,
                  'Attendance Report',
                  'View student attendance details',
                  Icons.calendar_month,
                ),

                _reportCard(
                  context,
                  'Marks Report',
                  'View examination and marks report',
                  Icons.assessment,
                ),

                _reportCard(
                  context,
                  'Fees Report',
                  'View paid and pending fees',
                  Icons.account_balance_wallet,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _reportCard(
      BuildContext context,
      String title,
      String description,
      IconData icon,
      ) {

    return Card(
      elevation: 3,

      child: Padding(
        padding: EdgeInsets.all(25),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Container(
              padding: EdgeInsets.all(14),

              decoration: BoxDecoration(
                color: Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(12),
              ),

              child: Icon(
                icon,
                size: 35,
                color: Color(0xFF1976D2),
              ),
            ),

            SizedBox(height: 20),

            Text(
              title,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Color(0xFF123456),
              ),
            ),

            SizedBox(height: 8),

            Text(
              description,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            Spacer(),

            ElevatedButton.icon(
              onPressed: () {

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '$title opened',
                    ),
                  ),
                );

              },

              icon: Icon(Icons.visibility),

              label: Text('View Report'),

              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1976D2),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DataStructuresPage extends StatelessWidget {

  final List<Map<String, dynamic>> structures = [

    {
      'icon': Icons.grid_view,
      'title': 'Array',
      'operation': 'Insertion, Deletion, Traversing, Searching',
      'used': 'Student records and fixed-size data',
      'purpose': 'Stores and displays student information efficiently.',
    },

    {
      'icon': Icons.account_tree,
      'title': 'Linked List',
      'operation': 'Insert at Start, End, Before, After, Delete',
      'used': 'Student record management',
      'purpose': 'Allows easy insertion and deletion of student records.',
    },

    {
      'icon': Icons.queue,
      'title': 'Queue',
      'operation': 'Enqueue and Dequeue',
      'used': 'Pending certificate and service requests',
      'purpose': 'Processes requests in First In First Out (FIFO) order.',
    },

    {
      'icon': Icons.search,
      'title': 'Searching',
      'operation': 'Linear Search, Binary Search',
      'used': 'Finding a particular student',
      'purpose': 'Helps admin quickly search students using ID or name.',
    },

    {
      'icon': Icons.sort,
      'title': 'Sorting',
      'operation': 'Bubble Sort',
      'used': 'Student list and marks',
      'purpose': 'Arranges records according to name, ID or marks.',
    },

  ];

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      padding: EdgeInsets.all(25),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Text(
            'Data Structures',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 8),

          Text(
            'Data structures and algorithms used in Student Management System',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),

          SizedBox(height: 25),

          ...structures.map((item) {

            return Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 18),
              padding: EdgeInsets.all(22),

              decoration: BoxDecoration(
                color: Color(0xFF102A43),
                borderRadius: BorderRadius.circular(15),
              ),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Container(
                    width: 55,
                    height: 55,

                    decoration: BoxDecoration(
                      color: Color(0xFF1976D2),
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Icon(
                      item['icon'],
                      color: Colors.white,
                      size: 28,
                    ),
                  ),

                  SizedBox(width: 18),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        Text(
                          item['title'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 8),

                        Text(
                          'Operation: ${item['operation']}',
                          style: TextStyle(
                            color: Colors.lightBlueAccent,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 6),

                        Text(
                          'Used in: ${item['used']}',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),

                        SizedBox(height: 6),

                        Text(
                          'Purpose: ${item['purpose']}',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );

          }).toList(),
        ],
      ),
    );
  }
}

class StudentDashboard extends StatefulWidget {
  final Student student;

  StudentDashboard({required this.student});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {

  late Widget currentPage;

  @override
  void initState() {
    super.initState();
    currentPage = StudentHomePage(student: widget.student);
  }

  String selectedMenu = 'Dashboard';

  void openPage(String menu, Widget page) {
    setState(() {
      selectedMenu = menu;
      currentPage = page;
    });
  }

  Widget studentMenuItem({
    required IconData icon,
    required String title,
    required Widget page,
  }) {

    bool selected = selectedMenu == title;

    return InkWell(

      onTap: () {
        openPage(title, page);
      },

      child: Container(

        width: double.infinity,

        padding: EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 14,
        ),

        decoration: BoxDecoration(

          color: selected
              ? Color(0xFF1976D2)
              : Colors.transparent,

          borderRadius: BorderRadius.circular(8),
        ),

        margin: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 2,
        ),

        child: Row(
          children: [

            Icon(
              icon,
              color: Colors.white,
              size: 21,
            ),

            SizedBox(width: 15),

            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: selected
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Row(
        children: [

          // =================================================
          // SIDEBAR
          // =================================================

          Container(
            width: 230,
            color: Color(0xFF071A2B),

            child: Column(
              children: [

                // LOGO
                Container(
                  height: 90,
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Icon(
                        Icons.school,
                        color: Colors.white,
                        size: 35,
                      ),

                      SizedBox(width: 10),

                      Expanded(
                        child: Text(
                          'Student\nManagement System',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Divider(
                  color: Colors.white24,
                ),

                // SCROLLABLE MENU
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                        studentMenuItem(
                          icon: Icons.dashboard,
                          title: 'Dashboard',
                          page: StudentHomePage(student: widget.student),
                        ),

                        studentMenuItem(
                          icon: Icons.person,
                          title: 'My Profile',
                          page: StudentProfilePage(student: widget.student),
                        ),

                        studentMenuItem(
                          icon: Icons.badge,
                          title: 'My ID Card',
                          page: StudentIdCardPage(student: widget.student),
                        ),

                        Divider(
                          color: Colors.white24,
                        ),

                        // ACADEMICS

                        Padding(
                          padding: EdgeInsets.only(
                            left: 18,
                            top: 8,
                            bottom: 5,
                          ),

                          child: Align(
                            alignment: Alignment.centerLeft,

                            child: Text(
                              'ACADEMICS',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        studentMenuItem(
                          icon: Icons.menu_book,
                          title: 'Registered Subjects',
                          page: RegisteredSubjectsPage(),
                        ),

                        studentMenuItem(
                          icon: Icons.assignment,
                          title: 'My Marks',
                          page: StudentMarksPage(),
                        ),

                        studentMenuItem(
                          icon: Icons.calendar_today,
                          title: 'Attendance',
                          page: AttendancePage(),
                        ),

                        studentMenuItem(
                          icon: Icons.emoji_events,
                          title: 'Result',
                          page: ResultPage(),
                        ),

                        // EXAMINATION

                        Padding(
                          padding: EdgeInsets.only(
                            left: 18,
                            top: 8,
                            bottom: 5,
                          ),

                          child: Align(
                            alignment: Alignment.centerLeft,

                            child: Text(
                              'EXAMINATION',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        studentMenuItem(
                          icon: Icons.assignment_turned_in,
                          title: 'Hall Ticket',
                          page: StudentHallTicketPage(student: widget.student),
                        ),

                        // FEES

                        studentMenuItem(
                          icon: Icons.account_balance_wallet,
                          title: 'Fees Paid',
                          page: StudentFeesPage(),
                        ),

                        // SERVICES

                        Padding(
                          padding: EdgeInsets.only(
                            left: 18,
                            top: 8,
                            bottom: 5,
                          ),

                          child: Align(
                            alignment: Alignment.centerLeft,

                            child: Text(
                              'SERVICES',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        studentMenuItem(
                          icon: Icons.description,
                          title: 'Certificate',
                          page: CertificatePage(student: widget.student),
                        ),

                        studentMenuItem(
                          icon: Icons.verified,
                          title: 'Bonafide Certificate',
                          page: BonafideCertificatePage(student: widget.student),
                        ),

                        studentMenuItem(
                          icon: Icons.add_circle_outline,
                          title: 'Other Requests',
                          page: OtherRequestsPage(student: widget.student),
                        ),

                        studentMenuItem(
                          icon: Icons.notifications,
                          title: 'Notices',
                          page: StudentNoticesPage(),
                        ),
                      ],
                    ),
                  ),
                ),

                // LOGOUT FIXED AT BOTTOM

                Divider(
                  color: Colors.white24,
                ),

                InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                          (route) => false,
                    );
                  },

                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 15,
                    ),

                    child: Row(
                      children: [

                        Icon(
                          Icons.logout,
                          color: Colors.white70,
                        ),

                        SizedBox(width: 15),

                        Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 15),
              ],
            ),
          ),

          // =================================================
          // MAIN AREA
          // =================================================

          Expanded(

            child: Column(
              children: [

                // TOP BAR

                Container(

                  height: 70,

                  padding: EdgeInsets.symmetric(
                    horizontal: 25,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                      ),
                    ],
                  ),

                  child: Row(
                    children: [

                      Text(
                        selectedMenu,
                        style: TextStyle(
                          color: Color(0xFF163B60),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Spacer(),

                      Icon(
                        Icons.notifications_none,
                        color: Colors.grey,
                        size: 28,
                      ),

                      SizedBox(width: 20),

                      CircleAvatar(

                        radius: 25,

                        backgroundColor:
                        Color(0xFF163B60),

                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),

                      SizedBox(width: 10),

                      Text(
                        widget.student.name,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(width: 5),

                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),

                // PAGE

                Expanded(
                  child: Container(
                    color: Color(0xFFF5F7FA),
                    child: currentPage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// =============================================================
// STUDENT HOME PAGE
// =============================================================

class StudentHomePage extends StatelessWidget {
  final Student student;

  StudentHomePage({required this.student});

  Widget dashboardCard(
      String title,
      String value,
      IconData icon,
      ) {

    return Container(

      padding: EdgeInsets.all(20),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(12),

        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
          ),
        ],
      ),

      child: Row(
        children: [

          Container(

            padding: EdgeInsets.all(14),

            decoration: BoxDecoration(
              color: Color(0xFFE3F2FD),
              borderRadius:
              BorderRadius.circular(10),
            ),

            child: Icon(
              icon,
              color: Color(0xFF1976D2),
              size: 28,
            ),
          ),

          SizedBox(width: 15),

          Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              Text(
                title,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),

              SizedBox(height: 5),

              Text(
                value,
                style: TextStyle(
                  color: Color(0xFF163B60),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(

      padding: EdgeInsets.all(25),

      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Text(
            'Welcome, ${student.name}!',
            style: TextStyle(
              color: Color(0xFF163B60),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 5),

          Text(
            'Here is your academic overview.',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),

          SizedBox(height: 25),

          // =================================================
          // SUMMARY CARDS
          // =================================================

          Row(
            children: [

              Expanded(
                child: dashboardCard(
                  'My Subjects',
                  '5',
                  Icons.menu_book,
                ),
              ),

              SizedBox(width: 15),

              Expanded(
                child: dashboardCard(
                  'Attendance',
                  '85%',
                  Icons.calendar_today,
                ),
              ),

              SizedBox(width: 15),

              Expanded(
                child: dashboardCard(
                  'Average Marks',
                  '78%',
                  Icons.bar_chart,
                ),
              ),

              SizedBox(width: 15),

              Expanded(
                child: dashboardCard(
                  'Notices',
                  '3',
                  Icons.notifications,
                ),
              ),
            ],
          ),

          SizedBox(height: 25),

          // =================================================
          // STUDENT INFORMATION
          // =================================================

          Container(

            width: double.infinity,

            padding: EdgeInsets.all(25),

            decoration: BoxDecoration(

              color: Colors.white,

              borderRadius:
              BorderRadius.circular(12),

              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                ),
              ],
            ),

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  'Student Information',
                  style: TextStyle(
                    color: Color(0xFF163B60),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 20),

                Row(
                  children: [

                    Expanded(
                      child: infoText(
                        'Student ID',
                        student.id,
                      ),
                    ),

                    Expanded(
                      child: infoText(
                        'Course',
                        student.course,
                      ),
                    ),

                    Expanded(
                      child: infoText(
                        'Department',
                        'Information Technology',
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                Row(
                  children: [

                    Expanded(
                      child: infoText(
                        'Semester',
                        student.semester,
                      ),
                    ),

                    Expanded(
                      child: infoText(
                        'Division',
                        student.division,
                      ),
                    ),

                    Expanded(
                      child: infoText(
                        'Academic Year',
                        '2026-27',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 25),

          // =================================================
          // SUBJECT MARKS
          // =================================================

          Container(

            width: double.infinity,

            padding: EdgeInsets.all(25),

            decoration: BoxDecoration(

              color: Colors.white,

              borderRadius:
              BorderRadius.circular(12),

              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                ),
              ],
            ),

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  'Subject-wise Marks',
                  style: TextStyle(
                    color: Color(0xFF163B60),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 15),

                markRow(
                  'Data Structures',
                  '87',
                ),

                markRow(
                  'DBMS',
                  '79',
                ),

                markRow(
                  'Operating System',
                  '76',
                ),

                markRow(
                  'MPMC',
                  '72',
                ),

                markRow(
                  'Flutter',
                  '82',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget infoText(
      String title,
      String value,
      ) {

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [

        Text(
          title,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),

        SizedBox(height: 5),

        Text(
          value,
          style: TextStyle(
            color: Color(0xFF163B60),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget markRow(
      String subject,
      String marks,
      ) {

    return Container(

      padding: EdgeInsets.symmetric(
        vertical: 12,
      ),

      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black12,
          ),
        ),
      ),

      child: Row(
        children: [

          Expanded(
            child: Text(
              subject,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14,
              ),
            ),
          ),

          Text(
            '$marks / 100',
            style: TextStyle(
              color: Color(0xFF1976D2),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}


// =============================================================
// MY PROFILE
// =============================================================

class StudentProfilePage extends StatelessWidget {
  final Student student;

  StudentProfilePage({required this.student});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Profile',
            style: TextStyle(
              color: Color(0xFF163B60),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xFF163B60),
                  child: Icon(Icons.person, size: 55, color: Colors.white),
                ),
                SizedBox(height: 20),
                Text(
                  student.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF163B60),
                  ),
                ),
                SizedBox(height: 25),
                profileRow('Student ID', student.id),
                profileRow('Email', student.email),
                profileRow('Phone', student.phone),
                profileRow('Date of Birth', student.dob),
                profileRow('Gender', student.gender),
                profileRow('Course', student.course),
                profileRow('Department', 'Information Technology'),
                profileRow('Semester', student.semester),
                profileRow('Division', student.division),
                profileRow('Address', student.address),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget profileRow(String title, String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 180,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Color(0xFF163B60),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// =============================================================
// MY ID CARD
// =============================================================

class StudentIdCardPage extends StatelessWidget {
  final Student student;

  StudentIdCardPage({required this.student});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 400,
        margin: EdgeInsets.all(30),
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 12),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.school, color: Color(0xFF163B60), size: 45),
            SizedBox(height: 10),
            Text(
              'STUDENT ID CARD',
              style: TextStyle(
                color: Color(0xFF163B60),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(),
            CircleAvatar(
              radius: 45,
              backgroundColor: Color(0xFF163B60),
              child: Icon(Icons.person, color: Colors.white, size: 50),
            ),
            SizedBox(height: 15),
            Text(
              student.name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Text('Student ID: ${student.id}'),
            Text('${student.course} | Information Technology'),
            Text('${student.semester} | Division ${student.division}'),
            Text('Academic Year: 2026-27'),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(10),
              color: Color(0xFFE3F2FD),
              child: Text(
                'VALID STUDENT',
                style: TextStyle(
                  color: Color(0xFF1976D2),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// =============================================================
// REGISTERED SUBJECTS
// =============================================================

class RegisteredSubjectsPage extends StatelessWidget {

  final List<String> subjects = [
    'Data Structures',
    'DBMS',
    'Operating System',
    'MPMC',
    'Flutter',
  ];

  @override
  Widget build(BuildContext context) {

    return pageContainer(

      title: 'Registered Subjects',

      child: Column(

        children: [

          infoBanner(
            'B.Sc. | Information Technology | Semester 3',
          ),

          SizedBox(height: 20),

          ...List.generate(
            subjects.length,
                (index) {

              return Container(

                width: double.infinity,

                margin: EdgeInsets.only(
                  bottom: 12,
                ),

                padding: EdgeInsets.all(18),

                decoration: BoxDecoration(

                  color: Colors.white,

                  borderRadius:
                  BorderRadius.circular(10),
                ),

                child: Row(
                  children: [

                    CircleAvatar(
                      backgroundColor:
                      Color(0xFFE3F2FD),

                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color:
                          Color(0xFF1976D2),
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),

                    SizedBox(width: 15),

                    Text(
                      subjects[index],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight:
                        FontWeight.bold,
                      ),
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


// =============================================================
// MY MARKS
// =============================================================

class StudentMarksPage extends StatelessWidget {

  final List<Map<String, dynamic>> marks = [

    {
      'subject': 'Data Structures',
      'marks': 87,
    },

    {
      'subject': 'DBMS',
      'marks': 79,
    },

    {
      'subject': 'Operating System',
      'marks': 76,
    },

    {
      'subject': 'MPMC',
      'marks': 72,
    },

    {
      'subject': 'Flutter',
      'marks': 82,
    },
  ];

  @override
  Widget build(BuildContext context) {

    return pageContainer(

      title: 'My Marks',

      child: Column(

        children: [

          infoBanner(
            'B.Sc. | Information Technology | Semester 3',
          ),

          SizedBox(height: 20),

          Container(

            width: double.infinity,

            color: Colors.white,

            child: DataTable(

              columns: [

                DataColumn(
                  label: Text(
                    'Subject',
                    style: TextStyle(
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),

                DataColumn(
                  label: Text(
                    'Marks',
                    style: TextStyle(
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),

                DataColumn(
                  label: Text(
                    'Status',
                    style: TextStyle(
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),
              ],

              rows: marks.map((item) {

                return DataRow(
                  cells: [

                    DataCell(
                      Text(item['subject']),
                    ),

                    DataCell(
                      Text(
                        '${item['marks']} / 100',
                      ),
                    ),

                    DataCell(
                      Text(
                        item['marks'] >= 40
                            ? 'Pass'
                            : 'Fail',

                        style: TextStyle(
                          color:
                          item['marks'] >= 40
                              ? Colors.green
                              : Colors.red,

                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );

              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}


// =============================================================
// ATTENDANCE
// =============================================================

class AttendancePage extends StatelessWidget {

  final List<Map<String, dynamic>>
  attendance = [

    {
      'subject': 'Data Structures',
      'attendance': '90%',
    },

    {
      'subject': 'DBMS',
      'attendance': '85%',
    },

    {
      'subject': 'Operating System',
      'attendance': '80%',
    },

    {
      'subject': 'MPMC',
      'attendance': '82%',
    },

    {
      'subject': 'Flutter',
      'attendance': '88%',
    },
  ];

  @override
  Widget build(BuildContext context) {

    return pageContainer(

      title: 'Attendance',

      child: Column(

        children: attendance.map((item) {

          return Container(

            width: double.infinity,

            margin: EdgeInsets.only(
              bottom: 12,
            ),

            padding: EdgeInsets.all(20),

            color: Colors.white,

            child: Row(
              children: [

                Expanded(
                  child: Text(
                    item['subject'],
                    style: TextStyle(
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),

                Text(
                  item['attendance'],
                  style: TextStyle(
                    color: Color(0xFF1976D2),
                    fontWeight:
                    FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          );

        }).toList(),
      ),
    );
  }
}


// =============================================================
// RESULT
// =============================================================

class ResultPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return pageContainer(

      title: 'Result',

      child: Container(

        width: double.infinity,

        padding: EdgeInsets.all(25),

        color: Colors.white,

        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            Text(
              'Semester 3 Result',
              style: TextStyle(
                fontSize: 22,
                fontWeight:
                FontWeight.bold,
                color:
                Color(0xFF163B60),
              ),
            ),

            SizedBox(height: 20),

            Text(
              'Total Marks: 396 / 500',
            ),

            SizedBox(height: 10),

            Text(
              'Percentage: 79.2%',
            ),

            SizedBox(height: 10),

            Text(
              'Result: PASS',
              style: TextStyle(
                color: Colors.green,
                fontWeight:
                FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// =============================================================
// HALL TICKET
// =============================================================

class StudentHallTicketPage extends StatelessWidget {

  final Student student;

  StudentHallTicketPage({required this.student});

  @override
  Widget build(BuildContext context) {

    return pageContainer(

      title: 'Hall Ticket',

      child: Container(

        width: double.infinity,

        padding: EdgeInsets.all(25),

        color: Colors.white,

        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            Text(
              'Semester 3 Examination',
              style: TextStyle(
                fontSize: 22,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            SizedBox(height: 15),

            Text('Student: ${student.name}'),

            Text('Student ID: ${student.id}'),

            Text('${student.course} | Information Technology'),

            Text(student.semester),

            SizedBox(height: 25),

            ElevatedButton.icon(

              onPressed: () {

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  SnackBar(
                    content: Text(
                      'Hall Ticket generated successfully',
                    ),
                  ),
                );
              },

              icon: Icon(
                Icons.download,
              ),

              label: Text(
                'Generate Hall Ticket',
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// =============================================================
// FEES
// =============================================================

class StudentFeesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return pageContainer(

      title: 'Fees Paid',

      child: Container(

        width: double.infinity,

        padding: EdgeInsets.all(25),

        color: Colors.white,

        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            Text(
              'Fee Details',
              style: TextStyle(
                fontSize: 22,
                fontWeight:
                FontWeight.bold,
                color:
                Color(0xFF163B60),
              ),
            ),

            SizedBox(height: 20),

            Text(
              'Total Fees: ₹50,000',
            ),

            SizedBox(height: 10),

            Text(
              'Paid: ₹50,000',
              style: TextStyle(
                color: Colors.green,
              ),
            ),

            SizedBox(height: 10),

            Text(
              'Pending: ₹0',
              style: TextStyle(
                color: Colors.green,
              ),
            ),

            SizedBox(height: 20),

            Container(

              padding: EdgeInsets.all(15),

              color: Color(0xFFE8F5E9),

              child: Row(
                children: [

                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),

                  SizedBox(width: 10),

                  Text(
                    'All fees are paid',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight:
                      FontWeight.bold,
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
}


// =============================================================
// CERTIFICATE
// =============================================================

class CertificatePage extends StatelessWidget {

  final Student student;

  CertificatePage({required this.student});

  @override
  Widget build(BuildContext context) {

    return requestPage(
      context,
      'Certificate',
      student,
    );
  }
}


// =============================================================
// BONAFIDE
// =============================================================

class BonafideCertificatePage
    extends StatelessWidget {

  final Student student;

  BonafideCertificatePage({required this.student});

  @override
  Widget build(BuildContext context) {

    return requestPage(
      context,
      'Bonafide Certificate',
      student,
    );
  }
}


// =============================================================
// OTHER REQUESTS
// =============================================================

class OtherRequestsPage extends StatelessWidget {

  final Student student;

  OtherRequestsPage({required this.student});

  @override
  Widget build(BuildContext context) {

    return requestPage(
      context,
      'Other Request',
      student,
    );
  }
}


// =============================================================
// NOTICES
// =============================================================

class StudentNoticesPage extends StatelessWidget {

  final List<String> notices = [

    'Semester 3 examination timetable has been released.',

    'Students are requested to check their attendance.',

    'Hall tickets will be available before examination.',
  ];

  @override
  Widget build(BuildContext context) {

    return pageContainer(

      title: 'Notices',

      child: Column(

        children: notices.map((notice) {

          return Container(

            width: double.infinity,

            margin: EdgeInsets.only(
              bottom: 12,
            ),

            padding: EdgeInsets.all(20),

            color: Colors.white,

            child: Row(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Icon(
                  Icons.notifications,
                  color:
                  Color(0xFF1976D2),
                ),

                SizedBox(width: 15),

                Expanded(
                  child: Text(
                    notice,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          );

        }).toList(),
      ),
    );
  }
}


// =============================================================
// COMMON PAGE CONTAINER
// =============================================================

Widget pageContainer({
  required String title,
  required Widget child,
}) {

  return SingleChildScrollView(

    padding: EdgeInsets.all(25),

    child: Column(

      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [

        Text(
          title,
          style: TextStyle(
            color: Color(0xFF163B60),
            fontSize: 28,
            fontWeight:
            FontWeight.bold,
          ),
        ),

        SizedBox(height: 20),

        child,
      ],
    ),
  );
}


// =============================================================
// INFO BANNER
// =============================================================

Widget infoBanner(String text) {

  return Container(

    width: double.infinity,

    padding: EdgeInsets.all(15),

    decoration: BoxDecoration(

      color: Color(0xFFE3F2FD),

      borderRadius:
      BorderRadius.circular(10),
    ),

    child: Text(
      text,
      style: TextStyle(
        color: Color(0xFF163B60),
        fontWeight:
        FontWeight.bold,
      ),
    ),
  );
}


// =============================================================
// REQUEST PAGE
// =============================================================

Widget requestPage(
    BuildContext context,
    String requestName,
    Student student,
    ) {

  return pageContainer(

    title: requestName,

    child: Container(

      width: double.infinity,

      padding: EdgeInsets.all(25),

      color: Colors.white,

      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Text(
            'Request $requestName',
            style: TextStyle(
              fontSize: 20,
              fontWeight:
              FontWeight.bold,
              color:
              Color(0xFF163B60),
            ),
          ),

          SizedBox(height: 20),

          Text(
            'Student Name: ${student.name}',
          ),

          SizedBox(height: 8),

          Text(
            'Student ID: ${student.id}',
          ),

          SizedBox(height: 25),

          ElevatedButton.icon(

            onPressed: () {

              ScaffoldMessenger.of(context)
                  .showSnackBar(
                SnackBar(
                  content: Text(
                    '$requestName request submitted successfully',
                  ),
                ),
              );
            },

            icon: Icon(
              Icons.send,
            ),

            label: Text(
              'Submit Request',
            ),
          ),
        ],
      ),
    ),
  );
}