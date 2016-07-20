//
//  SXCellTableViewCell.m
//  GreatDiscount
//
//  Created by Hello Cai on 16/4/19.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "SXCellTableViewCell.h"

@interface SXCellTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imagV;

@end
@implementation SXCellTableViewCell

-(void)setModel:(ImgModel *)model{
    [_imagV sd_setImageWithURL:[NSURL URLWithString:model.main_img] placeholderImage:[UIImage imageNamed:@""]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
