//
//  AwesomeMenuItem.h
//  AwesomeMenu
//
//  Created by Levey on 11/30/11.
//  Copyright (c) 2011 Levey & Other Contributors. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AwesomeMenuItemDelegate;

@interface AwesomeMenuItem : UIImageView
{
    UIImageView *_contentImageView;
    NSString *label;
    CGPoint _startPoint;
    CGPoint _endPoint;
    CGPoint _nearPoint; // near
    CGPoint _farPoint; // far
    
    id<AwesomeMenuItemDelegate> _delegate;
}

@property (nonatomic, retain, readonly) UIImageView *contentImageView;
@property (nonatomic, retain) UILabel *labelView;

@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;
@property (nonatomic) CGPoint nearPoint;
@property (nonatomic) CGPoint farPoint;

@property (nonatomic, retain) id<AwesomeMenuItemDelegate> delegate;

- (id)initWithImage:(UIImage *)img 
   highlightedImage:(UIImage *)himg
       contentImage:(UIImage *)cimg
highlightedContentImage:(UIImage *)hcimg
label: (NSString *)lbl;

- (id)initWithImage:(UIImage *)img
   highlightedImage:(UIImage *)himg
       contentImage:(UIImage *)cimg
highlightedContentImage:(UIImage *)hcimg;


@end

@protocol AwesomeMenuItemDelegate <NSObject>
- (void)AwesomeMenuItemTouchesBegan:(AwesomeMenuItem *)item;
- (void)AwesomeMenuItemTouchesEnd:(AwesomeMenuItem *)item;
@end