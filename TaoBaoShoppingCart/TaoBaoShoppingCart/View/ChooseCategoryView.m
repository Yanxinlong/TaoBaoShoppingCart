//
//  ChooseCategoryView.m
//  CSN
//
//  Created by qhzc-iMac-02 on 2017/4/15.
//  Copyright © 2017年 QianHaiZhongChou. All rights reserved.
//

#import "ChooseCategoryView.h"
#import "StoreProjectDetailModule.h"
#import "ChooseAttributeModel.h"

#import "GoodsCatagoryView.h"
#import "GoodsBuyCountView.h"

@interface ChooseCategoryView()

@property (nonatomic,strong) UIView *whiteView;

@property (nonatomic,strong) UILabel *priceLabel;

@property (nonatomic,strong) UILabel *countLabel;

@property (nonatomic,strong) UILabel *categoryLabel;

@property (nonatomic,strong) UIButton *sureButton;

@property (nonatomic,strong) StoreProjectDetailModule *detailModule;

@property (nonatomic,strong) NSMutableArray *categoryArray;

@property (nonatomic,strong) NSMutableArray *cateViewArray;

@property (nonatomic,strong) NSMutableArray *titleArray;
/**
 *  库存
 **/
@property (nonatomic,assign) NSInteger inventoryCount;

@property (nonatomic,assign) NSInteger hadChooseCount;

/**
 *  价格
 **/
@property (nonatomic,assign) CGFloat goodsPrice;

/**
 *  筛选数组
 **/
@property (nonatomic,strong) NSMutableArray *sortArray;

/**
 *  有存货的属性组合
 **/
@property (nonatomic,strong) NSMutableArray *countRightGroupArray;

@property (nonatomic,strong) NSMutableArray *hadSelectArray;


@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) GoodsBuyCountView *countCell;

/**
 *  存储cell
 **/
@property (nonatomic,strong) NSMutableArray *cellViewArray;

@end

@implementation ChooseCategoryView


-(instancetype)initWithBasicModel:(StoreProjectDetailModule *)model {
    if (self = [super init]) {
        _detailModule = model;
        _categoryArray = [NSMutableArray arrayWithArray:_detailModule.attributeList];
        
        _cateViewArray = [NSMutableArray arrayWithArray:_detailModule.valueGroupList];
        
        _countRightGroupArray = [NSMutableArray array];
        
        _cellViewArray = [NSMutableArray array];
        
        for (StoreProjectValueGroupModule *grounModel in _detailModule.valueGroupList) {
            
            if (grounModel.totalNumber - grounModel.sellNumber > 0) {
                // *  将符合条件的先存起来
                [_countRightGroupArray addObject:grounModel];
            }
        }
        NSLog(@"符合条件的数量%ld",[_countRightGroupArray count]);
        _hadSelectArray = [NSMutableArray array];
        for (NSInteger i = 0; i < [_categoryArray count]; ++i) {
            GoodsAttrValueModel *newModel = [[GoodsAttrValueModel alloc] init];
            newModel.attrValue = @"null";
            [_hadSelectArray addObject:newModel];
        }
        
        
        
        _titleArray = [NSMutableArray array];
        
        
        _sortArray = [NSMutableArray arrayWithArray:_countRightGroupArray];
        
        _hadChooseCount = 1;
        
        [self initView];
        
    }
    return self;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 98, SCREEN_WIDTH, SCREEN_HEIGHT*3/4-50-98)];
        
    }
    return _scrollView;
}

- (void)initView {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    
    UIView *hiddenView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    hiddenView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    
    hiddenView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeView)];
    [hiddenView addGestureRecognizer:tap];
    [self addSubview:hiddenView];
    
    _whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT*3/4)];
    _whiteView.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    [self addSubview:_whiteView];
    
    [self creatHeaderFooterView];
    
    [_whiteView addSubview:self.scrollView];
    
    [self creatScrollView];
    
    [self sortIsCanSelectAttribute];
    
}

