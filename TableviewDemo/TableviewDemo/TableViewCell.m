//
//  TableViewCell.m
//  TableviewDemo
//
//  Created by DeerClass on 2022/9/14.
//

#import "TableViewCell.h"

@implementation TableViewCell

///cell里需要初始化在这里做（如创建元素，设置默认值等等）
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
