//

// 
//
//  Created by Jesse MacFadyen on 10-05-29.
//  Copyright 2010 Nitobi. All rights reserved.
//

#import "ChildBrowserCommand.h"
#import "AppDelegate.h"

#ifdef PHONEGAP_FRAMEWORK
	#import <PhoneGap/PhoneGapViewController.h>
	
#else
	#import "PhoneGapViewController.h"
#endif

AppDelegate *objDelegate;
@implementation ChildBrowserCommand

@synthesize childBrowser;

-(void) deleteCookies:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options{
    
    
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (NSHTTPCookie *each in [cookieStorage cookies]) {
        
        [cookieStorage  deleteCookie:each];
    }
}
- (void) showWebPage:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options // args: url
{	
    objDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//	if(childBrowser == NULL)
//	{
		childBrowser = [[ ChildBrowserViewController alloc ] initWithScale:FALSE ];
		childBrowser.delegate = self;
//	}
	
/* // TODO: Work in progress
	NSString* strOrientations = [ options objectForKey:@"supportedOrientations"];
	NSArray* supportedOrientations = [strOrientations componentsSeparatedByString:@","];
*/

	PhoneGapViewController* cont = (PhoneGapViewController*)[ super appViewController ];
	childBrowser.supportedOrientations = cont.supportedOrientations;
	[cont presentModalViewController:childBrowser animated:YES ];
	
	NSString *url1 = (NSString*) [arguments objectAtIndex:0];
    
    
    NSLog(@"GGHDFGDFGHJ%@",url1);
	
   
    NSArray* stringComponents = [url1 componentsSeparatedByString:@"&"];
    
    NSString *url = [stringComponents objectAtIndex:0];
    
    NSString *port = [stringComponents objectAtIndex:1];
    
    NSString *username = [stringComponents objectAtIndex:2];
    
    NSString *password = [stringComponents objectAtIndex:3];
    
    
    
    
    objDelegate.urlH = url;
    objDelegate.port = port;
    objDelegate.username = username;
    objDelegate.password = password;
    
    
    
    NSLog(@"UUUUUUU%@VVV%@WWW%@XXX%@AAAA",port,url,username,password);
    
    


	[childBrowser loadURL:url];

}

//- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
//{
//    NSString * jsCallBack = [NSString stringWithFormat:@"window.plugins.nativeControls.tabBarItemSelected(%d);", item.tag];
//    NSLog(@"%@",item.tag);
//    [self.webView stringByEvaluatingJavaScriptFromString:jsCallBack];
//}


-(void) close:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options // args: url
{
	[ childBrowser closeBrowser];
	
}

-(void) onClose
{
	NSString* jsCallback = [NSString stringWithFormat:@"ChildBrowser._onClose();",@""];
	[self.webView stringByEvaluatingJavaScriptFromString:jsCallback];
}

-(void) onOpenInSafari
{
	NSString* jsCallback = [NSString stringWithFormat:@"ChildBrowser._onOpenExternal();",@""];
	[self.webView stringByEvaluatingJavaScriptFromString:jsCallback];
}


-(void) onChildLocationChange:(NSString*)newLoc
{
	
	NSString* tempLoc = [NSString stringWithFormat:@"%@",newLoc];
	NSString* encUrl = [tempLoc stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	 
	NSString* jsCallback = [NSString stringWithFormat:@"ChildBrowser._onLocationChange('%@');",encUrl];
	[self.webView stringByEvaluatingJavaScriptFromString:jsCallback];

}

-(void)dealloc
{
    [super dealloc];
    [childBrowser release];
}


@end
