import { Component, OnInit } from '@angular/core';
import { ToastrService } from 'ngx-toastr';
import { Subscription } from 'rxjs';
import { Users } from '../../entity/users';
import { UsersResponse } from '../../entity/users-response';
import { UsersService } from '../../services/users.service';

@Component({
  selector: 'app-list-users',
  templateUrl: './list-users.component.html',
  styleUrls: ['./list-users.component.scss']
})
export class ListUsersComponent implements OnInit {

  
  users: Users[];
  usersList: Users[] = [];
  usersFilterList: Users[] = [];         // We Create It Second For Filter
  isDeleted = false;
  config: any;                    // Config Variable For Pagination Configuration
  name: string;                   // name variable to store the input search value
  suggestProgress = false;
  allUsersObservable: Subscription;
  

  constructor(
    private usersService: UsersService,
    private toaster: ToastrService
    ) { }

  ngOnInit() {
    this.getUsers();
  }



  ngOnDestroy() {
    this.allUsersObservable.unsubscribe();
  }

  getUsers() {
    // all Users
    this.allUsersObservable = this.usersService.allUsers().subscribe(
      (usersResponse: UsersResponse) => {
        if (usersResponse) {
          this.users = usersResponse.data.Profiles;
          this.usersList = usersResponse.data.Profiles;
        }
        console.log(usersResponse);
      }, 
      error1 => console.log('Error :', error1), 
      () => {
        this.usersFilterList = this.usersList;
      });


    this.config = {
      itemsPerPage: 10,
      currentPage: 1,
      totalItems: this.usersList.length
    };
  }

  // Fetch The Page Number On Page Change
  pageChanged(event) {
    this.config.currentPage = event;
  }


  // Delete The Users
  // delete(userId: number) {
  //   if (confirm('Are You Sure You Want To Delete This User')) {
  //     this.isDeleted = true;
  //     this.usersService.deleteUser(userId).subscribe(
  //       data => {
  //         this.toaster.success('User Successfully Deleted');
  //         console.log('deleted Successfully: ', data);
  //       },
  //       error => {
  //         this.isDeleted = false;
  //         console.log('error : ', error);
  //         this.toaster.error('There Is An Error Please Try Again');
  //       }, () => {
  //         this.isDeleted = false;
  //         this.getUsers();
  //       }
  //     );
  //   } else {
  //     return false;
  //   }
  // }


  applyFilter() {
    // if the search input value is empty
    if (!this.name) {
      this.usersFilterList = [...this.usersList];
    } else {
      this.usersFilterList = [];
      this.usersFilterList = this.usersList.filter(res => {
        // Search In Name Column
        const userName = res.userName.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
        // Search In Name Column
        const location = res.location.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
        // Search In userName Column
        // const serTwoName = res.userTwoName.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
        if (userName) {
          // display the Name Column
          return userName;
        } else if (location) {
          // display the Name Column
          return location;
        } 
        // else if (serTwoName) {
        //   return serTwoName;
        // }
      });
    }
  }
}