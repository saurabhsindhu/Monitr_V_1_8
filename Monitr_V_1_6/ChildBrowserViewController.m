//
//  ChildBrowserViewController.m
//
//  Created by Jesse MacFadyen on 21/07/09.
//  Copyright 2009 Nitobi. All rights reserved.
//

#import "ChildBrowserViewController.h"
#import "ChildBrowserCommand.h"
#import "AppDelegate.h"
#import "DataClass.h"

BOOL setVar=YES;


AppDelegate *objDelegate;
@implementation ChildBrowserViewController

@synthesize supportedOrientations;
@synthesize delegate;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/



+ (NSString*) resolveImageResource:(NSString*)resource
{
	NSString* systemVersion = [[UIDevice currentDevice] systemVersion];
	BOOL isLessThaniOS4 = ([systemVersion compare:@"4.0" options:NSNumericSearch] == NSOrderedAscending);
	
	// the iPad image (nor retina) differentiation code was not in 3.x, and we have to explicitly set the path
	if (isLessThaniOS4)
	{
        return [NSString stringWithFormat:@"%@.png", resource];
	}
	
	return resource;
}


- (ChildBrowserViewController*)initWithScale:(BOOL)enabled
{
    self = [super init];
	

	return self;	
}

- (void)viewWillAppear:(BOOL)animated
{
    [customP.player play];
    [viewVectorsBtn setHidden:YES];
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [customP setFrame:CGRectMake(56, 26, 912, 500)];
    }
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        
        
        [customP setFrame:CGRectMake(56, 26, 912, 500)];
        [viewVectorsBtn setFrame:CGRectMake(200, 500, 654, 200)];
        [bgView         setFrame:CGRectMake(51, 0, 190, 200)];
        [btnRefresh     setFrame:CGRectMake(86, 40, 120, 120)];
        [btnDown        setFrame:CGRectMake(129, 170, 35, 18)];
        [btnRight       setFrame:CGRectMake(210, 82, 18, 35)];
        [btnLeft        setFrame:CGRectMake(60, 82, 18, 35)];
        [btnUp          setFrame:CGRectMake(129, 16, 35, 18)];
        [btnZoomOut     setFrame:CGRectMake(434, 73, 51, 53)];
        [btnZoomIn      setFrame:CGRectMake(554, 73, 51, 53)];
        [btnZoom        setFrame:CGRectMake(479, 71, 82, 55)];
        [activity       setFrame:CGRectMake(632, 716, 20, 20)];
        
        [bgView setBackgroundImage:[UIImage imageNamed:@"bg_ipad.png"] forState:UIControlStateNormal];
        [btnRefresh setBackgroundImage:[UIImage imageNamed:@"refresh_ipad.png"] forState:UIControlStateNormal];
        [btnDown setBackgroundImage:[UIImage imageNamed:@"bottom_ipad.png"] forState:UIControlStateNormal];
        [btnRight setBackgroundImage:[UIImage imageNamed:@"right_ipad.png"] forState:UIControlStateNormal];
        [btnLeft setBackgroundImage:[UIImage imageNamed:@"left_ipad.png"] forState:UIControlStateNormal];
        [btnUp setBackgroundImage:[UIImage imageNamed:@"top_ipad.png"] forState:UIControlStateNormal];
        [btnZoomOut setBackgroundImage:[UIImage imageNamed:@"zoom-out_ipad.png"] forState:UIControlStateNormal];
        [btnZoomIn setBackgroundImage:[UIImage imageNamed:@"zoom-in_ipad.png"] forState:UIControlStateNormal];
        [btnZoom setImage:[UIImage imageNamed:@"zoom_btn_ipad.png"]];
    }
    else
    {
//        bgView = [[UIImageView alloc] init];
//        [bgView setUserInteractionEnabled:YES];
//        btnRefresh = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btnRefresh addTarget:self action:@selector(toCallPreSet) forControlEvents:UIControlEventTouchDragInside];..
        
        
//        [customP setUserInteractionEnabled:YES];
//        
//        [customP setFrame:CGRectMake(0, 80, 320, 214)];
//        [viewVectorsBtn setFrame:CGRectMake(3, 290, 271, 11)];
//        [bgView         setFrame:CGRectMake(22,6, 104, 100)];
//        [btnRefresh     setFrame:CGRectMake(44, 27, 60, 60)];
//        [btnDown        setFrame:CGRectMake(61, 87, 27, 15)];
//        [btnRight       setFrame:CGRectMake(105, 46, 15, 27)];
//        [btnLeft        setFrame:CGRectMake(28, 46, 15, 27)];
//        [btnUp          setFrame:CGRectMake(61, 11, 27, 15)];
//        [btnZoomOut     setFrame:CGRectMake(158, 46, 25, 26)];
//        [btnZoomIn      setFrame:CGRectMake(216, 46, 25, 26)];
//        [btnZoom        setFrame:CGRectMake(180, 49, 41, 21)];
//        [activity setFrame:CGRectMake(177, 428, 20, 20)];
        
        
        
//        [bgView setImage:[UIImage imageNamed:@"bg.png"]];
//        [btnRefresh setBackgroundImage:[UIImage imageNamed:@"refresh.png"] forState:UIControlStateNormal];
        
//        [viewVectorsBtn addSubview:bgView];
//        [viewVectorsBtn addSubview:btnRefresh];
    }
    
    isTableGesOn = YES;
    
    NSLog(@"1111");
    [activity setHidden:YES];
   // comm = [[ChildBrowserCommand alloc]init];
     objDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    

    
    
    selButton = NO;
    
    loadingView = [[MBProgressHUD alloc]initWithView:self.view];
    loadingView.labelText = @"loading...";
    [self.view addSubview:loadingView];
    
    
    //customP = [[CustomPlayerView alloc]initWithFrame:CGRectMake(0, 0, 200, 400)];
    


	webView.delegate = self;
	webView.scalesPageToFit = TRUE;
    
   
   // movie.view.userInteractionEnabled = NO;
 
	//webView.backgroundColor = [UIColor whiteColor];
    for (id subview in webView.subviews)
        if ([[subview class] isSubclassOfClass: [UIScrollView class]])
            ((UIScrollView *)subview).bounces = NO;
	NSLog(@"View did load");
    

}



