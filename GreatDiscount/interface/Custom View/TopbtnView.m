//
//  TopbtnView.m
//  GreatDiscount
//
//  Created by Hello Cai on 16/4/17.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "TopbtnView.h"

@interface TopbtnView ()

//小黄线
@property(nonatomic,strong)UIView *indicatorView;

@property(nonatomic,assign)CGFloat oldValueX;
@property(nonatomic,assign)int i;
@end

@implementation TopbtnView

-(instancetype)initWithFrame:(CGRect)frame titlesArray:(NSArray *)titlesArray{
    if(self = [super initWithFrame:frame]){

        self.titlesArray = [NSMutableArray arrayWithArray:titlesArray];

        [self createBtns];
        
        [self createIndicatorView];
        
        self.selectedIndex = 0;
    }
    return self;
}


-(void)createIndicatorView{


    NSString *str = self.titlesArray[0];

    CGRect rect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    CGFloat btnWidth = rect.size.width;
    self.indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-2, btnWidth,2)];
    self.indicatorView.backgroundColor = [UIColor orangeColor];
    [self addSubview:self.indicatorView];
}

-(void)createBtns{
    

    for (int i = 0; i<self.titlesArray.count; i++) {
        NSString *str = self.titlesArray[i];
        CGRect rect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        CGFloat btnWidth = rect.size.width;

        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(_oldValueX + 10, 0, btnWidth, self.height)];
        _oldValueX = btnWidth + 20 + _oldValueX;
        [btn setTitle:self.titlesArray[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

-(void)btnClicked:(UIButton *)btn{
    //切换选中的序号
    self.selectedIndex = btn.tag -100;
    
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_LxTopView_BtnClick object:nil];
}


-(void)setSelectedIndex:(NSInteger)newSelectedIndex{
    //将之前选中的按钮
    UIButton *previousBtn = (UIButton *)[self viewWithTag:_selectedIndex+ 100];
    
    previousBtn.selected = NO;
    
    //设置新的选中按钮
    UIButton *btn = [self viewWithTag:100 + newSelectedIndex];
    btn.selected = YES;
    
    //将selectedIndex的值复制给成员变量
    _selectedIndex = newSelectedIndex;


    [UIView animateWithDuration:0.2 animations:^{
//        CGFloat btnWidth = self.width /self.titlesArray.count;
//        self.indicatorView.x = newSelectedIndex *btnWidth;
        //获取指示view的x坐标
        
        

        //求前面部分文字的长度
        NSString *preStr = @"上新女装鞋包居家美妆美食";
        CGRect preRect = [preStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        CGFloat textWidth = preRect.size.width ;
        CGFloat preWidth = textWidth +20 *6 +10;
        
        //做标示符号

        NSString *str = @"上新女装鞋包居家美妆美食母婴童装昨日热卖下期预告";

        
        if (newSelectedIndex < 6) {
            //i＝0记为处在两个字状态。如果之前i是处在四个字状态就将宽度除以2
            if (_i!=0) {
                self.indicatorView.width = self.indicatorView.width /2;

                _i=0;
            }
            CGRect rect = [[str substringToIndex:2*newSelectedIndex] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
            
            CGFloat btnWidth = rect.size.width ;
            self.indicatorView.x = btnWidth +20*newSelectedIndex+10;
            
        }else{
            //记录小黄线的长度
            //i!=0记为处在四个字状态。如果之前i是处在两个字状态就将宽度乘以2
            if ( _i==0) {
                self.indicatorView.width = self.indicatorView.width *2;
                _i++;

            }

            CGRect rect = [[str substringToIndex:4*(newSelectedIndex-6)] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
            CGFloat btnWidth = rect.size.width ;
            self.indicatorView.x = preWidth + btnWidth +20*(newSelectedIndex-6);
        }
        
        
    }];
    
}


@end
