CREATE TABLE IF NOT EXISTS "T_Status" (
    "statusid" integer NOT NULL,
    "userid" integer NOT NULL,
    "status" text,
    PRIMARY KEY ("statusid", "userid")
);
