//
//  BPAlbumTitleReusableView.m
//  PseudoSked
//
//  Created by Justin C. Beck on 6/3/14.
//  Copyright (c) 2014 BeckProduct. All rights reserved.
//

#import "BPAlbumTitleReusableView.h"

@interface BPAlbumTitleReusableView()

@property (nonatomic, strong, readwrite) UILabel *titleLabel;

@end

@implementation BPAlbumTitleReusableView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setTitleLabel:[[UILabel alloc] initWithFrame:self.bounds]];
        [[self titleLabel] setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [[self titleLabel] setBackgroundColor:[UIColor clearColor]];
        [[self titleLabel] setTextAlignment:NSTextAlignmentCenter];
        [[self titleLabel] setFont:[UIFont boldSystemFontOfSize:13.0f]];
        [[self titleLabel] setTextColor:[UIColor colorWithWhite:1.0f alpha:1.0f]];
        [[self titleLabel] setShadowColor:[UIColor colorWithWhite:0.0f alpha:0.3f]];
        [[self titleLabel] setShadowOffset:CGSizeMake(0.0f, 1.0f)];
        
        [self addSubview:[self titleLabel]];
    }
    
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    [[self titleLabel] setText:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
