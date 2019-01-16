//
//  JFTB_PayView.m
//  JFTB_CollectionViewWithPayView_Xib
//
//  Created by lee on 2019/1/16.
//  Copyright © 2019年 lee. All rights reserved.
//

#import "JFTB_PayView.h"
#import "JFTB_PayCell.h"
#import "JFTB_PayModel.h"

#import "JFTB_PayHeaderView.h"
#import "JFTB_PayFooterView.h"

static NSString * const reuseIdentifierHeader = @"JFTB_PayHeaderView";
static NSString * const reuseIdentifierFooter = @"JFTB_PayFooterView";

@interface JFTB_PayView ()
@property (nonatomic,strong) NSMutableArray<JFTB_PayModel *> *payModelArray;
@end

@implementation JFTB_PayView

{
    CGRect tempframe;
}
//- (IBAction)closeGame:(UIButton *)closeBtn{
//
//}
#pragma mark - xib 设置 start
/**
 头像边框 收尾椭圆
 layer.cornerRadius Number 22
 layer.maskToBounds Boolean Yes
 头像设置 圆角
 
 */

#pragma mark xib 设置 end


#pragma mark - 初始化 start
//+ (instancetype)jftb_LiveHeadView {
//    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
//}
// 等待被唤醒的时候 调用
- (void)awakeFromNib
{
    [super awakeFromNib];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
// 初始化设置frame时候 调用
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        NSArray *nibs=[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
        //        self=[nibs objectAtIndex:0];
        self = [[NSBundle mainBundle]loadNibNamed:@"JFTB_PayView" owner:nil options:nil].firstObject;
        //        NSLog(@"%f",frame.size.width);
        //        NSLog(@"%f",frame.size.height);
        tempframe = frame;
        
        _jftb_collectionView.delegate = self;
        _jftb_collectionView.dataSource = self;
        
        [_jftb_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([JFTB_PayCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"JFTB_PayCell"];
   
        
        [_jftb_collectionView registerNib:[UINib nibWithNibName:@"JFTB_PayHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierHeader];
        
        [_jftb_collectionView registerNib:[UINib nibWithNibName:@"JFTB_PayFooterView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseIdentifierFooter];
        
        
        
       
        
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];     [_jftb_collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        
     
        
    }
    return self;
    
}
// 用于绘制frame的 http://www.zhimengzhe.com/IOSkaifa/334789.html
-(void)drawRect:(CGRect)rect
{
    self.frame = tempframe;
    
}


#pragma mark settings
- (void)setDataA:(NSMutableArray *)dataA
{
    _dataA = dataA;
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSDictionary *dict in dataA) {
        JFTB_PayModel *model = [[JFTB_PayModel alloc]initWithDict:dict];
        [tempArray addObject:model];
    }
    self.payModelArray = tempArray;
    
  
}

#pragma mark collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"___ %ld",self.dataA.count);
    return self.dataA.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath

{
    
    static NSString *ID = @"JFTB_PayCell";
    
    JFTB_PayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    NSLog(@"图片 名称 %@",self.dataA[indexPath.item]);
    JFTB_PayModel *model = self.payModelArray[indexPath.item];
    cell.img.image = [UIImage imageNamed:model.imageName];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (self.dataA.firstObject) {
            model.select = YES;
        }
       
    });
    NSLog(@"indexPath.row %d",indexPath.row);
    NSLog(@"self.dataA.count %d",self.dataA.count);
    
    if (indexPath.row == self.dataA.count -1 ) {
        cell.img_isSuper.hidden = NO;
    }
    else
    {
        cell.img_isSuper.hidden = YES;
    }
    
  
    
    cell.model = model;
//    cell.img.image = [UIImage imageNamed:self.dataA[indexPath.item]];
    
    return cell;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
//    JFTB_PayModel *model = self.dataA[indexPath.item];
//    NSLog(@" 点击的图片名称是 %@",model.imageName);
//
//    NSLog(@" 点击的图片名称是 %@",self.dataA[indexPath.item]);
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 先取消所有选中状态
        for (JFTB_PayModel *model in self.payModelArray) {
            model.select = NO;
        }
        // 在设置选中
        JFTB_PayModel *model = self.payModelArray[indexPath.row];
        model.select = YES;
    });
    dispatch_async(dispatch_get_main_queue(), ^{
        JFTB_PayModel *model = self.payModelArray[indexPath.row];
        NSLog(@" 点击的图片名称是 %@",model.imageName);
        [self.jftb_collectionView reloadData];
    });
//    NSLog(@"%ld-%ld",indexPath.section,indexPath.row);
    
    
    
}


#pragma mark  头尾部
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *headerView;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        JFTB_PayHeaderView *view = (JFTB_PayHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierHeader forIndexPath:indexPath];
        view.headerLabel.text = [NSString stringWithFormat:@"MG这是header:%ld",(long)indexPath.section];
        headerView = view;
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        JFTB_PayFooterView *view = (JFTB_PayFooterView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseIdentifierFooter forIndexPath:indexPath];
//        view.footerLabel.text = [NSString stringWithFormat:@"LYH这是footer:%ld",(long)indexPath.section];
        headerView = view;
    }
    return headerView;
}
- (CGSize)collectionView:(UICollectionView* )collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    return CGSizeMake(screenWidth, 170);
}
- (CGSize)collectionView:(UICollectionView* )collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    return CGSizeMake(screenWidth, 150);
}


#pragma mark item
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // 上 左 下 右
    return UIEdgeInsetsMake(10, 15,10, 15);
    
}
// 定义每个 item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"宽度 %2f",(self.jftb_collectionView.bounds.size.width-30-10)/2.0f); // 只会摆设2个 所以设置item / 2
    

    
    NSLog(@"宽度 %2f",([UIScreen mainScreen].bounds.size.width-30-10)/2.0f);
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width-30-10)/2.0f, 60);
    
}


@end
