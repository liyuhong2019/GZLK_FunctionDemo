//
//  JFTB_PayModel.h
//  JFTB_CollectionViewWithPayView_Xib
//
//  Created by lee on 2019/1/16.
//  Copyright © 2019年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JFTB_PayModel : NSObject
@property (nonatomic,strong) NSString *imageName;

// 用来标记是不是选中的
@property (nonatomic,assign) BOOL select;

- (instancetype)initWithDict:(NSDictionary *)dict;
/** 工厂方法 */
+ (instancetype)jftb_payModelWithDict:(NSDictionary *)dict;
@end
