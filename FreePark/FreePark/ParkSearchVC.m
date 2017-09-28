//
//  ParkSearchVC.m
//  FreePark
//
//  Created by zhangwx on 15/12/26.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import "ParkSearchVC.h"
#import "ParkRequests.h"
#import "ParkEntity.h"
#import "MBProgressHUD.h"
#import "NSObject+Commen.h"
#import "IQKeyboardManager.h"

@interface ParkSearchVC () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    NSString *currCityStr;
}

@property (weak, nonatomic) IBOutlet UIButton *currCity;
@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet UIView *searchFieldBG;
@property (weak, nonatomic) IBOutlet UIButton *cleanSearchFieldBtn;
@property (weak, nonatomic) IBOutlet UITableView *listView;
@property (weak, nonatomic) IBOutlet UITableView *cityList;
@property (weak, nonatomic) IBOutlet UIView *citylistdimView;
@property (weak, nonatomic) IBOutlet UILabel *myPositionLabel;

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSMutableArray *cities;

@property (weak, nonatomic) MBProgressHUD *hud;

@end

@implementation ParkSearchVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.cities = [[NSMutableArray alloc] initWithArray:@[@"北京",@"上海",@"广州",@"深圳"]];
    NSString *city = self.cities[[[DataManager cityIndex] integerValue]];
    currCityStr = [city stringByAppendingString:@"市"];
    self.dataSource = [[NSMutableArray alloc] init];
    self.listView.tableFooterView = [[UIView alloc] init];
    
    self.searchFieldBG.layer.cornerRadius = 15;
    
    [ParkRequests requestCurrentAddress:^(BOOL issuccess, NSString *ret) {
        self.myPositionLabel.text = ret;
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
}

#pragma mark Actions

- (IBAction)cleanSearchField:(id)sender
{
    self.searchField.text = @"";
}

- (IBAction)actionShowCityChoice:(id)sender
{
    self.citylistdimView.hidden = NO;
}

- (IBAction)actionSearch:(id)sender
{
//    [self.searchField resignFirstResponder];
//    [self searchPark:self.searchField.text];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)tapDimView
{
    self.citylistdimView.hidden = YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *retStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self searchPark:retStr];
    return YES;
}

#pragma mark Search

- (void)searchPark:(NSString *)str
{
    [ParkRequests requestParkSearchToCoor:str City:currCityStr complete:^(BOOL issuccess, NSArray *retPositions) {
        
        [self.dataSource removeAllObjects];
        
        if (issuccess) {
            if (retPositions.count > 0) {
                [self.dataSource addObjectsFromArray:retPositions];
                self.listView.hidden = NO;
            }else{
                [Utils showToastWithMessage:@"没有找到相应的停车场"];
                self.listView.hidden = YES;
            }
        }else{
            [Utils showToastWithMessage:@"没有找到相应的停车场"];
            self.listView.hidden = YES;
        }
        [self.listView reloadData];
    }];
}

#pragma mark TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.cityList) {
        return self.cities.count;
    }
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.cityList) {
        static NSString *cityCellID = @"citycell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cityCellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cityCellID];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.separatorInset = UIEdgeInsetsMake(0, 5, 0, 0);
        cell.textLabel.text = self.cities[indexPath.row];
        
        return cell;
    }else{
        static NSString *cellID = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        }
        NSDictionary *entity = self.dataSource[indexPath.row];
        cell.textLabel.text = entity[@"parkName"];
        cell.imageView.image = [UIImage imageNamed:@"searchrsticon"];
        cell.textLabel.textColor = UIColorFromHex(0x787ea0);
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.cityList) {
        NSString *city = self.cities[indexPath.row];
        currCityStr = [city stringByAppendingString:@"市"];
        [self.currCity setTitle:city forState:UIControlStateNormal];
        self.citylistdimView.hidden = YES;
    }else{
        NSDictionary *entity = self.dataSource[indexPath.row];
        CLLocationCoordinate2D position = CLLocationCoordinate2DMake([entity[@"parkPosition"][@"lat"] doubleValue], [entity[@"parkPosition"][@"lng"] doubleValue]);
        [self.delegate parkSearchResult:position searchStr:entity[@"parkName"]];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
