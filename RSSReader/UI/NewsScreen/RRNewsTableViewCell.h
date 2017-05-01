//
//  RRNewsTableViewCell.h
//  RSSReader
//
//  Created by Timofey Taran on 10.01.17.
//  Copyright © 2017 Timofey Taran. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RRNewsTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *newsDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *newsHeaderLabel;
@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;
@property (weak, nonatomic) IBOutlet UIImageView *gradientImageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@end
