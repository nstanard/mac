#!/bin/bash  

ituat () {
    http -f post app.tst.sparkpost:8888/api/v1/authenticate/logout x-msys-tenant:uat Authorization:$1 token=$1
}

itstg () {
    http -f post app.stg.sparkpost:8888/api/v1/authenticate/logout x-msys-tenant:staging Authorization:$1 token=$1
}

itchkstg () {
    http get "app.stg.sparkpost/access?access_token=$1&tenant=staging&resource_method=get&resource_uri=/api/v1/metrics"
}
