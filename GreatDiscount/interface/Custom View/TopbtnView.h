//
//  TopbtnView.h
//  GreatDiscount
//
//  Created by Hello Cai on 16/4/17.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopbtnView : UIView
//标题数组
@property(nonatomic,strong)NSMutableArray *titlesArray;
//当前选中的序号
@property(nonatomic,assign)NSInteger selectedIndex;

-(instancetype)initWithFrame:(CGRect)frame titlesArray:(NSArray *)titlesArray;
@end
