//
//  UIColor+LYHCategory_UIKit_UIColor.h
//  ZPP_Project_GiftGivingDemo
//
//  Created by lee on 2019/1/6.
//  Copyright © 2019年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LYHCategory_UIKit_UIColor)
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr;
+ (UIColor *)colorWithHex:(NSString *)hexColor;
@end
