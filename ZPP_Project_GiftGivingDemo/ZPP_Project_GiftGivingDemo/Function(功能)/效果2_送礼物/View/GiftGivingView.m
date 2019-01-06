//#import "GiftGivingView.h"
//
//@implementation GiftGivingView
//
///*
//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//}
//*/
//
//@end



#import "GiftGivingView.h"
#import "UIViewExt.h"

/** 宏定义 绑定tag、弹出时间 */
#define TagValue  1000
#define AlertTime 0.3 //弹出动画时间
#define DropTime 0.5 //落下动画时间
#define KScreenHeight [UIScreen mainScreen].bounds.size.height  // 屏幕的高度
#define KScreenWidth [UIScreen mainScreen].bounds.size.width    // 屏幕的宽度
#define GradientStart @"#3EC5F5"  // 渐变开始颜色
#define GradientEnd @"#2B82DE"  // 渐变结束颜色

@implementation GiftGivingView
#pragma - alloc init 和 xib 初始化的时候 调用的方法 start
- (instancetype)init
{
    if (self = [super init]) {
        // ...代码创建 调用的方法1
        // NSLog(@"%s",__func__);
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // ...代码创建 调用的方法2 这里设置frame
        // NSLog(@"%s",__func__);
    }
    return self;
}

// xib加载时调用方法1 __ 未被唤醒 设置frame无效 只能去layoutSubviews 设置
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        NSLog(@"%s",__func__);
        // 在这里设置一共有多少个数据
        self.scrollview_gift.delegate = self;
        self.pageC.numberOfPages = 2; // 设置多少个分页
        [self.pageC addTarget:self action:@selector(pageScrollAction) forControlEvents:UIControlEventValueChanged];

    }
    return self;
}
// xib加载时调用方法1 __ 被唤醒状态
- (void)awakeFromNib
{
    [super awakeFromNib];
    NSLog(@"%s",__func__);
//    [IQKeyboardManager sharedManager].enable = YES;
    
    //  添加观察者，监听键盘弹起、收起
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidHide:) name:UIKeyboardWillHideNotification object:nil];

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    // NSLog(@"%s",__func__);
    // 布局子控件的 frame
    [self loadData];
}
#pragma  alloc init 和 xib 初始化的时候 调用的方法 end

#pragma mark - customMethod 自定义方法 快速xib 创建 start
- (void)loadData
{
    self.scrollview_gift.contentSize =  CGSizeMake([UIScreen mainScreen].bounds.size.width * 2, self.scrollview_gift.frame.size.height);
    CGFloat col = 0;
    CGFloat row = 0;
     for(int i=0; i<_arr_Data.count; i++){
         
     }
}
+ (instancetype)giftGivingView
{
    // 通过软件的包 去加载xib名字为 该类的名字的xib文件 并且加载的是xib的第一个视图
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}
#pragma mark  customMethod 自定义方法 快速xib 创建 end


#pragma mark - 自定义对象方法 start
//隐藏
-(void)hide
{
    if (self.superview) {
        [UIView animateWithDuration:AlertTime animations:^{
            self.transform = CGAffineTransformScale(self.transform,0.1,0.1);
            self.alpha = 0;
        } completion:^(BOOL finished) {
            UIView *bgview = [[UIApplication sharedApplication].keyWindow viewWithTag:TagValue];
            if (bgview) {
                [bgview removeFromSuperview];
            }
            [self removeFromSuperview];
        }];
    }
}
-(void)show{
    if (self.superview) {
        [self removeFromSuperview];
    }
    UIView *oldView = [[UIApplication sharedApplication].keyWindow viewWithTag:TagValue];
    if (oldView) {
        [oldView removeFromSuperview];
    }
    UIView *iview = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    iview.tag = TagValue;
    iview.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [iview addGestureRecognizer:tap]; // 不添加手势 不给用户点击其他地方删除该视图
        iview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
//    iview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    [[UIApplication sharedApplication].keyWindow addSubview:iview];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
//    self.center = [UIApplication sharedApplication].keyWindow.center;
    self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 315, [UIScreen mainScreen].bounds.size.width, 315);

    self.alpha = 0;
    self.transform = CGAffineTransformScale(self.transform,0.1,0.1);
    [UIView animateWithDuration:AlertTime animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }];
}
#pragma mark  自定义对象方法 end


#pragma mark - 键盘弹起、收起
- (void)keyBoardDidShow:(NSNotification*)notifiction {
    
    //获取键盘高度
    NSValue *keyboardObject = [[notifiction userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    NSLog(@"键盘高度 %@",keyboardObject);
    
    CGRect keyboardRect;
    
    [keyboardObject getValue:&keyboardRect];
    
    //得到键盘的高度
    //CGRect keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notifiction.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSLog(@"%f",duration);
    //调整放置有textView的view的位置
    
    //设置动画
    [UIView beginAnimations:nil context:nil];
    
    //定义动画时间
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelay:0];
    
    //设置view的frame，往上平移
    self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-keyboardRect.size.height-315, [UIScreen mainScreen].bounds.size.width, 315);

//    [(UIView *)[self viewWithTag:1000] setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-keyboardRect.size.height-315, [UIScreen mainScreen].bounds.size.width, 315)];
    
    //提交动画
    [UIView commitAnimations];
}

- (void)keyBoardDidHide:(NSNotification*)notification {
    
    //定义动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    
    //设置view的frame，往下平移
    
    self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-315, [UIScreen mainScreen].bounds.size.width, 315);
//    [(UIView *)[self viewWithTag:1000] setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 315, [UIScreen mainScreen].bounds.size.width, 315)];
    [UIView commitAnimations];
}


#pragma mark sc\pagec delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@" scrollViewDidScroll");

    //获取当前页索引
    NSInteger index = scrollView.contentOffset.x/KScreenWidth;
    self.pageC.currentPage = index;
}

-(void)pageScrollAction{
    NSLog(@" page s");
    //获得当前页码
    NSInteger pages = self.pageC.currentPage;
    
    CGFloat contentOfSize = pages * KScreenWidth;
    
    [self.scrollview_gift scrollRectToVisible:CGRectMake(contentOfSize, 0, self.scrollview_gift.width, self.scrollview_gift.height) animated:YES];
}


@end


/**
 1、实现包含
 1.1 宏定义
 用来绑定该类里面经常使用到的字符串、常量等等
 1.2 实现系统的init方法 防止用户通过allocinit初始化
 实现系统的xib创建方法 唤醒状态 被唤醒状态
 1.3 功能实现
 
 */
