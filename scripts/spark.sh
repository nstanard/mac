#!/bin/bash  

getUatInvite() {
    http -f post app.tst.sparkpost:8888/api/v1/users/invite x-msys-tenant:uat 
}

ituat () {
    http -f post app.tst.sparkpost:8888/api/v1/authenticate/logout x-msys-tenant:uat Authorization:$1 token=$1
}

termuat () {
    http put app.tst.sparkpost:8888/api/v1/account/control x-msys-tenant:uat x-msys-customer:$1 status=$2
}

termstg () {
    http put app.stg.sparkpost:8888/api/v1/account/control x-msys-tenant:staging x-msys-customer:$1 status=$2
}

termprd () {
    http put app.prd.sparkpost:8888/api/v1/account/control x-msys-tenant:spc x-msys-customer:$1 status=$2
}

itstg () {
    http -f post app.stg.sparkpost:8888/api/v1/authenticate/logout x-msys-tenant:staging Authorization:$1 token=$1
}

itstgmtas () {
    http -f post app.stg.sparkpost:8888/api/v1/authenticate/logout x-msys-tenant:stagingmtas Authorization:$1 token=$1
}

itprd () {
    http -f post app.prd.sparkpost:8888/api/v1/authenticate/logout x-msys-tenant:spc Authorization:$1 token=$1
}

itchkstg () {
    http get "app.stg.sparkpost/access?access_token=$1&tenant=staging&resource_method=get&resource_uri=/api/v1/metrics"
}
