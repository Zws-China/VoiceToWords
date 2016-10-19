//
//  ViewController.m
//  语音转文字
//
//  Created by iMac on 16/10/19.
//  Copyright © 2016年 zws. All rights reserved.
//

#import "ViewController.h"
#import "iflyMSC/iflyMSC.h"
#import "ISRDataHelper.h"


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<IFlyRecognizerViewDelegate>

@end

@implementation ViewController{
    
    IFlyRecognizerView      *_iflyRecognizerView;
    
    UITextView *TextV;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化语音识别控件
    _iflyRecognizerView = [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
    _iflyRecognizerView.delegate = self;
    [_iflyRecognizerView setParameter: @"iat" forKey: [IFlySpeechConstant IFLY_DOMAIN]];
    //asr_audio_path保存录音文件名，如不再需要，设置value为nil表示取消，默认目录是documents
    [_iflyRecognizerView setParameter:@"asrview.pcm " forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    
    
    TextV= [[UITextView alloc]initWithFrame:CGRectMake(10, 20, kScreenWidth -20, 300)];
    TextV.text = @"";
    TextV.layer.cornerRadius = 5;
    TextV.layer.borderWidth = 1;
    TextV.layer.borderColor = [UIColor grayColor].CGColor;
    TextV.editable = NO;
    TextV.font = [UIFont boldSystemFontOfSize:14];
    [self.view addSubview:TextV];
    
    
    UIButton *haha = [UIButton buttonWithType:UIButtonTypeCustom];
    haha.frame = CGRectMake(50, CGRectGetMaxY(TextV.frame)+50, kScreenWidth - 100, 35);
    haha.layer.cornerRadius = 5;
    haha.backgroundColor = [UIColor grayColor];
    [haha setTitle:@"点击开始听写" forState:UIControlStateNormal];
    [self.view addSubview:haha];
    [haha addTarget:self action:@selector(hahahaha) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}


- (void)hahahaha {
    [TextV resignFirstResponder];//禁止弹键盘
    
    //启动识别服务
    [_iflyRecognizerView start];
}



/*识别结果返回代理
 @param resultArray 识别结果
 @ param isLast 表示是否最后一次结果
 */
- (void)onResult: (NSArray *)resultArray isLast:(BOOL) isLast
{
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = [resultArray objectAtIndex:0];
    
    for (NSString *key in dic) {
        [result appendFormat:@"%@",key];
    }
    NSString * resultFromJson =  [ISRDataHelper stringFromJson:result];
    
    NSLog(@"---------%@",resultFromJson);
    TextV.text = [NSString stringWithFormat:@"%@%@",TextV.text,resultFromJson];
}
/*识别会话错误返回代理
 @ param  error 错误码
 */
- (void)onError: (IFlySpeechError *) error
{
    NSLog(@"%@",error);
    
}







@end
