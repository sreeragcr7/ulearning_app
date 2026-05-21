class MockCourse {
  final String title;
  final String subtitle;
  final String imageUrl;

  const MockCourse({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });
}

const mockCourses = [
  MockCourse(
    title: 'User Interface',
    subtitle: '30 Pages',
    imageUrl:
        'https://picsum.photos/400/300?random=1',
  ),

  MockCourse(
    title: 'Visual Identity',
    subtitle: '24 Lessons',
    imageUrl:
        'https://picsum.photos/400/300?random=2',
  ),

  MockCourse(
    title: 'Marketing',
    subtitle: '12 Videos',
    imageUrl:
        'https://picsum.photos/400/300?random=3',
  ),

  MockCourse(
    title: 'Packaging Design',
    subtitle: '18 Lessons',
    imageUrl:
        'https://picsum.photos/400/300?random=4',
  ),
];