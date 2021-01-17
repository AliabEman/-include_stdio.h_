-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.1
-- PostgreSQL version: 9.5
-- Project Site: pgmodeler.io
-- Model Author: ---

-- object: jeya0023 | type: ROLE --
-- DROP ROLE IF EXISTS jeya0023;
CREATE ROLE jeya0023 WITH 
	INHERIT
	LOGIN
	BYPASSRLS
	ENCRYPTED PASSWORD '********';
-- ddl-end --

-- object: web | type: ROLE --
-- DROP ROLE IF EXISTS web;
CREATE ROLE web WITH 
	INHERIT
	BYPASSRLS
	ENCRYPTED PASSWORD '********'
	ROLE jeya0023;
-- ddl-end --


-- Database creation must be done outside a multicommand file.
-- These commands were put in this file only as a convenience.
-- -- object: "AAAAAA" | type: DATABASE --
-- -- DROP DATABASE IF EXISTS "AAAAAA";
-- CREATE DATABASE "AAAAAA"
-- 	ENCODING = 'UTF8'
-- 	LC_COLLATE = 'English_Canada.1252'
-- 	LC_CTYPE = 'English_Canada.1252'
-- 	TABLESPACE = pg_default
-- 	OWNER = web;
-- -- ddl-end --
-- 

-- object: public.customer | type: TABLE --
-- DROP TABLE IF EXISTS public.customer CASCADE;
CREATE TABLE public.customer(
	id character(10) NOT NULL,
	name character varying(20) NOT NULL,
	address character varying(60) NOT NULL,
	phone char(16) NOT NULL,
	work character varying(10) NOT NULL,
	type character varying(10) NOT NULL,
	CONSTRAINT customer_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.customer OWNER TO postgres;
-- ddl-end --

-- object: public.shipment | type: TABLE --
-- DROP TABLE IF EXISTS public.shipment CASCADE;
CREATE TABLE public.shipment(
	method character varying(40) NOT NULL,
	term character(6) NOT NULL,
	id character(10) NOT NULL,
	CONSTRAINT shipment_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.shipment OWNER TO postgres;
-- ddl-end --

-- object: public.staff | type: TABLE --
-- DROP TABLE IF EXISTS public.staff CASCADE;
CREATE TABLE public.staff(
	id character(6) NOT NULL,
	name character varying(20) NOT NULL,
	job character varying(20),
	CONSTRAINT staff_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.staff OWNER TO postgres;
-- ddl-end --

-- object: public.invoice | type: TABLE --
-- DROP TABLE IF EXISTS public.invoice CASCADE;
CREATE TABLE public.invoice(
	date_i date,
	invoice character(10) NOT NULL,
	company character varying(20) NOT NULL,
	address character varying(60) NOT NULL,
	phone character varying(16) NOT NULL,
	fax character varying(16) NOT NULL,
	email character varying(20) NOT NULL,
	cust_c_id character(10),
	staff_id character(6),
	ship_id_shipment character(10),
	CONSTRAINT invoice_pk PRIMARY KEY (invoice)

);
-- ddl-end --
ALTER TABLE public.invoice OWNER TO postgres;
-- ddl-end --

-- object: public.products | type: TABLE --
-- DROP TABLE IF EXISTS public.products CASCADE;
CREATE TABLE public.products(
	id character(6) NOT NULL,
	staff_id character(6),
	description character varying(20) NOT NULL,
	unit_price numeric(10,2) NOT NULL,
	discount character(10) NOT NULL,
	CONSTRAINT products_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.products OWNER TO postgres;
-- ddl-end --

-- object: public.order_p | type: TABLE --
-- DROP TABLE IF EXISTS public.order_p CASCADE;
CREATE TABLE public.order_p(
	id character(10) NOT NULL,
	invoice_id character(10) NOT NULL,
	del_date date,
	payment_term character varying(20) NOT NULL,
	due_date date,
	CONSTRAINT order_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.order_p OWNER TO postgres;
-- ddl-end --

-- object: fk_staff_id | type: CONSTRAINT --
-- ALTER TABLE public.invoice DROP CONSTRAINT IF EXISTS fk_staff_id CASCADE;
ALTER TABLE public.invoice ADD CONSTRAINT fk_staff_id FOREIGN KEY (staff_id)
REFERENCES public.staff (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_cust_c_id | type: CONSTRAINT --
-- ALTER TABLE public.invoice DROP CONSTRAINT IF EXISTS fk_cust_c_id CASCADE;
ALTER TABLE public.invoice ADD CONSTRAINT fk_cust_c_id FOREIGN KEY (cust_c_id)
REFERENCES public.customer (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_ship_id_shipment | type: CONSTRAINT --
-- ALTER TABLE public.invoice DROP CONSTRAINT IF EXISTS fk_ship_id_shipment CASCADE;
ALTER TABLE public.invoice ADD CONSTRAINT fk_ship_id_shipment FOREIGN KEY (ship_id_shipment)
REFERENCES public.shipment (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_staff_id | type: CONSTRAINT --
-- ALTER TABLE public.products DROP CONSTRAINT IF EXISTS fk_staff_id CASCADE;
ALTER TABLE public.products ADD CONSTRAINT fk_staff_id FOREIGN KEY (staff_id)
REFERENCES public.staff (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_order_id | type: CONSTRAINT --
-- ALTER TABLE public.order_p DROP CONSTRAINT IF EXISTS fk_order_id CASCADE;
ALTER TABLE public.order_p ADD CONSTRAINT fk_order_id FOREIGN KEY (invoice_id)
REFERENCES public.invoice (invoice) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


