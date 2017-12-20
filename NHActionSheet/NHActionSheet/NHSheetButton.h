//
//  NHSheetButton.h
//  NHActionSheet
//
//  Created by niuhu on 17/2/14.
//  Copyright © 2017年 NiuHu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NHSheetButton;
typedef void (^sheetButtonAction) (NHSheetButton *sheetButton);

@interface NHSheetButton : UIButton
//按钮的高度 默认50
@property (nonatomic,assign)CGFloat buttonHeight;
//点击响应
@property (nonatomic,copy)sheetButtonAction buttonAction;
/**
 *  初始化方法
 *
 *  @param title             title
 *  @param image             image
 *  @param titleColor        titleColor
 *  @param sheetBtnAction    点击处理
 *
 *  @return return value description
 */
- (instancetype)initWithTitile:(NSString *)title Image:(UIImage *)image titleColor:(UIColor *)titleColor andSheetButtonAction:(sheetButtonAction)sheetBtnAction;
/**
 *  初始化方法
 *
 *  @param title             title
 *  @param titleColor        titleColor
 *  @param sheetBtnAction    点击处理
 *
 *  @return return value description
 */
- (instancetype)initWithTitile:(NSString *)title titleColor:(UIColor *)titleColor andSheetButtonAction:(sheetButtonAction)sheetBtnAction;
/**
 *  初始化方法
 *
 *  @param title             title
 *  @param sheetBtnAction    点击处理
 *
 *  @return return value description
 */
- (instancetype)initWithTitile:(NSString *)title  andSheetButtonAction:(sheetButtonAction)sheetBtnAction;
@end
