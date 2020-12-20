import { SwapItemDetailsComments } from './swap-item-details-comments';

export interface SwapItemDetails {
    id: number;
    name: string ;
    category: string;
    platform: string;
    tag: [];
    description: string;
    mainImage: string;
    userID: string;
    userName: string;
    commentNumber: number;
    interaction: null;
    comments: SwapItemDetailsComments[];
    images?: [];
    specialLink: string;
    isRequested: boolean;
}