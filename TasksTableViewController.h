//
//  TasksTableViewController.h
//  Hw2-ToDoList
//
//  Created by Alberto Campos on 1/25/14.
//  Copyright (c) 2014 Alberto Campos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TasksTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSString *listPath;
}
@property (strong, nonatomic) IBOutlet UITextField *customTaskTextField;
@property (strong, nonatomic) IBOutlet UIButton *addButton;

- (IBAction)addButton:(id)sender;
- (IBAction)customTaskTextField:(id)sender;
- (IBAction)customTaskTouchOutside:(id)sender;
- (IBAction)customAddTaskTextEdit:(id)sender;

@end
