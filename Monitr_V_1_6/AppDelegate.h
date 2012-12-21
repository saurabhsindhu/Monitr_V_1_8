//
//  AppDelegate.h
//  Monitor_V_1.2
//
//  Created by Gaurav Murghai on 8/20/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  ChildBrowserViewController;

#ifdef PHONEGAP_FRAMEWORK
	#import <PhoneGap/PhoneGapDelegate.h>
#else
	#import "PhoneGapDelegate.h"
#endif

@class ChildBrowserCommand;

@interface AppDelegate : PhoneGapDelegate {
    
    ChildBrowserCommand *camm;
    
    NSString *urlH;
    NSString *port;
    NSString *username;
    NSString *password;
    NSString *ptz;
    NSString *value;
    NSString *assetname;
    
    NSString *active;
    NSString *function;
	NSString* invokeString;
    
    UIView *viewLoading;
    UIActivityIndicatorView *loadingIndicator;
    
    ChildBrowserViewController *childBrowserVC;
}

// invoke string is passed to your app on launch, this is only valid if you 
// edit Monitor_V_1.2.plist to add a protocol
// a simple tutorial can be found here : 
// http://iphonedevelopertips.com/cocoa/launching-your-own-application-via-a-custom-url-scheme.html

@property (copy)  NSString* invokeString;
@property (retain,nonatomic)  NSString* urlH;
@property (retain,nonatomic)  NSString* port;
@property (nonatomic,retain) NSString *username;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *ptz;
@property (nonatomic, retain) NSString *value;
@property (nonatomic, retain) NSString *active;
@property (nonatomic, retain) NSString *assetname;


-(void)callNative;
-(void)loadAsset;
-(void)callPreSet;

//-(void) loadingIndicatorCreationMethod;
//- (void)show_LoadingIndicator;
//- (void)hide_LoadingIndicator;

@end

