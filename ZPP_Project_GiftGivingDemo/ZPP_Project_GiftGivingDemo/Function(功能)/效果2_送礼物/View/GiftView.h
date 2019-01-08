
#import <UIKit/UIKit.h>
@class GiftView;
@class GiftModel;
@protocol GiftViewDelegate <NSObject>
@required
@optional
- (void)Click_GiftViewDelegate:(GiftView *)view WithModel:(GiftModel *)model; // 可选的方法
@end

@interface GiftView : UIView
#pragma mark - 1.2、属性(控件、自定义) start
/*******控件属性 start *****/
@property (weak, nonatomic) IBOutlet UIButton *click_gift;
@property (weak, nonatomic)  GiftModel *model;
/*******控件属性 end *****/

/*******自定义属性 start *****/
@property(nonatomic,weak)id <GiftViewDelegate> giftViewDelegate; // 代理属性
/*******自定义属性 end *****/
#pragma mark   1.2、属性(控件、自定义)  end
#pragma mark - 1.3、类方法 start
/** 1、提供类方法:用于快速创建视图 */
+ (instancetype)giftView;
#pragma mark  1.3、类方法 end
@end
