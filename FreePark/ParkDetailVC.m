//
//  ParkDetailVC.m
//  FreePark
//
//  Created by zhangwx on 15/12/14.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import "ParkDetailVC.h"
#import "ParkCommentVC.h"
#import "TagPasteVC.h"
#import "ParkTagCell.h"
#import "ParkCommonCell.h"
#import "ParkRequests.h"
#import "NSString+StringSize.h"
#import "MJRefresh.h"
#import "WXApi.h"
#import "WeiboSDK.h"
#import "Share.h"
#import "MBProgressHUD.h"
#import "NSObject+Commen.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetItem.h>
#import "ShareAlterViewNodelete.h"
#import "UserRequests.h"

#define openBTag 16758
#define editBTag 1675800
#define deleteBTag 167580000

@interface ParkDetailVC () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate,ShareAlterViewNodeleteDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *listView;

@property (nonatomic, strong) NSString *shareReason;
@property (nonatomic, strong) NSMutableArray *tags;
@property (nonatomic, strong) NSMutableArray *orderedTags;
@property (nonatomic, strong) NSMutableArray *comments;
@property (nonatomic, strong) NSMutableArray *openedComment;

@property (strong, nonatomic) IBOutlet UITableViewCell *parkTagCell;
@property (weak, nonatomic) IBOutlet UICollectionView *parkTagsView;

@property (strong, nonatomic) IBOutlet UITableViewCell *parkPriceCell;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *sharerID;
@property (weak, nonatomic) IBOutlet UILabel *lastUpdateTime;
@property (weak, nonatomic) IBOutlet UIButton *commentB;
@property (weak, nonatomic) IBOutlet UIButton *pasteButton;
@property (weak, nonatomic) IBOutlet UIButton *shareB;
@property (weak, nonatomic) IBOutlet UIButton *collectionB;

@property (nonatomic) NSInteger currPage;
@property (nonatomic) NSInteger totalpage;

@property (nonatomic,strong) ShareAlterViewNodelete *shareNotDeleteView;

@property (weak, nonatomic) IBOutlet UIView *recoverDimView;
@property (weak, nonatomic) IBOutlet UITextView *commentCoverField;
@property (weak, nonatomic) IBOutlet UIButton *recoverSureB;
@property (weak, nonatomic) IBOutlet UILabel *recoverTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *recoverButtom;

@property (strong, nonatomic) NSString *currReplyName;
@property (weak, nonatomic) NSDictionary *currEditComment;
@property (nonatomic) BOOL isRecover;

@property (strong, nonatomic) NSString *lastModifyTime;
@property (nonatomic, strong) NSString *creator;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint4;

@end

@implementation ParkDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.listView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^(){
        [self loadMoreComments];
    }];
    
    self.tags = [[NSMutableArray alloc] init];
    self.comments = [[NSMutableArray alloc] init];
    self.openedComment = [[NSMutableArray alloc] init];
    
    self.priceLabel.text = (self.parkEntity.parkStopprice.length > 0 ? self.parkEntity.parkStopprice : self.parkEntity.parPriceTime);
    
    self.collectionB.selected = [self.parkEntity.hasCollected boolValue];
    self.collectionB.backgroundColor = self.collectionB.selected ? UIColorFromHex(0x58C3DA) : [UIColor whiteColor];
    
    self.commentB.layer.borderWidth = 1;
    self.commentB.layer.borderColor = UIColorFromHex(0x58C3DA).CGColor;
    self.commentB.layer.cornerRadius = 15;
    
    self.pasteButton.layer.borderWidth = 1;
    self.pasteButton.layer.borderColor = UIColorFromHex(0x58C3DA).CGColor;
    self.pasteButton.layer.cornerRadius = 15;
    
    self.shareB.layer.borderWidth = 1;
    self.shareB.layer.borderColor = UIColorFromHex(0x58C3DA).CGColor;
    self.shareB.layer.cornerRadius = 15;
    
    self.collectionB.layer.borderWidth = 1;
    self.collectionB.layer.borderColor = UIColorFromHex(0x58C3DA).CGColor;
    self.collectionB.layer.cornerRadius = 15;
    
    self.leftConstraint.constant = self.leftConstraint2.constant = self.leftConstraint3.constant = self.leftConstraint4.constant = ([UIScreen mainScreen].bounds.size.width - 280) / 5;
    
    [self.parkTagsView registerNib:[UINib nibWithNibName:@"ParkTagCell" bundle:nil] forCellWithReuseIdentifier:@"ParkTagCell"];
    
    [self setupShareView];
    
    [self requestParkDetail];
}

