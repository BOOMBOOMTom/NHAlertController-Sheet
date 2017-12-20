//
//  NHSheetContentView.h
//  NHActionSheet
//
//  Created by niuhu on 17/2/14.
//  Copyright © 2017年 NiuHu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NHSheetButton.h"
@interface NHSheetContentView : UIView

//取消按钮高度
@property (nonatomic,assign)CGFloat         cancelBtnHeight;
//btn之间的分割线高度 默认2
@property (nonatomic,assign)CGFloat         seperaLineHeight;
//btn距离屏幕的左右间隔
@property (nonatomic,assign)CGFloat         margin;
//圆角半径
@property (nonatomic,assign)CGFloat         cornerRadius;

/**
 *  初始化方法
 *
 *  @param title        主标题
 *  @param detailTtile  详情title
 *  @param buttonItems  包含按钮的数组
 *
 *  @return return value description
 */
- (instancetype)initWithTitle:(NSString *)title detailTitle:(NSString *)detailTtile andButtonItems:(NSArray <NHSheetButton *>*)buttonItems;
/**
 *  初始化方法
 *
 *  @param title        主标题
 *  @param buttonItems  包含按钮的数组
 *
 *  @return return value description
 */
- (instancetype)initWithTitle:(NSString *)title andButtonItems:(NSArray <NHSheetButton *>*)buttonItems;
//展示
- (void)show;
//隐藏
- (void)hide;
@end
