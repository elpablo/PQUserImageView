/***************************************************************************
 Copyright [2015] [Paolo Quadrani]
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 ***************************************************************************/

//
//  PQUserImageView.m
//
//  Created by Paolo Quadrani on 14/09/15.
//

#import "PQUserImageView.h"

@interface PQUserImageView ()

@property (strong) UIImageView *imageView;
@property (strong) CAShapeLayer *maskLayer;
@property (strong) CAShapeLayer *ringLayer;

@end


@implementation PQUserImageView

@synthesize ringColor = _ringColor;
@synthesize ringWidth = _ringWidth;
@synthesize image = _image;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    [self setup];
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

- (void)setup
{
    self.imageView = [[UIImageView alloc] init];
    
    [self addSubview:self.imageView];

    self.ringWidth = 2.0;
    self.ringColor = [UIColor whiteColor];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_ringLayer == nil) {
        _maskLayer = [[CAShapeLayer alloc] init];
        _ringLayer = [[CAShapeLayer alloc] init];
        
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.bounds, 1, 1)];
        [_maskLayer setPath:path.CGPath];
        _maskLayer.fillMode = kCAFillRuleEvenOdd;
        
        _ringLayer.path = path.CGPath;
        _ringLayer.fillColor = [[UIColor clearColor] CGColor];
        
        self.imageView.layer.backgroundColor = [[UIColor clearColor] CGColor];
        self.imageView.layer.mask = _maskLayer;
        [self.imageView.layer addSublayer:_ringLayer];
    }
    
    [_ringLayer setStrokeColor:[[self ringColor] CGColor]];
    [_ringLayer setLineWidth:self.ringWidth];
    
    [self.imageView setContentMode:self.contentMode];
    [self.imageView setFrame:self.bounds];
    [self.maskLayer setFrame:[self.imageView.layer bounds]];
    [self.ringLayer setFrame:[self.imageView.layer bounds]];
}

#pragma mark - Properties

- (UIColor *)ringColor
{
    return _ringColor;
}

- (void)setRingColor:(UIColor *)ringColor
{
    if (_ringColor != ringColor) {
        [self willChangeValueForKey:@"ringColor"];
        _ringColor = ringColor;
        [self didChangeValueForKey:@"ringColor"];
        [self setNeedsLayout];
    }
}

- (CGFloat)ringWidth
{
    return _ringWidth;
}

- (void)setRingWidth:(CGFloat)ringWidth
{
    if (_ringWidth != ringWidth) {
        [self willChangeValueForKey:@"ringWidth"];
        _ringWidth = (ringWidth <= 0) ? 1. : ringWidth;
        [self didChangeValueForKey:@"ringWidth"];
        [self setNeedsLayout];
    }
}

- (UIImage *)image
{
    return _image;
}

- (void)setImage:(UIImage *)image
{
    if (_image != image) {
        [self willChangeValueForKey:@"image"];
        _image = image;
        [self.imageView setImage:_image];
        [self didChangeValueForKey:@"image"];
        [self setNeedsLayout];
    }
}

@end
