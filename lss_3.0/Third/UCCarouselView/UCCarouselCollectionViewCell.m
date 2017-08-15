//
//  UCCarouselCollectionViewCell.m
//  UCCarouselView
//
//  Created by apple on 2017/8/7.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "UCCarouselCollectionViewCell.h"
#import <WebKit/WebKit.h>

@interface UCCarouselCollectionViewCell () <WKUIDelegate>


@end

@implementation UCCarouselCollectionViewCell

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadImageView];
    }
    return self;
}

#pragma mark - Accessor

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = _image;
}

#pragma mark - UI

- (void)loadImageView {
    if (!self.imageView) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imageView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.imageView];
    }
}

@end
