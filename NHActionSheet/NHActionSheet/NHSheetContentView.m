//
//  NHSheetContentView.m
//  NHActionSheet
//
//  Created by niuhu on 17/2/14.
//  Copyright © 2017年 NiuHu. All rights reserved.
//

#import "NHSheetContentView.h"

@interface NHSheetContentView ()<UIGestureRecognizerDelegate>
//取消按钮
@property (nonatomic,strong)NHSheetButton * cancelButton;
//提示文字Label
@property (nonatomic,strong)UILabel       * titleLabel;
//title的高度
@property (nonatomic,assign)CGFloat         titleHeight;
//详情文字Label
@property (nonatomic,strong)UILabel       * detailLabel;
//detail的高度
@property (nonatomic,assign)CGFloat         detailHeight;
//顶部放置label的view
@property (nonatomic,strong)UIView        * headerView;
//headerView的高度
@property (nonatomic,assign)CGFloat         headerViewHeight;
//放置buttond的view
@property (nonatomic,strong)UIView        * contentView;
//contentView的高度
@property (nonatomic,assign)CGFloat         contentViewHeight;
//title
@property (nonatomic,copy)  NSString      * titleString;
//detail
@property (nonatomic,copy)  NSString      * detailString;
//盛放Btn的数组
@property (nonatomic,strong)NSArray <NHSheetButton *> * buttonItems;
@end

@implementation NHSheetContentView

