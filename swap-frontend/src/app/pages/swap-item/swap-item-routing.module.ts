import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { SwapItemComponent } from './swap-item.component';
import { ListSwapItemsComponent } from './components/list-swap-items/list-swap-items.component';
import { ViewSwapItemComponent } from './components/view-swap-item/view-swap-item.component';


const routes: Routes = [
  {
    path: '',
    component: SwapItemComponent,
    children: [
      { path: '', component: ListSwapItemsComponent },
      { path: 'view/:id', component: ViewSwapItemComponent }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class SwapItemRoutingModule { }
