import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ListSwapOperationsComponent } from './components/list-swap-operations/list-swap-operations.component';
import { SwapsOperationComponent } from './swaps-operation.component';


const routes: Routes = [
  {
    path: '',
    component: SwapsOperationComponent,
    children: [
      { path: '', component: ListSwapOperationsComponent }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class SwapsOperationRoutingModule { }
