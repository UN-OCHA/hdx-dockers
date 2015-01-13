--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ckan_dataset; Type: TABLE; Schema: public; Owner: cps; Tablespace: 
--

CREATE TABLE ckan_dataset (
    name character varying(255) NOT NULL,
    author character varying(255),
    author_email character varying(255),
    maintainer character varying(255),
    maintainer_email character varying(255),
    status character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    type character varying(255),
    configuration_id bigint
);


ALTER TABLE public.ckan_dataset OWNER TO cps;

--
-- Name: ckan_resource; Type: TABLE; Schema: public; Owner: cps; Tablespace: 
--

CREATE TABLE ckan_resource (
    id character varying(255) NOT NULL,
    revision_id character varying(255) NOT NULL,
    detectiondate timestamp without time zone NOT NULL,
    downloaddate timestamp without time zone,
    evaluationdate timestamp without time zone,
    evaluator character varying(255),
    importdate timestamp without time zone,
    importer character varying(255),
    name character varying(255) NOT NULL,
    parentdataset_id character varying(255) NOT NULL,
    parentdataset_name character varying(255) NOT NULL,
    parentdataset_revision_id character varying(255) NOT NULL,
    parentdataset_revision_timestamp timestamp without time zone NOT NULL,
    revision_timestamp timestamp without time zone NOT NULL,
    workflowstate character varying(255) NOT NULL,
    resource_configuration_id bigint,
    type character varying(255)
);


ALTER TABLE public.ckan_resource OWNER TO cps;

--
-- Name: entity; Type: TABLE; Schema: public; Owner: cps; Tablespace: 
--

CREATE TABLE entity (
    id bigint NOT NULL,
    code character varying(255) NOT NULL,
    text_id bigint,
    entity_type_id bigint,
    parent_id bigint
);


ALTER TABLE public.entity OWNER TO cps;

--
-- Name: entity_seq; Type: SEQUENCE; Schema: public; Owner: cps
--

CREATE SEQUENCE entity_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.entity_seq OWNER TO cps;

--
-- Name: entity_type; Type: TABLE; Schema: public; Owner: cps; Tablespace: 
--

CREATE TABLE entity_type (
    id bigint NOT NULL,
    code character varying(255) NOT NULL,
    text_id bigint
);


ALTER TABLE public.entity_type OWNER TO cps;

--
-- Name: entity_type_seq; Type: SEQUENCE; Schema: public; Owner: cps
--

CREATE SEQUENCE entity_type_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.entity_type_seq OWNER TO cps;

--
-- Name: hdx_dataserie_metadata; Type: TABLE; Schema: public; Owner: cps; Tablespace: 
--

CREATE TABLE hdx_dataserie_metadata (
    id bigint NOT NULL,
    entry_key character varying(255) NOT NULL,
    entry_value_text_id bigint,
    indicator_type_id bigint NOT NULL,
    source_id bigint NOT NULL
);


ALTER TABLE public.hdx_dataserie_metadata OWNER TO cps;

--
-- Name: hdx_dataserie_metadata_seq; Type: SEQUENCE; Schema: public; Owner: cps
--

CREATE SEQUENCE hdx_dataserie_metadata_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hdx_dataserie_metadata_seq OWNER TO cps;

--
-- Name: hdx_indicator; Type: TABLE; Schema: public; Owner: cps; Tablespace: 
--

CREATE TABLE hdx_indicator (
    id bigint NOT NULL,
    end_time timestamp without time zone,
    initial_value character varying(255) NOT NULL,
    periodicity character varying(255) NOT NULL,
    source_link character varying(255),
    start_time timestamp without time zone NOT NULL,
    date_value date,
    datetime_value timestamp without time zone,
    number_value double precision,
    string_value character varying(255),
    entity_id bigint NOT NULL,
    import_from_ckan_id bigint,
    source_id bigint NOT NULL,
    type_id bigint NOT NULL,
    text_id bigint,
    validation_status character varying(255) DEFAULT 'SUCCESS'::character varying NOT NULL,
    expected_time_format character varying(255),
    interpreted_time_format character varying(255),
    lower_boundary double precision,
    multiplier double precision,
    upper_boundary double precision,
    validation_message character varying(255)
);


ALTER TABLE public.hdx_indicator OWNER TO cps;

--
-- Name: hdx_translation; Type: TABLE; Schema: public; Owner: cps; Tablespace: 
--