-(void)hideActivity
{
    NSLog(@"HIDDEN");
    [activity setHidden:YES];
    [activity stopAnimating];
    [self.view setUserInteractionEnabled:YES];
}



-(IBAction)doneClick:(id)sender
{
    
    
    [self dismissModalViewControllerAnimated:YES];
    
    [objDelegate loadAsset];
    
    [tool                   release];
    [barFixedSpace          release];
    [activity               release];
    [comm                   release];
    [viewVectorsBtn         release];
    [customP                release];
    [loadingView            release];
    [webView                release];
    [pauseBtn               release];
    [supportedOrientations  release];
    [bgView                 release];
    [btnRefresh             release];
    [btnDown                release];
    [btnLeft                release];
    [btnRight               release];
    [btnUp                  release];
    [btnZoomOut             release];
    [btnZoomIn              release];
    [btnZoom                release];
    
    tool=nil;
    barFixedSpace=nil;
    activity=nil;
    comm=nil;
    viewVectorsBtn=nil;
    customP=nil;
    loadingView=nil;
    webView=nil;
    pauseBtn=nil;
    supportedOrientations=nil;
    bgView=nil;
    btnRefresh=nil;
    btnDown=nil;
    btnLeft=nil;
    btnRight=nil;
    btnUp=nil;
    btnZoomOut=nil;
    btnZoomIn      =nil;
    btnZoom=nil;
    
    tool =nil;
    barFixedSpace =nil;
    
    
	webView.delegate = nil;
	
	[webView release];
    
    [self release];
    
}


//-(void)animationSet:(id)sender
//{
//
//    
//    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
//    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//    anim.duration = 0.2;
//    anim.repeatCount = 0;
//    anim.autoreverses = YES;
//    anim.removedOnCompletion = YES;
//    anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 0.5)];
//   
//    [viewVectorsBtn.layer addAnimation:anim forKey:nil];
//    
//}



