CREATE TABLE "data.metric"(
    "id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "vmin" DOUBLE PRECISION NULL,
    "vmax" DOUBLE PRECISION NULL,
    "unit" VARCHAR(255) NOT NULL,
    "snmp_old" VARCHAR(255) NOT NULL,
    "agnt_scale" DOUBLE PRECISION NULL,
    "metric_pkey" INTEGER NULL
);
ALTER TABLE
    "data.metric" ADD PRIMARY KEY("id");
CREATE INDEX "data_metric_metric_pkey_index" ON
    "data.metric"("metric_pkey");
CREATE TABLE "data.collect"(
    "node" INTEGER NOT NULL,
    "metric" INTEGER NOT NULL,
    "intval" INTEGER NOT NULL,
    "node_id" INTEGER NULL,
    "metric_id" INTEGER NULL
);
CREATE INDEX "data_collect_node_id_index" ON
    "data.collect"("node_id");
CREATE INDEX "data_collect_metric_id_index" ON
    "data.collect"("metric_id");
CREATE TABLE "data.node"(
    "id" INTEGER NOT NULL,
    "map" INTEGER NOT NULL,
    "x" DOUBLE PRECISION NOT NULL,
    "y" DOUBLE PRECISION NOT NULL,
    "ip" VARCHAR(255) NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "agent" INTEGER NOT NULL,
    "node_pkey" INTEGER NULL,
    "map_id" INTEGER NULL,
    "agent_id" INTEGER NULL
);
ALTER TABLE
    "data.node" ADD PRIMARY KEY("id");
CREATE INDEX "data_node_node_pkey_index" ON
    "data.node"("node_pkey");
CREATE INDEX "data_node_map_id_index" ON
    "data.node"("map_id");
CREATE INDEX "data_node_agent_id_index" ON
    "data.node"("agent_id");
CREATE TABLE "data.agent"(
    "id" INTEGER NOT NULL,
    "key" CHAR(255) NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "agent_pkey" INTEGER NOT NULL,
    "agent_key_key" INTEGER NOT NULL
);
ALTER TABLE
    "data.agent" ADD PRIMARY KEY("id");
CREATE INDEX "data_agent_agent_pkey_index" ON
    "data.agent"("agent_pkey");
ALTER TABLE
    "data.agent" ADD CONSTRAINT "data_agent_agent_key_key_unique" UNIQUE("agent_key_key");
CREATE TABLE "data.account"(
    "id" INTEGER NOT NULL,
    "account" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "account_pkey" INTEGER NOT NULL
);
ALTER TABLE
    "data.account" ADD PRIMARY KEY("id");
CREATE INDEX "data_account_account_pkey_index" ON
    "data.account"("account_pkey");
CREATE TABLE "data.map"(
    "id" INTEGER NOT NULL,
    "account" INTEGER NOT NULL,
    "name" INTEGER NOT NULL,
    "map_pkey" INTEGER NULL,
    "account_id" INTEGER NULL
);
ALTER TABLE
    "data.map" ADD PRIMARY KEY("id");
CREATE INDEX "data_map_map_pkey_index" ON
    "data.map"("map_pkey");
CREATE INDEX "data_map_account_id_index" ON
    "data.map"("account_id");
CREATE TABLE "data.link"(
    "id" INTEGER NOT NULL,
    "node_a" INTEGER NOT NULL,
    "node_b" INTEGER NOT NULL,
    "link_pkey" INTEGER NOT NULL,
    "node_a_id" INTEGER NOT NULL,
    "node_b_id" INTEGER NOT NULL
);
ALTER TABLE
    "data.link" ADD PRIMARY KEY("id");
CREATE INDEX "data_link_link_pkey_index" ON
    "data.link"("link_pkey");
CREATE INDEX "data_link_node_a_id_index" ON
    "data.link"("node_a_id");
CREATE INDEX "data_link_node_b_id_index" ON
    "data.link"("node_b_id");
CREATE TABLE "data.permission"(
    "account" INTEGER NOT NULL,
    "func" VARCHAR(255) NOT NULL,
    "account_id" INTEGER NOT NULL
);
ALTER TABLE
    "data.permission" ADD PRIMARY KEY("account");
CREATE INDEX "data_permission_account_id_index" ON
    "data.permission"("account_id");
CREATE TABLE "data.session"(
    "key" CHAR(255) NOT NULL,
    "account" INTEGER NOT NULL,
    "t_begin" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "t_end" TIMESTAMP(0) WITHOUT TIME ZONE NULL,
    "session_key" INTEGER NULL,
    "account_id" INTEGER NULL
);
ALTER TABLE
    "data.session" ADD PRIMARY KEY("key");
CREATE INDEX "data_session_session_key_index" ON
    "data.session"("session_key");
CREATE INDEX "data_session_account_id_index" ON
    "data.session"("account_id");
CREATE TABLE "data.sample"(
    "ts" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "node" INTEGER NOT NULL,
    "metric" INTEGER NOT NULL,
    "value" DOUBLE PRECISION NOT NULL,
    "idx_ts" INTEGER NOT NULL,
    "idx_node" INTEGER NOT NULL
);
ALTER TABLE
    "data.sample" ADD PRIMARY KEY("ts");
CREATE INDEX "data_sample_idx_ts_index" ON
    "data.sample"("idx_ts");
CREATE INDEX "data_sample_idx_node_index" ON
    "data.sample"("idx_node");
ALTER TABLE
    "data.collect" ADD CONSTRAINT "data_collect_node_id_foreign" FOREIGN KEY("node_id") REFERENCES "data.node"("id");
ALTER TABLE
    "data.collect" ADD CONSTRAINT "data_collect_metric_id_foreign" FOREIGN KEY("metric_id") REFERENCES "data.metric"("id");
ALTER TABLE
    "data.link" ADD CONSTRAINT "data_link_node_b_id_foreign" FOREIGN KEY("node_b_id") REFERENCES "data.node"("id");
ALTER TABLE
    "data.link" ADD CONSTRAINT "data_link_node_a_id_foreign" FOREIGN KEY("node_a_id") REFERENCES "data.node"("id");
ALTER TABLE
    "data.sample" ADD CONSTRAINT "data_sample_idx_node_foreign" FOREIGN KEY("idx_node") REFERENCES "data.node"("id");
ALTER TABLE
    "data.node" ADD CONSTRAINT "data_node_agent_id_foreign" FOREIGN KEY("agent_id") REFERENCES "data.agent"("id");
ALTER TABLE
    "data.session" ADD CONSTRAINT "data_session_account_id_foreign" FOREIGN KEY("account_id") REFERENCES "data.account"("id");
ALTER TABLE
    "data.permission" ADD CONSTRAINT "data_permission_account_id_foreign" FOREIGN KEY("account_id") REFERENCES "data.account"("id");
ALTER TABLE
    "data.map" ADD CONSTRAINT "data_map_account_id_foreign" FOREIGN KEY("account_id") REFERENCES "data.account"("id");
ALTER TABLE
    "data.node" ADD CONSTRAINT "data_node_map_id_foreign" FOREIGN KEY("map_id") REFERENCES "data.map"("id");