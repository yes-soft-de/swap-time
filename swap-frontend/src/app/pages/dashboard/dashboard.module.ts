import { NgModule } from '@angular/core';
import { ThemeModule } from 'src/app/@theme/theme.module';

import { DashboardRoutingModule } from './dashboard-routing.module';
import { DashboardComponent } from './dashboard.component';


@NgModule({
  declarations: [DashboardComponent],
  imports: [
    ThemeModule,
    DashboardRoutingModule
  ]
})
export class DashboardModule { }
