import Logger from '@ohos.hilog';
export class Log {
}
Log.domain = 0x00;
Log.info = (tag, format, ...args) => {
    Logger.info(Log.domain, tag, format, args);
};
Log.error = (tag, format, ...args) => {
    Logger.error(Log.domain, tag, format, args);
};
//# sourceMappingURL=Log.js.map