# VoiceToWords
简单集成讯飞语音，将语音转文字。


# PhotoShoot
![image](https://github.com/Zws-China/VoiceToWords/blob/master/Wechat.jpeg)


# How To Use

```ruby
IFlyRecognizerView      *_iflyRecognizerView;


//初始化语音识别控件
_iflyRecognizerView = [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
_iflyRecognizerView.delegate = self;
[_iflyRecognizerView setParameter: @"iat" forKey: [IFlySpeechConstant IFLY_DOMAIN]];
//asr_audio_path保存录音文件名，如不再需要，设置value为nil表示取消，默认目录是documents
[_iflyRecognizerView setParameter:@"asrview.pcm " forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];



//启动识别服务
[_iflyRecognizerView start];



/*识别结果返回代理
@param resultArray 识别结果
@ param isLast 表示是否最后一次结果
*/
- (void)onResult: (NSArray *)resultArray isLast:(BOOL) isLast {

    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = [resultArray objectAtIndex:0];

    for (NSString *key in dic) {
        [result appendFormat:@"%@",key];
    }
    NSString * resultFromJson =  [ISRDataHelper stringFromJson:result];

    NSLog(@"识别结果:%@",resultFromJson);
}

/*识别会话错误返回代理
@ param  error 错误码
*/
- (void)onError: (IFlySpeechError *) error {

    NSLog(@"%@",error);

}



```