# README

Information that would be needed to work with API's

For authentication is using [devise_token_auth](https://github.com/lynndylanhurley/devise_token_auth)
Status of APi's could be success or failed
####Sign-up & sign-in
#####To sign-up should be used custom made API which allows to create User without email confirmation
?/auth/registration

```
{
    "name": "dummy",
    "nickname": "dummy_nick",
    "email": "dummy_email@exqample.com",
    "password": "password" 
}
```
User would be created and confirmed. After that user could be signed-in. Response would be like
```
{
  "status": "success",
  "data": {
    "name": "dummy",
    "nickname": "dummy_nick",
    "email": "dummy_email@exqample.com",
    "password": "password" 
  }
}
```
#####To sign-in should be used link and json example bellow
>/auth/sign_in

```
{
    "email": "dummy_email@exqample.com",
    "password": "password" 
}
```

In response body would be signed in user model and token in header as on example bellow
###### header example
```
{
    "access-token"=>"-XUuGTSuZVTO4xYm7y8ALA",
    "token-type"=>"Bearer",
    "client"=>"5FbZ4Gf5fd_LStStRjHPag",
    "expiry"=>"1495825059",
    "uid"=>"email-a@domain.com"
}
```
###### body example
```
{
  "status": "success",
  "data": {
     "id": "23",
     "name": "dummy",
     "email": "dummy_email@exqample.com",
     "password": "password" 
  }
}
```
####Tasks

Task status is adding automatically on creation and it's 'new'
When task is closed it has status 'done'
#####To create task should be used json example and link bellow
>/tasks/create

```
{
    "tag": "ABC",
    "deadline_time": '05/19/2017'
}
```

Example of response 
```
{
  "status": "success",
  "data": {
     "id": "23",
     "tag": "abc",
     "deadline_time": '05/19/2017',
     "status": "new" 
  }
}
```

#####To close task should be used json example and link bellow
>/tasks/close

```
{
    id: 23
}
```

Example of response 
```
{
  "status": "success",
  "data": [
      {
         "id": "23",
         "tag": "abc",
         "deadline_time": '05/19/2017',
         "status": "new" 
      },
      {
         "id": "88",
         "tag": "dfe",
         "deadline_time": '05/19/2017',
         "status": "new" 
      },
  ]
}
```

####To receive list of tasks selected by tag should be used json example and link bellow
>/tasks/list

```
{
    tag: 'abc'   
}
```

Example of response 

```
{
  "status": "success",
  "data": {
     "id": "23",
     "tag": "abc",
     "deadline_time": '05/19/2017',
     "status": "close" 
  }
}
```

#####To receive list of tasks selected by tag and status should be used json example and link bellow
>/tasks/list

```
{
    tag: 'abc',
    status: 'done'
}
```

Example of response 

```
{
  "status": "success",
  "data": {
     "id": "23",
     "tag": "abc",
     "deadline_time": '05/19/2017',
     "status": "done" 
  }
}
```