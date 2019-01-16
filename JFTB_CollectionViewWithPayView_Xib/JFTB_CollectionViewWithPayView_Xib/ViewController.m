//
//  ViewController.m
//  JFTB_CollectionViewWithPayView_Xib
//
//  Created by lee on 2019/1/16.
//  Copyright © 2019年 lee. All rights reserved.
//

#import "ViewController.h"
#import "JFTB_PayView.h"
@interface ViewController ()
@property (nonatomic,strong) JFTB_PayView *view_payView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.view_payView];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// 1、头部
- (JFTB_PayView *)view_payView
{

    if (_view_payView == nil) {
        CGRect frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        JFTB_PayView *payView = [[JFTB_PayView alloc]initWithFrame:frame];
        
        NSDictionary *dict = @{@"imageName":@"longzhu1"};
        NSDictionary *dict2 = @{@"imageName":@"longzhu2"};
        NSDictionary *dict3 = @{@"imageName":@"longzhu3"};
        NSDictionary *dict4 = @{@"imageName":@"longzhu4"};
        NSDictionary *dict5 = @{@"imageName":@"longzhu1"};

        payView.dataA = [NSMutableArray arrayWithObjects:dict,dict2,dict3,dict4,dict5, nil];;

        
        
//        payView.dataA = [NSMutableArray arrayWithObjects:@"longzhu1",@"longzhu2",@"longzhu3",@"longzhu4",@"longzhu1",@"longzhu2",@"longzhu3",@"longzhu4",@"longzhu1",@"longzhu2",@"longzhu3",@"longzhu4",@"longzhu1",@"longzhu2",@"longzhu3",@"longzhu4", nil];;
        
        self.view_payView = payView;

    }
    return _view_payView;
}


@end
