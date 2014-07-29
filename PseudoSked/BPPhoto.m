//
//  BPPhoto.m
//  PseudoSked
//
//  Created by Justin C. Beck on 6/3/14.
//  Copyright (c) 2012 2014 BeckProduct. All rights reserved.
//

#import "BPPhoto.h"

@interface BPPhoto ()

@property (nonatomic, strong, readwrite) NSURL *imageURL;
@property (nonatomic, strong, readwrite) UIImage *image;

@end

@implementation BPPhoto

- (id)initWithImageURL:(NSURL *)imageURL
{
    if (self = [super init])
    {
        [self setImageURL:imageURL];
    }
    
    return self;
}

#pragma mark - Properties

- (UIImage *)image
{
    if (!_image && self.imageURL)
    {
        NSData *imageData = [NSData dataWithContentsOfURL:[self imageURL]];
        UIImage *image = [UIImage imageWithData:imageData scale:[UIScreen mainScreen].scale];
        
        _image = image;
    }
    
    return _image;
}

#pragma mark - Lifecycle

+ (BPPhoto *)photoWithImageURL:(NSURL *)imageURL
{
    return [[self alloc] initWithImageURL:imageURL];
}

@end
