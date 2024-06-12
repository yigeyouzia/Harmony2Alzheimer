export function formatDate(date: string): string {
  console.log('formatDate->', date);
  if (date) {
    let d = new Date();
    if (date.toString().indexOf('+') > -1) {
      d = new Date(date);
    } else {
      d = new Date(parseInt(date));
    }

    // let ymd = d
    //   .toISOString()
    //   .replace('-', '/')
    //   .split('T')[0]
    //   .replace('-', '/');
    let year = d.getFullYear();

    let month = (d.getMonth() + 1).toString();
    month = month.length < 2 ? "0" + month : month;

    let day = d.getDate()
                .toString()
                .length < 2 ? "0" + d.getDate() : d.getDate();
    ;

    let hours = d.getHours()
                  .toString()
                  .length < 2 ? "0" + d.getHours() : d.getHours();

    let minutes = d.getMinutes()
                    .toString()
                    .length < 2 ? "0" + d.getMinutes() : d.getMinutes();

    let seconds = d.getSeconds()
                    .toString()
                    .length < 2 ? "0" + d.getSeconds() : d.getSeconds();

    let hm = hours + ':' + minutes + ':' + seconds;

    return `${year}-${month}-${day}` + ' ' + hm;
  } else {
    return date;
  }
}

//格式化手机号或者邮箱，隐藏部分字符
export function formatNickName(str: string): string {

  let isemial = str.includes('@');
  let istelPhone = str.includes('+86');
  // 判断是否是邮箱
  if (isemial) {
    // 处理邮箱隐藏@之前的部分字符用*代替
    let arr = str.split('@');
    let nickname = arr[0];
    let nicknameLng = nickname.length;

    // 取前2个字符，最后取两个字符，中间用*号替代
    return `${nickname.slice(0, 2)}****${nickname.slice(-2)}${arr[1]}`;

  } else if (istelPhone) {
    let telphone = str.replace("+86-", "");

    // 取前面3位数，后面四位数，中间用*号替代
    return `${telphone.slice(0, 3)}****${telphone.slice(-4)}`;

  } else {
    return str;
  }
}

//取部分用户名用户卡片显示
export function getPartalNickName(str: string): string {
  let isemial = str.includes('@');
  let istelPhone = str.includes('+86');
  // 判断是否是邮箱
  if (isemial) {
    // 处理邮箱隐藏@之前的部分字符用*代替
    let arr = str.split('@');
    return arr[0];

  } else if (istelPhone) {
    // 取前面3位数，后面四位数，中间用*号替代
    return str.slice(-4);

  } else {
    return str;
  }
}