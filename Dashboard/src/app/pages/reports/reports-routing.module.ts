import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ListReportsComponent } from './components/list-reports/list-reports.component';
import { ReportsComponent } from './reports.component';


const routes: Routes = [
  {
    path: '',
    component: ReportsComponent,
    children: [
      { path: '', component: ListReportsComponent }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ReportsRoutingModule { }
