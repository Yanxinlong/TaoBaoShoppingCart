//
//  GoodsCatagoryView.m
//  CSN
//
//  Created by qhzc-iMac-02 on 2017/5/10.
//  Copyright © 2017年 QianHaiZhongChou. All rights reserved.
//

#import "GoodsCatagoryView.h"
#import "StoreProjectDetailModule.h"
#import "BasicDefine.h"

@interface GoodsCatagoryView()

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UIView *buttonListView;

@property (nonatomic,strong) NSMutableArray *buttonModelArray;

@property (nonatomic,strong) StoreProjectAttributeModule *attributeModel;

@end

@implementation GoodsCatagoryView


- (instancetype)initWithFrame:(CGRect)frame withAttributeModule:(StoreProjectAttributeModule *)model withIdx:(NSInteger)idx {
    if (self = [super initWithFrame:frame]) {
        _buttonModelArray = [NSMutableArray array];
        _attributeModel = model;
        [self initCellView];
    }
    return self;

}

- (void)initCellView {
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH-30, 15)];
    _titleLabel.textColor = [UIColor lightGrayColor];
    _titleLabel.font = kTextFont_14;
    [self addSubview:_titleLabel];
    
    
    _buttonListView = [[UIView alloc] initWithFrame:CGRectMake(15, BOTTOM_Y(_titleLabel)+20, SCREEN_WIDTH-30, 20)];
    [self addSubview:_buttonListView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, HEIGH(self)-1, SCREEN_WIDTH-15, 1)];
    lineView.backgroundColor = RGBCOLOR(227, 227, 229);
    [self addSubview:lineView];
    
//    [self fillCellWithStoreProjectAttributeModule:_attributeModel];
}

- (void)fillCellWithStoreProjectAttributeModule:(StoreProjectAttributeModule *)model {
    _titleLabel.text = model.attributeName;
    
    for (UIView *subView in _buttonListView.subviews) {
        [subView removeFromSuperview];
    }
    
    NSMutableArray *buttonArray =  model.attributeValues;
    _buttonModelArray = model.attributeValues;
    if ([buttonArray count] > 0) {
        
        int i = 0;
        int tagIdex = 0;
        CGFloat width = 0;
        
        
        for (GoodsAttrValueModel *model in buttonArray) {
            
            CGFloat buttonWidth = [Unit widthForLabelWithContent:model.attrValue withHeight:30 withFontSize:14] + 20;
            
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(width, 40*i, buttonWidth, 30)];
            btn.enabled = model.isCanSelect;
            btn.selected = model.isSelect;
            btn.titleLabel.font = kTextFont_13;
            btn.tag = 1000 + tagIdex;
            btn.layer.cornerRadius = 4;
            btn.layer.masksToBounds = YES;
            [btn setTitle:model.attrValue forState:UIControlStateNormal];
            
//            NSLog(@"%@-----是否可以选%d",model.attrValue,model.isCanSelect);
            
            
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            
            [btn setTitleColor:RGBCOLOR(204, 204, 204) forState:UIControlStateDisabled];
            
            [btn setBackgroundImage:[UIImage imageNamed:@"icon_attributeNormal"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"icon_attributeSelect"] forState:UIControlStateSelected];
            [btn setBackgroundImage:[UIImage imageNamed:@"icon_attributeNormal"] forState:UIControlStateDisabled];
            
            [btn addTarget:self action:@selector(buttonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
            [_buttonListView addSubview:btn];
            
            ++tagIdex;
            
            /** < 记录当前累计按钮长度 > **/
            width += buttonWidth+10;
            
            
            /** < 判断下一个按钮宽度是否能续到当前行后面，不行的话跳转到下一行 > **/
            GoodsAttrValueModel * nextModel;
            if (tagIdex < [buttonArray count]) {
                nextModel = buttonArray[tagIdex];
            }
            
            CGFloat nextButtonWidth = [Unit widthForLabelWithContent:nextModel.attrValue withHeight:30 withFontSize:14] + 20;
            
            if (SCREEN_WIDTH - 30 - width < nextButtonWidth) {
                ++i;
                width = 0;
            }
        }
        
        _buttonListView.frame = CGRectMake(15, BOTTOM_Y(_titleLabel)+20, SCREEN_WIDTH-30, 40 * (i+1));
        
    }
}

- (void)buttonClickEvent:(UIButton *)sender {
    BOOL status = sender.isSelected;
    
    for (NSInteger i = 0; i < [_buttonModelArray count]; ++i) {
        UIButton *btn = [self viewWithTag:1000 + i];
        btn.selected = NO;
        
        
        GoodsAttrValueModel *model = _buttonModelArray[i];
        model.isSelect = NO;
    }
    sender.selected = !status;
    
    GoodsAttrValueModel *selectModel = _buttonModelArray[sender.tag-1000];
    selectModel.isSelect = sender.selected;
    
//    NSLog(@"%d",selectModel.isSelect);
//    
//    NSLog(@"%ld",_cellIdx);
    
    if (self.block) {
        self.block(selectModel,_cellIdx);
    }
    
}


@end