- (void)requestParkAddress
{
    [ParkRequests requestParkShareReason:self.parkEntity.parkName complete:^(BOOL issuccess, NSString *reason) {
        if (issuccess) {
            self.shareReason = reason;
            [self.listView reloadData];
        }
    }];
}

- (void)requestParkDetail
{
    [UserRequests requestGetParkDetailById:self.parkEntity.parkId andCityIndex:self.parkEntity.cityIndex ? self.parkEntity.cityIndex : [DataManager cityIndex] complete:^(BOOL issuccess, NSString *name, NSString *description, NSString *stopPrice, NSString *priceTime, NSString *sid,NSString *lastModifyTime,NSString *creator,NSNumber *hasCollected) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        self.lastModifyTime = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[lastModifyTime doubleValue]]];
        self.creator = creator;
        self.sharerID.text = self.creator;
        self.lastUpdateTime.text = self.lastModifyTime;
        self.collectionB.selected = [hasCollected boolValue];
        self.collectionB.backgroundColor = [hasCollected boolValue] ? UIColorFromHex(0x58C3DA) : [UIColor whiteColor];
        [self.listView reloadData];
    }];
}

//"resultlist":[{
//    “labelName”:”xxx”,
//    “count”:”xxx”,
//},{
//    “labelName”:”xxx”,
//    “count”:”xxx”,
//}]
- (void)requestTags
{
    [ParkRequests requestParkTags:self.parkEntity.parkId andCityIndex:[DataManager cityIndex] complete:^(BOOL issuccess, NSArray *parkTags) {
        if (issuccess) {
            [self.tags removeAllObjects];
            [self.tags addObjectsFromArray:parkTags];
            
            self.orderedTags = [NSMutableArray arrayWithArray:[self.tags sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                return [obj1[@"count"] intValue]  < [obj2[@"count"] intValue];
            }]];
            self.tags = self.orderedTags;
            [self.parkTagsView reloadData];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.listView reloadData];
            });
        }
    }];
}

- (void)requestComments
{
    [ParkRequests requestParkComment:self.parkEntity.parkId pageSize:@"10" pageIndex:@"1" andCityIndex:[DataManager cityIndex] complete:^(BOOL issuccess, NSArray *parkCommens, NSInteger totalPage) {
        if (issuccess) {
            self.currPage = 1;
            self.totalpage = totalPage;
            if (self.currPage >= totalPage) {
                self.listView.footer.hidden = YES;
            }else{
                self.listView.footer.hidden = NO;
            }
            [self.comments removeAllObjects];
            [self.openedComment removeAllObjects];
            [self.comments addObjectsFromArray:parkCommens];
            [self.listView reloadData];
        }
    } ];
}

- (void)loadMoreComments
{
    if (self.currPage >= self.totalpage) {
        [self.listView.footer endRefreshing];
        return;
    }
    [ParkRequests requestParkComment:self.parkEntity.parkId pageSize:@"10" pageIndex:[NSString stringWithFormat:@"%i", self.currPage+1]  andCityIndex:[DataManager cityIndex] complete:^(BOOL issuccess, NSArray *parkCommens, NSInteger totalPage) {
        [self.listView.footer endRefreshing];
        if (issuccess) {
            self.currPage++;
            self.totalpage = totalPage;
            
            if (self.currPage >= totalPage) {
                self.listView.footer.hidden = YES;
            }else{
                self.listView.footer.hidden = NO;
            }
            
            [self.comments addObjectsFromArray:parkCommens];
            [self.parkTagsView reloadData];
        }
    } ];
}
- (void)setupShareView
{
    //没有删除的view
    ShareAlterViewNodelete *shareViewNodelete =   [[NSBundle mainBundle] loadNibNamed:@"ShareAlterViewNodelete" owner:nil options:nil][0];
    shareViewNodelete.delegate = self;
    shareViewNodelete.supperVC = self;
    shareViewNodelete.frame = CGRectMake(0, self.navigationController.view.frame.size.height, self.navigationController.view.frame.size.width, 180);
    [self.navigationController.view addSubview:shareViewNodelete];
    self.shareNotDeleteView = shareViewNodelete;
    
}

