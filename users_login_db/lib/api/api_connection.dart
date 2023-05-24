class API {
  static const hostConnect = "http://192.168.16.52/api_user";
  //static const hostConnect = "https://ddaw-pau.000webhostapp.com/api_user";
  static const hostConnectUser = "$hostConnect/user";

  static const validateEmail = "$hostConnect/user/validate_email.php";
  static const signUp = "$hostConnect/user/signup.php";
  static const login = "$hostConnect/user/login.php";
  static const groups = "$hostConnect/group/groupsShow.php";
  static const tasks = "$hostConnect/task/tasksShow.php";
  static const tasksAlumnSave = "$hostConnect/task/alumnTaskSave.php";
  static const tasksAlumnUpdate = "$hostConnect/task/alumnTaskUpdate.php";
  static const imageSave = "$hostConnect/task/imageSave.php";
  static const getAlumnTask = "$hostConnect/task/getAlumnTask.php";
  static const profilePhoto = "$hostConnect/user/profilePhoto.php";
  static const profilePhoto2 = "$hostConnect/user/profilePhoto2.php";
  static const ownTasks = "$hostConnect/task/ownTask.php";
  static const deleteTask = "$hostConnect/task/deleteTask.php";
  static const addOwnTask = "$hostConnect/task/ownTaskSave.php";
}
