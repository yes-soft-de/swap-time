export interface SwapItems {
    id: number;
    category: string;
    commentNumber: number;
    comments: Array<any>;
    description: string;
    images: [];
    interaction: {
        loved: number; 
        checkLoved: boolean;
    };
    isRequested: boolean;
    mainImage: string;
    name: string;
    platform: string;
    specialLink: string;
    tag: [];
    userID: string;
    userName: string;
    
}