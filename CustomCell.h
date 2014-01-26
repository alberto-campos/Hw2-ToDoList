//
//  CustomCell.h
//  Hw2-ToDoList
//
//  Created by Alberto Campos on 1/25/14.
//  Copyright (c) 2014 Alberto Campos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *CustomTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *CustomRecurringLabel;
@property (strong, nonatomic) IBOutlet UILabel *CustomDueLabel;
@property (strong, nonatomic) IBOutlet UIImageView *CustomIconImage;



@end
