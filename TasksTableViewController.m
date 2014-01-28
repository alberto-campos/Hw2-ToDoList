//
//  TasksTableViewController.m
//  Hw2-ToDoList
//
//  Created by Alberto Campos on 1/25/14.
//  Copyright (c) 2014 Alberto Campos. All rights reserved.
//

#import "TasksTableViewController.h"
#import "CustomCell.h"

#define kFontSize 15.0 // fontsize
#define kTextViewWidth 206

@interface TasksTableViewController ()
{
    CustomCell *myCell;
}

@property (nonatomic, strong)NSMutableDictionary *task;
@property (nonatomic, strong)NSMutableArray *todoArray;


-(void)saveToPlist;
-(void)updatePlist;
-(NSInteger)getHeight:(NSString *)str;

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
    [self.customTaskTextField becomeFirstResponder];
    
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
    return [todoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    myCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *taskTitle = todoArray[indexPath.row];
    myCell.customTextView.text = taskTitle;
    
    return myCell;
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
        NSObject *tempObj = myCell.customTextView.text;
        [todoArray insertObject:tempObj atIndex:indexPath.row];
        [self saveToPlist];
    }   
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    
    NSObject *tempObj = [todoArray objectAtIndex:fromIndexPath.row];
    [todoArray removeObjectAtIndex:fromIndexPath.row];
    [todoArray insertObject:tempObj atIndex:toIndexPath.row];
    [self saveToPlist];
    
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
    
    if (![self.customTaskTextField.text isEqual: @""])
    {
        [todoArray insertObject:self.customTaskTextField.text atIndex:0];
        [self saveToPlist];
        [self.tableView reloadData];
    }
    [self.addButton setEnabled:FALSE];
}

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

- (IBAction)customUpdate:(id)sender {
    
    [self.view endEditing:YES];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:myCell];
    NSObject *tempObj = myCell.customTextView.text;
    
    [todoArray insertObject:tempObj atIndex:indexPath.row];
    [self saveToPlist];
    NSLog(@"updating...");
}

- (void) textViewDidChange:(UITextView *)textView
{
    myCell.model = textView.text;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

- (void) textViewDidEndEditing:(UITextView *)textView
{
    if (textView == myCell.customTextView) {
        myCell.model = textView.text;
    }
}


-(NSInteger)getHeight:(NSString *)str
{
    NSInteger thisHeight;
    thisHeight = (str.length / kTextViewWidth) + 1;
    
    return thisHeight * 44;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *mytext = todoArray[indexPath.row];
    myCell.customTextView.text = mytext;
    
    if (indexPath.section == 0 && indexPath.row == 0) {

        if (myCell.customTextView.contentSize.height >= 44) {
            return  [self getHeight:mytext] + 10;
        }
        else
        {
            return  [self getHeight:mytext];
        }
        
    }
    else
    {
        return  [self getHeight:mytext];
    }
}


@end
