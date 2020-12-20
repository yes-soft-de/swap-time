import { NgModule } from '@angular/core';
import { ThemeModule } from 'src/app/@theme/theme.module';

import { ReportsRoutingModule } from './reports-routing.module';
import { ReportsComponent } from './reports.component';
import { ListReportsComponent } from './components/list-reports/list-reports.component';


@NgModule({
  declarations: [ReportsComponent, ListReportsComponent],
  imports: [
    ThemeModule,
    ReportsRoutingModule
  ]
})
export class ReportsModule { }
