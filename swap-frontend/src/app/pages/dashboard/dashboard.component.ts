import { DatePipe, formatDate } from '@angular/common';
import { typeWithParameters } from '@angular/compiler/src/render3/util';
import { Component, OnDestroy, OnInit } from '@angular/core';
import {forkJoin, Observable, Subscription} from 'rxjs';
import { map, mergeMap } from 'rxjs/operators';
import { FooterComponent } from 'src/app/@theme/components';
import { Reports } from '../reports/entity/reports';
import { ReportsResponse } from '../reports/entity/reportsResponse';
import { ReportsService } from '../reports/services/reports.service';
import { SwapItems } from '../swap-item/entity/swap-item';
import { SwapItemsResponse } from '../swap-item/entity/swap-item-response';
import { SwapItemService } from '../swap-item/services/swap-item.service';
import { Swap } from '../swaps-operation/entity/swap';
import { SwapResponse } from '../swaps-operation/entity/swapResponse';
import { SwapOperationService } from '../swaps-operation/services/swap-operation.service';
import { Users } from '../users/entity/users';
import { UsersResponse } from '../users/entity/users-response';
import { UsersService } from '../users/services/users.service';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss'],
  providers: [FooterComponent]
})
export class DashboardComponent implements OnInit, OnDestroy {
  users: Users[];
  usersCount: number;
  swapItems: SwapItems[];
  swapOperations: Swap[];
  reports: Reports[];
  
  latestUsersNumber = 5;
  latestSwapItemsNumber = 5;
  latestSwapOperationsNumber = 5;
  latestReportsNumber = 5;
  
  joinAllRequestsObservable: Subscription;

  constructor(
      private usersServivce: UsersService,
      private swapItemsService: SwapItemService,
      private swapOperationService: SwapOperationService,
      private reportsService: ReportsService) {
  }

  ngOnInit() {
      
    const allUsers: Observable<UsersResponse> = this.usersServivce.allUsers();
    const allSwapItems: Observable<SwapItemsResponse> = this.swapItemsService.allSwapItems();
    const allSwapOperations: Observable<SwapResponse> = this.swapOperationService.allSwapOperations();
    const allReports: Observable<ReportsResponse> = this.reportsService.allReports();
    const joinAllRequests: Observable<any> = forkJoin([allUsers, allSwapItems, allSwapOperations, allReports]);
    this.joinAllRequestsObservable = joinAllRequests.subscribe(
      response => {
        console.log(response);
        this.users = response[0].data.Profiles.reverse();
        this.usersCount = response[0].data.ProfilesCount;
        this.swapItems = response[1].data.reverse();
        this.swapOperations = response[2].data.reverse();
        this.reports = response[3].data.reverse();
      }
    );

  }

  ngOnDestroy() {
    this.joinAllRequestsObservable.unsubscribe();
  }

}
