

class API{
  static String webUrl = 'https://sciencecourseska.com/api/';
  static String localUrl = 'http://192.168.1.9:8000/api/';
  static String baseUrl = webUrl;


  static String signUp = '${baseUrl}signup';

  static String login = '${baseUrl}login';

  static String subjects = '${baseUrl}subjects';
  static String lessons = '${baseUrl}lessons/ID';
  static String courses = '${baseUrl}courses/ID';
  static String quizzes = '${baseUrl}quizze';
  static String questions = '${baseUrl}questions/ID';
  static String quizeResult = '${baseUrl}quize-result';
  static String myQuizzes = '${baseUrl}my-quizzes';
  static String myCourses = '${baseUrl}my-cources';
  static String insertCode = '${baseUrl}insert-code';

}