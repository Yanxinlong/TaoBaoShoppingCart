//
//  GoodsBuyCountView.m
//  CSN
//
//  Created by qhzc-iMac-02 on 2017/5/10.
//  Copyright © 2017年 QianHaiZhongChou. All rights reserved.
//

#import "GoodsBuyCountView.h"
#import "BasicDefine.h"

@interface GoodsBuyCountView()<UITextFieldDelegate>

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UIButton *reduceButton;

@property (nonatomic,strong) UIButton *addButton;

@property (nonatomic,strong) UITextField *countField;

@end

@implementation GoodsBuyCountView



- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _maxCount = 1;
        [self initCellView];
    }
    return self;
}

-(void)setMaxCount:(NSInteger)maxCount {
    _maxCount = maxCount;
    
    if ([_countField.text integerValue] >= _maxCount) {
        _countField.text = [NSString stringWithFormat:@"%ld",_maxCount];
    }
}

- (void)initCellView {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 100, 15)];
    _titleLabel.text = @"购买数量";
    _titleLabel.font = kTextFont_15;
    [self addSubview:_titleLabel];
    
    _reduceButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-120, 15, 25, 25)];
    _reduceButton.backgroundColor = RGBCOLOR(245, 245, 245);
    [_reduceButton setImage:[UIImage imageNamed:@"icon_jian"] forState:UIControlStateNormal];
    [_reduceButton addTarget:self action:@selector(reduceButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_reduceButton];
    
    _countField = [[UITextField alloc] initWithFrame:CGRectMake(RIGHT_X(_reduceButton), 15, 45, 25)];
    _countField.font = kTextFont_14;
    _countField.delegate = self;
    _countField.keyboardType = UIKeyboardTypeNumberPad;
    _countField.textAlignment = NSTextAlignmentCenter;
    _countField.text = @"1";
    [self addSubview:_countField];
    
    _addButton = [[UIButton alloc]initWithFrame:CGRectMake(RIGHT_X(_countField), 15, 25, 25)];
    _addButton.backgroundColor = RGBCOLOR(245, 245, 245);
    [_addButton setImage:[UIImage imageNamed:@"icon_jia"] forState:UIControlStateNormal];
    [_addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addButton];
    
}

- (void)reduceButtonClick {
    if ([_countField.text integerValue] <= 1) {
        [SVProgressHUD showInfoWithStatus:@"最少选择一件商品"];
        return;
    }
    _countField.text = [NSString stringWithFormat:@"%ld",[_countField.text integerValue]-1];
    
    if (self.block) {
        self.block([_countField.text integerValue]);
    }
}

- (void)addButtonClick {
    
    if ([_countField.text integerValue] <= _maxCount && [_countField.text integerValue] >= 999) {
        [SVProgressHUD showInfoWithStatus:@"最多可购买999件"];
        return;
    }
    
    if ([_countField.text integerValue] >= _maxCount) {
        [SVProgressHUD showInfoWithStatus:@"数量超出库存 ~"];
        return;
    }
    
    _countField.text = [NSString stringWithFormat:@"%ld",[_countField.text integerValue]+1];
    
    if (self.block) {
        self.block([_countField.text integerValue]);
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if ([textField.text integerValue] < _maxCount && [textField.text integerValue] > 999) {
        [SVProgressHUD showInfoWithStatus:@"最多可购买999件"];
        _countField.text = @"999";
        return;
    }

    
    if ([textField.text integerValue] >= _maxCount) {
        [SVProgressHUD showInfoWithStatus:@"数量超出库存 ~"];
        _countField.text = [NSString stringWithFormat:@"%ld",_maxCount];
        return;
    }
    
    if ([textField.text integerValue] < 1) {
        [SVProgressHUD showInfoWithStatus:@"最少选择一件商品"];
        _countField.text = @"1";
        return;
    }
    
    if (self.block) {
        self.block([_countField.text integerValue]);
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSUInteger proposedNewLength = textField.text.length-range.length+string.length;
    
    if ((textField == _countField && proposedNewLength > 3)) {
        return NO;
    }
    
    return YES;
    
}

@end
