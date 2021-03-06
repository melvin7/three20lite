//
// Copyright 2009-2011 Facebook
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "TTErrorView.h"

// UI
#import "UIViewAdditions.h"

// Style
#import "TTGlobalStyle.h"
#import "TTDefaultStyleSheet.h"

// Core
#import "TTCorePreprocessorMacros.h"

static const CGFloat kVPadding1 = 30.0f;
static const CGFloat kVPadding2 = 10.0f;
static const CGFloat kVPadding3 = 15.0f;
static const CGFloat kHPadding  = 10.0f;


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTErrorView

@synthesize reloadButton = _reloadButton;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)addReloadButton {
  _reloadButton = [[TTButton buttonWithStyle:@"tableReloadButton:"] retain];
  [_reloadButton setImage:@"bundle://Three20.bundle/images/reloadButton.png"
                 forState:UIControlStateNormal];
  [_reloadButton sizeToFit];
  [self addSubview:_reloadButton];

  [self layoutSubviews];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithTitle:(NSString*)title subtitle:(NSString*)subtitle image:(UIImage*)image {
	self = [self init];
  if (self) {
    self.title = title;
    self.subtitle = subtitle;
    self.image = image;
  }

  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
  if (self) {
      self.backgroundColor = [UIColor whiteColor];
    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeCenter;
    [self addSubview:_imageView];

    _titleView = [[UILabel alloc] init];
    _titleView.backgroundColor = [UIColor clearColor];
    _titleView.textColor = TTSTYLEVAR(tableErrorTextColor);
    _titleView.font = TTSTYLEVAR(errorTitleFont);
    _titleView.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleView];

    _subtitleView = [[UILabel alloc] init];
    _subtitleView.backgroundColor = [UIColor clearColor];
    _subtitleView.textColor = TTSTYLEVAR(tableErrorTextColor);
    _subtitleView.font = TTSTYLEVAR(errorSubtitleFont);
    _subtitleView.textAlignment = NSTextAlignmentCenter;
    _subtitleView.numberOfLines = 0;
    [self addSubview:_subtitleView];
  }

  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  TT_RELEASE_SAFELY(_imageView);
  TT_RELEASE_SAFELY(_titleView);
  TT_RELEASE_SAFELY(_subtitleView);
  TT_RELEASE_SAFELY(_reloadButton);

  [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
  _subtitleView.size = [_subtitleView sizeThatFits:CGSizeMake(self.width - kHPadding*2, 0)];
  [_titleView sizeToFit];
  [_imageView sizeToFit];

  CGFloat maxHeight = _imageView.height + _titleView.height + _subtitleView.height
                      + kVPadding1 + kVPadding2;
  BOOL canShowImage = _imageView.image && self.height > maxHeight;

  CGFloat totalHeight = 0.0f;

  if (canShowImage) {
    totalHeight += _imageView.height;
  }
  if (_titleView.text.length) {
    totalHeight += (totalHeight ? kVPadding1 : 0) + _titleView.height;
  }
  if (_subtitleView.text.length) {
    totalHeight += (totalHeight ? kVPadding2 : 0) + _subtitleView.height;
  }

  totalHeight += (totalHeight ? kVPadding3 : 0) + _reloadButton.height;

  CGFloat top = floor(self.height/2 - totalHeight/2);

  if (canShowImage) {
    _imageView.origin = CGPointMake(floor(self.width/2 - _imageView.width/2), top);
    _imageView.hidden = NO;
    top += _imageView.height + kVPadding1;

  } else {
    _imageView.hidden = YES;
  }
  if (_titleView.text.length) {
    _titleView.origin = CGPointMake(floor(self.width/2 - _titleView.width/2), top);
    top += _titleView.height + kVPadding2;
  }
  if (_subtitleView.text.length) {
    _subtitleView.origin = CGPointMake(floor(self.width/2 - _subtitleView.width/2), top);
    top += _subtitleView.height + kVPadding3;
  }

  if (_reloadButton!=nil) {
    _reloadButton.origin = CGPointMake(floor(self.width/2 - _reloadButton.width/2), top);
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Properties


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)title {
  return _titleView.text;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTitle:(NSString*)title {
  _titleView.text = title;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)subtitle {
  return _subtitleView.text;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setSubtitle:(NSString*)subtitle {
  _subtitleView.text = subtitle;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIImage*)image {
  return _imageView.image;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setImage:(UIImage*)image {
  _imageView.image = image;
}




@end
