export class AdminConfig {
  // An Example | Delete The Content When Started
  // source api
  public static sourceAPI                   = 'http://34.70.151.188/html/public/index.php/';

  // All Application Api
  public static loginAPI                    = AdminConfig.sourceAPI + 'login_check';
  public static userAPI                     = AdminConfig.sourceAPI + 'user';
  public static usersAPI                    = AdminConfig.sourceAPI + 'userprofileall';
  

  // swapItems     
  public static swapItemAPI                 = AdminConfig.sourceAPI + 'swapitem';
  public static swapOperationsAPI           = AdminConfig.sourceAPI + 'swap';
  public static getSwapItemAPI              = AdminConfig.sourceAPI + 'swapitembyid';
  
  // Reports
  public static reportAPI                   = AdminConfig.sourceAPI + 'report';
 

  // Upload     
  public static generalUploadAPI            = AdminConfig.sourceAPI + 'uploadfile'; 
}
