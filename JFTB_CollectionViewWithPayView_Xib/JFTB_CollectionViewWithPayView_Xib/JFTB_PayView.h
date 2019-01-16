//
//  JFTB_PayView.h
//  JFTB_CollectionViewWithPayView_Xib
//
//  Created by lee on 2019/1/16.
//  Copyright © 2019年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JFTB_PayView : UIView
<UICollectionViewDelegate,
UICollectionViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataA;
@property (weak, nonatomic) IBOutlet UICollectionView *jftb_collectionView;

@end
