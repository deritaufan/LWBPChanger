//
//  FileDropView.m
//  LWBPChanger
//
//  Created by Deri Taufan on 8/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NSImageUtils.h"
#import "FileDropView.h"

@implementation FileDropView


- (id)initWithFrame:(NSRect)frame {
    if (self = [super initWithFrame:frame]) {
		[self registerForDraggedTypes:[NSArray arrayWithObjects:
									   NSFilenamesPboardType, nil]];
		
		fileThumb = nil;
		fileName = nil;
		globFile = nil;
    }
    return self;
}

- (void)drawRect:(NSRect)rect {
	int centerX = rect.size.width / 2;
	
	NSRect textRect = NSMakeRect(0, 0, 0, 30);
	if (fileName != nil) {
		textRect = [fileName boundingRectWithSize:NSMakeSize(rect.size.width - 25, 30) options:NSStringDrawingUsesFontLeading attributes:nil];
		textRect.origin.x = centerX - textRect.size.width / 2;
		textRect.origin.y = 0;
		[fileName drawInRect:textRect withAttributes:nil];
	}
	
	if (fileThumb != nil) {
		NSImage *image = [fileThumb imageByScalingProportionallyToSize:NSMakeSize(rect.size.width, rect.size.height - textRect.size.height)];
		CGFloat imageCenterX = centerX - [image size].width / 2;
		CGFloat imageWidth = [image size].width;
		CGFloat imageHeigth = [image size].height;
		
		[image drawAtPoint:NSMakePoint(imageCenterX, textRect.size.height) fromRect:NSMakeRect(0, 0, imageWidth, imageHeigth) operation:NSCompositeSourceOver fraction:1.0];
	}
}


- (void)addLinkToFiles:(NSArray *)files {
	fileName = [[files objectAtIndex:0] retain]; globFile = [[files objectAtIndex:0] retain];
	fileThumb = [[NSImage alloc] initWithContentsOfFile:fileName];
	[self setNeedsDisplay:YES];
}

// I'm DND Destination
- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
    NSPasteboard *pboard;
    NSDragOperation sourceDragMask;
	
    sourceDragMask = [sender draggingSourceOperationMask];
    pboard = [sender draggingPasteboard];
	
    if ( [[pboard types] containsObject:NSFilenamesPboardType] ) {
        if (sourceDragMask & NSDragOperationLink) {
            return NSDragOperationLink;
        } else if (sourceDragMask & NSDragOperationCopy) {
            return NSDragOperationCopy;
        }
    }
    return NSDragOperationNone;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender {
    NSPasteboard *pboard;
    NSDragOperation sourceDragMask;
	
    sourceDragMask = [sender draggingSourceOperationMask];
    pboard = [sender draggingPasteboard];
	
	if ([[pboard types] containsObject:NSFilenamesPboardType]) {
        NSArray *files = [pboard propertyListForType:NSFilenamesPboardType];
		
        // Depending on the dragging source and modifier keys,
        // the file data may be copied or linked
        if (sourceDragMask & NSDragOperationLink) {
            [self addLinkToFiles:files];
        } else {
            [self addLinkToFiles:files];
        }
		
    }
	
    return YES;
}

//+ (NSString *)returnFile {
//	return fileName;
//}

@end
