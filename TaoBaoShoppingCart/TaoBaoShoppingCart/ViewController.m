//
//  ViewController.m
//  TaoBaoShoppingCart
//
//  Created by qhzc-iMac-02 on 2017/8/29.
//  Copyright © 2017年 Yxl. All rights reserved.
//

#import "ViewController.h"
#import "BasicDefine.h"
#import "ChooseCategoryView.h"
#import "StoreProjectDetailModule.h"

@interface ViewController ()

@property (nonatomic,strong) ChooseCategoryView *chooseView;

@property (nonatomic,strong) StoreProjectDetailModule *detailModule;

@property (nonatomic, strong) UILabel *soldOutView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self creatBottomView];
    
    [self reloadBasicInfo];
}

- (void)creatBottomView {
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 49)];
    bottomView.backgroundColor = RGBCOLOR(245, 245, 245);
    [self.view addSubview:bottomView];
    
    CGFloat itemButtonWidth = SCREEN_WIDTH/2-20;
    
    UIButton *carButton = [[UIButton alloc]initWithFrame:CGRectMake(itemButtonWidth, 0, (SCREEN_WIDTH-itemButtonWidth)/2, HEIGH(bottomView))];
    carButton.backgroundColor = RGBCOLOR(159, 200, 254);
    carButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [carButton setTitle:@"加入购物车" forState:UIControlStateNormal];
    [carButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [carButton addTarget:self action:@selector(addMallCar) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:carButton];
    
    UIButton *buyButton = [[UIButton alloc]initWithFrame:CGRectMake(RIGHT_X(carButton), 0, (SCREEN_WIDTH-itemButtonWidth)/2, HEIGH(bottomView))];
    buyButton.backgroundColor = RGBCOLOR(74, 146, 234);
    buyButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyButton addTarget:self action:@selector(buyButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:buyButton];
    
}

- (void)reloadBasicInfo {
    
    [StoreProjectDetailModule requestStoreProjectDetailModuleCompleteBlock:^(StoreProjectDetailModule *model, NSError *error) {
        [SVProgressHUD dismiss];

        _detailModule = model;
        
        _chooseView = [[ChooseCategoryView alloc]initWithBasicModel:_detailModule];
        
        if (_detailModule.productStatus != 1 ) {
            [self.view addSubview:self.soldOutView];
        }
        
    }];
}


#pragma mark------------------添加购物车--------------------------------
- (void)addMallCar {
    
    _chooseView.chooseType = 2;
    [_chooseView showInView:self.view.window];
}

#pragma mark------------------购买商品--------------------------------

- (void)buyButtonClick {
    
    _chooseView.chooseType = 3;
    
    [_chooseView showInView:self.view.window];
    
    _chooseView.block = ^(ChooseAttributeModel *model) {
        [SVProgressHUD showInfoWithStatus:@"跳转到确认订单页面"];
    };
}

- (UILabel *)soldOutView {
    if (!_soldOutView) {
        _soldOutView = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-49-30, SCREEN_WIDTH, 30)];
        _soldOutView.backgroundColor = RGBCOLOR(66, 70, 73);
        _soldOutView.text = @"已下架";
        _soldOutView.textColor = [UIColor whiteColor];
        _soldOutView.font = kTextFont_14;
        _soldOutView.textAlignment = NSTextAlignmentCenter;
    }
    return _soldOutView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
