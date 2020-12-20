import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ListUsersComponent } from './components/list-users/list-users.component';
import { UsersComponent } from './users.component';


const routes: Routes = [
  {
    path: '',
    component: UsersComponent,
    children: [
      { path: '', component: ListUsersComponent }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class UsersRoutingModule { }
