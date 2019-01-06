

#import <UIKit/UIKit.h>

@interface UIButton (LYHCategory_UIKit_UIButton)
/**
 给按钮绑定事件回调block
 
 @param block 回调的block
 @param controlEvents 回调block的事件
 */
- (void)cq_addEventHandler:(void(^)(void))block forControlEvents:(UIControlEvents)controlEvents;
@end
