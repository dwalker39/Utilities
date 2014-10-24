//
//  UIViewControllerUtils.swift
//  One
//
//  Created by Derrick Walker on 10/23/14.
//  Copyright (c) 2014 Derrick Walker. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    typealias OptionalClosure = (() -> Void)?
    
    func showMessage(message: String?, title: String?) {
        self.showMessage(message,
            title: title,
            buttonCancelText: "OK",
            button1Text: nil,
            button2Text: nil,
            button3Text: nil,
            button4Text: nil,
            cancelAction: nil,
            button1Action: nil,
            button2Action: nil,
            button3Action: nil,
            button4Action: nil)
    }
    
    func showMessage(message: String?, title: String?, buttonText: String?, buttonAction: OptionalClosure) {
        self.showMessage(message,
            title: title,
            buttonCancelText: buttonText,
            button1Text: nil,
            button2Text: nil,
            button3Text: nil,
            button4Text: nil,
            cancelAction: buttonAction,
            button1Action: nil,
            button2Action: nil,
            button3Action: nil,
            button4Action: nil)
    }
    
    func showMessage(message: String?, title: String?, buttonCancelText: String?, buttonText: String?, buttonCancelAction: OptionalClosure, buttonAction: OptionalClosure) {
        self.showMessage(message,
            title: title,
            buttonCancelText: buttonCancelText,
            button1Text: buttonText,
            button2Text: nil,
            button3Text: nil,
            button4Text: nil,
            cancelAction: buttonCancelAction,
            button1Action: buttonAction,
            button2Action: nil,
            button3Action: nil,
            button4Action: nil)
    }
    
    func showMessage(message: String?, title: String?, buttonCancelText: String?, button1Text: String?, button2Text: String?, buttonCancelAction: OptionalClosure, button1Action: OptionalClosure, button2Action: OptionalClosure) {
        self.showMessage(message,
            title: title,
            buttonCancelText: buttonCancelText,
            button1Text: button1Text,
            button2Text: button2Text,
            button3Text: nil,
            button4Text: nil,
            cancelAction: buttonCancelAction,
            button1Action: button1Action,
            button2Action: button2Action,
            button3Action: nil,
            button4Action: nil)
    }
    
    func showMessage(message: String?, title: String?, buttonCancelText: String?, button1Text: String?, button2Text: String?, button3Text: String?, buttonCancelAction: OptionalClosure, button1Action: OptionalClosure, button2Action: OptionalClosure, button3Action: OptionalClosure) {
        self.showMessage(message,
            title: title,
            buttonCancelText: buttonCancelText,
            button1Text: button1Text,
            button2Text: button2Text,
            button3Text: button3Text,
            button4Text: nil,
            cancelAction: buttonCancelAction,
            button1Action: button1Action,
            button2Action: button2Action,
            button3Action: button3Action,
            button4Action: nil)
    }
    
    func showMessage(message: String?, title: String?, buttonCancelText: String?, button1Text: String?, button2Text: String?, button3Text: String?, button4Text: String?, cancelAction: OptionalClosure, button1Action: OptionalClosure, button2Action: OptionalClosure, button3Action: OptionalClosure, button4Action: OptionalClosure) {
        let currentVersion = UIDevice.currentDevice().systemVersion as NSString

        if currentVersion.floatValue < 8 {
            QuickAlert.showMessage(message, withTitle: title, buttonCancel: buttonCancelText, button1: button1Text, button2: button2Text, button3: button3Text, button4: button4Text, cancelBlock: cancelAction, action1Block: button1Action, action2Block: button2Action, action3Block: button3Action, action4Block: button4Action)
        } else {
            func createAlertActionHandlerIfPossible(action: OptionalClosure) -> ((UIAlertAction!) -> Void)? {
                var alertAction: (UIAlertAction!) -> Void = {
                    (UIAlertAction) -> Void in
                    
                    if action != nil {
                        action!()
                    }
                }
                
                return alertAction
            }
            
            func createAlertActionIfPossible(title: String, style: UIAlertActionStyle, handler: OptionalClosure) -> UIAlertAction? {
                var alertActionHandler = createAlertActionHandlerIfPossible(handler)
                if let _alertActionHandler = alertActionHandler {
                    var alertAction = UIAlertAction(title: title, style: style, handler: alertActionHandler)
                    
                    return alertAction
                }
                
                return nil
            }
            
            var actionsArray = Array<UIAlertAction>()
            
            if buttonCancelText != nil {
                var action = createAlertActionIfPossible(buttonCancelText!, .Cancel, cancelAction)
                
                if action != nil {
                    actionsArray.append(action!)
                }
            }
            
            if button1Text != nil {
                var action = createAlertActionIfPossible(button1Text!, .Default, button1Action)
                
                if action != nil {
                    actionsArray.append(action!)
                }
            }
            
            if button2Text != nil {
                var action = createAlertActionIfPossible(button2Text!, .Default, button2Action)
                
                if action != nil {
                    actionsArray.append(action!)
                }
            }
            
            if button3Text != nil {
                var action = createAlertActionIfPossible(button3Text!, .Default, button3Action)
                
                if action != nil {
                    actionsArray.append(action!)
                }
            }
            
            if button4Text != nil {
                var action = createAlertActionIfPossible(button4Text!, .Default, button4Action)
                
                if action != nil {
                    actionsArray.append(action!)
                }
            }
            
            self.showAlert(title, message: message, actions: actionsArray)
        }
    }
    
    private func showAlert(title: String?, message: String?, actions: [UIAlertAction]) {
        self.showAlert(title: title, message: message, animated: true, completion: nil, actions: actions)
    }
    
    private func showAlert(#title: String?, message: String?, animated: Bool, completion: (() -> Void)?, actions: [UIAlertAction]) {
        if (title == nil && message == nil) {
            return;
        }
        
        var alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    
        for action in actions {
            alertController.addAction(action)
        }
        
        self.presentViewController(alertController, animated: animated, completion: completion)
    }
    
    func showAlert(#title: String?, message: String?, animated: Bool, completion: (() -> Void)?, actions: UIAlertAction?...) {
        if (title == nil && message == nil) {
            return;
        }
        
        var alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        for action in actions {
            if let _action = action {
                alertController.addAction(_action)
            } else {
                alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            }
        }
        
        self.presentViewController(alertController, animated: animated, completion: completion)
    }
}