- (void)creatScrollView {
    CGFloat scrollHeight = 0;
    __weak typeof(self) weakSelf = self;
    
    for (NSInteger i = 0; i < [_categoryArray count]; ++i) {
        StoreProjectAttributeModule *model = _categoryArray[i];
        
        
        GoodsCatagoryView *cateView = [[GoodsCatagoryView alloc] initWithFrame:CGRectMake(0, scrollHeight, SCREEN_WIDTH, model.cellHeight)
                                                           withAttributeModule:model withIdx:i];
        
        cateView.cellIdx = i;
        cateView.block = ^(GoodsAttrValueModel *attModel,NSInteger cellIdx) {
            [weakSelf reloadAttributeButton:attModel idx:cellIdx];
        };
        
        
        scrollHeight += model.cellHeight;
        
        [self.scrollView addSubview:cateView];
        [_cellViewArray addObject:cateView];
    }
    
    _countCell =[[GoodsBuyCountView alloc]initWithFrame:CGRectMake(0, scrollHeight, SCREEN_WIDTH, 55)];
    
    _countCell.maxCount = _detailModule.productNum - _detailModule.purchaseNum;
    
    _countCell.block = ^(NSInteger count) {
        _hadChooseCount = count;
    };
    
    [self.scrollView addSubview:_countCell];
    
    scrollHeight += 155;
    
    
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, scrollHeight);
    
}

- (void)setChooseType:(NSInteger)chooseType {
    _chooseType = chooseType;
}

- (void)setCatageString:(NSString *)catageString {
    _catageString = catageString;
    _categoryLabel.text = _catageString;
}

- (void)creatHeaderFooterView {
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, -35, 120, 120)];
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.layer.cornerRadius = 3;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.layer.borderColor = kColor_Eight.CGColor;
    imageView.layer.borderWidth = 0.6;
    imageView.layer.masksToBounds = YES;
    
    NSArray *imageArray = [_detailModule.imgList componentsSeparatedByString:@","];
    if (imageArray.count > 0) {
        imageView.backgroundColor = [UIColor redColor];
    }
    
    [_whiteView addSubview:imageView];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(RIGHT_X(imageView)+15, 15, SCREEN_WIDTH-150, 15)];
    _priceLabel.textColor = RGBCOLOR(255, 0, 0);
    _priceLabel.font = kTextFont_15;
    _priceLabel.text = [NSString stringWithFormat:@"¥ %@",_detailModule.price];
    [_whiteView addSubview:_priceLabel];
    
    _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(RIGHT_X(imageView)+15, BOTTOM_Y(_priceLabel)+10, SCREEN_WIDTH-150, 15)];
    _countLabel.font = kTextFont_14;
    _countLabel.textColor = [UIColor blackColor];
    _countLabel.text = [NSString stringWithFormat:@"库存%ld件",_detailModule.productNum - _detailModule.purchaseNum];
    [_whiteView addSubview:_countLabel];
    
    _inventoryCount = _detailModule.productNum - _detailModule.purchaseNum;
    
    NSMutableArray *array = [NSMutableArray array];
    for (StoreProjectAttributeModule *model in _detailModule.attributeList) {
        [array addObject:model.attributeName];
        [_titleArray addObject:@" "];
    }
    _catageString = [NSString stringWithFormat:@"选择： %@",[array componentsJoinedByString:@"，"]];
    
    CGFloat cateHeight = [Unit heightWithString:_catageString font:kTextFont_14 constrainedToWidth:SCREEN_WIDTH-150];
    cateHeight = cateHeight > 40 ? 40 : cateHeight;
    _categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(RIGHT_X(imageView)+15, BOTTOM_Y(_countLabel)+5, SCREEN_WIDTH-150, cateHeight)];
    _categoryLabel.font = kTextFont_14;
    _categoryLabel.textColor = [UIColor blackColor];
    
    _categoryLabel.numberOfLines = 0;
    _categoryLabel.text = _catageString;
    [_whiteView addSubview:_categoryLabel];
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, BOTTOM_Y(imageView)+12, SCREEN_WIDTH-15, 1)];
    lineView.backgroundColor = kColor_Eight;
    [_whiteView addSubview:lineView];
    
    _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sureButton.frame = CGRectMake(0, BOTTOM_Y(self.scrollView), SCREEN_WIDTH, 50);
    [_sureButton setTitle:@"完成" forState:UIControlStateNormal];
    [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sureButton setBackgroundColor:RGBCOLOR(159, 200, 255)];
    
    [_sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_whiteView addSubview:_sureButton];
    
}

