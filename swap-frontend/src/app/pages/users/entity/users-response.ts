import { Users } from './users';

export interface UsersResponse {
    data: {
        Profiles: Users[];
        ProfilesCount: number;
    }
}