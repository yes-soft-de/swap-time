export interface SwapItemDetailsComments {
    comment: string;
    date: { 
        timestamp: number
    };
    userID: string;
    userName: string;
    image: string;
    swapItemID?: number;
}