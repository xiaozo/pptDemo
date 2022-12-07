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

@end

@implementation PhoneItemViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *phoneLbl = [[UILabel alloc] init];
        [self.contentView addSubview:phoneLbl];
        phoneLbl.font = [UIFont systemFontOfSize:16.0];
        _phoneLbl = phoneLbl;
        
        UILabel *timeLbl = [[UILabel alloc] init];
        [self.contentView addSubview:timeLbl];
        timeLbl.font = [UIFont systemFontOfSize:14.0];
        timeLbl.textColor = RGB(200, 200, 200);
        _timeLbl = timeLbl;
        
        UILabel *siteLbl = [[UILabel alloc] init];
        [self.contentView addSubview:siteLbl];
        siteLbl.font = [UIFont systemFontOfSize:14.0];
        siteLbl.textColor = RGB(200, 200, 200);
        _siteLbl = siteLbl;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeInfoLight];
        [self.contentView addSubview:btn];
        _btn = btn;
        
        [_phoneLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(20.0);
            make.top.mas_equalTo(self.contentView).mas_offset(15.0).priorityHigh();
        }];
        
        [_siteLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(20.0);
            make.top.mas_equalTo(self.phoneLbl.mas_bottom).mas_offset(5.0);
            make.bottom.mas_equalTo(self.contentView).mas_offset(-15.0).priorityHigh();
        }];
        
        [_timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.right.mas_equalTo(self.contentView).mas_offset(-20.0);
        }];
        
    }
    return self;
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

- (void)setPhoneItem:(PhoneItem *)phoneItem {
    _phoneLbl.text = phoneItem.phone;
    _timeLbl.text = phoneItem.time;
    _siteLbl.text = phoneItem.site;
    
    _phoneLbl.textColor = phoneItem.isAnswer ? UIColor.blackColor : [UIColor redColor];
    
}

- (void)updateConstraints {
    [super updateConstraints];
    
    [_timeLbl sizeToFit];
    [_timeLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(ScreenWidth - 50 - self.timeLbl.frame.size.width);
    }];
}


@end