-(IBAction)btnSettingButtonClicked:(id)sender
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if(isTableGesOn == YES)
        {
            [customP setFrame:CGRectMake(56,0, 912, 500)];
            [viewVectorsBtn setHidden:NO];
            isTableGesOn = NO;
        }
        else
        {
            [customP setFrame:CGRectMake(56, 26, 912, 500)];
            [viewVectorsBtn setHidden:YES];
            isTableGesOn = YES;
        }
    }
    else
    {
        if(isTableGesOn == YES)
        {
            [customP setFrame:CGRectMake(0,30, 320, 250)];
            [viewVectorsBtn setHidden:NO];
            isTableGesOn = NO;
        }
        else
        {
            [customP setFrame:CGRectMake(0, 86, 320, 250)];
            [viewVectorsBtn setHidden:YES];
            isTableGesOn = YES;
        }

    
    }
            
}



-(IBAction)ZoomInOut:(UIButton*)btn
{
//    UIView *senderView = (UIView*)sender;
		
    [self.view setUserInteractionEnabled:NO];
    
    [activity setHidden:NO];
    [activity startAnimating];
    
    if(btn.tag == 2)
    {
        objDelegate.ptz = @"ZoomIn";
        objDelegate.value = @"1000";

    }
    else if (btn.tag == 1)
    {
        objDelegate.ptz = @"ZoomOut";
        objDelegate.value = @"1000";
    }
    
    else if (btn.tag == 3)
    {
        objDelegate.ptz = @"TiltUp";
        objDelegate.value = @"10";
    }
    
    else if (btn.tag == 4)
    {
        objDelegate.ptz = @"PanRight";
        objDelegate.value = @"10";
    }
    else if (btn.tag == 5)
    {
        objDelegate.ptz = @"TiltDown";
        objDelegate.value = @"10";
    }
    else if (btn.tag == 6)
    {
        objDelegate.ptz = @"PanLeft";
        objDelegate.value = @"10";
    }

        
    
    [objDelegate callNative];
    
    [self performSelector:@selector(hideActivity) withObject:nil afterDelay:40];
}

-(IBAction)toCallPreSet
{
    [self.view setUserInteractionEnabled:NO];
    
    [activity setHidden:NO];
    [activity startAnimating];
    
    [objDelegate callPreSet];
    
    [self performSelector:@selector(hideActivity) withObject:nil afterDelay:40];

}

#pragma mark
#pragma pauseBtn Methods

-(IBAction)playClick{
    //[sender imageForState:UIControlStateNormal]isEqual:@"pause.png"]
    
    
    if (selButton==NO)
    {
        [customP.player pause];
        // [sender setTitle:@"Play" forState:UIControlStateNormal];
        [pauseBtn setTitle:@"Play"];
         selButton = YES;
    }
    
   
    else{
       
        [customP.player play];
      //  [pauseBtn setTitle:@"Pause" forState:UIControlStateNormal];
        [pauseBtn setTitle:@"Pause"];
        selButton = NO;
    }
}



- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    //popOver
    [popoverController release];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    //    NSLog(@"keyPath:%@,object:%@",keyPath,NSStringFromClass([object class]));
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItem *playerItem = (AVPlayerItem*)object;
        if (playerItem.status==AVPlayerStatusReadyToPlay) {
            //loadingView
            [loadingView hide:YES];
        }
    }
}



- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	NSLog(@"View did UN-load");
}


