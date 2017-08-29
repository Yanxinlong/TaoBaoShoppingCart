//
//  ChooseAttributeModel.m
//  CSN
//
//  Created by qhzc-iMac-02 on 2017/4/20.
//  Copyright © 2017年 QianHaiZhongChou. All rights reserved.
//

#import "ChooseAttributeModel.h"

@implementation ChooseAttributeModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"%@类这个字段没有定义%@",[NSString stringWithUTF8String:object_getClassName(self)],key);
    
}

@end
