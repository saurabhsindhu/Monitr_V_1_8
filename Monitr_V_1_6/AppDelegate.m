//
//  AppDelegate.m
//  Monitor_V_1.2
//
//  Created by Gaurav Murghai on 8/20/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import "AppDelegate.h"
#import "ChildBrowserViewController.h"

#ifdef PHONEGAP_FRAMEWORK
	#import <PhoneGap/PhoneGapViewController.h>
#else
	#import "PhoneGapViewController.h"
#endif

#import "ChildBrowserCommand.h"




@implementation AppDelegate

@synthesize urlH,port,username,password,ptz,value,active,assetname;

@synthesize invokeString;

- (id) init
{	
	/** If you need to do any extra app-specific initialization, you can do it here
	 *  -jm
	 **/
    return [super init];
}

/**
 * This is main kick off after the app inits, the views and Settings are setup here. (preferred - iOS4 and up)
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    NSURL* url1 = [launchOptions objectForKey:UIApplicationLaunchOptionsURLKey];
    if (url1 && [url1 isKindOfClass:[NSURL class]])
    {
        self.invokeString = [url1 absoluteString];
		NSLog(@"Monitor_V_1.2 launchOptions = %@",url1);
    }    
    
    
	return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

// this happens while we are running ( in the background, or from within our own app )
// only valid if Monitor_V_1.2.plist specifies a protocol to handle
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url 
{
    // must call super so all plugins will get the notification, and their handlers will be called 
	// super also calls into javascript global function 'handleOpenURL'
    return [super application:application handleOpenURL:url];
}

-(id) getCommandInstance:(NSString*)className
{
	/** You can catch your own commands here, if you wanted to extend the gap: protocol, or add your
	 *  own app specific protocol to it. -jm
	 **/
	return [super getCommandInstance:className];
}

/**
 Called when the webview finishes loading.  This stops the activity view and closes the imageview
 */
- (void)webViewDidFinishLoad:(UIWebView *)theWebView 
{
	// only valid if Monitor_V_1.2.plist specifies a protocol to handle
	if(self.invokeString)
	{
		// this is passed before the deviceready event is fired, so you can access it in js when you receive deviceready
		NSString* jsString = [NSString stringWithFormat:@"var invokeString = \"%@\";", self.invokeString];
		[theWebView stringByEvaluatingJavaScriptFromString:jsString];
	}
	
	 // Black base color for background matches the native apps
   	theWebView.backgroundColor = [UIColor blackColor];
    
	return [ super webViewDidFinishLoad:theWebView ];
}

- (void)webViewDidStartLoad:(UIWebView *)theWebView 
{
	return [ super webViewDidStartLoad:theWebView ];
   
}

/**
 * Fail Loading With Error
 * Error - If the webpage failed to load display an error with the reason.
 */
- (void)webView:(UIWebView *)theWebView didFailLoadWithError:(NSError *)error 
{
	return [ super webView:theWebView didFailLoadWithError:error ];
}

/**
 * Start Loading Request
 * This is where most of the magic happens... We take the request(s) and process the response.
 * From here we can redirect links and other protocols to different internal methods.
 */
- (BOOL)webView:(UIWebView *)theWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    //NSString *requestString = [[request URL] absoluteString];
    if ([[[request URL] absoluteString] hasPrefix:@"js-call:"]) {
        
        // Extract the selector name from the URL
        //NSArray *components = [requestString componentsSeparatedByString:@":"];
//        function = [components objectAtIndex:1];
//        NSLog(@"Purcahse_iod %@",function);
//        [self setActiveStatus];
        return NO;
    }
	return [ super webView:theWebView shouldStartLoadWithRequest:request navigationType:navigationType ];
}

-(void)callNative
{
     NSString *jsCallBack = [NSString localizedStringWithFormat:@"Zooming('%@','%@','%@','%@','%@','%@')",urlH,port,username,password,ptz,value];
    
    [self.webView stringByEvaluatingJavaScriptFromString:jsCallBack];
    

}

-(void)callPreSet
{
    NSString *jsCallBack = [NSString localizedStringWithFormat:@"PresetCamera('%@','%@','%@','%@')",urlH,port,username,password];
    
    [self.webView stringByEvaluatingJavaScriptFromString:jsCallBack];
    
    
}

-(void)loadAsset{
    
    NSString *jsCallBack1 = [NSString localizedStringWithFormat:@"ReLoadAssets()"];
    
    [self.webView stringByEvaluatingJavaScriptFromString:jsCallBack1];    
    
}

- (BOOL) execute:(InvokedUrlCommand*)command
{
	return [ super execute:command];
}

- (void)dealloc
{
	[ super dealloc ];
}


@end


@implementation UINavigationBar (CustomBackground)

- (UIImage *)barBackground
{
    return [UIImage imageNamed:@"tabBar_iPhone.png"];
}

- (void)didMoveToSuperview
{
    //iOS5 only
    if ([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [self setBackgroundImage:[self barBackground] forBarMetrics:UIBarMetricsDefault];
    }
}

//this doesn't work on iOS5 but is needed for iOS4 and earlier
- (void)drawRect:(CGRect)rect
{
    //draw image
    [[self barBackground] drawInRect:rect];
}

@end

