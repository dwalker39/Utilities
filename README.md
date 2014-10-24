Utilities
=========

**QuickAlert via Swift**
This lets you quickly and easily create new UIAlertViews with closures for each button tap

Example usage:
```swift
            self.showMessage("Here is your message", title: "Here is your title", buttonCancelText: "Cancel", buttonText: "OK", buttonCancelAction: nil) {
            () -> Void in
            println("You tapped on the only button")
        }
        
        self.showMessage("Longer Message!", title: "Here is your title", buttonCancelText: "Cancel", button1Text: "Button 1 text", button2Text: "Button 2 text", buttonCancelAction: { () -> Void in
            println("You tapped on Cancel")
        }, button1Action: { () -> Void in
            println("You tapped on the first button")
        }, button2Action: { () -> Void in
            println("You tapped on the second button")
        })
```

**QuickAlert via Objective-C** - 
This lets you quickly and easily create new UIAlertViews with block handlers for button taps. This class supports both ARC and Non-ARC projects. 

Example usage:
```objective-c
    [QuickAlert showMessage:@"Hey there!"
                  withTitle:@"Popup Message"
                 buttonText:@"Tap here to continue!"
                actionBlock: ^ {
                    NSLog(@"User tapped to continue");
    }];
```

**AsyncDownloader** -
Contains convenient class methods for downloading resources or files asynchronously with block handlers for completion, failure, and monitoring download progress

Example usage:
```objective-c
    [AsyncDownloader downloadFromURL:@"www.website.com/image.png"
                      withCompletion: ^ (NSData *apData)
    {
        UIImage *imageInstance = [UIImage imageWithData:apData];
    }
                         withFailure: ^ (NSError *apError)
    {
        // handle error
    }
                 withProgressHandler: ^ (NSUInteger aDownloadedBytes, NSUInteger aTotalBytes)
    {
        NSLog(@"Download progress: %d/%d", aDownloadedBytes, aTotalBytes);
    }];
```

**DXLogger** - 
Custom logger that can be easily edited, used to show the originating class and line number from where the log was called. It only logs when in DEBUG mode, release/production disables all logging.

**FileManager** -
Wrapper class for NSFileManager that contains many convenience methods for creating/moving/deleting/copying files and directories as well as returning common directory paths (Documents, Support, Temp, ect...)

**MapWrapper** -
Wrapper class for quickly opening latitude/longitude or addresses in google or apple maps

**NSString+Extensions** -
Contains helper methods for easily URL encoding strings

**UIDevice+Extensions** - 
Contains helper methods for detecting 4" screen, iOS 7 devices, iPad or iPhone devices, ect...