CREATE TABLE hdx_translation (
    value pg_catalog.text NOT NULL,
    language character varying(255) NOT NULL,
    text bigint NOT NULL
);


ALTER TABLE public.hdx_translation OWNER TO cps;

--
-- Name: hdx_unit; Type: TABLE; Schema: public; Owner: cps; Tablespace: 
--

CREATE TABLE hdx_unit (
    id bigint NOT NULL,
    code character varying(255) NOT NULL,
    text_id bigint
);


ALTER TABLE public.hdx_unit OWNER TO cps;

--
-- Name: hdx_unit_seq; Type: SEQUENCE; Schema: public; Owner: cps
--

CREATE SEQUENCE hdx_unit_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hdx_unit_seq OWNER TO cps;

--
-- Name: hdx_user; Type: TABLE; Schema: public; Owner: cps; Tablespace: 
--

CREATE TABLE hdx_user (
    id character varying(255) NOT NULL,
    ckanapikey character varying(255),
    password character varying(255),
    role character varying(255)
);


ALTER TABLE public.hdx_user OWNER TO cps;

--
-- Name: text; Type: TABLE; Schema: public; Owner: cps; Tablespace: 
--

CREATE TABLE text (
    id bigint NOT NULL,
    default_value pg_catalog.text NOT NULL
);


ALTER TABLE public.text OWNER TO cps;

--
-- Name: hdx_view_additional_data_text; Type: VIEW; Schema: public; Owner: cps
--

CREATE VIEW hdx_view_additional_data_text AS
    SELECT ad.id, ad.entry_key, ad.entry_value_text_id, ad.indicator_type_id, ad.source_id, t.default_value FROM hdx_dataserie_metadata ad, text t WHERE (ad.entry_value_text_id = t.id);


ALTER TABLE public.hdx_view_additional_data_text OWNER TO cps;

--
-- Name: indicator_type; Type: TABLE; Schema: public; Owner: cps; Tablespace: 
--

CREATE TABLE indicator_type (
    id bigint NOT NULL,
    code character varying(255) NOT NULL,
    value_type character varying(255),
    text_id bigint,
    unit_id bigint
);


ALTER TABLE public.indicator_type OWNER TO cps;

--
-- Name: source; Type: TABLE; Schema: public; Owner: cps; Tablespace: 
--

CREATE TABLE source (
    id bigint NOT NULL,
    code character varying(255) NOT NULL,
    org_link character varying(255),
    text_id bigint NOT NULL,
    organisation_id bigint
);


ALTER TABLE public.source OWNER TO cps;

--
-- Name: hdx_view_indicator_max_date; Type: VIEW; Schema: public; Owner: cps
--

CREATE VIEW hdx_view_indicator_max_date AS
    SELECT i.id, i.number_value AS value, it.code AS indicator_type_code, itt.default_value AS indicator_type_name, e.code AS location_code, et.default_value AS location_name, s.code AS source_code, st.default_value AS source_name, i.start_time FROM (hdx_indicator i JOIN (SELECT hdx_indicator.entity_id, hdx_indicator.source_id, hdx_indicator.type_id, max(hdx_indicator.start_time) AS max_date FROM hdx_indicator GROUP BY hdx_indicator.entity_id, hdx_indicator.source_id, hdx_indicator.type_id) i2 ON (((((i.entity_id = i2.entity_id) AND (i.source_id = i2.source_id)) AND (i.type_id = i2.type_id)) AND (i.start_time = i2.max_date)))), indicator_type it, source s, entity e, text itt, text st, text et WHERE (((((((i.type_id = it.id) AND (i.source_id = s.id)) AND (i.entity_id = e.id)) AND (itt.id = it.text_id)) AND (st.id = s.text_id)) AND (et.id = e.text_id)) AND (i.number_value IS NOT NULL));


ALTER TABLE public.hdx_view_indicator_max_date OWNER TO cps;

--
-- Name: hdx_view_indicator_type_count; Type: VIEW; Schema: public; Owner: cps
--

CREATE VIEW hdx_view_indicator_type_count AS
    SELECT i.type_id AS id, it.code, count(*) AS count FROM hdx_indicator i, indicator_type it WHERE (i.type_id = it.id) GROUP BY i.type_id, it.code ORDER BY it.code;


ALTER TABLE public.hdx_view_indicator_type_count OWNER TO cps;

--
-- Name: hdx_view_report_indicator_data; Type: VIEW; Schema: public; Owner: cps
--

