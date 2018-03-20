<img src = "https://github.com/CommanTeam/iOS/blob/master/wireframe/Comman_ICON.png" height=32/> 컴만
====================================
<img src = "https://github.com/CommanTeam/iOS/blob/master/wireframe/Comman_ICON.png" height=200/> <img src = "https://github.com/CommanTeam/iOS/blob/master/wireframe/Splash.png" height=200/> <img src = "https://github.com/CommanTeam/iOS/blob/master/wireframe/login.png" height=200/> <img src = "https://github.com/CommanTeam/iOS/blob/master/wireframe/main.png" height=200/> <img src = "https://github.com/CommanTeam/iOS/blob/master/wireframe/list.png" height=200/> <img src = "https://github.com/CommanTeam/iOS/blob/master/wireframe/preview.png" height=200/>

개발자 : 김지우


Preview
-------
* 컴만은 중장년층 IT 소외자들을 위한 IT 교육 서비스 플랫폼입니다.<br>
* SOPT로 불리는 대학 연합 IT 창업동아리 내에서 이루어진 2주간의 해커톤 활동에서 개발하였습니다.<br>
* 애플리케이션 기획자는 <a href="https://github.com/JunhoeKim">김준회</a>입니다.
* 애플리케이션 디자이너는 최형윤(yunii96@naver.com)으로 Adobe XD를 사용하여 디자인하였습니다.
* 앱은 MVC패턴으로 작성되었으며, 개발기간이 짧았던 관계로 일부 MVC의 디자인적 요소는 배제하였습니다.<br>


Detail
------
* Splash & Login

  <img src = "https://github.com/CommanTeam/iOS/blob/master/wireframe/Splash.png" height=200/> <img src = "https://github.com/CommanTeam/iOS/blob/master/wireframe/login.png" height=200/> 
  
  * Model : Splash의 특별한 모델이 존재하지 않으나 Login의 경우엔 Kakao에서 accessToken을 받아 저희 앱의 서버에 전달하여  token, nickname, thumbnail을 받아옵니다.
  
  * View : SplashViewContrller의 view 에서는 userdefault 공간에 token이 있는 경우 main화면으로 없는 경우 login화면으로 전환됩니다.
  
  * Controller : Splash Controller에서는 userdefault 공간에 token이 있는지 여부를 판단하고 그 여부에 따라 main과 login으로 구분하여 화면을 전환시킵        니다. Login Controller의 경우 kakao와 자체 서버와의 통신을 통해 받은 정보들을 가지고 main으로 넘어갈지 판단하여 정상 통신이 되었다면 데이터와 함께 화면을 전환 시킵니다.

* Home & Search

  <img src = "https://github.com/CommanTeam/iOS/blob/master/wireframe/main.png" height=200/> <img src = "https://github.com/CommanTeam/iOS/blob/master/wireframe/search.png" height=200/> 
  
  * Model : Home의 경우엔 사용자가 최근에 수강한 강의와 총 수강한 강의들의 목록에 대한 데이터를 가지고 있으며 Search의 경우 저희 앱에서 제공하는 카테고리들의 데이터를 가지고 있습니다.
  
  * View : Home의 경우엔 TableView를 통해 사용자가 수강한 내용을 출력해주며, Search의 경우 CollectionView를 활용하여 카테고리 별 정보를 출력합니다.
  
  * Controller : Home의 Controller는 사용자가 수강한 강의들을 정보를 서버로 부터 받아 수강한 강의에 따라 구분하여 출력합니다. 하단의 선택된 탭바에 따라  Home과 Search로 변환해주며 Search에서는 카테고리 정보 서버로 부터 받아 분할하여 출력해줍니다.
  
* List & Preview
  
  <img src = "https://github.com/CommanTeam/iOS/blob/master/wireframe/list.png" height=200/> <img src = "https://github.com/CommanTeam/iOS/blob/master/wireframe/preview.png" height=200/>
  
  * Model : List는 저희 앱에서 총 3가지로 구분됩니다.  Course, Chapter, Lecture 순으로 List는 Course 내의 Chapter 목록, Chapter 내의 Lecture 목록의 데이터로 구분되어 Modeling되어 있으며, 만약 미등록된 Chapter라면 Chapter의 데이터에 미리보기 영상에 대한 데이터가 추가적으로 들어가 Preview 데이터로 사용됩니다.
  
  * View : Chapter, Lecture 목록을 Tableview로 출력시켜주며 등록여부가 cell 단위로 구분되어 출력됩니다. 만약 미등록된 Chapter라면 미리보기 영상과 등록하기 버튼이 추가적으로 출력됩니다.
  
  * Controller : list(Chapter, Lecture)의 경우 미등록된 정보에 따라서 출력 시켜주는 cell의 이미지를 다르게 구분해줍니다. 또한 등록되지 않은 Chapter의 경우 동영상 데이터를 외부 웹페이지에서 받아온 뒤 화면에 넘겨주는 역할을 합니다.

사용 라이브러리 및 api
-----------------
  
  * <a href="https://github.com/Alamofire/Alamofire">Alamofire</a>
  
  * <a href="https://github.com/SwiftyJSON/SwiftyJSON">SwiftyJSON</a>
  
  * <a href="https://github.com/onevcat/Kingfisher">Kingfisher</a>
  
  * <a href="https://github.com/rinov/YoutubeKit">YoutubeKit</a>
  
  * <a href="https://github.com/JV17/YoutubePlayer">YoutubePlayer</a>
  

라이선스
------
Project is published under the MIT licence. Feel free to clone and modify repo as you want, but don'y forget to add reference to authors :)
