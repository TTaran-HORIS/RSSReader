//
//  RRDescriptionNewsViewController.h
//  RSSReader
//
//  Created by Timofey Taran on 11.01.17.
//  Copyright © 2017 Timofey Taran. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RRNewsData;

@interface RRDescriptionNewsViewController : UIViewController

@property (nonatomic) RRNewsData *newsData;
@property (nonatomic) UIImage *newsImage;

@end
