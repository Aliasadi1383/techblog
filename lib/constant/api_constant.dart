class ApiUrlConstant {
  ApiUrlConstant._();
  static const hostDlUrl="https://techblog.sasansafari.com";
  static const baseurl="https://techblog.sasansafari.com/Techblog/api/";
  static const getHomeItems="${baseurl}home/?command=index";
  static const getArticleList="${baseurl}article/get.php?command=new&user_id=1";
  static const publishedByMe="${baseurl}article/get.php?command=published_by_me&user_id=";
  static const postRegister="${baseurl}register/action.php";
  static const articlePost="${baseurl}article/post.php";
  static const podcastFiles="${baseurl}podcast/get.php?command=get_files&podcats_id=";
}
class ApiArticleKeyConstant {
  static const title="title";
  static const content="content";
  static const catId="cat_id";
  static const tagList="tag_list";
  static const userId="user_id";
  static const image="image";
  static const command="command";


}