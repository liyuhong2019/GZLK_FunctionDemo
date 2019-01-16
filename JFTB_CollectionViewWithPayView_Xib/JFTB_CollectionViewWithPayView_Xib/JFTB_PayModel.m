//
//  JFTB_PayModel.m
//  JFTB_CollectionViewWithPayView_Xib
//
//  Created by lee on 2019/1/16.
//  Copyright © 2019年 lee. All rights reserved.
//

#import "JFTB_PayModel.h"

@implementation JFTB_PayModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)jftb_payModelWithDict:(NSDictionary *)dict
{
    JFTB_PayModel *model = [[JFTB_PayModel alloc]initWithDict:dict];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%s  %@",__func__,key);
}
@end