- (void)sureButtonClick {
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSInteger i = 0; i < [_detailModule.attributeList count]; ++i) {
        StoreProjectAttributeModule *model = _detailModule.attributeList[i];
        if ([@" " isEqualToString:_titleArray[i]]) {
            [array addObject:model.attributeName];
        }
    }
    
    if ([array count] > 0) {
        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"请选择：%@",[array componentsJoinedByString:@" "]]];
        return;
    }
    
    if (_inventoryCount <= 0) {
        [SVProgressHUD showInfoWithStatus:@"暂时缺货，请选择其他款式"];
        return;
    }
    
    switch (_chooseType) {
        case 1://查看
            [self chooseAtt];
            break;
        case 2://加入购物车
            [self addInCar];
            break;
        case 3://购买
            [self buy];
            break;
            
            
        default:
            break;
    }
}

- (void)buy {
    [self removeView];
    [self sendAttributeNotification];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [_titleArray componentsJoinedByString:@","],@"valueGroup",
                         [NSString stringWithFormat:@"%ld",_hadChooseCount],@"num",
                         [NSString stringWithFormat:@"%ld",_detailModule.productId],@"productId",nil];
    
    ChooseAttributeModel *attriModel = [[ChooseAttributeModel alloc]init];
    [attriModel setValuesForKeysWithDictionary:dic];
    
    if (self.block) {
        self.block(attriModel);
    }
}

- (void)addInCar {
    [SVProgressHUD showInfoWithStatus:@"添加进购物车"];
    [self removeView];
    [self sendAttributeNotification];
}

- (void)chooseAtt {
    [self sendAttributeNotification];
    [self removeView];
}

- (void)sendAttributeNotification {
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [_titleArray componentsJoinedByString:@","],@"valueGroup",
                         [NSString stringWithFormat:@"%ld",_hadChooseCount],@"num",
                         [NSString stringWithFormat:@"%ld",_detailModule.productId],@"productId",nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeAttributeNotification" object:nil userInfo:dic];
    
}

- (void)showInView:(UIView *)view {
    [view addSubview:self];
    __weak typeof(self) _weakSelf = self;
    _whiteView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT*3/4);
    
    [UIView animateWithDuration:0.3 animations:^{
        _weakSelf.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        _whiteView.frame = CGRectMake(0, SCREEN_HEIGHT/4, SCREEN_WIDTH, SCREEN_HEIGHT*3/4);
    }];
}

- (void)removeView {
    __weak typeof(self) _weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        _weakSelf.backgroundColor = [UIColor clearColor];
        _whiteView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT*3/4);
    } completion:^(BOOL finished) {
        [_weakSelf removeFromSuperview];
    }];
}


- (void)sortIsCanSelectAttribute {
    
    for (NSInteger i = 0; i < [_categoryArray count]; ++i) {//每个属性循环一次
        StoreProjectAttributeModule *smodel = _categoryArray[i];
        //        NSLog(@"外层循环---%ld--%@",i,smodel.attributeName);
        
        for (GoodsAttrValueModel *newModel in smodel.attributeValues) {//循环这个属性所有值
            
            //            NSLog(@"---比较某类属性---%@",newModel.attrValue);
            
            NSMutableArray *newArray = [NSMutableArray arrayWithArray:_hadSelectArray];
            
            [newArray replaceObjectAtIndex:i withObject:newModel];
            
            BOOL aa = [self compareSingleMapToGroups:newArray];
            
            newModel.isCanSelect =  aa;
        }
        
        GoodsCatagoryView *cateView = _cellViewArray[i];
        [cateView fillCellWithStoreProjectAttributeModule:smodel];
    }
    
}

