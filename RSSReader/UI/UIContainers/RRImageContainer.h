//
//  RRImageContainer.h
//  RSSReader
//
//  Created by Timofey Taran on 02.02.17.
//  Copyright © 2017 Timofey Taran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RRImageContainer : NSObject

@property (nonatomic) NSMutableDictionary<NSString *, UIImage *> *imagesDictionary;

+ (RRImageContainer*)sharedContainer;

@end
