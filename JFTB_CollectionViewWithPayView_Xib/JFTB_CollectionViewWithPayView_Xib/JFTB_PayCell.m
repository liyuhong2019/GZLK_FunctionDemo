//
//  JFTB_PayCell.m
//  JFTB_CollectionViewWithPayView_Xib
//
//  Created by lee on 2019/1/16.
//  Copyright © 2019年 lee. All rights reserved.
//

#import "JFTB_PayCell.h"
#import "JFTB_PayModel.h"
@implementation JFTB_PayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setModel:(JFTB_PayModel *)model
{
    _model = model;
    
    if (model.select) {
        [self.view_content setBackgroundColor:[UIColor colorWithRed:198.0/255.0 green:155.0/255.0 blue:81.0/255.0 alpha:1]];
    }
    else
    {
//        [self.img_seleteState setImage:[UIImage imageNamed:@"充值_选择勾框"]];
        [self.view_content setBackgroundColor:[UIColor colorWithRed:58.0/255.0 green:44/255.0 blue:25.0/255.0 alpha:1]];
    }
    
}

@end
