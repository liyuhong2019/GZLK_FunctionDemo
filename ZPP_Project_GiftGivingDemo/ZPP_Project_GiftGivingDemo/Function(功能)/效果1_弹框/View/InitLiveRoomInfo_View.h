#import <UIKit/UIKit.h>
/**
 一、
 @class 是用来告诉编译器 说明 这个类的.h文件 系统有 InitLiveRoomInfo_View这个类 。
 使用到该类额时候 到.m里面的时候 就需要#import该类 。这样是提高性能并且防止循环引用
 */
@class InitLiveRoomInfo_View;

/**
 二、创建一个代理 并且设置代理的必须实现方法和可选方法
    必须实现 关键字 @required
    可选实现 关键字 @optional
    创建代理 使用关键字 @protocol 声明一个代理
 
 规则:
        1、以类开头 并且以Delegate字眼结尾 这样能清楚描述这个是一个代理
        2、方法名 最好传递一个当前类回去。这个在控制器里面遵循这个代理时。可以拿到该类。并且能使用该类.h里面声明的属性和方法
        3、方法名最好见名知意
            CloseView_InitLiveRoomInfo_ViewDelegate // 关闭视图的代理
        4、定义一个代理属性
            属性必须是 weak声明 防止循环引用
            id类型 表示任何对象都能设置他的代理
 
 */
#pragma mark - 1.1、代理方法 start
@protocol InitLiveRoomInfo_ViewDelegate <NSObject>
@required
//- (void)function1InitLiveRoomInfo_ViewDelegate:(InitLiveRoomInfo_View *)view; // 必须实现的方法
@optional
- (void)CloseView_InitLiveRoomInfo_ViewDelegate:(InitLiveRoomInfo_View *)view; // 可选的方法
@end
#pragma mark  1.1、代理方法 end


@interface InitLiveRoomInfo_View : UIView

#pragma mark - 1.2、属性(控件、自定义) start
/*******控件属性 start *****/
@property (weak, nonatomic) IBOutlet UIView *view_header;
@property (weak, nonatomic) IBOutlet UIView *view_footer;
@property (weak, nonatomic) IBOutlet UIButton *btn_confirm;


/*******控件属性 end *****/

/*******自定义属性 start *****/
@property(nonatomic,weak)id <InitLiveRoomInfo_ViewDelegate> initLiveRoomInfo_ViewDelegate; // 代理属性
/*******自定义属性 end *****/
#pragma mark   1.2、属性(控件、自定义)  end


#pragma mark - 1.3、类方法 start
/** 1、提供类方法:用于快速创建视图 */
+ (instancetype)initLiveRoomInfo_View;
#pragma mark  1.3、类方法 end

#pragma mark - 1.4、对象方法 start
//弹出
-(void)show;
//隐藏
-(void)hide;
#pragma mark  1.4、对象方法 end

@end


/**
  1、xib创建控件 包含
    1.1、代理
    1.2 属性
    1.3 xib快速创建的类方法
    1.4 弹框的隐藏、显示方法
 */
