
#import "ViewController.h"
#import "InitLiveRoomInfo_View.h"

@interface ViewController ()
@property (nonatomic,strong) InitLiveRoomInfo_View *LiveRoomInfo_View;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self function1];
}


- (void)function1
{
    InitLiveRoomInfo_View *v = [InitLiveRoomInfo_View initLiveRoomInfo_View];
    v.center = CGPointMake(self.view.frame.size.width*0.5, self.view.frame.size.height * 0.5); // 设置位置
    self.LiveRoomInfo_View = v;
    // 延迟0.3秒弹出
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view addSubview:self.LiveRoomInfo_View];
        [self.LiveRoomInfo_View show];
    });
    [v.btn_confirm cq_addEventHandler:^{
        [self.LiveRoomInfo_View hide]; // 隐藏
    } forControlEvents:UIControlEventTouchUpInside];

}
- (IBAction)ClickFunction1:(UIButton *)sender {
    [self function1];
}

/**
 创建送礼物的视图
 */
- (void)custom_CreateGiftView
{
    
}


@end