- (instancetype)initWithTitle:(NSString *)title detailTitle:(NSString *)detailTtile andButtonItems:(NSArray <NHSheetButton *>*)buttonItems{
    if (self = [super init]) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        self.hidden = YES;
        self.titleString = title;
        self.detailString = detailTtile;
        if (buttonItems) {
            self.buttonItems = buttonItems;
        }else{
            NSAssert(NO, @"需要设置button");
        }
        [self initUI];
    }
    return self;
}
- (instancetype)initWithTitle:(NSString *)title andButtonItems:(NSArray <NHSheetButton *>*)buttonItems{
    return [self initWithTitle:title detailTitle:nil andButtonItems:buttonItems];
}
- (void)initUI{
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.cancelButton];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    _cancelBtnHeight = 45;
    _margin = 20;
    _seperaLineHeight = 2;
    _cornerRadius = 10;
    [self setHeaderInContentView];
    for (NHSheetButton *btn in _buttonItems) {
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:btn];
    }
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.superview) {
        self.frame = self.superview.frame;
        CGFloat contentViewMaxWidth = self.bounds.size.width - 2 * _margin;
        if (_headerView) {
            _headerView.frame = CGRectMake(0, 0, contentViewMaxWidth, _headerViewHeight);
            [self setcornerRadiusFromView:_headerView isForTop:YES];
            if (_detailLabel && _titleLabel) {
                _titleLabel.frame = CGRectMake(0, 10, contentViewMaxWidth, _titleHeight);
                _detailLabel.frame = CGRectMake(0, CGRectGetMaxY(_titleLabel.frame)+8, contentViewMaxWidth, _detailHeight);
            }else if (_titleLabel){
               _titleLabel.frame = _headerView.frame;
            }else if (_detailLabel){
               _detailLabel.frame = _detailLabel.frame;
            }
        }
        CGFloat btnY = _headerViewHeight;
        for (int i = 0; i < _buttonItems.count; i ++) {
            NHSheetButton *btn = _buttonItems[i];
            btnY += _seperaLineHeight;
            btn.frame = CGRectMake(0, btnY, contentViewMaxWidth, btn.buttonHeight);
            btnY += btn.buttonHeight;
            
            if (i == 0) {//第一个btn
                if (_headerView == nil) {//没有title的时候
                    if (_buttonItems.count == 1) {
                        //只有一个按钮的时候
                        btn.layer.masksToBounds = YES;
                        btn.layer.cornerRadius = _cornerRadius;
                    }else{
                        //没有文字，多个按钮
                        [self setcornerRadiusFromView:btn isForTop:YES];
                    }
                }else{//有title
                    if (_buttonItems.count == 1) {
                        //仅有一个的时候，尾部需要圆角；当多个的时候，暂不需要思考第一个
                        [self setcornerRadiusFromView:btn isForTop:NO];
                    }
                }
            }
            if (i == _buttonItems.count -1) {//最后一个btn
                //最后一个，只需考虑设置下面为圆角就可以
                [self setcornerRadiusFromView:btn isForTop:NO];
            }
        }
        _cancelButton.frame = CGRectMake(0, btnY + 10, contentViewMaxWidth, _cancelBtnHeight);
        _cancelButton.layer.masksToBounds = YES;
        _cancelButton.layer.cornerRadius = _cornerRadius;
        _contentView.frame = CGRectMake(_margin, self.bounds.size.height - _contentViewHeight, contentViewMaxWidth, _contentViewHeight);
    }
}
#pragma mark method
- (void)setHeaderInContentView{
    CGFloat labelMaxWidth = [UIScreen mainScreen].bounds.size.width - 2 * _margin;
    if (_titleString) {
        self.titleLabel.text = _titleString;
        [self.headerView addSubview:_titleLabel];
        //计算标题的高度
        _titleHeight = [_titleString boundingRectWithSize:CGSizeMake(labelMaxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_titleLabel.font} context:nil].size.height;
        //headerView的高度 = 标题高度 + 10空隙
        _headerViewHeight += _titleHeight + 10;
    }
    if (_detailString) {
        self.detailLabel.text = _detailString;
        [self.headerView addSubview:_detailLabel];
        //计算详情高度
        _detailHeight = [_detailString boundingRectWithSize:CGSizeMake(labelMaxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_detailLabel.font} context:nil].size.height;
        
        _headerViewHeight += _detailHeight + 10;
    }
    if (_headerView) {
        [_contentView addSubview:_headerView];
    }
    _headerViewHeight = MAX(20, _headerViewHeight);
}
- (void)computeContentViewHeight{
    
    _contentViewHeight = _headerViewHeight;
    for (NHSheetButton * btn in _buttonItems) {
        _contentViewHeight += (_seperaLineHeight + btn.buttonHeight);
    }
    _contentViewHeight += (_cancelBtnHeight + 2 * 10);
}
//绘制圆角
- (void)setcornerRadiusFromView:(UIView *)view isForTop:(BOOL)isForTop{
    //根据BOOL设置 上或下 的圆角
    UIRectCorner rectConrner = isForTop ? (UIRectCornerTopLeft|UIRectCornerTopRight):(UIRectCornerBottomLeft|UIRectCornerBottomRight);
    // UIBezierPath
    UIBezierPath *viewPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:rectConrner cornerRadii:CGSizeMake(_cornerRadius, _cornerRadius)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = viewPath.CGPath;
    view.layer.mask = maskLayer;
}
- (void)showView{
    self.hidden = NO;
    self.alpha = 1;
     _contentView.frame = CGRectMake(0, self.bounds.size.height - _contentViewHeight, self.bounds.size.width - 2*_margin, _contentViewHeight);
}
- (void)hiddenView{
    self.hidden= YES;
    self.alpha = 0;
    _contentView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width - 2*_margin, _contentViewHeight);
}
//展示
- (void)show{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
    
    [self computeContentViewHeight];
    [self hiddenView];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self showView];
    }];
}
//隐藏
- (void)hide{

    [UIView animateWithDuration:0.25 animations:^{
        [self hiddenView];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)cancelButtonAction{
    [self hide];
}
- (void)tapAction{
    [self hide];
}
- (void)btnAction:(NHSheetButton *)btn{
    if (btn.buttonAction) {
        btn.buttonAction(btn);
    }
    [self hide];
}
#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    CGFloat locationY = [gestureRecognizer locationInView:self].y;
    return locationY < _contentView.frame.origin.y || locationY > CGRectGetMaxY(_contentView.frame);
}
#pragma mark initUI
- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
    }
    return _contentView;
}
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]init];
        _headerView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    }
    return _headerView;
}
- (NSArray<NHSheetButton *> *)buttonItems{
    if (!_buttonItems) {
        _buttonItems = [NSArray array];
    }
    return _buttonItems;
}
- (NHSheetButton *)cancelButton{
    if (!_cancelButton) {
        NHSheetButton *cancelBtn = [[NHSheetButton alloc]init];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [cancelBtn setBackgroundColor:[UIColor whiteColor]];
        [cancelBtn addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton = cancelBtn;
    }
    return _cancelButton;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}
- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _detailLabel.textColor = [UIColor blackColor];
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
}
@end