CREATE VIEW hdx_view_report_indicator_data AS
    SELECT i.id AS indicator_id, date_part('year'::pg_catalog.text, i.start_time) AS indicator_year, i.number_value AS indicator_value, it.code AS indicator_type_code, s.code AS source_code, st.default_value AS source_default_value, e.code AS country_code, etx.default_value AS country_default_value FROM hdx_indicator i, indicator_type it, source s, text st, entity e, text etx, entity_type et WHERE ((((((it.id = i.type_id) AND (s.id = i.source_id)) AND (st.id = s.text_id)) AND (e.id = i.entity_id)) AND (etx.id = e.text_id)) AND (et.id = e.entity_type_id));


ALTER TABLE public.hdx_view_report_indicator_data OWNER TO cps;

--
-- Name: hdx_view_report_indicator_type_overview; Type: VIEW; Schema: public; Owner: cps
--

CREATE VIEW hdx_view_report_indicator_type_overview AS
    SELECT DISTINCT it.id AS indicator_type_id, it.code AS indicator_type_code, itt.default_value AS indicator_type_default_value, s.code AS source_code, st.default_value AS source_default_value, u.code AS unit_code, ut.default_value AS unit_default_value, dads.id AS data_summary_id, dads.default_value AS data_summary_default_value, dami.id AS more_info_id, dami.default_value AS more_info_default_value, datu.id AS terms_of_use_id, datu.default_value AS terms_of_use_default_value, damy.id AS methodology_id, damy.default_value AS methodology_default_value FROM ((((indicator_type it LEFT JOIN hdx_view_additional_data_text dads ON (((it.id = dads.indicator_type_id) AND ((dads.entry_key)::pg_catalog.text = 'DATASET_SUMMARY'::pg_catalog.text)))) LEFT JOIN hdx_view_additional_data_text dami ON (((it.id = dami.indicator_type_id) AND ((dami.entry_key)::pg_catalog.text = 'MORE_INFO'::pg_catalog.text)))) LEFT JOIN hdx_view_additional_data_text datu ON (((it.id = datu.indicator_type_id) AND ((datu.entry_key)::pg_catalog.text = 'TERMS_OF_USE'::pg_catalog.text)))) LEFT JOIN hdx_view_additional_data_text damy ON (((it.id = damy.indicator_type_id) AND ((damy.entry_key)::pg_catalog.text = 'METHODOLOGY'::pg_catalog.text)))), hdx_view_additional_data_text ad, text itt, source s, text st, hdx_unit u, text ut WHERE ((((((itt.id = it.text_id) AND (st.id = s.text_id)) AND (u.id = it.unit_id)) AND (ut.id = u.text_id)) AND (s.id = ad.source_id)) AND (it.id = ad.indicator_type_id)) ORDER BY it.id;


ALTER TABLE public.hdx_view_report_indicator_type_overview OWNER TO cps;

--
-- Name: import_from_ckan; Type: TABLE; Schema: public; Owner: cps; Tablespace: 
--

CREATE TABLE import_from_ckan (
    id bigint NOT NULL,
    resource_id character varying(255) NOT NULL,
    revision_id character varying(255) NOT NULL,
    "timestamp" timestamp without time zone NOT NULL
);


ALTER TABLE public.import_from_ckan OWNER TO cps;

--
-- Name: import_from_ckan_seq; Type: SEQUENCE; Schema: public; Owner: cps
--

CREATE SEQUENCE import_from_ckan_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.import_from_ckan_seq OWNER TO cps;

--
-- Name: indicator_resource_config_entry; Type: TABLE; Schema: public; Owner: cps; Tablespace: 
--

CREATE TABLE indicator_resource_config_entry (
    id bigint NOT NULL,
    entry_key character varying(255) NOT NULL,
    entry_value pg_catalog.text NOT NULL,
    indicator_type_id bigint NOT NULL,
    resource_configuration_id bigint NOT NULL,
    source_id bigint NOT NULL
);


ALTER TABLE public.indicator_resource_config_entry OWNER TO cps;

--
-- Name: indicator_resource_config_entry_seq; Type: SEQUENCE; Schema: public; Owner: cps
--

CREATE SEQUENCE indicator_resource_config_entry_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.indicator_resource_config_entry_seq OWNER TO cps;

--
-- Name: indicator_seq; Type: SEQUENCE; Schema: public; Owner: cps
--

