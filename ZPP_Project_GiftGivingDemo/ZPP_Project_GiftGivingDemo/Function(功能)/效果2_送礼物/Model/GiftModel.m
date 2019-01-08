//
//  GiftModel.m
//  ZPP_Project_GiftGivingDemo
//
//  Created by lee on 2019/1/8.
//  Copyright © 2019年 lee. All rights reserved.
//

#import "GiftModel.h"

@implementation GiftModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)giftWithDict:(NSDictionary *)dict
{
    GiftModel *model = [[GiftModel alloc]initWithDict:dict];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    //    NSLog(@"%s  %@",__func__,key);
}
@end
