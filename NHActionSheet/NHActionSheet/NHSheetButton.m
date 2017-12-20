//
//  NHSheetButton.m
//  NHActionSheet
//
//  Created by niuhu on 17/2/14.
//  Copyright © 2017年 NiuHu. All rights reserved.
//

#import "NHSheetButton.h"

@interface NHSheetButton ()

@property (nonatomic,copy)NSString *title;

@end

@implementation NHSheetButton
- (instancetype)initWithTitile:(NSString *)title Image:(UIImage *)image titleColor:(UIColor *)titleColor andSheetButtonAction:(sheetButtonAction)sheetBtnAction{
    if (self = [super init]) {
        if (title) {
            [self setTitle:title forState:UIControlStateNormal];
        }
        if (image) {
            [self setImage:image forState:UIControlStateNormal];
            // 设置图片和文字的间距 20
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        }
        if (titleColor) {
            [self setTitleColor:titleColor forState:UIControlStateNormal];
        }
        _buttonHeight = 70;
        _buttonAction = [sheetBtnAction copy];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (instancetype)initWithTitile:(NSString *)title titleColor:(UIColor *)titleColor andSheetButtonAction:(sheetButtonAction)sheetBtnAction{

    return [self initWithTitile:title Image:nil titleColor:titleColor andSheetButtonAction:sheetBtnAction];;
}
- (instancetype)initWithTitile:(NSString *)title  andSheetButtonAction:(sheetButtonAction)sheetBtnAction{
    
    return [self initWithTitile:title Image:nil titleColor:[UIColor blackColor] andSheetButtonAction:sheetBtnAction];;
}
@end
