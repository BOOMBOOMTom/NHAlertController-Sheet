//
//  ViewController.m
//  NHActionSheet
//
//  Created by niuhu on 17/2/14.
//  Copyright © 2017年 NiuHu. All rights reserved.
//

#import "ViewController.h"
#import "NHSheetContentView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 220, 60)];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"类似系统ActionSheet效果" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(btnOnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    
}
- (void)btnOnClick {
    
    NHSheetButton *btn1 = [[NHSheetButton alloc]initWithTitile:@"QQ" Image:[UIImage imageNamed:@"qq"] titleColor:[UIColor orangeColor] andSheetButtonAction:^(NHSheetButton *sheetButton) {
        NSLog(@"点击了 QQ");
    }];
    
    NHSheetButton *btn2 = [[NHSheetButton alloc]initWithTitile:@"Qzone" Image:[UIImage imageNamed:@"qzone"] titleColor:[UIColor orangeColor] andSheetButtonAction:^(NHSheetButton *sheetButton) {
        NSLog(@"点击了 空间");
    }];
    
    NHSheetButton *btn3 = [[NHSheetButton alloc]initWithTitile:@"朋友圈" Image:[UIImage imageNamed:@"pyq"] titleColor:[UIColor orangeColor] andSheetButtonAction:^(NHSheetButton *sheetButton) {
        NSLog(@"点击了 朋友圈");
    }];
    
    NHSheetButton *btn4 = [[NHSheetButton alloc]initWithTitile:@"豆瓣" Image:[UIImage imageNamed:@"douban"] titleColor:[UIColor orangeColor] andSheetButtonAction:^(NHSheetButton *sheetButton) {
        NSLog(@"点击了 豆瓣");
    }];
    
    NHSheetButton *btn5 = [[NHSheetButton alloc]initWithTitile:@"微信" Image:[UIImage imageNamed:@"weixin"] titleColor:[UIColor orangeColor] andSheetButtonAction:^(NHSheetButton *sheetButton) {
        NSLog(@"点击了 微信");
    }];
    NHSheetContentView *btnView = [[NHSheetContentView alloc]initWithTitle:@"测试" detailTitle:@"测试圣诞节快更合适的房间看圣诞节快更合适的卢浮宫寒暑假快乐的水电费科技感和塑料袋开花结果规划局快乐" andButtonItems:@[btn1,btn2,btn3,btn4,btn5]];
    [btnView show];
}




@end
