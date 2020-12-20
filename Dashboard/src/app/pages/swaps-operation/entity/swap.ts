export interface Swap {
    id: number;
    cost: string;
    date: { timestamp: number };
    roomID: string;
    status: string;
    swapItemIdOne: number;
    swapItemIdTwo: number;
    swapItemOneImage: string;
    swapItemTwoImage: string;
    userIdOne: string;
    userIdTwo: string;
    userOneImage: string;
    userOneName?: string;
    userTwoImage: string;
    userTwoName?: string;   
}