import { Component, OnInit } from '@angular/core';
import { ToastrService } from 'ngx-toastr';
import { Subscription } from 'rxjs';
import { SwapItemService } from 'src/app/pages/swap-item/services/swap-item.service';
import { Reports } from '../../entity/reports';
import { ReportsResponse } from '../../entity/reportsResponse';
import { ReportsService } from '../../services/reports.service';

@Component({
  selector: 'app-list-reports',
  templateUrl: './list-reports.component.html',
  styleUrls: ['./list-reports.component.scss']
})
export class ListReportsComponent implements OnInit {


  
  reports: Reports[];
  reportsList: Reports[] = [];
  reportsFilterList: Reports[] = [];         // We Create It Second For Filter
  isDeleted = false;
  config: any;                    // Config Variable For Pagination Configuration
  name: string;                   // name variable to store the input search value
  suggestProgress = false;
  allReportsObservable: Subscription;
  

  constructor(
    private reportsService: ReportsService,
    private swapItemService: SwapItemService,
    private toaster: ToastrService
    ) { }

  ngOnInit() {
    this.getReports();
  }



  ngOnDestroy() {
    this.allReportsObservable.unsubscribe();
  }

  getReports() {
    // all Reports
    this.allReportsObservable = this.reportsService.allReports().subscribe(
      (reportsResponse: ReportsResponse) => {
        if (reportsResponse) {
          this.reports = reportsResponse.data;
          this.reportsList = reportsResponse.data;
        }
        console.log(reportsResponse);
      }, 
      error1 => console.log('Error :', error1), 
      () => {
        this.reportsFilterList = this.reportsList;
      });


    this.config = {
      itemsPerPage: 5,
      currentPage: 1,
      totalItems: this.reportsList.length
    };
  }

  // Fetch The Page Number On Page Change
  pageChanged(event) {
    this.config.currentPage = event;
  }


  // Delete The Reports
  delete(reportId: number) {
    if (confirm('Are You Sure You Want To Delete This Report')) {
      this.isDeleted = true;
      this.reportsService.deleteReport(reportId).subscribe(
        data => {
          this.toaster.success('Report Successfully Deleted');
          console.log('deleted Successfully: ', data);
        },
        error => {
          this.isDeleted = false;
          console.log('error : ', error);
          this.toaster.error('There Is An Error Please Try Again');
        }, () => {
          this.isDeleted = false;
          this.getReports();
        }
      );
    } else {
      return false;
    }
  }

    // Delete The Reports
    deleteWithoutConfirm(reportId: number) {
      this.isDeleted = true;
      this.reportsService.deleteReport(reportId).subscribe(
        data => {
          this.toaster.success('Report Successfully Deleted');
          console.log('deleted Successfully: ', data);
        },
        error => {
          this.isDeleted = false;
          console.log('error : ', error);
          this.toaster.error('There Is An Error Please Try Again');
        }, () => {
          this.isDeleted = false;
          this.getReports();
        }
      );
    }

    // Delete The Reports
    deleteItem(swapItemtId: number, reportId: number) {
      if (confirm('Are You Sure You Want To Delete This Report')) {
        this.isDeleted = true;
        this.swapItemService.deleteSwapItem(swapItemtId).subscribe(
          data => {
            this.toaster.success('Reported Swap Item Successfully Deleted');
            console.log('deleted Successfully: ', data);
          },
          error => {
            this.isDeleted = false;
            console.log('error : ', error);
            this.toaster.error('There Is An Error Please Try Again');
          }, () => {
            this.isDeleted = false;
            this.deleteWithoutConfirm(reportId);
          }
        );
      } else {
        return false;
      }
    }
  

  applyFilter() {
    // if the search input value is empty
    if (!this.name) {
      this.reportsFilterList = [...this.reportsList];
    } else {
      this.reportsFilterList = [];
      this.reportsFilterList = this.reportsList.filter(res => {
        // Search In Name Column
        const nameResult = res.userName.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
        // Search In userName Column
        const itemName = res.itemName.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
        if (nameResult) {
          // display the Name Column
          return nameResult;
        } else if (itemName) {
          return itemName;
        }
      });
    }
  }

}
