//
//  SXView.h
//  GreatDiscount
//
//  Created by Hello Cai on 16/4/19.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProModel.h"
@interface SXView : UIView

@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIImageView *leftImg;
@property(nonatomic,strong)UIImageView *upImg;
@property(nonatomic,strong)UIImageView *downLeftImg;
@property(nonatomic,strong)UIImageView *downrighttImg;

-(instancetype)initWithFrame:(CGRect)frame;
@property(nonatomic,strong)NSArray *array;

@end