#pragma mark - shareViewNodelete代理
- (void)chooseActionNodeleteAtIndex:(NSInteger)index
{
    [self.shareNotDeleteView hideView];
}
- (void)chooseShareNodeleteTypeAtIndex:(NSInteger)index{
    [self shareToPlatform:index];
}
- (void)shareToPlatform:(NSInteger)index
{
    [self.shareNotDeleteView hideView];
    SSDKPlatformType ssdkType;
    if(index == 0)//新浪微博
    {
        ssdkType = SSDKPlatformTypeSinaWeibo;
    }
    else if(index == 1)//微信会话
    {
        ssdkType = SSDKPlatformSubTypeWechatSession;
    }
    else if(index == 2)//微信朋友圈
    {
        ssdkType = SSDKPlatformSubTypeWechatTimeline;
    }
//    self.ssdkType = ssdkType;
    NSString *shareTxt = [NSString stringWithFormat:@"地点：%@\n价格：%@\n详情：%@",self.parkEntity.parkName,(self.parkEntity.parkStopprice.length > 0 ? self.parkEntity.parkStopprice : self.parkEntity.parPriceTime),self.parkEntity.parkDescription];
    NSString *shareTitle = @"来看看我从“0元停车”找到的廉价停车场，帮大家节省停车费。";
    
    UIImage *shareImg = [UIImage imageNamed:@"shareIcon"];
    [Share shareWithType:ssdkType content:shareTxt defaultContent:shareTxt image:shareImg title:shareTitle url:[NSString stringWithFormat:@"http://a.app.qq.com/o/simple.jsp?pkgname=com.water.park"] description:nil result:^{
    }];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self requestComments];
    [self requestParkAddress];
    [self requestTags];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionComment:(id)sender
{
    ParkCommentVC *commentVC = [[ParkCommentVC alloc] initWithNibName:@"ParkCommentVC" bundle:nil];
    commentVC.parkEntity = self.parkEntity;
    [self.navigationController pushViewController:commentVC animated:YES];
}