CREATE SEQUENCE indicator_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.indicator_seq OWNER TO cps;

--
-- Name: indicator_type_dictionary; Type: TABLE; Schema: public; Owner: cps; Tablespace: 
--

CREATE TABLE indicator_type_dictionary (
    id bigint NOT NULL,
    unnormalized_name character varying(255) NOT NULL,
    indicator_type_id bigint NOT NULL,
    resource_configuration_id bigint NOT NULL
);


ALTER TABLE public.indicator_type_dictionary OWNER TO cps;

--
-- Name: indicator_type_dictionary_seq; Type: SEQUENCE; Schema: public; Owner: cps
--

CREATE SEQUENCE indicator_type_dictionary_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.indicator_type_dictionary_seq OWNER TO cps;

--
-- Name: indicator_type_seq; Type: SEQUENCE; Schema: public; Owner: cps
--

CREATE SEQUENCE indicator_type_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.indicator_type_seq OWNER TO cps;

--
-- Name: language; Type: TABLE; Schema: public; Owner: cps; Tablespace: 
--

CREATE TABLE language (
    code character varying(255) NOT NULL,
    native_name character varying(255) NOT NULL
);


ALTER TABLE public.language OWNER TO cps;

--
-- Name: organisation; Type: TABLE; Schema: public; Owner: cps; Tablespace: 
--

CREATE TABLE organisation (
    id bigint NOT NULL,
    org_link character varying(255),
    full_name_id bigint NOT NULL,
    short_name_id bigint NOT NULL
);


ALTER TABLE public.organisation OWNER TO cps;

--
-- Name: organisation_seq; Type: SEQUENCE; Schema: public; Owner: cps
--

CREATE SEQUENCE organisation_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.organisation_seq OWNER TO cps;

--
-- Name: region_dictionary; Type: TABLE; Schema: public; Owner: cps; Tablespace: 
--

CREATE TABLE region_dictionary (
    id bigint NOT NULL,
    unnormalized_name character varying(255) NOT NULL,
    entity_id bigint NOT NULL,
    resource_configuration_id bigint NOT NULL
);


ALTER TABLE public.region_dictionary OWNER TO cps;

--
-- Name: region_dictionary_seq; Type: SEQUENCE; Schema: public; Owner: cps
--

CREATE SEQUENCE region_dictionary_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.region_dictionary_seq OWNER TO cps;

--
-- Name: resource_config_entry; Type: TABLE; Schema: public; Owner: cps; Tablespace: 
--

CREATE TABLE resource_config_entry (
    id bigint NOT NULL,
    entry_key character varying(255) NOT NULL,
    entry_value pg_catalog.text NOT NULL,
    resource_configuration_id bigint NOT NULL
);


ALTER TABLE public.resource_config_entry OWNER TO cps;

--
-- Name: resource_config_entry_seq; Type: SEQUENCE; Schema: public; Owner: cps
--

CREATE SEQUENCE resource_config_entry_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.resource_config_entry_seq OWNER TO cps;

--
-- Name: resource_configuration; Type: TABLE; Schema: public; Owner: cps; Tablespace: 
--

