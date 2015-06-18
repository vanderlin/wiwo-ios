//
//  RootViewController.h
//  wiwo
//
//  Created by Todd Vanderlin on 6/16/15.
//  Copyright (c) 2015 wishiwasoutside.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <GooglePlus/GooglePlus.h>
@class GPPSignInButton;


static NSString * const kClientId = @"800475978549-514amdgje2bct79kl2v7aj69gtj331gh.apps.googleusercontent.com";

@interface RootViewController : UIViewController <GPPSignInDelegate>

@end