- (IBAction)actionPasteTag:(id)sender {
    
    TagPasteVC *vc = [[TagPasteVC alloc] initWithNibName:@"TagPasteVC" bundle:nil];
    vc.parkEntity = self.parkEntity;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)actionShare:(id)sender
{
//    来看看我从“0元停车”找到的廉价停车场，帮大家节省停车费。
//    地点：XXXX
//    价格：0元/小时（或0元/次）
//    详情：XXXX
    
//    NSString *shareTxt = [NSString stringWithFormat:@"地点：%@\n价格：%@\n详情：%@",self.parkEntity.parkName,self.parkEntity.parkStopprice,self.parkEntity.parkDescription];
//    NSString *shareTitle = @"来看看我从“0元停车”找到的廉价停车场，帮大家节省停车费。";
//    
//    NSURL *shareUrl = [NSURL URLWithString:@"https://www.gybyy.com/api/app/download/"];
//    
//    UIImage *shareImg = [UIImage imageNamed:@"shareIcon"];
//    
//    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
//    NSString *shareTxt2 = [NSString stringWithFormat:@"%@%@",shareTxt,@"https://www.gybyy.com/api/app/download/"];
//    [param SSDKSetupSinaWeiboShareParamsByText:shareTxt2 title:shareTitle image:shareImg url:shareUrl latitude:[self.parkEntity.mapLat doubleValue] longitude:[self.parkEntity.mapLng doubleValue] objectID:@"ss" type:SSDKContentTypeImage];
//    
//    [param SSDKSetupWeChatParamsByText:shareTxt title:shareTitle url:shareUrl thumbImage:nil image:shareImg musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeWechatSession];
//    
//    [param SSDKSetupWeChatParamsByText:shareTxt title:shareTitle url:shareUrl thumbImage:nil image:shareImg musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeWechatTimeline];
//    
//    
//    [param SSDKSetupSMSParamsByText:shareTxt title:shareTitle images:shareImg attachments:nil recipients:nil type:SSDKContentTypeAuto];
//  
//    
//    [param SSDKEnableUseClientShare];
//
//    SSUIShareActionSheetController *sheet =  [ShareSDK showShareActionSheet:self.parkPriceCell items:@[@(SSDKPlatformTypeSinaWeibo),@(SSDKPlatformSubTypeWechatSession),@(SSDKPlatformSubTypeWechatTimeline),@(SSDKPlatformTypeSMS)] shareParams:param onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
//        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
//        switch (state) {
//                
//            case SSDKResponseStateSuccess:
//            {
//                [Utils showToastWithMessage:@"分享成功"];
////                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
////                                                                    message:nil
////                                                                   delegate:nil
////                                                          cancelButtonTitle:@"确定"
////                                                          otherButtonTitles:nil];
////                [alertView show];
//                break;
//            }
//            case SSDKResponseStateFail:
//            {
//                if (platformType == SSDKPlatformTypeSMS && [error code] == 201)
//                {
//                    [Utils showToastWithMessage:@"分享失败"];
////                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
////                                                                    message:@"失败原因可能是：1、短信应用没有设置帐号；2、设备不支持短信应用；3、短信应用在iOS 7以上才能发送带附件的短信。"
////                                                                   delegate:nil
////                                                          cancelButtonTitle:@"OK"
////                                                          otherButtonTitles:nil, nil];
////                    [alert show];
//                    break;
//                }
//                else if(platformType == SSDKPlatformTypeMail && [error code] == 201)
//                {
//                    [Utils showToastWithMessage:@"分享失败"];
////                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
////                                                                    message:@"失败原因可能是：1、邮件应用没有设置帐号；2、设备不支持邮件应用；"
////                                                                   delegate:nil
////                                                          cancelButtonTitle:@"OK"
////                                                          otherButtonTitles:nil, nil];
////                    [alert show];
//                    break;
//                }
//                else
//                {
//                    [Utils showToastWithMessage:@"分享失败"];
//                    break;
//                }
//                break;
//            }
//            case SSDKResponseStateCancel:
//            {
//                [Utils showToastWithMessage:@"分享已取消"];
//                break;
//            }
//            default:
//                break;
//        }
//    }];
//    [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSinaWeibo)];
    
    [self.shareNotDeleteView showView];
}

- (IBAction)actionCollection:(UIButton *)sender
{
    MBProgressHUD *hud = [self.navigationController.view showLoading:@""];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    param[@"id"] = self.parkEntity.parkId;
    param[@"userName"] = [DataManager getUserName];
    param[@"parkName"] = self.parkEntity.parkName;
    param[@"cityIndex"] = [DataManager cityIndex];
    if (sender.selected) {
        [ParkRequests sendParkUnCollect:param complete:^(BOOL issuccess, NSString *parkAddr) {
            if (issuccess) {
                sender.selected = !sender.selected;
                sender.backgroundColor = sender.selected ? UIColorFromHex(0x58C3DA) : [UIColor whiteColor];
            }
            [self.navigationController.view stopLoading:hud];
        }];
    }else{
        [ParkRequests sendParkCollect:param complete:^(BOOL issuccess, NSString *parkAddr) {
            if (issuccess) {
                sender.selected = !sender.selected;
                sender.backgroundColor = sender.selected ? UIColorFromHex(0x58C3DA) : [UIColor whiteColor];
            }
            [self.navigationController.view stopLoading:hud];
        }];
    }
}

