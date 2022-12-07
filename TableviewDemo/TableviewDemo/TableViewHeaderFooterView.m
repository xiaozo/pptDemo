//
//  TableViewHeaderFooterView.m
//  TableviewDemo
//
//  Created by DeerClass on 2022/9/8.
//

#import "TableViewHeaderFooterView.h"

@implementation TableViewHeaderFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
      if (self) {
          _lbl = [[UILabel alloc] init];
          _lbl.textColor = UIColor.redColor;
          [self.contentView addSubview:_lbl];
          _lbl.frame = CGRectMake(20, 0, 0, 0);
      }
      return self;
}

@end
