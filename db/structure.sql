CREATE TABLE "admin_roles" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "admin_id" integer NOT NULL, "role_id" integer NOT NULL);
CREATE TABLE "admins" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "login_id" varchar(16), "first_name" varchar(10), "last_name" varchar(10), "telephone_no" varchar(15), "status" varchar(2), "deleted_at" datetime, "email" varchar(255) DEFAULT '' NOT NULL, "encrypted_password" varchar(255) DEFAULT '' NOT NULL, "reset_password_token" varchar(255), "reset_password_sent_at" datetime, "remember_created_at" datetime, "sign_in_count" integer DEFAULT 0, "current_sign_in_at" datetime, "last_sign_in_at" datetime, "current_sign_in_ip" varchar(255), "last_sign_in_ip" varchar(255), "password_salt" varchar(255), "confirmation_token" varchar(255), "confirmed_at" datetime, "confirmation_sent_at" datetime, "unconfirmed_email" varchar(255), "failed_attempts" integer DEFAULT 0, "unlock_token" varchar(255), "locked_at" datetime, "authentication_token" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "court_properties" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "court_id" integer, "property_id" integer, "property_value" varchar(20), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "courts" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "sport_id" integer NOT NULL, "gym_id" integer NOT NULL, "min_unit" float DEFAULT 0.5, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "games" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "court_id" integer, "name" varchar(20), "sort" integer(3), "default_price" float DEFAULT 0, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "gyms" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(50) DEFAULT '' NOT NULL, "user_id" integer, "intro" text, "address" varchar(100) DEFAULT '' NOT NULL, "telephone" varchar(30) DEFAULT '' NOT NULL, "open_time" time DEFAULT '' NOT NULL, "close_time" time DEFAULT '' NOT NULL, "score" float DEFAULT 0 NOT NULL, "status" varchar(255) DEFAULT '00' NOT NULL, "deleted_at" datetime, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "properties" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(20) NOT NULL, "unit" varchar(6), "intro" varchar(50), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "roles" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(20) NOT NULL, "sort" integer(3) DEFAULT 1 NOT NULL, "function_codes" varchar(300), "deleted_at" datetime, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "sport_properties" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "sport_id" integer, "property_id" integer, "default_value" varchar(20), "scope" integer(1), "required" boolean, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "sports" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(50) NOT NULL, "intro" text, "sort" integer(3), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "user_roles" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer NOT NULL, "role_id" integer NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "login_id" varchar(16), "first_name" varchar(10), "last_name" varchar(10), "honey_name" varchar(20), "telephone_no" varchar(15), "sex" boolean, "birthday" date, "address" varchar(200), "status" varchar(2), "deleted_at" datetime, "email" varchar(255) DEFAULT '' NOT NULL, "encrypted_password" varchar(255) DEFAULT '' NOT NULL, "reset_password_token" varchar(255), "reset_password_sent_at" datetime, "remember_created_at" datetime, "sign_in_count" integer DEFAULT 0, "current_sign_in_at" datetime, "last_sign_in_at" datetime, "current_sign_in_ip" varchar(255), "last_sign_in_ip" varchar(255), "password_salt" varchar(255), "confirmation_token" varchar(255), "confirmed_at" datetime, "confirmation_sent_at" datetime, "unconfirmed_email" varchar(255), "failed_attempts" integer DEFAULT 0, "unlock_token" varchar(255), "locked_at" datetime, "authentication_token" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "index_admin_roles_on_admin_id" ON "admin_roles" ("admin_id");
CREATE INDEX "index_admin_roles_on_role_id" ON "admin_roles" ("role_id");
CREATE UNIQUE INDEX "index_admins_on_authentication_token" ON "admins" ("authentication_token");
CREATE UNIQUE INDEX "index_admins_on_confirmation_token" ON "admins" ("confirmation_token");
CREATE UNIQUE INDEX "index_admins_on_email" ON "admins" ("email");
CREATE UNIQUE INDEX "index_admins_on_login_id" ON "admins" ("login_id");
CREATE UNIQUE INDEX "index_admins_on_reset_password_token" ON "admins" ("reset_password_token");
CREATE UNIQUE INDEX "index_admins_on_unlock_token" ON "admins" ("unlock_token");
CREATE UNIQUE INDEX "index_roles_on_name" ON "roles" ("name");
CREATE INDEX "index_user_roles_on_role_id" ON "user_roles" ("role_id");
CREATE INDEX "index_user_roles_on_user_id" ON "user_roles" ("user_id");
CREATE UNIQUE INDEX "index_users_on_authentication_token" ON "users" ("authentication_token");
CREATE UNIQUE INDEX "index_users_on_confirmation_token" ON "users" ("confirmation_token");
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
CREATE UNIQUE INDEX "index_users_on_reset_password_token" ON "users" ("reset_password_token");
CREATE UNIQUE INDEX "index_users_on_unlock_token" ON "users" ("unlock_token");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20130329073940');

INSERT INTO schema_migrations (version) VALUES ('20130329075503');

INSERT INTO schema_migrations (version) VALUES ('20130412084155');

INSERT INTO schema_migrations (version) VALUES ('20130413095704');

INSERT INTO schema_migrations (version) VALUES ('20130414050034');

INSERT INTO schema_migrations (version) VALUES ('20130414060334');

INSERT INTO schema_migrations (version) VALUES ('20130414064735');

INSERT INTO schema_migrations (version) VALUES ('20130414073519');

INSERT INTO schema_migrations (version) VALUES ('20130423131908');

INSERT INTO schema_migrations (version) VALUES ('20130424135512');

INSERT INTO schema_migrations (version) VALUES ('20130428085309');

INSERT INTO schema_migrations (version) VALUES ('20130501024936');