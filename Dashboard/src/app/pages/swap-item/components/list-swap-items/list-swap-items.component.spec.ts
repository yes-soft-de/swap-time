import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ListSwapItemsComponent } from './list-swap-items.component';

describe('ListSwapItemsComponent', () => {
  let component: ListSwapItemsComponent;
  let fixture: ComponentFixture<ListSwapItemsComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ListSwapItemsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ListSwapItemsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
