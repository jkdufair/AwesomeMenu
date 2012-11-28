//
//  AwesomeMenuItem.m
//  AwesomeMenu
//
//  Created by Levey on 11/30/11.
//  Copyright (c) 2011 Levey & Other Contributors. All rights reserved.
//

#import "AwesomeMenuItem.h"
#import <QuartzCore/QuartzCore.h>

static inline CGRect ScaleRect(CGRect rect, float n) {return CGRectMake((rect.size.width - rect.size.width * n)/ 2, (rect.size.height - rect.size.height * n) / 2, rect.size.width * n, rect.size.height * n);}
@implementation AwesomeMenuItem

@synthesize contentImageView = _contentImageView;
@synthesize labelView = _labelView;

@synthesize startPoint = _startPoint;
@synthesize endPoint = _endPoint;
@synthesize nearPoint = _nearPoint;
@synthesize farPoint = _farPoint;
@synthesize delegate  = _delegate;

#pragma mark - initialization & cleaning up
- (id)initWithImage:(UIImage *)img 
   highlightedImage:(UIImage *)himg
       contentImage:(UIImage *)cimg
highlightedContentImage:(UIImage *)hcimg
label:(id)lbl;
{
    if (self = [super init]) 
    {
        self.image = img;
        self.highlightedImage = himg;
        self.userInteractionEnabled = YES;
        _contentImageView = [[UIImageView alloc] initWithImage:cimg];
        _contentImageView.highlightedImage = hcimg;
        [self addSubview:_contentImageView];
        if (lbl != nil)
        {
            self.labelView = [[UILabel alloc] init];
            self.labelView.text = lbl;
            self.labelView.backgroundColor = [UIColor clearColor];
            self.labelView.font = [UIFont boldSystemFontOfSize:16];
            self.labelView.textColor = [UIColor whiteColor];
            self.labelView.shadowColor = [UIColor blackColor];
            self.labelView.shadowOffset = CGSizeMake(1.0, 1.0);
            
            self.labelView.alpha = 0.0;
            [self addSubview:self.labelView];
        }
    }
    return self;
}

- (id)initWithImage:(UIImage *)img
   highlightedImage:(UIImage *)himg
       contentImage:(UIImage *)cimg
highlightedContentImage:(UIImage *)hcimg
{
    return [self initWithImage:img highlightedImage:himg contentImage:cimg highlightedContentImage:hcimg label:nil];
}

#pragma mark - UIView's methods
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bounds = CGRectMake(0, 0, self.image.size.width, self.image.size.height);
    
    float width = _contentImageView.image.size.width;
    float height = _contentImageView.image.size.height;
    _contentImageView.frame = CGRectMake(self.bounds.size.width/2 - width/2, self.bounds.size.height/2 - height/2, width, height);
    if (self.labelView != nil)
    {
        CGSize labelSize = [self.labelView.text sizeWithFont:[UIFont boldSystemFontOfSize:16]];
        self.labelView.bounds = CGRectMake(0, 0, labelSize.width, labelSize.height);
        self.labelView.frame = CGRectMake(self.bounds.size.width/2 - labelSize.width/2, self.bounds.size.height - 2, labelSize.width, labelSize.height);
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.highlighted = YES;
    if ([_delegate respondsToSelector:@selector(AwesomeMenuItemTouchesBegan:)])
    {
       [_delegate AwesomeMenuItemTouchesBegan:self];
    }
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // if move out of 2x rect, cancel highlighted.
    CGPoint location = [[touches anyObject] locationInView:self];
    if (!CGRectContainsPoint(ScaleRect(self.bounds, 2.0f), location))
    {
        self.highlighted = NO;
    }
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.highlighted = NO;
    // if stop in the area of 2x rect, response to the touches event.
    CGPoint location = [[touches anyObject] locationInView:self];
    if (CGRectContainsPoint(ScaleRect(self.bounds, 2.0f), location))
    {
        if ([_delegate respondsToSelector:@selector(AwesomeMenuItemTouchesEnd:)])
        {
            [_delegate AwesomeMenuItemTouchesEnd:self];
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.highlighted = NO;
}

#pragma mark - instant methods
- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [_contentImageView setHighlighted:highlighted];
}


@end
