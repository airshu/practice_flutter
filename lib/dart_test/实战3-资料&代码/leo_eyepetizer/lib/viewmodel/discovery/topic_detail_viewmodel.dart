import 'package:leo_eyepetizer/http/Url.dart';
import 'package:leo_eyepetizer/http/http_manager.dart';
import 'package:leo_eyepetizer/model/discovery/topic_detail_model.dart';
import 'package:leo_eyepetizer/utils/toast_util.dart';
import 'package:leo_eyepetizer/viewmodel/base_viewmodel.dart';
import 'package:leo_eyepetizer/widget/loading_state_widget.dart';

class TopicDetailViewModel extends BaseViewModel {
  TopicDetailModel topicDetailModel = TopicDetailModel();
  List<TopicDetailItemData> itemList = [];
  int _id;

  TopicDetailViewModel(this._id);

  @override
  void refresh() {
    // http://baobab.kaiyanapp.com/api/v3/lightTopics/internal/613
    HttpManager.requestData('${Url.topicsDetailUrl}$_id').then((res) {
      topicDetailModel = TopicDetailModel.fromJson(res);
      itemList = topicDetailModel.itemList;
      viewState = ViewState.done;
    }).catchError((e) {
      LeoToast.showError(e.toString());
      viewState = ViewState.error;
    }).whenComplete(() => notifyListeners());
  }
}