export class Constants {
  // 路由path
  static readonly PAGE_INDEX = 'pages/Index';
  static readonly PAGE_LOGIN = 'pages/Accout/Login';
  static readonly PAGE_LOGIN_BY_EMAIL = 'pages/Accout/LoginByEmail';
  static readonly PAGE_HOME = 'pages/Home/Home';
  static readonly PAGE_USER_CENTER = "pages/Accout/UserCenter";
  static readonly PAGE_LIST_CHAPTER = "pages/BrushQuest/ChapterList";
  static readonly PAGE_QUIZ = "pages/OnlineQuiz/QuizIndex";
  static readonly PAGE_ANSWER = "pages/OnlineQuiz/Answer";

  static readonly MY_QUIZ = "pages/MyQuiz/MyQuizIndex";

  static readonly PAGE_QUIZ_RESULT = "pages/OnlineQuiz/QuizResult";
  static readonly PAGE_QLIST = "pages/BrushQuest/QList";

  // 用户默认头像云存储url地址数组
  static readonly USER_HEAD_IMGURLS = [
    "https://agc-storage-drcn.platform.dbankcloud.cn/v0/hmqa-bbnx2/defaultAvatar%2Fic_public_avatar1.png?token=ec5c702d-9ed9-4caf-ac7f-4ca205c70e68",
    "https://agc-storage-drcn.platform.dbankcloud.cn/v0/hmqa-bbnx2/defaultAvatar%2Fic_public_avatar10.png?token=50bde7f9-89d5-4e3b-b590-1a12281a3996",
    "https://agc-storage-drcn.platform.dbankcloud.cn/v0/hmqa-bbnx2/defaultAvatar%2Fic_public_avatar15.png?token=7a7d8cf9-ae69-4d07-8392-c3e43cb9a799",
    "https://agc-storage-drcn.platform.dbankcloud.cn/v0/hmqa-bbnx2/defaultAvatar%2Fic_public_avatar2.png?token=60424e3b-db60-48e6-868d-bd1db1d76ff7",
    "https://agc-storage-drcn.platform.dbankcloud.cn/v0/hmqa-bbnx2/defaultAvatar%2Fic_public_avatar3.png?token=c12ac451-e5ea-4ef2-bb7b-2bc50ed1af7a",
    "https://agc-storage-drcn.platform.dbankcloud.cn/v0/hmqa-bbnx2/defaultAvatar%2Fic_public_avatar4.png?token=b78cf526-b73a-4c58-b167-0c2c41472e28",
    "https://agc-storage-drcn.platform.dbankcloud.cn/v0/hmqa-bbnx2/defaultAvatar%2Fic_public_avatar5.png?token=0fbeba07-d2e8-492d-bbd7-89a89a8ac715",
    "https://agc-storage-drcn.platform.dbankcloud.cn/v0/hmqa-bbnx2/defaultAvatar%2Fic_public_avatar6.png?token=5b8be89a-7b92-4a61-b528-2bf6ba1748b6",
    "https://agc-storage-drcn.platform.dbankcloud.cn/v0/hmqa-bbnx2/defaultAvatar%2Fic_public_avatar7.png?token=6032a2ba-f2a4-4f2a-9ec3-37e11898780b",
    "https://agc-storage-drcn.platform.dbankcloud.cn/v0/hmqa-bbnx2/defaultAvatar%2Fic_public_avatar8.png?token=847e823d-390d-4877-b22f-650c790017fc",
    "https://agc-storage-drcn.platform.dbankcloud.cn/v0/hmqa-bbnx2/defaultAvatar%2Fic_public_avatar9.png?token=092c659b-e298-44d3-ba8d-66099ed16243"
  ]

  // 登录相关
  static readonly LOGIN_USER = 'LOGIN_USER';
  static readonly PREFERENCES_STORE = 'PREFERENCES_STORE';


  // 颜色
  static readonly ERROR_FULL_COLOR = '#f83b43'
  static readonly ERROR_HALF_COLOR = '#fff2f2'
  static readonly RIGHT_FULL_COLOR = '#00cc9f'
  static readonly RIGHT_HALF_COLOR = '#f3fffc'
  static readonly GRAY_FULL_COLOR = '#d9d9d9'
  static readonly GRAY_LIGHT_COLOR = '#fafcff'
  static readonly BLUE_LIGHT_COLOR = '#449ef8'
  static readonly NORMAL_COLOR = '#121826'


  // 百分比
  static readonly PERCENT_25 = '25%';
  static readonly PERCENT_50 = '50%';
  static readonly PERCENT_70 = '70%';
  static readonly PERCENT_75 = '75%';
  static readonly PERCENT_90 = '90%';
  static readonly PERCENT_96 = '96%';
  static readonly PERCENT_100 = '100%';

  // 视口
  static readonly VIEWPORT_50 = '50vp';


  static readonly LENGTH_1_PX = 1;
  static readonly LENGTH_2_PX = 2;
  static readonly LENGTH_3_PX = 3;
  static readonly LENGTH_5_PX = 5;
  static readonly LENGTH_6_PX = 6;
  static readonly LENGTH_8_PX = 8;
  static readonly LENGTH_10_PX = 10;
  static readonly LENGTH_15_PX = 15;
  static readonly LENGTH_20_PX = 20;
  static readonly LENGTH_30_PX = 30;
  static readonly LENGTH_40_PX = 40;
  static readonly LENGTH_70_PX = 70;
  static readonly LENGTH_250_PX = 250;
  static readonly LENGTH_100_PX = 100;
  static readonly LENGTH_150_PX = 150;
  static readonly LENGTH_160_PX = 160;
  static readonly LENGTH_180_PX = 180;

  static readonly BORDER_RADIUS_4_PX = 4;

  static readonly HEIGHT_50VP = '50vp';
  static readonly WIDTH_25_P = '25%';
  static readonly WIDTH_50 = '50%';
  static readonly WIDTH_70_P = '70%';
  static readonly WIDTH_75_P = '75%';
  static readonly WIDTH_90 = '90%';
  static readonly FULL_WIDTH = '100%';
  static readonly WIDTH_20 = 20;
  static readonly WIDTH_70 = 70;
  static readonly WIDTH_250 = 250;
  static readonly HEIGHT_100 = 100;
  static readonly HEIGHT_150 = 150;
  static readonly HEIGHT_160 = 160;
  static readonly HEIGHT_180 = 180;
  static readonly HEIGHT_40 = 40;
  static readonly HEIGHT_24 = 24;
  static readonly HEIGHT_90 = '90%';
  static readonly FULL_HEIGHT = '100%';
  static readonly HEIGHT_50 = '50%';
  static readonly MP_5 = 5;
  static readonly MP_10 = 10;
  static readonly MP_15 = 15;
  static readonly MP_20 = 20;
  static readonly MP_30 = 30;
  static readonly BORDER_RADIUS = 4;
  static readonly BORDER_WIDTH = 1;
  static readonly WEIGHT_1 = 1;
  static readonly WEIGHT_2 = 2;
  static readonly WEIGHT_3 = 3;
  static readonly MAX_LENGTH_6 = 6;
  static readonly CHECKBOX_WIDTH = 8;
}

// Publisher通讯事件类型
export enum PublishEventType {
  APP_PUBLISH = "APP_PUBLISH",
  CARD_PUBLISH = "CARD_PUBLISH"
}