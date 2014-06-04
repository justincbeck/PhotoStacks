//
//  BPAlbum.h
//  PseudoSked
//
//  Created by Justin C. Beck on 6/3/14.
//  Copyright (c) 2014 BeckProduct. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BPPhoto;

@interface BPAlbum : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong, readonly) NSArray *photos;

- (void)addPhoto:(BPPhoto *)photo;
- (BOOL)removePhoto:(BPPhoto *)photo;

@end
