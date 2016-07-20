//
//  SXView.m
//  GreatDiscount
//
//  Created by Hello Cai on 16/4/19.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "SXView.h"


@implementation SXView


-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self createImageView];
    }
    return self;
}

-(void)createImageView{
    //167
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 7*SizeScale_H)];
    [self addSubview:_bgView];
    
    _leftImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 7*SizeScale_H, ScreenWidth/2-1, 160*SizeScale_H)];
    [self addSubview:_leftImg];
    
    _upImg = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2, 7*SizeScale_H, ScreenWidth/2, 66*SizeScale_H)];
    [self addSubview:_upImg];
    
    _downLeftImg = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2, 75*SizeScale_H, ScreenWidth/4, 92*SizeScale_H)];
    [self addSubview:_downLeftImg];
    
    _downrighttImg = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2+ScreenWidth/4, 75*SizeScale_H, ScreenWidth/4, 92*SizeScale_H)];
    [self addSubview:_downrighttImg];
    
}

-(void)setArray:(NSArray *)array{
    _bgView.backgroundColor = [UIColor grayColor];
    _bgView.alpha = 0.1;
    
    ProModel *model0 = array[0];
    [_leftImg sd_setImageWithURL:[NSURL URLWithString:model0.img] placeholderImage:[UIImage imageNamed:@""]];
    
    ProModel *model1 = array[1];
    [_upImg sd_setImageWithURL:[NSURL URLWithString:model1.img] placeholderImage:[UIImage imageNamed:@""]];
    
    ProModel *model2 = array[2];
    [_downLeftImg sd_setImageWithURL:[NSURL URLWithString:model2.img] placeholderImage:[UIImage imageNamed:@""]];
    
    ProModel *model3 = array[3];
    [_downrighttImg sd_setImageWithURL:[NSURL URLWithString:model3.img] placeholderImage:[UIImage imageNamed:@""]];
    
    [self createHelpLine];
}

-(void)createHelpLine{
    //竖线中间线
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth/2-1, 7*SizeScale_H, 1,160*SizeScale_H)];
    view1.backgroundColor = [UIColor grayColor];
    view1.alpha = 0.15;
    [self addSubview:view1];
    
    //横线
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth/2-1, 73*SizeScale_H, ScreenWidth/2,1)];
    view2.backgroundColor = [UIColor grayColor];
    view2.alpha = 0.15;
    [self addSubview:view2];
    
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth/2+ScreenWidth/4, 73*SizeScale_H, 1, 92*SizeScale_H)];
    view3.backgroundColor = [UIColor grayColor];
    view3.alpha = 0.15;
    [self addSubview:view3];


}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
