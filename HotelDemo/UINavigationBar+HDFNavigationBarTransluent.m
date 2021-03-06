//
//  UINavigationBar+HDFNavigationBarTransluent.m
//  JiaHao
//
//  Created by huangyibiao on 15/8/24.
//  Copyright © 2015年 Jerry. All rights reserved.
//

#import "UINavigationBar+HDFNavigationBarTransluent.h"
#import <objc/runtime.h>

@implementation UINavigationBar (HDFNavigationBarTransluent)

static char overlayKey;

- (UIView *)overlay {
  return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay {
  objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)hdf_setBackgroundColor:(UIColor *)backgroundColor {
  if (!self.overlay) {
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.bounds) + 20)];
    self.overlay.userInteractionEnabled = NO;
    self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self insertSubview:self.overlay atIndex:0];
  }
  self.overlay.backgroundColor = backgroundColor;
}

- (void)hdf_setTranslationY:(CGFloat)translationY {
  self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)hdf_setElementsAlpha:(CGFloat)alpha {
  [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
    view.alpha = alpha;
  }];
  
  [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
    view.alpha = alpha;
  }];
  
  UIView *titleView = [self valueForKey:@"_titleView"];
  titleView.alpha = alpha;
}

- (void)hdf_reset {
  [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
  [self.overlay removeFromSuperview];
  self.overlay = nil;
}

@end
