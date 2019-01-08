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
#import "GiftView.h"
#import "GiftModel.h"
/** 宏定义 绑定tag、弹出时间 */
#define TagValue  1000
#define AlertTime 0.3 //弹出动画时间
#define DropTime 0.5 //落下动画时间
#define KScreenHeight [UIScreen mainScreen].bounds.size.height  // 屏幕的高度
#define KScreenWidth [UIScreen mainScreen].bounds.size.width    // 屏幕的宽度
#define GradientStart @"#3EC5F5"  // 渐变开始颜色
#define GradientEnd @"#2B82DE"  // 渐变结束颜色

// 礼物的宽高
#define giftW 70.0f
#define giftH 70.0f


#define imgWidth 30
#define imgHeight 30
#define itemsWidth (KScreenWidth/4)
#define itemsHeight (KScreenWidth/4)
#define KScreenHeight [UIScreen mainScreen].bounds.size.height
#define KScreenWidth [UIScreen mainScreen].bounds.size.width

@interface GiftGivingView ()
// 标记点中哪个model、哪个view
@property (strong,nonatomic) GiftModel *gModel;
@property (strong,nonatomic) GiftView *gView;

@end
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
        self.scrollview_gift.pagingEnabled = YES; // 分页滚动
        self.pageC = [[UIPageControl alloc]init];
        self.pageC.backgroundColor = [UIColor redColor];
         self.pageC.numberOfPages = 5;
    
      [self.footerView addSubview:self.pageC];
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
     NSLog(@"布局子控件 %s",__func__);
    // 布局子控件的 frame
    if (self.viewTg == 1) {
        NSLog(@"不加载了");
    }
    else
    {
        [self loadData];
        [self drawView];
    }
    
    

}
#pragma  alloc init 和 xib 初始化的时候 调用的方法 end

#pragma mark - customMethod 自定义方法 快速xib 创建 start
- (void)loadData
{
    NSInteger pageCount = _arr_Data.count/8;
    if (_arr_Data.count % 8 > 0) {
        pageCount = pageCount + 1;
    }
    else
    {
        pageCount = pageCount;
    }
    
    self.scrollview_gift.contentSize =  CGSizeMake([UIScreen mainScreen].bounds.size.width * pageCount, self.scrollview_gift.frame.size.height);
    
    self.pageC = [[UIPageControl alloc]init];
    self.pageC.frame = CGRectMake((KScreenWidth-200)/2, 0, 200, 20);
        
    self.pageC.numberOfPages = pageCount;
    [self.pageC addTarget:self action:@selector(pageScrollAction) forControlEvents:UIControlEventValueChanged];
    [self.footerView addSubview:self.pageC];
    int col = 0; // 1行4个
    int row = 0;
    NSLog(@"数据的数量 %lu",(unsigned long)self.arr_Data.count);
    
    NSMutableArray *tempArray  = [NSMutableArray array];
    for (NSDictionary *dict in self.arr_Data) {
        GiftModel *model = [[GiftModel alloc]initWithDict:dict];
        [tempArray addObject:model];
    }
    self.arr_Data = tempArray;
    
    NSLog(@"%@",self.arr_Data);
    
     for(int i=0; i<pageCount; i++){
         // 一共有多少页
         for (int j = 0; j < 8; j++) {
             // 每一页8个view
              CGFloat hMargin  = 10;
              CGFloat vMargin = 15;
              CGFloat w = ([UIScreen mainScreen].bounds.size.width - (hMargin * (4 - 1))) / 4;
              CGFloat h = (self.scrollview_gift.frame.size.height - 15) / 2;
              CGFloat x = (hMargin + w) * (j % 4) + KScreenWidth*i; // 水平间距 + 自身宽度 * 第几个控件 (0 % 4) = 0
              CGFloat y = (vMargin + h) * (j / 4);
             if(i == (pageCount-1))
             {
                 NSLog(@"最后一页数据");
                 if (_arr_Data.count > (pageCount-1) * 8 + j) {
                     NSLog(@"添加 %d view",j);
                     GiftView *gv  = [[GiftView alloc]initWithFrame:CGRectMake(x, y, w, h)];
                     NSInteger index = 8 * i + j;
                     gv.model = self.arr_Data[index];
                     gv.giftViewDelegate = self;
                     [self.scrollview_gift addSubview:gv];
                 }
                 else
                 {
                     NSLog(@"不要添加view了");
                 }
             }
             else
             {
                 // 这里是添加之前的view
                 GiftView *gv  = [[GiftView alloc]initWithFrame:CGRectMake(x, y, w, h)];
                 NSInteger index = 8 * i + j;
                 gv.model = self.arr_Data[index];
                 gv.giftViewDelegate = self;
                 [self.scrollview_gift addSubview:gv];

             }
             col++;
             if(col ==4){  //一行显示7个表情
                 col = 0;
                 row ++;
             }
             if(row == 2){
                 row = 0;
             }
         }
         
         
         
         
         
     }
}
+ (instancetype)giftGivingView
{
    // 通过软件的包 去加载xib名字为 该类的名字的xib文件 并且加载的是xib的第一个视图
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}
#pragma mark  customMethod 自定义方法 快速xib 创建 end


#pragma mark - 自定义对象方法 start
- (void)drawView
{
    /**
     参考链接
     https://www.jianshu.com/p/2cd640183d5f
     https://www.jianshu.com/p/139f4fbe7b6b
     */
    // 使用贝塞尔曲线去绘制一个圆角
    // 通俗点就是UIBezierPath用来指定绘制图形路径，而CAShapeLayer就是根据路径来绘图的。
    // 图2
    
    UIBezierPath *maskPath2 = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(20, 20)];
    CAShapeLayer *maskLayer2 = [[CAShapeLayer alloc] init];
    maskLayer2.frame = self.contentView.bounds;
    maskLayer2.path = maskPath2.CGPath;
    self.contentView.layer.mask = maskLayer2;
    
    
}

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
    self.viewTg = 1;
    self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-keyboardRect.size.height-315, [UIScreen mainScreen].bounds.size.width, 315);
    //提交动画
    [UIView commitAnimations];
}

- (void)keyBoardDidHide:(NSNotification*)notification {
    
    //定义动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    //设置view的frame，往下平移
    self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-315, [UIScreen mainScreen].bounds.size.width, 315);
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

- (void)Click_GiftViewDelegate:(GiftView *)view WithModel:(GiftModel *)model
{
    NSLog(@"点击的礼物 %@",model.name);
    
    if ([self.giftGivingViewDelegate respondsToSelector:@selector(Click_GiftGivingViewDelegate:GiftView:WithModel:)])
    {
        self.gModel = model;
        self.gView = view;
        [self.giftGivingViewDelegate Click_GiftGivingViewDelegate:self GiftView:view WithModel:model];
    }
    
}

- (IBAction)go2Exceptional:(UIButton *)sender {
    NSLog(@"查看点击了哪个model %@",self.gModel.name);
    NSLog(@"查看点击了哪个view %@",self.gView);

    // 记录数量
    NSLog(@"记录数量 %@",self.tf_exceptionalCount.text);
    
    if ([self.giftGivingViewDelegate respondsToSelector:@selector(Click_GiftGivingViewDelegate:ClickGiftView:WithClickModel:WithExceptionalCount:)]) {
        [self.giftGivingViewDelegate Click_GiftGivingViewDelegate:self ClickGiftView:self.gView WithClickModel:self.gModel WithExceptionalCount:self.tf_exceptionalCount.text];
        
    }
    
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
