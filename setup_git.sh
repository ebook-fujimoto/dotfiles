#!/bin/sh

set -e
set -u

setup() {
    ghq get -p git@github.com:ebook-japan/no1api-devops.git
    ghq get -p git@github.com:ebook-japan/Infra-AWS-Service-AMI.git
    ghq get -p git@github.com:ebook-japan/Infra-AWS-Service.git
    ghq get -p git@github.com:ebook-japan/Infra-AWS-office.git
    ghq get -p git@github.com:ebook-japan/no1api-voucher.git
    ghq get -p git@github.com:ebook-japan/no1api-voucher-admin.git
    ghq get -p git@github.com:ebook-japan/coin-batch.git
    ghq get -p git@github.com:ebook-japan/coupon-batch.git
    ghq get -p git@github.com:ebook-japan/ticket-batch.git
    ghq get -p git@github.com:ebook-japan/agency-batch.git
}

setup