- (BOOL)compareSingleMapToGroups:(NSMutableArray *)singleArray {
    
    for (StoreProjectValueGroupModule *groupModel in _countRightGroupArray) {
        NSInteger i = 0;
        for (; i < [groupModel.valueGroup count]; ++i) {
            
            GoodsAttrValueModel *compareModel = singleArray[i];
            
            GoodsAttrValueModel *newModel = groupModel.valueGroup[i];
            //            NSLog(@"开始比第%ld个属性",i)
            
            if((![compareModel.attrValue isEqualToString:newModel.attrValue] && ![compareModel.attrValue isEqualToString:@"null"])) {
                break;
            }
        }

        if(i == singleArray.count && (groupModel.totalNumber - groupModel.sellNumber > 0)) {
            
            return YES;
        }
        
    }
    return NO;
    
}

- (void)reloadAttributeButton:(GoodsAttrValueModel *)model idx:(NSInteger)cellIdx {
    
    if ([_detailModule.valueGroupList count] <= 0) {
        return;
    } else {
        StoreProjectValueGroupModule *groupModel = _detailModule.valueGroupList[0];
        if ([groupModel.valueGroup count] != [_detailModule.attributeList count]) {
            return;
        }
    }
    
    if (model.isSelect) {
        [_hadSelectArray replaceObjectAtIndex:cellIdx withObject:model];
    } else {
        GoodsAttrValueModel *newModel = [[GoodsAttrValueModel alloc] init];
        newModel.attrValue = @"null";
        [_hadSelectArray replaceObjectAtIndex:cellIdx withObject:newModel];
    }
    
    [self sortIsCanSelectAttribute];
    
    /**
     *  数据填充页面
     **/
    
    [_titleArray replaceObjectAtIndex:cellIdx withObject:model.isSelect ? model.attrValue : @" "];
    
    NSMutableArray *newArray = [NSMutableArray array];
    for (NSString *title in _titleArray) {
        if ([title length] > 0 && ![title isEqualToString:@" "]) {
            [newArray addObject:title];
        }
    }
    
    _categoryLabel.text = [NSString stringWithFormat:@"选择： %@",[newArray componentsJoinedByString:@"，"]];
    
    if ([newArray count] > 0) {
        [_sureButton setEnabled:YES];
    } else {
        _categoryLabel.text = _catageString;
        [_sureButton setBackgroundColor:RGBCOLOR(159, 200, 255)];
    }
    
    
    if ([newArray count] == 0) {
        _categoryLabel.text = _catageString;
        [_sureButton setBackgroundColor:RGBCOLOR(159, 200, 255)];
    } else if ([newArray count] < [_categoryArray count]) {
        [_sureButton setBackgroundColor:RGBCOLOR(159, 200, 255)];
    } else {
        [_sureButton setBackgroundColor:kColor_skyBlue];
    }
    
    
    
    NSMutableArray *lastArray = [NSMutableArray array];
    
    for (NSString *title in _titleArray) {
        if (![title isEqualToString:@" "]) {
            [lastArray addObject:title];
        }
    }
    
    if ([lastArray count] == [_titleArray count]) {
        NSString *compareString = [lastArray componentsJoinedByString:@","];
        for (StoreProjectValueGroupModule *gModel in _detailModule.valueGroupList) {
            if ([gModel.valueGroupString isEqualToString:compareString]) {
                gModel.isSelect = YES;
                //                NSLog(@"%@",compareString);
                
                _inventoryCount = gModel.totalNumber - gModel.sellNumber;
                _goodsPrice = gModel.price;
                
                _countLabel.text = [NSString stringWithFormat:@"库存%ld件",_inventoryCount];
                
                
                _priceLabel.text = [NSString stringWithFormat:@"¥ %@",[Unit changePrice:_goodsPrice]];
                
            }
        }
        
    }
    
    _countCell.maxCount = _inventoryCount;
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"dddddd");
        GoodsCatagoryView *cateView = _cellViewArray[cellIdx];
        
        StoreProjectAttributeModule *smodel = _categoryArray[cellIdx];
        
        [cateView fillCellWithStoreProjectAttributeModule:smodel];
    });
}


@end
