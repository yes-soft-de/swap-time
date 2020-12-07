# Swap Time Backend 🚧
*. env file and private-public keys not enclosed .*
## Project setup

### Composer thing 
```
composer update 
```
### Database setup
First add to** .env** file correct connection string
`DATABASE_URL=mysql://root@127.0.0.1:3306/tourists?serverVersion=5.7`

Then create database
```
php bin/console doctrine:database:create
```

After that make migration
```
php bin/console make:migration
```

Finaly run migration versions to create tables
```
php bin/console doctrine:migration:migrate
```

## API guide

### Account
#### Create new user
```
/user
methods: POST
```
#### Create user profile
```
/userprofile
methods: POST
```
#### Update user profile
```
/userprofile
methods: PUT
```
#### Get user profile by userID
```
/userprofile/{id}
methods: GET
```
### Swap items
#### Create new item
```
/swapitem
methods: POST
```
#### Get all swap items
```
/swapitem
methods: GET
```
#### Get swap item details by it's id
```
/swapitembyid/{id}
methods: GET
```
#### Get swap items by userID
```
/swapitembyuserid/{id}
methods: GET
```

### Upload
#### Upload file
```
/uploadfile
methods: POST
```

### Swap Operations
#### Create swap
```
/swap
methods: POST
```
#### Get all swaps
```
/swap
methods: GET
```
#### Get all swaps by userID
```
/swapbyuserid/{id}
methods: GET
```
#### Get swap by id
```
/swapbyid/{id}
methods: GET
```
#### Delete swap
```
/swap/{id}
methods: DELETE
```
#### Update swap
```
/swap
methods: PUT
```
### Images
#### Save image
```
/image
methods: POST
```
### Comments
#### Save comment
```
/comment
methods: POST
```
### Admin
#### Create Admin
```
/*****
methods: POST
```
#### Admin login
```
/login_check
methods: POST
```
### Report
#### Create report
```
/report
methods: POST
```
#### Get reports
```
/report
methods: Get
```

### Interactions
#### Create interaction
```
/interaction
methods: POST
```
#### Update interaction
```
/interaction/{userID}/{animeID}/{type}
methods: PUT
```
#### Get all interactions
```
/interaction/{animeID}
methods: GET
```
#### Get interaction with user
```
/interaction/{animeID}/{userID}
methods: GET
```
#### Count interactions
```
/countInteractions/{animeID}
methods: GET
```
#### Get user interaction
```
/userinteraction
methods: GET
```
#### Delete interaction
```
/interaction/{itemID}
methods: DELETE
```
