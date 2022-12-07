//
//  PhoneItemViewCell.m
//  Demo1
//
//  Created by DeerClass on 2022/9/8.
//

#import "PhoneItemViewCell.h"

@interface PhoneItemViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *phoneLbl;

@property (weak, nonatomic) IBOutlet UILabel *timeLbl;

@property (weak, nonatomic) IBOutlet UILabel *siteLbl;

@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tiemLeading;

@end

@implementation PhoneItemViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   
}

- (void)adjuestView:(BOOL)show animated:(BOOL)animated{
    UIButton *btn = self.btn;
    if (animated) {
        [UIView animateWithDuration:0.4 animations:^{
            btn.alpha = show ? 0 : 1;
        }];
    } else {
        btn.alpha = show ? 0 : 1;
    }
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPhoneItem:(PhoneItem *)phoneItem {
    _phoneLbl.text = phoneItem.phone;
    _timeLbl.text = phoneItem.time;
    _siteLbl.text = phoneItem.site;
    
    _phoneLbl.textColor = phoneItem.isAnswer ? UIColor.blackColor : [UIColor redColor];
    
}

//- (void)updateConstraints {
//    [super updateConstraints];
//    
//    [_timeLbl sizeToFit];
//    _tiemLeading.constant = ScreenWidth - 50 - _timeLbl.frame.size.width;
//}

@end
