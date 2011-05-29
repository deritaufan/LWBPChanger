//
//  AppController.m
//  LWBPChanger
//
//  Created by Deri Taufan on 8/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"
#import "FileDropView.h"


@implementation AppController

- (void)awakeFromNib {
	[window setContentBorderThickness:24 forEdge:NSMinYEdge];
	/*NSTask *taskread;
	taskread = [[NSTask alloc] init];
	[taskread setLaunchPath: @"/usr/bin/defaults"];
	
	NSArray *argumentsread;
	argumentsread = [NSArray arrayWithObjects: @"read", @"/Library/Preferences/com.apple.loginwindow", @"DesktopPicture", nil];
	[taskread setArguments: argumentsread];
	
	NSPipe *piperead;
	piperead = [NSPipe pipe];
	[taskread setStandardOutput: piperead];
	
	NSFileHandle *fileread;
	fileread = [piperead fileHandleForReading];
	
	[taskread launch];
	
	NSData *data;
	data = [fileread readDataToEndOfFile];
	
	NSString *string;
	string = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
	NSLog (@"defaults returned:\n%@", string);	
	NSImage *imageThumb;
	imageThumb = [[NSImage alloc] initWithContentsOfFile:string]; */
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)app {
	return YES;
}

- (IBAction)changeSetting:(id)sender {
	NSAlert *alert = [NSAlert alertWithMessageText:@"Change?" 
									 defaultButton:@"Change" 
								   alternateButton:@"Cancel" 
									   otherButton:nil 
						 informativeTextWithFormat:@"Do you really want to change?"];
	[alert beginSheetModalForWindow:window 
					  modalDelegate:self 
					 didEndSelector:@selector(alertEnded:code:context:)
						contextInfo:NULL];
	
}

- (void)alertEnded:(NSAlert *)alert 
              code:(int)choice 
           context:(void *)v 
{ 
    if (choice == NSAlertDefaultReturn && globFile != nil) { 
        //NSLog(globFile); 
		
		//for cp
		NSString *newLocation = @"/Library/Desktop Pictures/";
		NSString *theFileName = [globFile lastPathComponent];
		NSString *cpFileName = [newLocation stringByAppendingString:theFileName];
		NSFileManager *fileManager = [NSFileManager defaultManager];
		if ([fileManager fileExistsAtPath:globFile]) 
		{
			[fileManager copyPath:globFile toPath:cpFileName handler:nil];
		}		
		//for defaults
		NSTask *task;
		task = [[NSTask alloc] init];
		[task setLaunchPath: @"/usr/bin/defaults"];
		
		NSArray *arguments;
		arguments = [NSArray arrayWithObjects: @"write", @"/Library/Preferences/com.apple.loginwindow", @"DesktopPicture", cpFileName, nil];
		[task setArguments: arguments];
		
		NSPipe *pipe;
		pipe = [NSPipe pipe];
		[task setStandardOutput: pipe];
		
		NSFileHandle *file;
		file = [pipe fileHandleForReading];
		
		[task launch];
		
		//NSData *data;
		//data = [file readDataToEndOfFile];
		
		//NSString *string;
		//string = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
		//NSLog (@"defaults returned:\n%@", string);	
		[textField setStringValue:@"Done!!!"]; 	
    } 
	else {
		[textField setStringValue:@"Cancelled!!!"]; 	
	}
} 

@end
