//
//  ViewController.h
//  ToDo
//
//  Created by Mac on 03/12/15.
//  Copyright © 2015 mobileacademy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

- (IBAction)buttonClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

