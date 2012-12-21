//
//  ChildBrowserViewController.h
//
//  Created by Jesse MacFadyen on 21/07/09.
//  Copyright 2009 Nitobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "CustomPlayerView.h"
#import "MBProgressHUD.h"
@class ChildBrowserCommand;

@protocol ChildBrowserDelegate<NSObject>



/*
 *  onChildLocationChanging:newLoc
 *  
 *  Discussion:
 *    Invoked when a new page has loaded
 */
-(void) onChildLocationChange:(NSString*)newLoc;
-(void) onOpenInSafari;
-(void) onClose;
@end


@interface ChildBrowserViewController : UIViewController < UIWebViewDelegate,UIPopoverControllerDelegate >
{
    IBOutlet UIButton       *bgView;
    IBOutlet UIButton       *btnRefresh;
    IBOutlet UIButton       *btnDown;
    IBOutlet UIButton       *btnLeft;
    IBOutlet UIButton       *btnRight;
    IBOutlet UIButton       *btnUp;
    IBOutlet UIButton       *btnZoomOut;
    IBOutlet UIButton       *btnZoomIn;
    IBOutlet UIImageView    *btnZoom;
    
    
    
    
    IBOutlet UIToolbar *tool;
    IBOutlet UIBarButtonItem *barFixedSpace;
    
    IBOutlet UIActivityIndicatorView *activity;
    
    ChildBrowserCommand *comm;

    IBOutlet UIView *viewVectorsBtn;
        
    IBOutlet CustomPlayerView *customP;
    
    MBProgressHUD *loadingView;
    
    BOOL selButton;
    BOOL isTableGesOn;
    
    
    UIWebView* webView;
	IBOutlet UIBarButtonItem* pauseBtn;
    
	NSArray* supportedOrientations;
    
	id <ChildBrowserDelegate> delegate;
    
    id <UIDocumentInteractionControllerDelegate> docControllerDelegate;
   //  UIButton *doneButton;
}

//@property (retain) UIDocumentInteractionController* docController;

@property (nonatomic, retain)id <ChildBrowserDelegate> delegate;

@property (nonatomic, retain) 	NSArray* supportedOrientations;
//@property(retain) NSString* imageURL;
//@property (nonatomic,retain) NSURL *movieURL;


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation; 
- (ChildBrowserViewController*)initWithScale:(BOOL)enabled;
- (IBAction)onDoneButtonPress:(id)sender;
//- (IBAction)onSafariButtonPress:(id)sender;
//- (IBAction)onDocumentButtonPress:(id)sender;
- (UIDocumentInteractionController *)setupControllerWithURL:(NSURL *)fileURL usingDelegate:(id <UIDocumentInteractionControllerDelegate>)interactionDelegate;
- (void)loadURL:(NSString*)url;
- (void)closeBrowser;
-(IBAction)doneClick:(id)sender;
-(IBAction)playClick;
-(IBAction)btnSettingButtonClicked:(id)sender;
-(IBAction)ZoomInOut:(UIButton*)btn;
-(void)hideActivity;
-(IBAction)toCallPreSet;







@end
