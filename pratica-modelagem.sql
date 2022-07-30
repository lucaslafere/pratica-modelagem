-- create database

CREATE DATABASE databank;

-- table states

CREATE TABLE states (
	id SERIAL NOT NULL PRIMARY KEY,
	name text NOT NULL UNIQUE
);

-- table cities 

CREATE TABLE cities (
	id serial NOT NULL PRIMARY KEY,
	name text NOT NULL UNIQUE,
	"stateId" integer REFERENCES states(id)
);

-- table customers

CREATE TABLE customers (
	id serial NOT NULL PRIMARY KEY,
	"fullName" text NOT NULL,
	cpf varchar(11) NOT NULL UNIQUE,
	email text NOT NULL UNIQUE,
	password text NOT NULL
);

-- table customerPhones

-- first we create the phoneType

CREATE TYPE "phoneType" AS ENUM ('landline', 'mobile');

-- then

CREATE TABLE "customerPhones" (
	id serial NOT NULL PRIMARY KEY,
	"customerId" integer NOT NULL REFERENCES customers(id),
	number integer NOT NULL UNIQUE,
	type "phoneType" NOT NULL
);

-- table customerAddresses

CREATE TABLE "customerAddresses" (
	id serial NOT NULL PRIMARY KEY,
	"customerId" integer NOT NULL REFERENCES customers(id) UNIQUE,
	street text NOT NULL,
	number integer NOT NULL,
	complement text,
	postalCode varchar(8) NOT NULL,
	"cityId" integer NOT NULL REFERENCES cities(id)
);

-- table bankAccount

CREATE TABLE "bankAccount" (
	id serial NOT NULL PRIMARY KEY,
	"customerId" integer NOT NULL REFERENCES customers(id),
	"accountNumber" text NOT NULL,
	agency text NOT NULL,
	"openDate" TIMESTAMP NOT NULL DEFAULT NOW(),
	"closeDate" TIMESTAMP DEFAULT NOW()
);

-- table transactions

-- first we create transactionType

CREATE TYPE "transactionsType" AS ENUM ('deposit', 'withdraw');


-- then

CREATE TABLE transactions (
	id serial NOT NULL PRIMARY KEY,
	"bankAccountId" integer NOT NULL REFERENCES "bankAccount"(id),
	amount numeric NOT NULL,
	type "transactionsType" NOT NULL,
	time timestamp NOT NULL DEFAULT NOW(),
	description text,
	cancelled boolean NOT NULL DEFAULT false
);

-- table creditCards

CREATE TABLE "creditCards" (
	id serial NOT NULL PRIMARY KEY,
	"bankAccountId" integer NOT NULL REFERENCES "bankAccount"(id),
	name text NOT NULL,
	number text NOT NULL UNIQUE,
	"securityCode" varchar(3) NOT NULL,
	"expirationMonth" varchar(2) NOT NULL,
	"expirationYear" varchar(2) NOT NULL,
	password text NOT NULL,
	"limit" integer NOT NULL
);
