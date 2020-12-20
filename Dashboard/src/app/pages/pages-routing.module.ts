import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { NotFoundComponent } from '../@theme/components';
import { AfterLoginService } from './admin-service/guard/after-login.service';
import { BeforeLoginService } from './admin-service/guard/before-login.service';


const routes: Routes = [
  {
    path: '',
    loadChildren: () => import('./dashboard/dashboard.module').then(m => m.DashboardModule),
    canActivate: [AfterLoginService]
  },
  {
    path: 'users',
    loadChildren: () => import('./users/users.module').then(m => m.UsersModule),
    canActivate: [AfterLoginService]
  },
  {
    path: 'login',
    loadChildren: () => import('./register/register.module').then(m => m.RegisterModule),
    canActivate: [BeforeLoginService]
  },
  {
    path: 'swap-item',
    loadChildren: () => import('./swap-item/swap-item.module').then(m => m.SwapItemModule),
    canActivate: [AfterLoginService]
  },
  {
    path: 'reports',
    loadChildren: () => import('./reports/reports.module').then(m => m.ReportsModule),
    canActivate: [AfterLoginService]
  },
  {
    path: 'operations',
    loadChildren: () => import('./swaps-operation/swaps-operation.module').then(m => m.SwapsOperationModule),
    canActivate: [AfterLoginService]
  },
  { path: '**', component: NotFoundComponent }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PagesRoutingModule { }
