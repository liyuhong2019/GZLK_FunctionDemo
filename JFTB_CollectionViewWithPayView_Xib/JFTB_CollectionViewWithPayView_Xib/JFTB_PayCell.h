//
//  JFTB_PayCell.h
//  JFTB_CollectionViewWithPayView_Xib
//
//  Created by lee on 2019/1/16.
//  Copyright © 2019年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JFTB_PayModel;
@interface JFTB_PayCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIImageView *img_isSuper; // 超值
@property (weak, nonatomic) IBOutlet UIView *view_content;
@property (strong,nonatomic) JFTB_PayModel *model;
@end
