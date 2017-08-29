//
//  ChooseCategoryView.h
//  CSN
//
//  Created by qhzc-iMac-02 on 2017/4/15.
//  Copyright © 2017年 QianHaiZhongChou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StoreProjectDetailModule;
@class ChooseAttributeModel;

typedef void(^ChooseCategoryBlock)(ChooseAttributeModel *model);

@interface ChooseCategoryView : UIView

@property (nonatomic,copy) ChooseCategoryBlock block;

/**
 *  1.详情查看  2.加入购物车  3.购买
 **/
@property (nonatomic,assign) NSInteger chooseType;

/**
 *  默认显示选择的属性
 **/
@property (nonatomic,strong) NSString *catageString;


/**
 *  显示属性选择视图
 *
 *  @param view 要在哪个视图中显示
 */
- (void)showInView:(UIView *)view;
/**
 *  属性视图的消失
 */
- (void)removeView;

-(instancetype)initWithBasicModel:(StoreProjectDetailModule *)model;

@end
