import cloud from '@hw-agconnect/cloud';
// import schema from '../../resources/rawfile/schema.json';
import schema from './schema.json';

const dbZone = 'hmqaZone';
import { qtype } from '../models/qtype';
import { chaplist } from '../models/chaplist';
import { chapqa } from '../models/chapqa';
import { chaplog } from '../models/chaplog';
import { chapqalog } from '../models/chapqalog';
import { Database, DatabaseZoneQuery } from '@hw-agconnect/cloud/src/main/ets/database/Database';
import { userHeadImg } from '../models/userHeadImg';

class DatabaseHelper {
  static database:Database = cloud.database({objectTypeInfo: schema,zoneName: dbZone});  //dbZone是在AGC中的存储区名称;

  //1. 获取考题大类数据
  static async QType_Query():Promise<qtype[]> {
    return await DatabaseHelper.database.collection(qtype).query().equalTo("isDel",false).get();
  }

  //TODO：根据编写其他数据库操作方法

}

export default DatabaseHelper;