- (IBAction)actionBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionCancelRecover:(id)sender
{
    [self.commentCoverField resignFirstResponder];
}

- (IBAction)actionSureRecover:(id)sender
{
    [self.commentCoverField resignFirstResponder];
    NSString *replyTxt = self.commentCoverField.text;
    
    if (self.isRecover) {
        if (replyTxt.length == 0) {
            [Utils showToastWithMessage:@"回复不能为空！"];
            return;
        }
        
        MBProgressHUD *hud = [self.navigationController.view showLoading:@"正在提交"];
        NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
        param[@"id"] = self.parkEntity.parkId;
        param[@"userName"] = [DataManager getUserName];
        param[@"parkName"] = self.parkEntity.parkName;
        param[@"description"] = replyTxt;
        param[@"cityIndex"] = [DataManager cityIndex];
        param[@"replyName"] = self.currReplyName;
        param[@"reviewId"] = self.currEditComment[@"reviewId"];
        
        [ParkRequests sendParkCommentReply:param complete:^(BOOL issuccess, NSString *parkAddr) {
            [self.navigationController.view stopLoading:hud];
            if (issuccess) {
                
                if ([parkAddr intValue] == 70042) {
                    [Utils showToastWithMessage:@"您回复的过于频繁，请稍后再试"];
                }else{
                    [Utils showToastWithMessage:@"回复成功"];
                    [self requestComments];
                }
            }else{
                [Utils showToastWithMessage:@"回复失败"];
            }
        }];
    }else{
        if (replyTxt.length == 0) {
            [Utils showToastWithMessage:@"评论不能为空！"];
            return;
        }
        
        MBProgressHUD *hud = [self.navigationController.view showLoading:@"正在提交"];
        NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
        param[@"id"] = self.parkEntity.parkId;
        param[@"userName"] = [DataManager getUserName];
        param[@"cityIndex"] = [DataManager cityIndex];
        param[@"newCommentContent"] = replyTxt;
        param[@"reviewId"] = self.currEditComment[@"reviewId"];
        
        [ParkRequests sendParkCommentEdit:param complete:^(BOOL issuccess, id json) {
            [self.navigationController.view stopLoading:hud];
            if (issuccess) {
                //TODO修改响应
                if ([json[@"modifyMyCommnetTag"] intValue] == 70050) {
                    [Utils showToastWithMessage:@"修改成功"];
                    [self requestComments];
                }else{
                    [Utils showToastWithMessage:@"修改失败"];
                    [self requestComments];
                }
            }else{
                [Utils showToastWithMessage:@"修改失败"];
            }
        }];
    }
}

#pragma mark UITextViewDelegate

- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.recoverDimView.alpha = 0;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5 + self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 3)
    {
        static NSString *parkDetailCellID = @"ParkDetailTextCell";
        ParkDetailTextCell *cell = [tableView dequeueReusableCellWithIdentifier:parkDetailCellID];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"ParkDetailTextCell" owner:nil options:nil][0];
        }
        switch (indexPath.row) {
            case 0:
            {
                cell.titleL.text = @"地点";
                cell.titleTop.constant = 15;
                cell.contentBottom.constant = 8;
                cell.sharerID.hidden = YES;
                cell.lastModityTime.hidden = YES;
                cell.contentL.text = self.parkEntity.parkName;
            }
                break;
            case 1:
            {
                cell.titleL.text = @"详情";
                cell.titleTop.constant = 15;
                cell.contentBottom.constant = 8;
                cell.sharerID.hidden = YES;
                cell.lastModityTime.hidden = YES;
                cell.contentL.text = [NSString stringWithFormat:@"    %@", self.parkEntity.parkDescription];
            }
                break;
            case 2:
            {
                cell.titleL.text = @"分享理由";
                cell.titleTop.constant = 15;
                cell.contentBottom.constant = 8;
                cell.sharerID.hidden = YES;
                cell.lastModityTime.hidden = YES;
                cell.contentL.text = self.shareReason;
            }
                break;
                
            default:
                break;
        }
        return cell;
    }
    else if (indexPath.row == 3)
    {
        return self.parkTagCell;
    }
    else if (indexPath.row == 4)
    {
        return self.parkPriceCell;
    }
    else
    {
        static NSString *ParkCommonCellID = @"ParkCommonCell";
        ParkCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:ParkCommonCellID];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"ParkCommonCell" owner:nil options:nil][0];
            [cell.openButton addTarget:self action:@selector(parkCommentOpen:) forControlEvents:UIControlEventTouchUpInside];
            [cell.editBtn addTarget:self action:@selector(parkCommentEdit:) forControlEvents:UIControlEventTouchUpInside];
            [cell.deleteBtn addTarget:self action:@selector(parkCommentDelete:) forControlEvents:UIControlEventTouchUpInside];
        }
        NSDictionary *commentDic = self.comments[indexPath.row-5];
        if (commentDic[@"replyTo"] &&
            [commentDic[@"replyTo"] isKindOfClass:[NSString class]] &&
            ((NSString *)commentDic[@"replyTo"]).length > 0) {
//            cell.commonTitle.text = [NSString stringWithFormat:@"%@ %@ 回复 %@", commentDic[@"date"], commentDic[@"userName"], commentDic[@"replyTo"]];
            cell.commonTitle.text = [NSString stringWithFormat:@"%@ %@", commentDic[@"date"], commentDic[@"userName"]];
        }else{
            cell.commonTitle.text = [NSString stringWithFormat:@"%@ %@", commentDic[@"date"], commentDic[@"userName"]];
        }
        
        if ([commentDic[@"userName"] isEqualToString:[DataManager getUserName]]) {
            cell.editBtn.hidden = NO;
            cell.deleteBtn.hidden = NO;
        }else{
            cell.editBtn.hidden = YES;
            cell.deleteBtn.hidden = YES;
        }
        
        cell.commonDetail.text = commentDic[@"content"];
        cell.openButton.tag = openBTag+indexPath.row-5;
        cell.editBtn.tag = editBTag+indexPath.row-5;
        cell.deleteBtn.tag = deleteBTag+indexPath.row-5;
        
//        cell.openButton.hidden = [self.openedComment containsObject:@(indexPath.row-5)];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 44;
    }else if (indexPath.row == 1){
        CGSize size = [[NSString stringWithFormat:@"    %@", self.parkEntity.parkDescription] stringSizeConstrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-95, 1000) WithFont:[UIFont systemFontOfSize:16]];
        return size.height+18;
    }else if (indexPath.row == 2){
        return 44;
    }else if (indexPath.row == 3){
        
        if (self.parkTagsView.contentSize.height < 44) {
            return 44;
        }else if (self.parkTagsView.contentSize.height > 100){
            return 100;
        }else{
            return self.parkTagsView.contentSize.height;
        }
    }else if (indexPath.row == 4){
        return 220;
    }else{
        
//        if ([self.openedComment containsObject:@(indexPath.row-5)]) {
            CGSize size = [self.comments[indexPath.row-5][@"content"] stringSizeConstrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-30, 1000) WithFont:[UIFont systemFontOfSize:15]];
            return size.height + 46;
//        }else{
//            return 84;
//        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSDictionary *commentDic = self.comments[indexPath.row-5];
//    self.currReplyName = commentDic[@"userName"];
//    self.recoverDimView.alpha = 1;
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
//    [self.commentCoverField becomeFirstResponder];
}

