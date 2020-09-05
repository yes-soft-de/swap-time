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