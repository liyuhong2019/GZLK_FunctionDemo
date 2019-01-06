#import "InitLiveRoomInfo_View.h"

/** 宏定义 绑定tag、弹出时间 */
#define TagValue  1000
#define AlertTime 0.3 //弹出动画时间
#define DropTime 0.5 //落下动画时间

#define GradientStart @"#3EC5F5"  // 渐变开始颜色
#define GradientEnd @"#2B82DE"  // 渐变结束颜色

@implementation InitLiveRoomInfo_View
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
    }
    return self;
}
// xib加载时调用方法1 __ 被唤醒状态
- (void)awakeFromNib
{
    [super awakeFromNib];
    NSLog(@"%s",__func__);
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    // NSLog(@"%s",__func__);
    // 布局子控件的 frame
    // 这里绘制指定圆角
    [self drawView];
}
#pragma  alloc init 和 xib 初始化的时候 调用的方法 end

#pragma mark - customMethod 自定义方法 快速xib 创建 start
+ (instancetype)initLiveRoomInfo_View
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
    
    // 图1
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.view_header.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(20, 20)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.view_header.bounds;
    maskLayer.path = maskPath.CGPath;
    self.view_header.layer.mask = maskLayer;
    
    // 设置渐变颜色
    [self.view_header.layer addSublayer:[UIColor setGradualChangingColor:self.view_header fromColor:GradientStart toColor:GradientEnd]];
    
    
    // 图2
    
    UIBezierPath *maskPath2 = [UIBezierPath bezierPathWithRoundedRect:self.view_footer.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(20, 20)];
    CAShapeLayer *maskLayer2 = [[CAShapeLayer alloc] init];
    maskLayer2.frame = self.view_footer.bounds;
    maskLayer2.path = maskPath2.CGPath;
    self.view_footer.layer.mask = maskLayer2;

    
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
    //    [iview addGestureRecognizer:tap]; // 不添加手势 不给用户点击其他地方删除该视图
    //    iview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    iview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    [[UIApplication sharedApplication].keyWindow addSubview:iview];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.center = [UIApplication sharedApplication].keyWindow.center;
    self.alpha = 0;
    self.transform = CGAffineTransformScale(self.transform,0.1,0.1);
    [UIView animateWithDuration:AlertTime animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }];
}
#pragma mark  自定义对象方法 end



@end


/**
    1、实现包含
        1.1 宏定义
            用来绑定该类里面经常使用到的字符串、常量等等
        1.2 实现系统的init方法 防止用户通过allocinit初始化
            实现系统的xib创建方法 唤醒状态 被唤醒状态
        1.3 功能实现
 
 */