- (void)dealloc
{
    [tool                   release];
    [barFixedSpace          release];
    [activity               release];
    [comm                   release];
    [viewVectorsBtn         release];
    [customP                release];
    [loadingView            release];
    [webView                release];
    [pauseBtn               release];
    [supportedOrientations  release];
    [bgView                 release];
    [btnRefresh             release];
    [btnDown                release];
    [btnLeft                release];
    [btnRight               release];
    [btnUp                  release];
    [btnZoomOut             release];
    [btnZoomIn              release];
    [btnZoom                release];
    
    tool=nil;
    barFixedSpace=nil;
    activity=nil;
    comm=nil;
    viewVectorsBtn=nil;
    customP=nil;
    loadingView=nil;
    webView=nil;
    pauseBtn=nil;
    supportedOrientations=nil;
    bgView=nil;
    btnRefresh=nil;
    btnDown=nil;
    btnLeft=nil;
    btnRight=nil;
    btnUp=nil;
    btnZoomOut=nil;
    btnZoomIn      =nil;
    btnZoom=nil;
    
    tool =nil;
    barFixedSpace =nil;
    

	webView.delegate = nil;
	
	[webView release];

	[super dealloc];
}

-(void)closeBrowser
{
	
	if(delegate != NULL)
	{
		[delegate onClose];		
	}
	
	[super dismissModalViewControllerAnimated:YES];
}

-(IBAction) onDoneButtonPress:(id)sender
{
	[ self closeBrowser];

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]];
    [webView loadRequest:request];
}


- (UIDocumentInteractionController *)setupControllerWithURL:(NSURL *)fileURL usingDelegate:(id <UIDocumentInteractionControllerDelegate>)interactionDelegate {
  
  UIDocumentInteractionController *interactionController =
  [UIDocumentInteractionController interactionControllerWithURL: fileURL];
  interactionController.delegate = interactionDelegate;
  
  return interactionController;
}


- (void)loadURL:(NSString*)url 
{
    
//        [lblTitle setText:[NSString stringWithFormat:@"%@",assetName]];

        [loadingView show:YES];
    
		//	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
       // customP = [[CustomPlayerView alloc]initWithFrame:CGRectMake(0, 0, 300, 400)];
   
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:url]];
        //player
        AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
        [customP setPlayer:player];
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [customP setFrame:CGRectMake(56, 26, 912, 500)];
    
        AVPlayerLayer* playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
        playerLayer.frame = CGRectMake(0, 0, 912, 500);
        
        NSLog(@"%f,%f,%f,%f",customP.layer.frame.origin.x,customP.layer.frame.origin.y,customP.layer.frame.size.width,customP.layer.frame.size.height);        
        
        [customP.layer addSublayer:playerLayer];         
  
        [customP.player play];
    }
    else
    {
        AVPlayerLayer* playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
        playerLayer.frame = CGRectMake(0, 0, customP.frame.size.width, customP.frame.size.height);
        [customP.layer addSublayer:playerLayer];         
        
        [customP.player play];
    
    }
            
        //slider
        
        
        //loadingView
        [customP.player.currentItem addObserver:self
                                     forKeyPath:@"status" 
                                        options:NSKeyValueObservingOptionNew
                                        context:nil];
        //notifation
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:customP.player.currentItem];
    
       // [previewView setPlayer:player];
    
   
        
 

	}


- (void)webViewDidStartLoad:(UIWebView *)sender {
	//addressLabel.text = @"Loading...";
	//backBtn.enabled = webView.canGoBack;
	//fwdBtn.enabled = webView.canGoForward;
	
	//[ spinner startAnimating ];
	
}

- (void)webViewDidFinishLoad:(UIWebView *)sender 
{
	NSURLRequest *request = webView.request;
	NSLog(@"New Address is : %@",request.URL.absoluteString);
//	addressLabel.text = request.URL.absoluteString;
//	backBtn.enabled = webView.canGoBack;
//	fwdBtn.enabled = webView.canGoForward;
	
	if(delegate != NULL)
	{
		[delegate onChildLocationChange:request.URL.absoluteString];		
	}

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation 
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        BOOL autoRotate = [self.supportedOrientations count] > 1; // autorotate if only more than 1 orientation supported
        if (autoRotate)
        {
            if ([self.supportedOrientations containsObject:
                 [NSNumber numberWithInt:interfaceOrientation]]) {
                return YES;
            }
        }
	}
    else
    {
        return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
    }
        
	return NO;
}




@end
