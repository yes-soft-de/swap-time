import { NgModule } from '@angular/core';
import { ThemeModule } from 'src/app/@theme/theme.module';

import { UsersRoutingModule } from './users-routing.module';
import { UsersComponent } from './users.component';
import { ListUsersComponent } from './components/list-users/list-users.component';


@NgModule({
  declarations: [UsersComponent, ListUsersComponent],
  imports: [
    ThemeModule,
    UsersRoutingModule
  ]
})
export class UsersModule { }
