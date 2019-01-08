//
//  GiftModel.h
//  ZPP_Project_GiftGivingDemo
//
//  Created by lee on 2019/1/8.
//  Copyright © 2019年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GiftModel : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *type;

- (instancetype)initWithDict:(NSDictionary *)dict;
/** 工厂方法 */
+ (instancetype)giftWithDict:(NSDictionary *)dict;
@end