CREATE TABLE resource_configuration (
    id bigint NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.resource_configuration OWNER TO cps;

--
-- Name: resource_configuration_seq; Type: SEQUENCE; Schema: public; Owner: cps
--

CREATE SEQUENCE resource_configuration_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.resource_configuration_seq OWNER TO cps;

--
-- Name: source_dictionary; Type: TABLE; Schema: public; Owner: cps; Tablespace: 
--

CREATE TABLE source_dictionary (
    id bigint NOT NULL,
    unnormalized_name character varying(255) NOT NULL,
    resource_configuration_id bigint NOT NULL,
    source_id bigint NOT NULL
);


ALTER TABLE public.source_dictionary OWNER TO cps;

--
-- Name: source_dictionary_seq; Type: SEQUENCE; Schema: public; Owner: cps
--

CREATE SEQUENCE source_dictionary_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.source_dictionary_seq OWNER TO cps;

--
-- Name: source_seq; Type: SEQUENCE; Schema: public; Owner: cps
--

CREATE SEQUENCE source_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.source_seq OWNER TO cps;

--
-- Name: text_seq; Type: SEQUENCE; Schema: public; Owner: cps
--

CREATE SEQUENCE text_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.text_seq OWNER TO cps;

--
-- Name: ckan_dataset_pkey; Type: CONSTRAINT; Schema: public; Owner: cps; Tablespace: 
--

ALTER TABLE ONLY ckan_dataset
    ADD CONSTRAINT ckan_dataset_pkey PRIMARY KEY (name);


--
-- Name: ckan_resource_pkey; Type: CONSTRAINT; Schema: public; Owner: cps; Tablespace: 
--

ALTER TABLE ONLY ckan_resource
    ADD CONSTRAINT ckan_resource_pkey PRIMARY KEY (id, revision_id);


--
-- Name: entity_code_entity_type_id_key; Type: CONSTRAINT; Schema: public; Owner: cps; Tablespace: 
--

ALTER TABLE ONLY entity
    ADD CONSTRAINT entity_code_entity_type_id_key UNIQUE (code, entity_type_id);


--
-- Name: entity_pkey; Type: CONSTRAINT; Schema: public; Owner: cps; Tablespace: 
--

ALTER TABLE ONLY entity
    ADD CONSTRAINT entity_pkey PRIMARY KEY (id);


--
-- Name: entity_type_code_key; Type: CONSTRAINT; Schema: public; Owner: cps; Tablespace: 
--

ALTER TABLE ONLY entity_type
    ADD CONSTRAINT entity_type_code_key UNIQUE (code);


--
-- Name: entity_type_pkey; Type: CONSTRAINT; Schema: public; Owner: cps; Tablespace: 
--

ALTER TABLE ONLY entity_type
    ADD CONSTRAINT entity_type_pkey PRIMARY KEY (id);


--
-- Name: hdx_additional_data_pkey; Type: CONSTRAINT; Schema: public; Owner: cps; Tablespace: 
--

ALTER TABLE ONLY hdx_dataserie_metadata
    ADD CONSTRAINT hdx_additional_data_pkey PRIMARY KEY (id);


--
-- Name: hdx_indicator_pkey; Type: CONSTRAINT; Schema: public; Owner: cps; Tablespace: 
--

ALTER TABLE ONLY hdx_indicator
    ADD CONSTRAINT hdx_indicator_pkey PRIMARY KEY (id);


--
-- Name: hdx_indicator_source_id_entity_id_type_id_start_time_period_key; Type: CONSTRAINT; Schema: public; Owner: cps; Tablespace: 
--

ALTER TABLE ONLY hdx_indicator
    ADD CONSTRAINT hdx_indicator_source_id_entity_id_type_id_start_time_period_key UNIQUE (source_id, entity_id, type_id, start_time, periodicity);


--
-- Name: hdx_translation_pkey; Type: CONSTRAINT; Schema: public; Owner: cps; Tablespace: 
--

ALTER TABLE ONLY hdx_translation
    ADD CONSTRAINT hdx_translation_pkey PRIMARY KEY (language, text);


--
-- Name: hdx_unit_pkey; Type: CONSTRAINT; Schema: public; Owner: cps; Tablespace: 
--

ALTER TABLE ONLY hdx_unit
    ADD CONSTRAINT hdx_unit_pkey PRIMARY KEY (id);


--
-- Name: hdx_user_pkey; Type: CONSTRAINT; Schema: public; Owner: cps; Tablespace: 
--

ALTER TABLE ONLY hdx_user
    ADD CONSTRAINT hdx_user_pkey PRIMARY KEY (id);


--
-- Name: import_from_ckan_pkey; Type: CONSTRAINT; Schema: public; Owner: cps; Tablespace: 
--

ALTER TABLE ONLY import_from_ckan
    ADD CONSTRAINT import_from_ckan_pkey PRIMARY KEY (id);


--
-- Name: indicator_resource_config_entry_pkey; Type: CONSTRAINT; Schema: public; Owner: cps; Tablespace: 
--

ALTER TABLE ONLY indicator_resource_config_entry
    ADD CONSTRAINT indicator_resource_config_entry_pkey PRIMARY KEY (id);


--
-- Name: indicator_type_code_key; Type: CONSTRAINT; Schema: public; Owner: cps; Tablespace: 
--

ALTER TABLE ONLY indicator_type
    ADD CONSTRAINT indicator_type_code_key UNIQUE (code);


--
-- Name: indicator_type_dictionary_pkey; Type: CONSTRAINT; Schema: public; Owner: cps; Tablespace: 
--

ALTER TABLE ONLY indicator_type_dictionary
    ADD CONSTRAINT indicator_type_dictionary_pkey PRIMARY KEY (id);


--
-- Name: indicator_type_pkey; Type: CONSTRAINT; Schema: public; Owner: cps; Tablespace: 
--

ALTER TABLE ONLY indicator_type
    ADD CONSTRAINT indicator_type_pkey PRIMARY KEY (id);


--
-- Name: language_pkey; Type: CONSTRAINT; Schema: public; Owner: cps; Tablespace: 
--

ALTER TABLE ONLY language
    ADD CONSTRAINT language_pkey PRIMARY KEY (code);


--
-- Name: organisation_pkey; Type: CONSTRAINT; Schema: public; Owner: cps; Tablespace: 
--

ALTER TABLE ONLY organisation
    ADD CONSTRAINT organisation_pkey PRIMARY KEY (id);


--
-- Name: region_dictionary_pkey; Type: CONSTRAINT; Schema: public; Owner: cps; Tablespace: 
--

ALTER TABLE ONLY region_dictionary
    ADD CONSTRAINT region_dictionary_pkey PRIMARY KEY (id);


--
-- Name: resource_config_entry_pkey; Type: CONSTRAINT; Schema: public; Owner: cps; Tablespace: 
--

ALTER TABLE ONLY resource_config_entry
    ADD CONSTRAINT resource_config_entry_pkey PRIMARY KEY (id);


--
-- Name: resource_configuration_name_key; Type: CONSTRAINT; Schema: public; Owner: cps; Tablespace: 
--

ALTER TABLE ONLY resource_configuration
    ADD CONSTRAINT resource_configuration_name_key UNIQUE (name);


--
-- Name: resource_configuration_pkey; Type: CONSTRAINT; Schema: public; Owner: cps; Tablespace: 
--

ALTER TABLE ONLY resource_configuration
    ADD CONSTRAINT resource_configuration_pkey PRIMARY KEY (id);


--
-- Name: source_code_key; Type: CONSTRAINT; Schema: public; Owner: cps; Tablespace: 
--

ALTER TABLE ONLY source
    ADD CONSTRAINT source_code_key UNIQUE (code);


--
-- Name: source_dictionary_pkey; Type: CONSTRAINT; Schema: public; Owner: cps; Tablespace: 
--

ALTER TABLE ONLY source_dictionary
    ADD CONSTRAINT source_dictionary_pkey PRIMARY KEY (id);


--
-- Name: source_indicator_entry; Type: CONSTRAINT; Schema: public; Owner: cps; Tablespace: 
--

ALTER TABLE ONLY hdx_dataserie_metadata
    ADD CONSTRAINT source_indicator_entry UNIQUE (source_id, indicator_type_id, entry_key);


--
-- Name: source_pkey; Type: CONSTRAINT; Schema: public; Owner: cps; Tablespace: 
--

ALTER TABLE ONLY source
    ADD CONSTRAINT source_pkey PRIMARY KEY (id);


--
-- Name: text_pkey; Type: CONSTRAINT; Schema: public; Owner: cps; Tablespace: 
--

ALTER TABLE ONLY text
    ADD CONSTRAINT text_pkey PRIMARY KEY (id);


--
-- Name: indicator_resource_config_entry_index; Type: INDEX; Schema: public; Owner: cps; Tablespace: 
--

CREATE INDEX indicator_resource_config_entry_index ON indicator_resource_config_entry USING btree (entry_key);


--
-- Name: nameindex; Type: INDEX; Schema: public; Owner: cps; Tablespace: 
--

CREATE INDEX nameindex ON resource_configuration USING btree (name);


--
-- Name: resource_config_entry_index; Type: INDEX; Schema: public; Owner: cps; Tablespace: 
--

CREATE INDEX resource_config_entry_index ON resource_config_entry USING btree (entry_key);


--
-- Name: fk__dataserie_metadata_to_indicator_type; Type: FK CONSTRAINT; Schema: public; Owner: cps
--

ALTER TABLE ONLY hdx_dataserie_metadata
    ADD CONSTRAINT fk__dataserie_metadata_to_indicator_type FOREIGN KEY (indicator_type_id) REFERENCES indicator_type(id);


--
-- Name: fk__dataserie_metadata_to_name_text; Type: FK CONSTRAINT; Schema: public; Owner: cps
--

ALTER TABLE ONLY hdx_dataserie_metadata
    ADD CONSTRAINT fk__dataserie_metadata_to_name_text FOREIGN KEY (entry_value_text_id) REFERENCES text(id);


--
-- Name: fk__dataserie_metadata_to_source; Type: FK CONSTRAINT; Schema: public; Owner: cps
--

ALTER TABLE ONLY hdx_dataserie_metadata
    ADD CONSTRAINT fk__dataserie_metadata_to_source FOREIGN KEY (source_id) REFERENCES source(id);


--
-- Name: fk_ckan_dataset_to_resource_config; Type: FK CONSTRAINT; Schema: public; Owner: cps
--

ALTER TABLE ONLY ckan_dataset
    ADD CONSTRAINT fk_ckan_dataset_to_resource_config FOREIGN KEY (configuration_id) REFERENCES resource_configuration(id);


--
-- Name: fk_ckan_resource_to_resource_config; Type: FK CONSTRAINT; Schema: public; Owner: cps
--

ALTER TABLE ONLY ckan_resource
    ADD CONSTRAINT fk_ckan_resource_to_resource_config FOREIGN KEY (resource_configuration_id) REFERENCES resource_configuration(id);


--
-- Name: fk_entity_to_name_text; Type: FK CONSTRAINT; Schema: public; Owner: cps
--

ALTER TABLE ONLY entity
    ADD CONSTRAINT fk_entity_to_name_text FOREIGN KEY (text_id) REFERENCES text(id);


--
-- Name: fk_entity_to_name_text; Type: FK CONSTRAINT; Schema: public; Owner: cps
--

ALTER TABLE ONLY hdx_unit
    ADD CONSTRAINT fk_entity_to_name_text FOREIGN KEY (text_id) REFERENCES text(id);


--
-- Name: fk_entity_to_parent; Type: FK CONSTRAINT; Schema: public; Owner: cps
--

ALTER TABLE ONLY entity
    ADD CONSTRAINT fk_entity_to_parent FOREIGN KEY (parent_id) REFERENCES entity(id);


--
-- Name: fk_entity_to_type; Type: FK CONSTRAINT; Schema: public; Owner: cps
--

ALTER TABLE ONLY entity
    ADD CONSTRAINT fk_entity_to_type FOREIGN KEY (entity_type_id) REFERENCES entity_type(id);


--
-- Name: fk_entity_type_to_name_text; Type: FK CONSTRAINT; Schema: public; Owner: cps
--

ALTER TABLE ONLY entity_type
    ADD CONSTRAINT fk_entity_type_to_name_text FOREIGN KEY (text_id) REFERENCES text(id);


--
-- Name: fk_full_name_to_text; Type: FK CONSTRAINT; Schema: public; Owner: cps
--

ALTER TABLE ONLY organisation
    ADD CONSTRAINT fk_full_name_to_text FOREIGN KEY (full_name_id) REFERENCES text(id);


--
-- Name: fk_import_from_ckan; Type: FK CONSTRAINT; Schema: public; Owner: cps
--

ALTER TABLE ONLY hdx_indicator
    ADD CONSTRAINT fk_import_from_ckan FOREIGN KEY (import_from_ckan_id) REFERENCES import_from_ckan(id);


--
-- Name: fk_ind_resource_config_map_to_indicator_type; Type: FK CONSTRAINT; Schema: public; Owner: cps
--

ALTER TABLE ONLY indicator_resource_config_entry
    ADD CONSTRAINT fk_ind_resource_config_map_to_indicator_type FOREIGN KEY (indicator_type_id) REFERENCES indicator_type(id);


--
-- Name: fk_ind_resource_config_map_to_parent; Type: FK CONSTRAINT; Schema: public; Owner: cps
--

ALTER TABLE ONLY indicator_resource_config_entry
    ADD CONSTRAINT fk_ind_resource_config_map_to_parent FOREIGN KEY (resource_configuration_id) REFERENCES resource_configuration(id);


--
-- Name: fk_ind_resource_config_map_to_source; Type: FK CONSTRAINT; Schema: public; Owner: cps
--

ALTER TABLE ONLY indicator_resource_config_entry
    ADD CONSTRAINT fk_ind_resource_config_map_to_source FOREIGN KEY (source_id) REFERENCES source(id);


--
-- Name: fk_indicator_to_entity; Type: FK CONSTRAINT; Schema: public; Owner: cps
--

ALTER TABLE ONLY hdx_indicator
    ADD CONSTRAINT fk_indicator_to_entity FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- Name: fk_indicator_to_source; Type: FK CONSTRAINT; Schema: public; Owner: cps
--

ALTER TABLE ONLY hdx_indicator
    ADD CONSTRAINT fk_indicator_to_source FOREIGN KEY (source_id) REFERENCES source(id);


--
-- Name: fk_indicator_to_type; Type: FK CONSTRAINT; Schema: public; Owner: cps
--

ALTER TABLE ONLY hdx_indicator
    ADD CONSTRAINT fk_indicator_to_type FOREIGN KEY (type_id) REFERENCES indicator_type(id);


--
-- Name: fk_indicator_type_dictionary_to_config; Type: FK CONSTRAINT; Schema: public; Owner: cps
--

ALTER TABLE ONLY indicator_type_dictionary
    ADD CONSTRAINT fk_indicator_type_dictionary_to_config FOREIGN KEY (resource_configuration_id) REFERENCES resource_configuration(id);


--
-- Name: fk_indicator_type_to_name_text; Type: FK CONSTRAINT; Schema: public; Owner: cps
--

ALTER TABLE ONLY indicator_type
    ADD CONSTRAINT fk_indicator_type_to_name_text FOREIGN KEY (text_id) REFERENCES text(id);


--
-- Name: fk_indicator_type_to_unit; Type: FK CONSTRAINT; Schema: public; Owner: cps
--

ALTER TABLE ONLY indicator_type
    ADD CONSTRAINT fk_indicator_type_to_unit FOREIGN KEY (unit_id) REFERENCES hdx_unit(id);


--
-- Name: fk_indicator_value_to_text; Type: FK CONSTRAINT; Schema: public; Owner: cps
--

ALTER TABLE ONLY hdx_indicator
    ADD CONSTRAINT fk_indicator_value_to_text FOREIGN KEY (text_id) REFERENCES text(id);


--
-- Name: fk_region_dictionary_to_config; Type: FK CONSTRAINT; Schema: public; Owner: cps
--

ALTER TABLE ONLY region_dictionary
    ADD CONSTRAINT fk_region_dictionary_to_config FOREIGN KEY (resource_configuration_id) REFERENCES resource_configuration(id);


--
-- Name: fk_resource_config_map_to_parent; Type: FK CONSTRAINT; Schema: public; Owner: cps
--

ALTER TABLE ONLY resource_config_entry
    ADD CONSTRAINT fk_resource_config_map_to_parent FOREIGN KEY (resource_configuration_id) REFERENCES resource_configuration(id);


--
-- Name: fk_short_name_to_text; Type: FK CONSTRAINT; Schema: public; Owner: cps
--

ALTER TABLE ONLY organisation
    ADD CONSTRAINT fk_short_name_to_text FOREIGN KEY (short_name_id) REFERENCES text(id);


--
-- Name: fk_source_dictionary_to_config; Type: FK CONSTRAINT; Schema: public; Owner: cps
--

ALTER TABLE ONLY source_dictionary
    ADD CONSTRAINT fk_source_dictionary_to_config FOREIGN KEY (resource_configuration_id) REFERENCES resource_configuration(id);


--
-- Name: fk_source_to_name_text; Type: FK CONSTRAINT; Schema: public; Owner: cps
--

ALTER TABLE ONLY source
    ADD CONSTRAINT fk_source_to_name_text FOREIGN KEY (text_id) REFERENCES text(id);


--
-- Name: fk_source_to_organisation; Type: FK CONSTRAINT; Schema: public; Owner: cps
--

ALTER TABLE ONLY source
    ADD CONSTRAINT fk_source_to_organisation FOREIGN KEY (organisation_id) REFERENCES organisation(id);


--
-- Name: fk_translation_to_language; Type: FK CONSTRAINT; Schema: public; Owner: cps
--

ALTER TABLE ONLY hdx_translation
    ADD CONSTRAINT fk_translation_to_language FOREIGN KEY (language) REFERENCES language(code);


--
-- Name: fk_translation_to_text; Type: FK CONSTRAINT; Schema: public; Owner: cps
--

ALTER TABLE ONLY hdx_translation
    ADD CONSTRAINT fk_translation_to_text FOREIGN KEY (text) REFERENCES text(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

INSERT INTO hdx_user VALUES ('cps', 'PzVxCsj/A1mKnI8Sg9e/0w==', '{SHA}O7/EfEtkY7nlXNFzOc7vYTGgU2g=', 'admin');


