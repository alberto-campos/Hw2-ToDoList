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
{
    CustomCell *model;
}

@property (nonatomic, strong)NSMutableDictionary *task;
@property (nonatomic, strong)NSMutableArray *todoArray;


-(void)saveToPlist;
-(void)updatePlist;

@end

@implementation TasksTableViewController

@synthesize task, todoArray;


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
    
    
    

    
    
    
    
    
    
    [self.customTaskTextField addTarget:self.customTaskTextField action:@selector(resignFirstResponder) forControlEvents:UIControlEventEditingDidEndOnExit];
     
    listPath = [[self docsDir]stringByAppendingPathComponent:@"todo.plist"];
    
    //TODO: check if PLIST file is corrupted or has any issues warn user and exit.
    //if (![[NSFileManager defaultManager]fileExistsAtPath:listPath])
    //{
        [[NSFileManager defaultManager]copyItemAtPath:[[NSBundle mainBundle] pathForResource:@"todo" ofType:@"plist"] toPath:listPath error:nil];
   // }

    todoArray = [NSMutableArray arrayWithContentsOfFile:listPath];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.title = @"To Do List";
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
    
    //task = tasksArray[indexPath.row];
    NSString *taskTitle = todoArray[indexPath.row];

    customCell.CustomTitleLabel.text = taskTitle;
    customCell.CustomRecurringLabel.text = @"Uncategorized";
    
    
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
        [self.view endEditing:YES];
        [todoArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self saveToPlist];
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
    self.customTaskTextField.text = @"";
    [todoArray writeToFile:listPath atomically:YES];
    NSLog(@"Success: %@", listPath);
}

-(void)updatePlist
{
    [todoArray insertObject:self.customTaskTextField.text atIndex:0];
    [self saveToPlist];
    [self.tableView reloadData];
}

//-(void)sortArrayAlpha
//{
//    NSSortDescriptor *sortDescriptor;
//    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:todoArray ascending:YES];
//    NSMutableArray *sortDescriptors = [NSMutableArray arrayWithObject:sortDescriptor];
//    NSMutableArray *sortedArray;
//    todoArray = [todoArray sortedArrayUsingDescriptors:sortDescriptors];
//}

- (IBAction)addButton:(id)sender
{
    [self.view endEditing:YES];
    [self updatePlist];
    
    
}

- (IBAction)customTaskTextField:(id)sender {
    
    if (self.customTaskTextField.text.length > 0)
    {
        [self.addButton setEnabled:TRUE];
    }
    else
    {
        [self.addButton setEnabled:FALSE];
    }
}

- (IBAction)customTaskTouchOutside:(id)sender {
    
    [self.view endEditing:YES];
    
    if (self.customTaskTextField.text.length > 0)
    {
        [self.addButton setEnabled:FALSE];
       
    }
}

- (IBAction)customAddTaskTextEdit:(id)sender {
    
    [self updatePlist];
}

// Inside tableView:cellForRowAtIndexPath:
//
//CustomCell.CustomTitleLabel.lineBreakMode = UILineBreakModeWordWrap;
//CustomCell.CustomTitleLabel.numberOfLines = self.numberOfTextRows;
// numberOfTextRows is an integer, declared in the class




- (CGFloat)heightForTextView:(UITextView*)textView containingString:(NSString*)string
{
    float horizontalPadding = 24;
    float verticalPadding = 16;
    float widthOfTextView = textView.contentSize.width - horizontalPadding;
    float height = [string sizeWithFont:[UIFont systemFontOfSize:18.0] constrainedToSize:CGSizeMake(widthOfTextView, 999999.0f) lineBreakMode:NSLineBreakByWordWrapping].height + verticalPadding;
    
    return height;
}

- (void) textViewDidChange:(UITextView *)textView
{
    model = textView.text;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
}

@end
