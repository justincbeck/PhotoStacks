//
//  BPPhoto.h
//  PseudoSked
//
//  Created by Justin C. Beck on 6/3/14.
//  Copyright (c) 2014 BeckProduct. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPPhoto : NSObject

@property (nonatomic, strong, readonly) NSURL *imageURL;
@property (nonatomic, strong, readonly) UIImage *image;

+ (BPPhoto *)photoWithImageURL:(NSURL *)imageURL;

- (id)initWithImageURL:(NSURL *)imageURL;

@end
