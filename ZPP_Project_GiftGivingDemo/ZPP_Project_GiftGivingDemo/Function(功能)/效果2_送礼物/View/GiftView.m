
#import "GiftView.h"
#import "GiftModel.h"
@implementation GiftView
{
    CGRect tempframe;
}
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
        self = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
        //        NSLog(@"%f",frame.size.width);
        //        NSLog(@"%f",frame.size.height);
        [self.click_gift addTarget:self action:@selector(selectGift:) forControlEvents:UIControlEventTouchUpInside];
        
        tempframe = frame;
    }
    return self;
}

- (void)selectGift:(UIButton *)btn
{
    NSLog(@"选择礼物 %@ type %@",self.model.name,self.model.type);
    if ([self.giftViewDelegate respondsToSelector:@selector(Click_GiftViewDelegate:WithModel:)]) {
        [self.giftViewDelegate Click_GiftViewDelegate:self WithModel:self.model];
    }
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
    NSLog(@"%@",self);
}
#pragma mark 重新绘制frame
// 用于绘制frame的 http://www.zhimengzhe.com/IOSkaifa/334789.html
-(void)drawRect:(CGRect)rect
{
    self.frame = tempframe;
    
}
#pragma  alloc init 和 xib 初始化的时候 调用的方法 end

- (void)setModel:(GiftModel *)model
{
    _model = model;
    NSLog(@"model name %@",model.name);
    
}
+ (instancetype)giftView
{
    // 通过软件的包 去加载xib名字为 该类的名字的xib文件 并且加载的是xib的第一个视图
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

@end
