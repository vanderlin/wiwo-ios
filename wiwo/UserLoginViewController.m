//
//  UserLoginViewController.m
//  wiwo
//
//  Created by Todd Vanderlin on 6/16/15.
//  Copyright (c) 2015 wishiwasoutside.com. All rights reserved.
//

#import "UserLoginViewController.h"
#import <GoogleOpenSource/GoogleOpenSource.h>

@interface UserLoginViewController ()

@end

@implementation UserLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
    signIn.shouldFetchGoogleUserEmail = YES;  // Uncomment to get the user's email
    
    // You previously set kClientId in the "Initialize the Google+ client" step
    signIn.clientID = kClientId;
    
    // Uncomment one of these two statements for the scope you chose in the previous step
    signIn.scopes = @[ kGTLAuthScopePlusLogin ];  // "https://www.googleapis.com/auth/plus.login" scope
    signIn.scopes = @[ @"profile" ];            // "profile" scope
    
    // Optional: declare signIn.actions, see "app activities"
    signIn.delegate = self;
    
    [signIn trySilentAuthentication];
    
    NSLog(@"%@", [[NSBundle mainBundle] bundleIdentifier]);
}

// -------------------------------------------------------------------
-(void)refreshInterfaceBasedOnSignIn {
    if ([[GPPSignIn sharedInstance] authentication]) {
        
        
        // email
        NSLog(@"User Email: %@", [GPPSignIn sharedInstance].userEmail);
        GTLPlusPerson *person = [GPPSignIn sharedInstance].googlePlusUser;
        if (person == nil) {
            return;
        }
        NSLog(@"GPlus Person: %@", person);
        
//        self.usernameLabel.text = person.displayName;
//        self.userMetaLabel.text = [GPPSignIn sharedInstance].userEmail;
//
        /*
        // Load avatar image asynchronously, in background
        dispatch_queue_t backgroundQueue =
        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        dispatch_async(backgroundQueue, ^{
            NSData *avatarData = nil;
            NSLog(@"%@", person.image);
            NSString * imageURLString = person.image.url;
            
            if (imageURLString) {
                NSRange range = [imageURLString rangeOfString:@"?sz"];
                if (range.location != NSNotFound) {
                    imageURLString= [imageURLString substringWithRange:NSMakeRange(0, range.location)];
                    imageURLString = [NSString stringWithFormat:@"%@?sz=200", imageURLString];
                }
                
                NSURL *imageURL = [NSURL URLWithString:imageURLString];
                avatarData = [NSData dataWithContentsOfURL:imageURL];
            }
            
            if (avatarData) {
                // Update UI from the main thread when available
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.userAvatar.image = [UIImage imageWithData:avatarData];
                });
            }
        });
         */
        
        
        // The user is signed in.
        self.signInButton.hidden = YES;
//        self.signOutButton.hidden = NO;
        // Perform other actions here, such as showing a sign-out button
    } else {
        self.signInButton.hidden = NO;
//        self.signOutButton.hidden = YES;
        // Perform other actions here
    }
}

// -------------------------------------------------------------------
- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error {
    NSLog(@"Received error %@ and auth object %@",error, auth);
    if (error) {
        // Do some error handling here.
    } else {
        [self refreshInterfaceBasedOnSignIn];
    }
}

// -------------------------------------------------------------------
- (void)signOut {
    [[GPPSignIn sharedInstance] signOut];
}

// -------------------------------------------------------------------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// -------------------------------------------------------------------
- (IBAction)signOutAction:(UIButton *)sender {
    [self signOut];
}

@end
