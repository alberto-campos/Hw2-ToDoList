//
//  TasksTableViewController.m
//  Hw2-ToDoList
//
//  Created by Alberto Campos on 1/25/14.
//  Copyright (c) 2014 Alberto Campos. All rights reserved.
//

#import "TasksTableViewController.h"
#import "CustomCell.h"

@interface TasksTableViewController ()

@property (nonatomic, strong)NSMutableArray *tasksArrayTEMP;
@property (nonatomic, strong)NSMutableDictionary *task;

@property (nonatomic, strong)NSMutableArray *todoArray;


-(void)saveToPlist;

@end

@implementation TasksTableViewController

@synthesize tasksArrayTEMP, task, todoArray;


-(NSString *)docsDir
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    //listPath = [[self docsDir]stringByAppendingPathComponent:@"tasks.plist"];
    listPath = [[self docsDir]stringByAppendingPathComponent:@"todo.plist"];
    
    //TODO: check if PLIST file is corrupted or has any issues warn user and exit.
    //if (![[NSFileManager defaultManager]fileExistsAtPath:listPath])
    //{
        //[[NSFileManager defaultManager]copyItemAtPath:[[NSBundle mainBundle] pathForResource:@"tasks" ofType:@"plist"] toPath:listPath error:nil];
        [[NSFileManager defaultManager]copyItemAtPath:[[NSBundle mainBundle] pathForResource:@"todo" ofType:@"plist"] toPath:listPath error:nil];
   // }
    
   // tasksArray = [NSArray arrayWithContentsOfFile:listPath];
   // todoArray = [NSMutableArray arrayWithContentsOfFile:listPath];
    todoArray = [NSMutableArray arrayWithContentsOfFile:listPath];
    
   // NSMutableDictionary *allTasks = [NSMutableDictionary dictionaryWithContentsOfFile:listPath];
    
    //NSLog(@"count: %i", [tasksArray count]);
    NSLog(@"count: %i", [todoArray count]);
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return [tasksArray count];
    return [todoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CustomCell *customCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
//    task = tasksArray[indexPath.row];
//    NSString *taskTitle = task[@"Title"];
//    NSString *taskCategory = task[@"Category"];
//    NSString *icon = task[@"Icon"];
//    BOOL taskComplete = task[@"Complete"];
//    UIImage *taskImage = [UIImage imageNamed:icon];
//    customCell.CustomTitleLabel.text = taskTitle;
//    customCell.CustomRecurringLabel.text = taskCategory;
 
    //task = tasksArray[indexPath.row];
    NSString *taskTitle = todoArray[indexPath.row];

    customCell.CustomTitleLabel.text = taskTitle;
    customCell.CustomRecurringLabel.text = @"Recurring";
    
    
    return customCell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

-(void)saveToPlist
{
    [todoArray writeToFile:listPath atomically:YES];
    NSLog(@"Success: %@", listPath);
}

-(void)deleteFromPlist
{
    
}

- (IBAction)addButton:(id)sender
{
    // User tapped the 'add' button
    
    [todoArray addObject:self.customTaskTextField.text];
    [self saveToPlist];
    
    //Leave it for now. Going back to arrays.
//    [task setObject:@"Icon" forKey:@"Icon"];
//    [task setValue:self.customTaskTextField.text forKey:@"Title"];
//    [task setValue:self.customTaskTextField.text forKey:@"Category"];
//    [task setValue:self.customTaskTextField.text forKey:@"Due"];
//    [task setValue:self.customTaskTextField.text forKey:@"Created"];
//    [task setValue:self.customTaskTextField.text forKey:@"Complete"];
//    [tasksArray addObject:task];
    
}

@end
