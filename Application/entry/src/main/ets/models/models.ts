
import { chaplog } from './chaplog';

export class QATopModel {
  headImg: string; // 头像url
  accoutName: string; // 账号名称
  score: number; // 得分


  constructor(chaplog:chaplog, imgurl: string) {
    this.headImg = imgurl;
    this.accoutName = chaplog.remark;
    this.score = chaplog.score;
  }
}

