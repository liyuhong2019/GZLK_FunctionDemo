/**
 参考
 - (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
 
 UICollectionReusableView *headerView;
 if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
 MGHeaderView *view = (MGHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierHeader forIndexPath:indexPath];
 view.headerLabel.text = [NSString stringWithFormat:@"MG这是header:%d",indexPath.section];
 headerView = view;
 }
 return headerView;
 }
 
 // 设置Header的尺寸
 (CGSize)collectionView:(UICollectionView )collectionView layout:(UICollectionViewLayout)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
 CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
 return CGSizeMake(screenWidth, 280);
 }
 
 
 */

#import "ViewController.h"
#import "CustomCell.h"


// 头尾
#import "CustomHeaderView.h"
#import "CustomFooterView.h"


@interface ViewController ()

@property (nonatomic,strong) NSMutableArray *photos;


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setHeaderView];
    NSLog(@"%@",self.photos);
    
    // 设置头部和 尾部
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

static NSString * const reuseIdentifierHeader = @"CustomHeaderView";
static NSString * const reuseIdentifierFooter = @"CustomFooterView";


- (void)setHeaderView
{
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CustomHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierHeader];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CustomFooterView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseIdentifierFooter];

    
}
#pragma mark 懒加载
- (NSMutableArray *)photos
{
    if (_photos == nil) {
        
        self.photos = [NSMutableArray arrayWithObjects:@"longzhu1",@"longzhu2",@"longzhu3",@"longzhu4",@"longzhu1",@"longzhu2",@"longzhu3",@"longzhu4",@"longzhu1",@"longzhu2",@"longzhu3",@"longzhu4",@"longzhu1",@"longzhu2",@"longzhu3",@"longzhu4", nil];
    }
    return _photos;
}

#pragma mark storyboary

#pragma mark collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section

{
    
    NSLog(@"___ %ld",self.photos.count);
    return self.photos.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath

{

    static NSString *ID = @"CCell";

    CustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    NSLog(@"图片 名称 %@",self.photos[indexPath.item]);
    cell.img.image = [UIImage imageNamed:self.photos[indexPath.item]];

    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@" 点击的图片名称是 %@",self.photos[indexPath.item]);
}


#pragma mark - 头尾部
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *headerView;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        CustomHeaderView *view = (CustomHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierHeader forIndexPath:indexPath];
        view.headerLabel.text = [NSString stringWithFormat:@"MG这是header:%ld",(long)indexPath.section];
        headerView = view;
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        CustomFooterView *view = (CustomFooterView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseIdentifierFooter forIndexPath:indexPath];
        view.footerLabel.text = [NSString stringWithFormat:@"LYH这是footer:%ld",(long)indexPath.section];
        headerView = view;
    }
    return headerView;
}

// 设置Header的尺寸
- (CGSize)collectionView:(UICollectionView* )collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    return CGSizeMake(screenWidth, 150);
}


- (CGSize)collectionView:(UICollectionView* )collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    return CGSizeMake(screenWidth, 150);
}
@end
