//
//  PhoneItemViewCell.h
//  Demo1
//
//  Created by DeerClass on 2022/9/8.
//

#import <UIKit/UIKit.h>
#import "PhoneItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhoneItemViewCell : UITableViewCell

@property (weak, nonatomic) PhoneItem *phoneItem;

- (void)adjuestView:(BOOL)show animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
