
#import "ViewController.h"
#import "InitLiveRoomInfo_View.h"
#import "GiftGivingView.h"
#import "GiftModel.h"
@interface ViewController () <GiftGivingViewDelegate>
@property (nonatomic,strong) InitLiveRoomInfo_View *LiveRoomInfo_View;
@property (nonatomic,strong) GiftGivingView *giftGivingView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self function1]; //弹框
    [self function2];
}


/**
 创建送礼物的视图
 */
- (void)function2
{
    GiftGivingView *v = [GiftGivingView giftGivingView];
//    v.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 315, [UIScreen mainScreen].bounds.size.width, 315);
//    v.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 315);
    
//    v.center = CGPointMake(self.view.frame.size.width*0.5, self.view.frame.size.height * 0.5); // 设置位置
    self.giftGivingView = v;
    self.giftGivingView.giftGivingViewDelegate = self;
    
    NSArray *array = @[@{@"name":@"1",@"type":@"11"},@{@"name":@"2",@"type":@"12"},@{@"name":@"3",@"type":@"13"},@{@"name":@"1",@"type":@"11"},@{@"name":@"2",@"type":@"12"},@{@"name":@"3",@"type":@"13"},@{@"name":@"77",@"type":@"777"},@{@"name":@"88",@"type":@"888"},@{@"name":@"99",@"type":@"999"},@{@"name":@"1",@"type":@"11"},@{@"name":@"2",@"type":@"12"},@{@"name":@"3",@"type":@"13"},@{@"name":@"1",@"type":@"11"},@{@"name":@"2",@"type":@"12"},@{@"name":@"3",@"type":@"13"},@{@"name":@"77",@"type":@"777"},@{@"name":@"66",@"type":@"666"}];
//    NSArray *array = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"
//                       ,@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"
//                       ,@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"
//                       ,@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",
//                       @"1"];
    self.giftGivingView.arr_Data = array;
    // 延迟0.3秒弹出
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view addSubview:self.giftGivingView];
        [self.giftGivingView show];
    });
}
- (void)Click_GiftGivingViewDelegate:(GiftGivingView *)gView GiftView:(GiftView *)view WithModel:(GiftModel *)model
{
    NSLog(@"%@,%@,model %@",gView,view,model.name);
}

- (void)Click_GiftGivingViewDelegate:(GiftGivingView *)sview ClickGiftView:(GiftView *)view WithClickModel:(GiftModel *)model WithExceptionalCount:(NSString *)count
{
    if (model.name == nil) {
        NSLog(@"请选择打赏类型");
    }
    else
    {
        NSLog(@"选择中的name %@ 打赏数量 %@",model.name,count);
        NSLog(@"打赏成功");
        [sview hide];
    }
}

#pragma mark - 弹框
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

- (IBAction)ClickFunction2:(UIButton *)sender {
    [self function2];
}


@end