- (void)parkCommentOpen:(UIButton *)button
{
    self.isRecover = YES;
    self.recoverTitle.text = @"写跟帖";
    NSDictionary *commentDic = self.comments[button.tag-openBTag];
    self.currReplyName = commentDic[@"userName"];
    self.currEditComment = commentDic;
    self.recoverDimView.alpha = 1;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [self.commentCoverField becomeFirstResponder];
    
    
//    [self.openedComment addObject:@(button.tag-openBTag)];
//    [self.listView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:button.tag-openBTag+5 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)parkCommentEdit:(UIButton *)button
{
    self.isRecover = NO;
    self.recoverTitle.text = @"编辑";
    NSDictionary *commentDic = self.comments[button.tag-editBTag];
    self.currReplyName = commentDic[@"userName"];
    self.currEditComment = commentDic;
    self.recoverDimView.alpha = 1;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [self.commentCoverField becomeFirstResponder];
}

- (void)parkCommentDelete:(UIButton *)button
{
    NSDictionary *commentDic = self.comments[button.tag-deleteBTag];
    MBProgressHUD *hud = [self.navigationController.view showLoading:@"正在删除"];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    param[@"id"] = self.parkEntity.parkId;
    param[@"userName"] = [DataManager getUserName];
    param[@"cityIndex"] = [DataManager cityIndex];
    param[@"reviewId"] = commentDic[@"reviewId"];
    
    [ParkRequests sendParkCommentDelete:param complete:^(BOOL issuccess, id json) {
        [self.navigationController.view stopLoading:hud];
        if (issuccess) {
            //TODO修改响应
            if ([json[@"delMyCommnetTag"] intValue] == 70060) {
                [Utils showToastWithMessage:@"删除成功"];
                [self requestComments];
            }else{
                [Utils showToastWithMessage:@"删除失败"];
            }
        }else{
            [Utils showToastWithMessage:@"删除失败"];
        }
    }];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notify
{
    NSDictionary *userInfo = notify.userInfo;
    
    // 键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self.recoverDimView layoutIfNeeded];
    [UIView animateWithDuration:.3 animations:^{
        self.recoverButtom.constant = keyboardF.size.height;
        [self.recoverDimView layoutIfNeeded];
    }];
}

#pragma mark CollectionView代理

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.tags.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"ParkTagCell";
    ParkTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    NSDictionary *tagDic = self.tags[indexPath.row];
    if ([tagDic[@"count"] integerValue] < 2) {
        cell.tagTitle.text = [NSString stringWithFormat:@"%@", tagDic[@"labelName"]];
    }else{
        cell.tagTitle.text = [NSString stringWithFormat:@"%@+%i", tagDic[@"labelName"], ([tagDic[@"count"] intValue]-1)];
    }
    
    if ([tagDic[@"count"] intValue] <= 1) {
        cell.plusCount = ParkTagPlusCountLow;
    }else{
        if ([tagDic[@"count"] intValue] > 3) {
            cell.plusCount = ParkTagPlusCountHigh;
        }else{
            cell.plusCount = ParkTagPlusCountMiddle;
        }
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = [NSString stringWithFormat:@"%@+%@", self.tags[indexPath.row][@"labelName"], self.tags[indexPath.row][@"count"]];
    
    
    if([UIScreen mainScreen].bounds.size.width < 330)
    {
        CGSize size = [title stringSizeConstrainedToSize:CGSizeMake(1000, 25) WithFont:[UIFont systemFontOfSize:12]];
        if (size.width + 2 < 45) {
            return CGSizeMake(45, 25);
        }else{
            return CGSizeMake(size.width-8, 25);
        }
    }else if ([UIScreen mainScreen].bounds.size.width > 400)
    {
        CGSize size = [title stringSizeConstrainedToSize:CGSizeMake(1000, 25) WithFont:[UIFont systemFontOfSize:12]];
        if (size.width + 2 < 45) {
            return CGSizeMake(45, 25);
        }else{
            return CGSizeMake(size.width+8, 25);
        }
    }
    else{
        CGSize size = [title stringSizeConstrainedToSize:CGSizeMake(1000, 25) WithFont:[UIFont systemFontOfSize:12]];
        if (size.width + 2 < 60) {
            return CGSizeMake(60, 25);
        }else{
            return CGSizeMake(size.width + 5, 25);
        }
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if ([UIScreen mainScreen].bounds.size.width > 400)
    {
        return UIEdgeInsetsMake(10, 15, 0, 15);
    }
    return UIEdgeInsetsMake(10, 8, 0, 8);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if ([UIScreen mainScreen].bounds.size.width > 400)
    {
        return 10;
    }
    return 5;
}

@end

@implementation ParkDetailTextCell

@end
