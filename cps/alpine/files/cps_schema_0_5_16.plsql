toc.dat                                                                                             0000600 0004000 0002000 00000127460 12455461436 014463  0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP       0    %                 s            cps    9.3.5    9.3.5 u    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false         �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false         �           1262    16778    cps    DATABASE     u   CREATE DATABASE cps WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';
    DROP DATABASE cps;
             cps    false                     2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false         �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    5         �           0    0    public    ACL     �   REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;
                  postgres    false    5         �            3079    11789    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false         �           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    214         �            1259    16779    ckan_dataset    TABLE     }  CREATE TABLE ckan_dataset (
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
     DROP TABLE public.ckan_dataset;
       public         cps    false    5         �            1259    16785    ckan_resource    TABLE     ^  CREATE TABLE ckan_resource (
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
 !   DROP TABLE public.ckan_resource;
       public         cps    false    5         �            1259    16791    entity    TABLE     �   CREATE TABLE entity (
    id bigint NOT NULL,
    code character varying(255) NOT NULL,
    text_id bigint,
    entity_type_id bigint,
    parent_id bigint
);
    DROP TABLE public.entity;
       public         cps    false    5         �            1259    16794 
   entity_seq    SEQUENCE     l   CREATE SEQUENCE entity_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 !   DROP SEQUENCE public.entity_seq;
       public       cps    false    5         �            1259    16796    entity_type    TABLE     s   CREATE TABLE entity_type (
    id bigint NOT NULL,
    code character varying(255) NOT NULL,
    text_id bigint
);
    DROP TABLE public.entity_type;
       public         cps    false    5         �            1259    16799    entity_type_seq    SEQUENCE     q   CREATE SEQUENCE entity_type_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.entity_type_seq;
       public       cps    false    5         �            1259    16801    hdx_dataserie_metadata    TABLE     �   CREATE TABLE hdx_dataserie_metadata (
    id bigint NOT NULL,
    entry_key character varying(255) NOT NULL,
    entry_value_text_id bigint,
    indicator_type_id bigint NOT NULL,
    source_id bigint NOT NULL
);
 *   DROP TABLE public.hdx_dataserie_metadata;
       public         cps    false    5         �            1259    16804    hdx_dataserie_metadata_seq    SEQUENCE     |   CREATE SEQUENCE hdx_dataserie_metadata_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.hdx_dataserie_metadata_seq;
       public       cps    false    5         �            1259    17152     hdx_dataserie_to_curated_dataset    TABLE     �  CREATE TABLE hdx_dataserie_to_curated_dataset (
    id bigint NOT NULL,
    ckan_dataset_id character varying(255),
    ckan_dataset_name character varying(255),
    last_data_push timestamp without time zone,
    last_data_update timestamp without time zone,
    last_metadata_push timestamp without time zone,
    last_metadata_update timestamp without time zone,
    indicator_type_id bigint NOT NULL,
    source_id bigint NOT NULL
);
 4   DROP TABLE public.hdx_dataserie_to_curated_dataset;
       public         cps    false    5         �            1259    17150 $   hdx_dataserie_to_curated_dataset_seq    SEQUENCE     �   CREATE SEQUENCE hdx_dataserie_to_curated_dataset_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.hdx_dataserie_to_curated_dataset_seq;
       public       cps    false    5         �            1259    16806    hdx_indicator    TABLE     �  CREATE TABLE hdx_indicator (
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
 !   DROP TABLE public.hdx_indicator;
       public         cps    false    5         �            1259    16813    hdx_translation    TABLE     �   CREATE TABLE hdx_translation (
    value pg_catalog.text NOT NULL,
    language character varying(255) NOT NULL,
    text bigint NOT NULL
);
 #   DROP TABLE public.hdx_translation;
       public         cps    false    5         �            1259    16819    hdx_unit    TABLE     p   CREATE TABLE hdx_unit (
    id bigint NOT NULL,
    code character varying(255) NOT NULL,
    text_id bigint
);
    DROP TABLE public.hdx_unit;
       public         cps    false    5         �            1259    16822    hdx_unit_seq    SEQUENCE     n   CREATE SEQUENCE hdx_unit_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.hdx_unit_seq;
       public       cps    false    5         �            1259    16824    hdx_user    TABLE     �   CREATE TABLE hdx_user (
    id character varying(255) NOT NULL,
    ckanapikey character varying(255),
    password character varying(255),
    role character varying(255)
);
    DROP TABLE public.hdx_user;
       public         cps    false    5         �            1259    16830    text    TABLE     Z   CREATE TABLE text (
    id bigint NOT NULL,
    default_value pg_catalog.text NOT NULL
);
    DROP TABLE public.text;
       public         cps    false    5         �            1259    16836    hdx_view_additional_data_text    VIEW       CREATE VIEW hdx_view_additional_data_text AS
 SELECT ad.id,
    ad.entry_key,
    ad.entry_value_text_id,
    ad.indicator_type_id,
    ad.source_id,
    t.default_value
   FROM hdx_dataserie_metadata ad,
    text t
  WHERE (ad.entry_value_text_id = t.id);
 0   DROP VIEW public.hdx_view_additional_data_text;
       public       cps    false    176    176    176    176    183    183    176    5         �            1259    16840    indicator_type    TABLE     �   CREATE TABLE indicator_type (
    id bigint NOT NULL,
    code character varying(255) NOT NULL,
    value_type character varying(255),
    text_id bigint,
    unit_id bigint
);
 "   DROP TABLE public.indicator_type;
       public         cps    false    5         �            1259    16846    source    TABLE     �   CREATE TABLE source (
    id bigint NOT NULL,
    code character varying(255) NOT NULL,
    org_link character varying(255),
    text_id bigint NOT NULL,
    organisation_id bigint
);
    DROP TABLE public.source;
       public         cps    false    5         �            1259    16852    hdx_view_indicator_max_date    VIEW     &  CREATE VIEW hdx_view_indicator_max_date AS
 SELECT i.id,
    i.number_value AS value,
    it.code AS indicator_type_code,
    itt.default_value AS indicator_type_name,
    e.code AS location_code,
    et.default_value AS location_name,
    s.code AS source_code,
    st.default_value AS source_name,
    i.start_time
   FROM (hdx_indicator i
     JOIN ( SELECT hdx_indicator.entity_id,
            hdx_indicator.source_id,
            hdx_indicator.type_id,
            max(hdx_indicator.start_time) AS max_date
           FROM hdx_indicator
          GROUP BY hdx_indicator.entity_id, hdx_indicator.source_id, hdx_indicator.type_id) i2 ON (((((i.entity_id = i2.entity_id) AND (i.source_id = i2.source_id)) AND (i.type_id = i2.type_id)) AND (i.start_time = i2.max_date)))),
    indicator_type it,
    source s,
    entity e,
    text itt,
    text st,
    text et
  WHERE (((((((i.type_id = it.id) AND (i.source_id = s.id)) AND (i.entity_id = e.id)) AND (itt.id = it.text_id)) AND (st.id = s.text_id)) AND (et.id = e.text_id)) AND (i.number_value IS NOT NULL));
 .   DROP VIEW public.hdx_view_indicator_max_date;
       public       cps    false    183    178    178    178    178    178    178    185    185    186    186    186    172    172    172    185    183    5         �            1259    16857    hdx_view_indicator_type_count    VIEW     �   CREATE VIEW hdx_view_indicator_type_count AS
 SELECT i.type_id AS id,
    it.code,
    count(*) AS count
   FROM hdx_indicator i,
    indicator_type it
  WHERE (i.type_id = it.id)
  GROUP BY i.type_id, it.code
  ORDER BY it.code;
 0   DROP VIEW public.hdx_view_indicator_type_count;
       public       cps    false    185    185    178    5         �            1259    16861    hdx_view_report_indicator_data    VIEW     �  CREATE VIEW hdx_view_report_indicator_data AS
 SELECT i.id AS indicator_id,
    date_part('year'::pg_catalog.text, i.start_time) AS indicator_year,
    i.number_value AS indicator_value,
    it.code AS indicator_type_code,
    s.code AS source_code,
    st.default_value AS source_default_value,
    e.code AS country_code,
    etx.default_value AS country_default_value
   FROM hdx_indicator i,
    indicator_type it,
    source s,
    text st,
    entity e,
    text etx,
    entity_type et
  WHERE ((((((it.id = i.type_id) AND (s.id = i.source_id)) AND (st.id = s.text_id)) AND (e.id = i.entity_id)) AND (etx.id = e.text_id)) AND (et.id = e.entity_type_id));
 1   DROP VIEW public.hdx_view_report_indicator_data;
       public       cps    false    178    172    174    178    178    178    183    172    172    172    183    185    185    186    186    186    178    178    5         �            1259    16866 '   hdx_view_report_indicator_type_overview    VIEW     x  CREATE VIEW hdx_view_report_indicator_type_overview AS
 SELECT DISTINCT it.id AS indicator_type_id,
    it.code AS indicator_type_code,
    itt.default_value AS indicator_type_default_value,
    s.code AS source_code,
    st.default_value AS source_default_value,
    u.code AS unit_code,
    ut.default_value AS unit_default_value,
    dads.id AS data_summary_id,
    dads.default_value AS data_summary_default_value,
    dami.id AS more_info_id,
    dami.default_value AS more_info_default_value,
    datu.id AS terms_of_use_id,
    datu.default_value AS terms_of_use_default_value,
    damy.id AS methodology_id,
    damy.default_value AS methodology_default_value
   FROM ((((indicator_type it
     LEFT JOIN hdx_view_additional_data_text dads ON (((it.id = dads.indicator_type_id) AND ((dads.entry_key)::pg_catalog.text = 'DATASET_SUMMARY'::pg_catalog.text))))
     LEFT JOIN hdx_view_additional_data_text dami ON (((it.id = dami.indicator_type_id) AND ((dami.entry_key)::pg_catalog.text = 'MORE_INFO'::pg_catalog.text))))
     LEFT JOIN hdx_view_additional_data_text datu ON (((it.id = datu.indicator_type_id) AND ((datu.entry_key)::pg_catalog.text = 'TERMS_OF_USE'::pg_catalog.text))))
     LEFT JOIN hdx_view_additional_data_text damy ON (((it.id = damy.indicator_type_id) AND ((damy.entry_key)::pg_catalog.text = 'METHODOLOGY'::pg_catalog.text)))),
    hdx_view_additional_data_text ad,
    text itt,
    source s,
    text st,
    hdx_unit u,
    text ut
  WHERE ((((((itt.id = it.text_id) AND (st.id = s.text_id)) AND (u.id = it.unit_id)) AND (ut.id = u.text_id)) AND (s.id = ad.source_id)) AND (it.id = ad.indicator_type_id))
  ORDER BY it.id;
 :   DROP VIEW public.hdx_view_report_indicator_type_overview;
       public       cps    false    180    186    186    186    185    185    185    185    184    184    184    184    184    183    183    180    180    5         �            1259    16871    import_from_ckan    TABLE     �   CREATE TABLE import_from_ckan (
    id bigint NOT NULL,
    resource_id character varying(255) NOT NULL,
    revision_id character varying(255) NOT NULL,
    "timestamp" timestamp without time zone NOT NULL
);
 $   DROP TABLE public.import_from_ckan;
       public         cps    false    5         �            1259    16877    import_from_ckan_seq    SEQUENCE     v   CREATE SEQUENCE import_from_ckan_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.import_from_ckan_seq;
       public       cps    false    5         �            1259    16879    indicator_resource_config_entry    TABLE       CREATE TABLE indicator_resource_config_entry (
    id bigint NOT NULL,
    entry_key character varying(255) NOT NULL,
    entry_value pg_catalog.text NOT NULL,
    indicator_type_id bigint NOT NULL,
    resource_configuration_id bigint NOT NULL,
    source_id bigint NOT NULL
);
 3   DROP TABLE public.indicator_resource_config_entry;
       public         cps    false    5         �            1259    16885 #   indicator_resource_config_entry_seq    SEQUENCE     �   CREATE SEQUENCE indicator_resource_config_entry_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.indicator_resource_config_entry_seq;
       public       cps    false    5         �            1259    16887    indicator_seq    SEQUENCE     o   CREATE SEQUENCE indicator_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.indicator_seq;
       public       cps    false    5         �            1259    16889    indicator_type_dictionary    TABLE     �   CREATE TABLE indicator_type_dictionary (
    id bigint NOT NULL,
    unnormalized_name character varying(255) NOT NULL,
    indicator_type_id bigint NOT NULL,
    resource_configuration_id bigint NOT NULL
);
 -   DROP TABLE public.indicator_type_dictionary;
       public         cps    false    5         �            1259    16892    indicator_type_dictionary_seq    SEQUENCE        CREATE SEQUENCE indicator_type_dictionary_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.indicator_type_dictionary_seq;
       public       cps    false    5         �            1259    16894    indicator_type_seq    SEQUENCE     t   CREATE SEQUENCE indicator_type_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.indicator_type_seq;
       public       cps    false    5         �            1259    16896    language    TABLE     u   CREATE TABLE language (
    code character varying(255) NOT NULL,
    native_name character varying(255) NOT NULL
);
    DROP TABLE public.language;
       public         cps    false    5         �            1259    16902    organisation    TABLE     �   CREATE TABLE organisation (
    id bigint NOT NULL,
    org_link character varying(255),
    full_name_id bigint NOT NULL,
    short_name_id bigint NOT NULL
);
     DROP TABLE public.organisation;
       public         cps    false    5         �            1259    16905    organisation_seq    SEQUENCE     r   CREATE SEQUENCE organisation_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.organisation_seq;
       public       cps    false    5         �            1259    16907    region_dictionary    TABLE     �   CREATE TABLE region_dictionary (
    id bigint NOT NULL,
    unnormalized_name character varying(255) NOT NULL,
    entity_id bigint NOT NULL,
    resource_configuration_id bigint NOT NULL
);
 %   DROP TABLE public.region_dictionary;
       public         cps    false    5         �            1259    16910    region_dictionary_seq    SEQUENCE     w   CREATE SEQUENCE region_dictionary_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.region_dictionary_seq;
       public       cps    false    5         �            1259    16912    resource_config_entry    TABLE     �   CREATE TABLE resource_config_entry (
    id bigint NOT NULL,
    entry_key character varying(255) NOT NULL,
    entry_value pg_catalog.text NOT NULL,
    resource_configuration_id bigint NOT NULL
);
 )   DROP TABLE public.resource_config_entry;
       public         cps    false    5         �            1259    16918    resource_config_entry_seq    SEQUENCE     {   CREATE SEQUENCE resource_config_entry_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.resource_config_entry_seq;
       public       cps    false    5         �            1259    16920    resource_configuration    TABLE     j   CREATE TABLE resource_configuration (
    id bigint NOT NULL,
    name character varying(255) NOT NULL
);
 *   DROP TABLE public.resource_configuration;
       public         cps    false    5         �            1259    16923    resource_configuration_seq    SEQUENCE     |   CREATE SEQUENCE resource_configuration_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.resource_configuration_seq;
       public       cps    false    5         �            1259    16925    source_dictionary    TABLE     �   CREATE TABLE source_dictionary (
    id bigint NOT NULL,
    unnormalized_name character varying(255) NOT NULL,
    resource_configuration_id bigint NOT NULL,
    source_id bigint NOT NULL
);
 %   DROP TABLE public.source_dictionary;
       public         cps    false    5         �            1259    16928    source_dictionary_seq    SEQUENCE     w   CREATE SEQUENCE source_dictionary_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.source_dictionary_seq;
       public       cps    false    5         �            1259    16930 
   source_seq    SEQUENCE     l   CREATE SEQUENCE source_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 !   DROP SEQUENCE public.source_seq;
       public       cps    false    5         �            1259    16932    text_seq    SEQUENCE     j   CREATE SEQUENCE text_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
    DROP SEQUENCE public.text_seq;
       public       cps    false    5         �           2606    16939    ckan_dataset_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY ckan_dataset
    ADD CONSTRAINT ckan_dataset_pkey PRIMARY KEY (name);
 H   ALTER TABLE ONLY public.ckan_dataset DROP CONSTRAINT ckan_dataset_pkey;
       public         cps    false    170    170         �           2606    16941    ckan_resource_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY ckan_resource
    ADD CONSTRAINT ckan_resource_pkey PRIMARY KEY (id, revision_id);
 J   ALTER TABLE ONLY public.ckan_resource DROP CONSTRAINT ckan_resource_pkey;
       public         cps    false    171    171    171         �           2606    16943    entity_code_entity_type_id_key 
   CONSTRAINT     i   ALTER TABLE ONLY entity
    ADD CONSTRAINT entity_code_entity_type_id_key UNIQUE (code, entity_type_id);
 O   ALTER TABLE ONLY public.entity DROP CONSTRAINT entity_code_entity_type_id_key;
       public         cps    false    172    172    172         �           2606    16945    entity_pkey 
   CONSTRAINT     I   ALTER TABLE ONLY entity
    ADD CONSTRAINT entity_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.entity DROP CONSTRAINT entity_pkey;
       public         cps    false    172    172         �           2606    16947    entity_type_code_key 
   CONSTRAINT     T   ALTER TABLE ONLY entity_type
    ADD CONSTRAINT entity_type_code_key UNIQUE (code);
 J   ALTER TABLE ONLY public.entity_type DROP CONSTRAINT entity_type_code_key;
       public         cps    false    174    174         �           2606    16949    entity_type_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY entity_type
    ADD CONSTRAINT entity_type_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.entity_type DROP CONSTRAINT entity_type_pkey;
       public         cps    false    174    174         �           2606    16951    hdx_additional_data_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY hdx_dataserie_metadata
    ADD CONSTRAINT hdx_additional_data_pkey PRIMARY KEY (id);
 Y   ALTER TABLE ONLY public.hdx_dataserie_metadata DROP CONSTRAINT hdx_additional_data_pkey;
       public         cps    false    176    176                    2606    17161 ?   hdx_dataserie_to_curated_datase_source_id_indicator_type_id_key 
   CONSTRAINT     �   ALTER TABLE ONLY hdx_dataserie_to_curated_dataset
    ADD CONSTRAINT hdx_dataserie_to_curated_datase_source_id_indicator_type_id_key UNIQUE (source_id, indicator_type_id);
 �   ALTER TABLE ONLY public.hdx_dataserie_to_curated_dataset DROP CONSTRAINT hdx_dataserie_to_curated_datase_source_id_indicator_type_id_key;
       public         cps    false    213    213    213                    2606    17159 %   hdx_dataserie_to_curated_dataset_pkey 
   CONSTRAINT     }   ALTER TABLE ONLY hdx_dataserie_to_curated_dataset
    ADD CONSTRAINT hdx_dataserie_to_curated_dataset_pkey PRIMARY KEY (id);
 p   ALTER TABLE ONLY public.hdx_dataserie_to_curated_dataset DROP CONSTRAINT hdx_dataserie_to_curated_dataset_pkey;
       public         cps    false    213    213         �           2606    16953    hdx_indicator_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY hdx_indicator
    ADD CONSTRAINT hdx_indicator_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.hdx_indicator DROP CONSTRAINT hdx_indicator_pkey;
       public         cps    false    178    178         �           2606    16955 ?   hdx_indicator_source_id_entity_id_type_id_start_time_period_key 
   CONSTRAINT     �   ALTER TABLE ONLY hdx_indicator
    ADD CONSTRAINT hdx_indicator_source_id_entity_id_type_id_start_time_period_key UNIQUE (source_id, entity_id, type_id, start_time, periodicity);
 w   ALTER TABLE ONLY public.hdx_indicator DROP CONSTRAINT hdx_indicator_source_id_entity_id_type_id_start_time_period_key;
       public         cps    false    178    178    178    178    178    178         �           2606    16957    hdx_translation_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY hdx_translation
    ADD CONSTRAINT hdx_translation_pkey PRIMARY KEY (language, text);
 N   ALTER TABLE ONLY public.hdx_translation DROP CONSTRAINT hdx_translation_pkey;
       public         cps    false    179    179    179         �           2606    16959    hdx_unit_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY hdx_unit
    ADD CONSTRAINT hdx_unit_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.hdx_unit DROP CONSTRAINT hdx_unit_pkey;
       public         cps    false    180    180         �           2606    16961    hdx_user_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY hdx_user
    ADD CONSTRAINT hdx_user_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.hdx_user DROP CONSTRAINT hdx_user_pkey;
       public         cps    false    182    182                     2606    16963    import_from_ckan_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY import_from_ckan
    ADD CONSTRAINT import_from_ckan_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.import_from_ckan DROP CONSTRAINT import_from_ckan_pkey;
       public         cps    false    191    191                    2606    16965 $   indicator_resource_config_entry_pkey 
   CONSTRAINT     {   ALTER TABLE ONLY indicator_resource_config_entry
    ADD CONSTRAINT indicator_resource_config_entry_pkey PRIMARY KEY (id);
 n   ALTER TABLE ONLY public.indicator_resource_config_entry DROP CONSTRAINT indicator_resource_config_entry_pkey;
       public         cps    false    193    193         �           2606    16967    indicator_type_code_key 
   CONSTRAINT     Z   ALTER TABLE ONLY indicator_type
    ADD CONSTRAINT indicator_type_code_key UNIQUE (code);
 P   ALTER TABLE ONLY public.indicator_type DROP CONSTRAINT indicator_type_code_key;
       public         cps    false    185    185                    2606    16969    indicator_type_dictionary_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY indicator_type_dictionary
    ADD CONSTRAINT indicator_type_dictionary_pkey PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.indicator_type_dictionary DROP CONSTRAINT indicator_type_dictionary_pkey;
       public         cps    false    196    196         �           2606    16971    indicator_type_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY indicator_type
    ADD CONSTRAINT indicator_type_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.indicator_type DROP CONSTRAINT indicator_type_pkey;
       public         cps    false    185    185                    2606    16973    language_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY language
    ADD CONSTRAINT language_pkey PRIMARY KEY (code);
 @   ALTER TABLE ONLY public.language DROP CONSTRAINT language_pkey;
       public         cps    false    199    199         	           2606    16975    organisation_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY organisation
    ADD CONSTRAINT organisation_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.organisation DROP CONSTRAINT organisation_pkey;
       public         cps    false    200    200                    2606    16977    region_dictionary_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY region_dictionary
    ADD CONSTRAINT region_dictionary_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.region_dictionary DROP CONSTRAINT region_dictionary_pkey;
       public         cps    false    202    202                    2606    16979    resource_config_entry_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY resource_config_entry
    ADD CONSTRAINT resource_config_entry_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.resource_config_entry DROP CONSTRAINT resource_config_entry_pkey;
       public         cps    false    204    204                    2606    16981    resource_configuration_name_key 
   CONSTRAINT     j   ALTER TABLE ONLY resource_configuration
    ADD CONSTRAINT resource_configuration_name_key UNIQUE (name);
 `   ALTER TABLE ONLY public.resource_configuration DROP CONSTRAINT resource_configuration_name_key;
       public         cps    false    206    206                    2606    16983    resource_configuration_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY resource_configuration
    ADD CONSTRAINT resource_configuration_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.resource_configuration DROP CONSTRAINT resource_configuration_pkey;
       public         cps    false    206    206         �           2606    16985    source_code_key 
   CONSTRAINT     J   ALTER TABLE ONLY source
    ADD CONSTRAINT source_code_key UNIQUE (code);
 @   ALTER TABLE ONLY public.source DROP CONSTRAINT source_code_key;
       public         cps    false    186    186                    2606    16987    source_dictionary_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY source_dictionary
    ADD CONSTRAINT source_dictionary_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.source_dictionary DROP CONSTRAINT source_dictionary_pkey;
       public         cps    false    208    208         �           2606    16989    source_indicator_entry 
   CONSTRAINT     �   ALTER TABLE ONLY hdx_dataserie_metadata
    ADD CONSTRAINT source_indicator_entry UNIQUE (source_id, indicator_type_id, entry_key);
 W   ALTER TABLE ONLY public.hdx_dataserie_metadata DROP CONSTRAINT source_indicator_entry;
       public         cps    false    176    176    176    176         �           2606    16991    source_pkey 
   CONSTRAINT     I   ALTER TABLE ONLY source
    ADD CONSTRAINT source_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.source DROP CONSTRAINT source_pkey;
       public         cps    false    186    186         �           2606    16993 	   text_pkey 
   CONSTRAINT     E   ALTER TABLE ONLY text
    ADD CONSTRAINT text_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.text DROP CONSTRAINT text_pkey;
       public         cps    false    183    183                    1259    16994 %   indicator_resource_config_entry_index    INDEX     o   CREATE INDEX indicator_resource_config_entry_index ON indicator_resource_config_entry USING btree (entry_key);
 9   DROP INDEX public.indicator_resource_config_entry_index;
       public         cps    false    193                    1259    16995 	   nameindex    INDEX     E   CREATE INDEX nameindex ON resource_configuration USING btree (name);
    DROP INDEX public.nameindex;
       public         cps    false    206                    1259    16996    resource_config_entry_index    INDEX     [   CREATE INDEX resource_config_entry_index ON resource_config_entry USING btree (entry_key);
 /   DROP INDEX public.resource_config_entry_index;
       public         cps    false    204                     2606    16997 (   fk__dataserie_metadata_to_indicator_type    FK CONSTRAINT     �   ALTER TABLE ONLY hdx_dataserie_metadata
    ADD CONSTRAINT fk__dataserie_metadata_to_indicator_type FOREIGN KEY (indicator_type_id) REFERENCES indicator_type(id);
 i   ALTER TABLE ONLY public.hdx_dataserie_metadata DROP CONSTRAINT fk__dataserie_metadata_to_indicator_type;
       public       cps    false    2042    185    176         !           2606    17002 #   fk__dataserie_metadata_to_name_text    FK CONSTRAINT     �   ALTER TABLE ONLY hdx_dataserie_metadata
    ADD CONSTRAINT fk__dataserie_metadata_to_name_text FOREIGN KEY (entry_value_text_id) REFERENCES text(id);
 d   ALTER TABLE ONLY public.hdx_dataserie_metadata DROP CONSTRAINT fk__dataserie_metadata_to_name_text;
       public       cps    false    183    176    2038         "           2606    17007     fk__dataserie_metadata_to_source    FK CONSTRAINT     �   ALTER TABLE ONLY hdx_dataserie_metadata
    ADD CONSTRAINT fk__dataserie_metadata_to_source FOREIGN KEY (source_id) REFERENCES source(id);
 a   ALTER TABLE ONLY public.hdx_dataserie_metadata DROP CONSTRAINT fk__dataserie_metadata_to_source;
       public       cps    false    176    2046    186         9           2606    17167 /   fk__dataserie_to_curated_data_to_indicator_type    FK CONSTRAINT     �   ALTER TABLE ONLY hdx_dataserie_to_curated_dataset
    ADD CONSTRAINT fk__dataserie_to_curated_data_to_indicator_type FOREIGN KEY (indicator_type_id) REFERENCES indicator_type(id);
 z   ALTER TABLE ONLY public.hdx_dataserie_to_curated_dataset DROP CONSTRAINT fk__dataserie_to_curated_data_to_indicator_type;
       public       cps    false    185    213    2042         8           2606    17162 '   fk__dataserie_to_curated_data_to_source    FK CONSTRAINT     �   ALTER TABLE ONLY hdx_dataserie_to_curated_dataset
    ADD CONSTRAINT fk__dataserie_to_curated_data_to_source FOREIGN KEY (source_id) REFERENCES source(id);
 r   ALTER TABLE ONLY public.hdx_dataserie_to_curated_dataset DROP CONSTRAINT fk__dataserie_to_curated_data_to_source;
       public       cps    false    2046    213    186                    2606    17012 "   fk_ckan_dataset_to_resource_config    FK CONSTRAINT     �   ALTER TABLE ONLY ckan_dataset
    ADD CONSTRAINT fk_ckan_dataset_to_resource_config FOREIGN KEY (configuration_id) REFERENCES resource_configuration(id);
 Y   ALTER TABLE ONLY public.ckan_dataset DROP CONSTRAINT fk_ckan_dataset_to_resource_config;
       public       cps    false    2067    206    170                    2606    17017 #   fk_ckan_resource_to_resource_config    FK CONSTRAINT     �   ALTER TABLE ONLY ckan_resource
    ADD CONSTRAINT fk_ckan_resource_to_resource_config FOREIGN KEY (resource_configuration_id) REFERENCES resource_configuration(id);
 [   ALTER TABLE ONLY public.ckan_resource DROP CONSTRAINT fk_ckan_resource_to_resource_config;
       public       cps    false    171    2067    206                    2606    17022    fk_entity_to_name_text    FK CONSTRAINT     m   ALTER TABLE ONLY entity
    ADD CONSTRAINT fk_entity_to_name_text FOREIGN KEY (text_id) REFERENCES text(id);
 G   ALTER TABLE ONLY public.entity DROP CONSTRAINT fk_entity_to_name_text;
       public       cps    false    2038    172    183         *           2606    17027    fk_entity_to_name_text    FK CONSTRAINT     o   ALTER TABLE ONLY hdx_unit
    ADD CONSTRAINT fk_entity_to_name_text FOREIGN KEY (text_id) REFERENCES text(id);
 I   ALTER TABLE ONLY public.hdx_unit DROP CONSTRAINT fk_entity_to_name_text;
       public       cps    false    183    180    2038                    2606    17032    fk_entity_to_parent    FK CONSTRAINT     n   ALTER TABLE ONLY entity
    ADD CONSTRAINT fk_entity_to_parent FOREIGN KEY (parent_id) REFERENCES entity(id);
 D   ALTER TABLE ONLY public.entity DROP CONSTRAINT fk_entity_to_parent;
       public       cps    false    172    172    2018                    2606    17037    fk_entity_to_type    FK CONSTRAINT     v   ALTER TABLE ONLY entity
    ADD CONSTRAINT fk_entity_to_type FOREIGN KEY (entity_type_id) REFERENCES entity_type(id);
 B   ALTER TABLE ONLY public.entity DROP CONSTRAINT fk_entity_to_type;
       public       cps    false    174    172    2022                    2606    17042    fk_entity_type_to_name_text    FK CONSTRAINT     w   ALTER TABLE ONLY entity_type
    ADD CONSTRAINT fk_entity_type_to_name_text FOREIGN KEY (text_id) REFERENCES text(id);
 Q   ALTER TABLE ONLY public.entity_type DROP CONSTRAINT fk_entity_type_to_name_text;
       public       cps    false    183    2038    174         3           2606    17047    fk_full_name_to_text    FK CONSTRAINT     v   ALTER TABLE ONLY organisation
    ADD CONSTRAINT fk_full_name_to_text FOREIGN KEY (full_name_id) REFERENCES text(id);
 K   ALTER TABLE ONLY public.organisation DROP CONSTRAINT fk_full_name_to_text;
       public       cps    false    2038    183    200         #           2606    17052    fk_import_from_ckan    FK CONSTRAINT     �   ALTER TABLE ONLY hdx_indicator
    ADD CONSTRAINT fk_import_from_ckan FOREIGN KEY (import_from_ckan_id) REFERENCES import_from_ckan(id);
 K   ALTER TABLE ONLY public.hdx_indicator DROP CONSTRAINT fk_import_from_ckan;
       public       cps    false    2048    191    178         /           2606    17057 ,   fk_ind_resource_config_map_to_indicator_type    FK CONSTRAINT     �   ALTER TABLE ONLY indicator_resource_config_entry
    ADD CONSTRAINT fk_ind_resource_config_map_to_indicator_type FOREIGN KEY (indicator_type_id) REFERENCES indicator_type(id);
 v   ALTER TABLE ONLY public.indicator_resource_config_entry DROP CONSTRAINT fk_ind_resource_config_map_to_indicator_type;
       public       cps    false    2042    193    185         0           2606    17062 $   fk_ind_resource_config_map_to_parent    FK CONSTRAINT     �   ALTER TABLE ONLY indicator_resource_config_entry
    ADD CONSTRAINT fk_ind_resource_config_map_to_parent FOREIGN KEY (resource_configuration_id) REFERENCES resource_configuration(id);
 n   ALTER TABLE ONLY public.indicator_resource_config_entry DROP CONSTRAINT fk_ind_resource_config_map_to_parent;
       public       cps    false    2067    206    193         1           2606    17067 $   fk_ind_resource_config_map_to_source    FK CONSTRAINT     �   ALTER TABLE ONLY indicator_resource_config_entry
    ADD CONSTRAINT fk_ind_resource_config_map_to_source FOREIGN KEY (source_id) REFERENCES source(id);
 n   ALTER TABLE ONLY public.indicator_resource_config_entry DROP CONSTRAINT fk_ind_resource_config_map_to_source;
       public       cps    false    186    193    2046         $           2606    17072    fk_indicator_to_entity    FK CONSTRAINT     x   ALTER TABLE ONLY hdx_indicator
    ADD CONSTRAINT fk_indicator_to_entity FOREIGN KEY (entity_id) REFERENCES entity(id);
 N   ALTER TABLE ONLY public.hdx_indicator DROP CONSTRAINT fk_indicator_to_entity;
       public       cps    false    172    178    2018         %           2606    17077    fk_indicator_to_source    FK CONSTRAINT     x   ALTER TABLE ONLY hdx_indicator
    ADD CONSTRAINT fk_indicator_to_source FOREIGN KEY (source_id) REFERENCES source(id);
 N   ALTER TABLE ONLY public.hdx_indicator DROP CONSTRAINT fk_indicator_to_source;
       public       cps    false    186    2046    178         &           2606    17082    fk_indicator_to_type    FK CONSTRAINT     |   ALTER TABLE ONLY hdx_indicator
    ADD CONSTRAINT fk_indicator_to_type FOREIGN KEY (type_id) REFERENCES indicator_type(id);
 L   ALTER TABLE ONLY public.hdx_indicator DROP CONSTRAINT fk_indicator_to_type;
       public       cps    false    178    185    2042         2           2606    17087 &   fk_indicator_type_dictionary_to_config    FK CONSTRAINT     �   ALTER TABLE ONLY indicator_type_dictionary
    ADD CONSTRAINT fk_indicator_type_dictionary_to_config FOREIGN KEY (resource_configuration_id) REFERENCES resource_configuration(id);
 j   ALTER TABLE ONLY public.indicator_type_dictionary DROP CONSTRAINT fk_indicator_type_dictionary_to_config;
       public       cps    false    206    2067    196         +           2606    17092    fk_indicator_type_to_name_text    FK CONSTRAINT     }   ALTER TABLE ONLY indicator_type
    ADD CONSTRAINT fk_indicator_type_to_name_text FOREIGN KEY (text_id) REFERENCES text(id);
 W   ALTER TABLE ONLY public.indicator_type DROP CONSTRAINT fk_indicator_type_to_name_text;
       public       cps    false    185    2038    183         ,           2606    17097    fk_indicator_type_to_unit    FK CONSTRAINT     |   ALTER TABLE ONLY indicator_type
    ADD CONSTRAINT fk_indicator_type_to_unit FOREIGN KEY (unit_id) REFERENCES hdx_unit(id);
 R   ALTER TABLE ONLY public.indicator_type DROP CONSTRAINT fk_indicator_type_to_unit;
       public       cps    false    2034    185    180         '           2606    17102    fk_indicator_value_to_text    FK CONSTRAINT     x   ALTER TABLE ONLY hdx_indicator
    ADD CONSTRAINT fk_indicator_value_to_text FOREIGN KEY (text_id) REFERENCES text(id);
 R   ALTER TABLE ONLY public.hdx_indicator DROP CONSTRAINT fk_indicator_value_to_text;
       public       cps    false    178    183    2038         5           2606    17107    fk_region_dictionary_to_config    FK CONSTRAINT     �   ALTER TABLE ONLY region_dictionary
    ADD CONSTRAINT fk_region_dictionary_to_config FOREIGN KEY (resource_configuration_id) REFERENCES resource_configuration(id);
 Z   ALTER TABLE ONLY public.region_dictionary DROP CONSTRAINT fk_region_dictionary_to_config;
       public       cps    false    2067    202    206         6           2606    17112     fk_resource_config_map_to_parent    FK CONSTRAINT     �   ALTER TABLE ONLY resource_config_entry
    ADD CONSTRAINT fk_resource_config_map_to_parent FOREIGN KEY (resource_configuration_id) REFERENCES resource_configuration(id);
 `   ALTER TABLE ONLY public.resource_config_entry DROP CONSTRAINT fk_resource_config_map_to_parent;
       public       cps    false    206    204    2067         4           2606    17117    fk_short_name_to_text    FK CONSTRAINT     x   ALTER TABLE ONLY organisation
    ADD CONSTRAINT fk_short_name_to_text FOREIGN KEY (short_name_id) REFERENCES text(id);
 L   ALTER TABLE ONLY public.organisation DROP CONSTRAINT fk_short_name_to_text;
       public       cps    false    2038    183    200         7           2606    17122    fk_source_dictionary_to_config    FK CONSTRAINT     �   ALTER TABLE ONLY source_dictionary
    ADD CONSTRAINT fk_source_dictionary_to_config FOREIGN KEY (resource_configuration_id) REFERENCES resource_configuration(id);
 Z   ALTER TABLE ONLY public.source_dictionary DROP CONSTRAINT fk_source_dictionary_to_config;
       public       cps    false    2067    208    206         -           2606    17127    fk_source_to_name_text    FK CONSTRAINT     m   ALTER TABLE ONLY source
    ADD CONSTRAINT fk_source_to_name_text FOREIGN KEY (text_id) REFERENCES text(id);
 G   ALTER TABLE ONLY public.source DROP CONSTRAINT fk_source_to_name_text;
       public       cps    false    186    2038    183         .           2606    17132    fk_source_to_organisation    FK CONSTRAINT     �   ALTER TABLE ONLY source
    ADD CONSTRAINT fk_source_to_organisation FOREIGN KEY (organisation_id) REFERENCES organisation(id);
 J   ALTER TABLE ONLY public.source DROP CONSTRAINT fk_source_to_organisation;
       public       cps    false    186    200    2057         (           2606    17137    fk_translation_to_language    FK CONSTRAINT     �   ALTER TABLE ONLY hdx_translation
    ADD CONSTRAINT fk_translation_to_language FOREIGN KEY (language) REFERENCES language(code);
 T   ALTER TABLE ONLY public.hdx_translation DROP CONSTRAINT fk_translation_to_language;
       public       cps    false    2055    179    199         )           2606    17142    fk_translation_to_text    FK CONSTRAINT     s   ALTER TABLE ONLY hdx_translation
    ADD CONSTRAINT fk_translation_to_text FOREIGN KEY (text) REFERENCES text(id);
 P   ALTER TABLE ONLY public.hdx_translation DROP CONSTRAINT fk_translation_to_text;
       public       cps    false    2038    179    183                                                                                                                                                                                                                        restore.sql                                                                                         0000600 0004000 0002000 00000116670 12455461436 015411  0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

ALTER TABLE ONLY public.hdx_translation DROP CONSTRAINT fk_translation_to_text;
ALTER TABLE ONLY public.hdx_translation DROP CONSTRAINT fk_translation_to_language;
ALTER TABLE ONLY public.source DROP CONSTRAINT fk_source_to_organisation;
ALTER TABLE ONLY public.source DROP CONSTRAINT fk_source_to_name_text;
ALTER TABLE ONLY public.source_dictionary DROP CONSTRAINT fk_source_dictionary_to_config;
ALTER TABLE ONLY public.organisation DROP CONSTRAINT fk_short_name_to_text;
ALTER TABLE ONLY public.resource_config_entry DROP CONSTRAINT fk_resource_config_map_to_parent;
ALTER TABLE ONLY public.region_dictionary DROP CONSTRAINT fk_region_dictionary_to_config;
ALTER TABLE ONLY public.hdx_indicator DROP CONSTRAINT fk_indicator_value_to_text;
ALTER TABLE ONLY public.indicator_type DROP CONSTRAINT fk_indicator_type_to_unit;
ALTER TABLE ONLY public.indicator_type DROP CONSTRAINT fk_indicator_type_to_name_text;
ALTER TABLE ONLY public.indicator_type_dictionary DROP CONSTRAINT fk_indicator_type_dictionary_to_config;
ALTER TABLE ONLY public.hdx_indicator DROP CONSTRAINT fk_indicator_to_type;
ALTER TABLE ONLY public.hdx_indicator DROP CONSTRAINT fk_indicator_to_source;
ALTER TABLE ONLY public.hdx_indicator DROP CONSTRAINT fk_indicator_to_entity;
ALTER TABLE ONLY public.indicator_resource_config_entry DROP CONSTRAINT fk_ind_resource_config_map_to_source;
ALTER TABLE ONLY public.indicator_resource_config_entry DROP CONSTRAINT fk_ind_resource_config_map_to_parent;
ALTER TABLE ONLY public.indicator_resource_config_entry DROP CONSTRAINT fk_ind_resource_config_map_to_indicator_type;
ALTER TABLE ONLY public.hdx_indicator DROP CONSTRAINT fk_import_from_ckan;
ALTER TABLE ONLY public.organisation DROP CONSTRAINT fk_full_name_to_text;
ALTER TABLE ONLY public.entity_type DROP CONSTRAINT fk_entity_type_to_name_text;
ALTER TABLE ONLY public.entity DROP CONSTRAINT fk_entity_to_type;
ALTER TABLE ONLY public.entity DROP CONSTRAINT fk_entity_to_parent;
ALTER TABLE ONLY public.hdx_unit DROP CONSTRAINT fk_entity_to_name_text;
ALTER TABLE ONLY public.entity DROP CONSTRAINT fk_entity_to_name_text;
ALTER TABLE ONLY public.ckan_resource DROP CONSTRAINT fk_ckan_resource_to_resource_config;
ALTER TABLE ONLY public.ckan_dataset DROP CONSTRAINT fk_ckan_dataset_to_resource_config;
ALTER TABLE ONLY public.hdx_dataserie_to_curated_dataset DROP CONSTRAINT fk__dataserie_to_curated_data_to_source;
ALTER TABLE ONLY public.hdx_dataserie_to_curated_dataset DROP CONSTRAINT fk__dataserie_to_curated_data_to_indicator_type;
ALTER TABLE ONLY public.hdx_dataserie_metadata DROP CONSTRAINT fk__dataserie_metadata_to_source;
ALTER TABLE ONLY public.hdx_dataserie_metadata DROP CONSTRAINT fk__dataserie_metadata_to_name_text;
ALTER TABLE ONLY public.hdx_dataserie_metadata DROP CONSTRAINT fk__dataserie_metadata_to_indicator_type;
DROP INDEX public.resource_config_entry_index;
DROP INDEX public.nameindex;
DROP INDEX public.indicator_resource_config_entry_index;
ALTER TABLE ONLY public.text DROP CONSTRAINT text_pkey;
ALTER TABLE ONLY public.source DROP CONSTRAINT source_pkey;
ALTER TABLE ONLY public.hdx_dataserie_metadata DROP CONSTRAINT source_indicator_entry;
ALTER TABLE ONLY public.source_dictionary DROP CONSTRAINT source_dictionary_pkey;
ALTER TABLE ONLY public.source DROP CONSTRAINT source_code_key;
ALTER TABLE ONLY public.resource_configuration DROP CONSTRAINT resource_configuration_pkey;
ALTER TABLE ONLY public.resource_configuration DROP CONSTRAINT resource_configuration_name_key;
ALTER TABLE ONLY public.resource_config_entry DROP CONSTRAINT resource_config_entry_pkey;
ALTER TABLE ONLY public.region_dictionary DROP CONSTRAINT region_dictionary_pkey;
ALTER TABLE ONLY public.organisation DROP CONSTRAINT organisation_pkey;
ALTER TABLE ONLY public.language DROP CONSTRAINT language_pkey;
ALTER TABLE ONLY public.indicator_type DROP CONSTRAINT indicator_type_pkey;
ALTER TABLE ONLY public.indicator_type_dictionary DROP CONSTRAINT indicator_type_dictionary_pkey;
ALTER TABLE ONLY public.indicator_type DROP CONSTRAINT indicator_type_code_key;
ALTER TABLE ONLY public.indicator_resource_config_entry DROP CONSTRAINT indicator_resource_config_entry_pkey;
ALTER TABLE ONLY public.import_from_ckan DROP CONSTRAINT import_from_ckan_pkey;
ALTER TABLE ONLY public.hdx_user DROP CONSTRAINT hdx_user_pkey;
ALTER TABLE ONLY public.hdx_unit DROP CONSTRAINT hdx_unit_pkey;
ALTER TABLE ONLY public.hdx_translation DROP CONSTRAINT hdx_translation_pkey;
ALTER TABLE ONLY public.hdx_indicator DROP CONSTRAINT hdx_indicator_source_id_entity_id_type_id_start_time_period_key;
ALTER TABLE ONLY public.hdx_indicator DROP CONSTRAINT hdx_indicator_pkey;
ALTER TABLE ONLY public.hdx_dataserie_to_curated_dataset DROP CONSTRAINT hdx_dataserie_to_curated_dataset_pkey;
ALTER TABLE ONLY public.hdx_dataserie_to_curated_dataset DROP CONSTRAINT hdx_dataserie_to_curated_datase_source_id_indicator_type_id_key;
ALTER TABLE ONLY public.hdx_dataserie_metadata DROP CONSTRAINT hdx_additional_data_pkey;
ALTER TABLE ONLY public.entity_type DROP CONSTRAINT entity_type_pkey;
ALTER TABLE ONLY public.entity_type DROP CONSTRAINT entity_type_code_key;
ALTER TABLE ONLY public.entity DROP CONSTRAINT entity_pkey;
ALTER TABLE ONLY public.entity DROP CONSTRAINT entity_code_entity_type_id_key;
ALTER TABLE ONLY public.ckan_resource DROP CONSTRAINT ckan_resource_pkey;
ALTER TABLE ONLY public.ckan_dataset DROP CONSTRAINT ckan_dataset_pkey;
DROP SEQUENCE public.text_seq;
DROP SEQUENCE public.source_seq;
DROP SEQUENCE public.source_dictionary_seq;
DROP TABLE public.source_dictionary;
DROP SEQUENCE public.resource_configuration_seq;
DROP TABLE public.resource_configuration;
DROP SEQUENCE public.resource_config_entry_seq;
DROP TABLE public.resource_config_entry;
DROP SEQUENCE public.region_dictionary_seq;
DROP TABLE public.region_dictionary;
DROP SEQUENCE public.organisation_seq;
DROP TABLE public.organisation;
DROP TABLE public.language;
DROP SEQUENCE public.indicator_type_seq;
DROP SEQUENCE public.indicator_type_dictionary_seq;
DROP TABLE public.indicator_type_dictionary;
DROP SEQUENCE public.indicator_seq;
DROP SEQUENCE public.indicator_resource_config_entry_seq;
DROP TABLE public.indicator_resource_config_entry;
DROP SEQUENCE public.import_from_ckan_seq;
DROP TABLE public.import_from_ckan;
DROP VIEW public.hdx_view_report_indicator_type_overview;
DROP VIEW public.hdx_view_report_indicator_data;
DROP VIEW public.hdx_view_indicator_type_count;
DROP VIEW public.hdx_view_indicator_max_date;
DROP TABLE public.source;
DROP TABLE public.indicator_type;
DROP VIEW public.hdx_view_additional_data_text;
DROP TABLE public.text;
DROP TABLE public.hdx_user;
DROP SEQUENCE public.hdx_unit_seq;
DROP TABLE public.hdx_unit;
DROP TABLE public.hdx_translation;
DROP TABLE public.hdx_indicator;
DROP SEQUENCE public.hdx_dataserie_to_curated_dataset_seq;
DROP TABLE public.hdx_dataserie_to_curated_dataset;
DROP SEQUENCE public.hdx_dataserie_metadata_seq;
DROP TABLE public.hdx_dataserie_metadata;
DROP SEQUENCE public.entity_type_seq;
DROP TABLE public.entity_type;
DROP SEQUENCE public.entity_seq;
DROP TABLE public.entity;
DROP TABLE public.ckan_resource;
DROP TABLE public.ckan_dataset;
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


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
-- Name: hdx_dataserie_to_curated_dataset; Type: TABLE; Schema: public; Owner: cps; Tablespace: 
--

CREATE TABLE hdx_dataserie_to_curated_dataset (
    id bigint NOT NULL,
    ckan_dataset_id character varying(255),
    ckan_dataset_name character varying(255),
    last_data_push timestamp without time zone,
    last_data_update timestamp without time zone,
    last_metadata_push timestamp without time zone,
    last_metadata_update timestamp without time zone,
    indicator_type_id bigint NOT NULL,
    source_id bigint NOT NULL
);


ALTER TABLE public.hdx_dataserie_to_curated_dataset OWNER TO cps;

--
-- Name: hdx_dataserie_to_curated_dataset_seq; Type: SEQUENCE; Schema: public; Owner: cps
--

CREATE SEQUENCE hdx_dataserie_to_curated_dataset_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hdx_dataserie_to_curated_dataset_seq OWNER TO cps;

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
 SELECT ad.id,
    ad.entry_key,
    ad.entry_value_text_id,
    ad.indicator_type_id,
    ad.source_id,
    t.default_value
   FROM hdx_dataserie_metadata ad,
    text t
  WHERE (ad.entry_value_text_id = t.id);


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
 SELECT i.id,
    i.number_value AS value,
    it.code AS indicator_type_code,
    itt.default_value AS indicator_type_name,
    e.code AS location_code,
    et.default_value AS location_name,
    s.code AS source_code,
    st.default_value AS source_name,
    i.start_time
   FROM (hdx_indicator i
     JOIN ( SELECT hdx_indicator.entity_id,
            hdx_indicator.source_id,
            hdx_indicator.type_id,
            max(hdx_indicator.start_time) AS max_date
           FROM hdx_indicator
          GROUP BY hdx_indicator.entity_id, hdx_indicator.source_id, hdx_indicator.type_id) i2 ON (((((i.entity_id = i2.entity_id) AND (i.source_id = i2.source_id)) AND (i.type_id = i2.type_id)) AND (i.start_time = i2.max_date)))),
    indicator_type it,
    source s,
    entity e,
    text itt,
    text st,
    text et
  WHERE (((((((i.type_id = it.id) AND (i.source_id = s.id)) AND (i.entity_id = e.id)) AND (itt.id = it.text_id)) AND (st.id = s.text_id)) AND (et.id = e.text_id)) AND (i.number_value IS NOT NULL));


ALTER TABLE public.hdx_view_indicator_max_date OWNER TO cps;

--
-- Name: hdx_view_indicator_type_count; Type: VIEW; Schema: public; Owner: cps
--

CREATE VIEW hdx_view_indicator_type_count AS
 SELECT i.type_id AS id,
    it.code,
    count(*) AS count
   FROM hdx_indicator i,
    indicator_type it
  WHERE (i.type_id = it.id)
  GROUP BY i.type_id, it.code
  ORDER BY it.code;


ALTER TABLE public.hdx_view_indicator_type_count OWNER TO cps;

--
-- Name: hdx_view_report_indicator_data; Type: VIEW; Schema: public; Owner: cps
--

CREATE VIEW hdx_view_report_indicator_data AS
 SELECT i.id AS indicator_id,
    date_part('year'::pg_catalog.text, i.start_time) AS indicator_year,
    i.number_value AS indicator_value,
    it.code AS indicator_type_code,
    s.code AS source_code,
    st.default_value AS source_default_value,
    e.code AS country_code,
    etx.default_value AS country_default_value
   FROM hdx_indicator i,
    indicator_type it,
    source s,
    text st,
    entity e,
    text etx,
    entity_type et
  WHERE ((((((it.id = i.type_id) AND (s.id = i.source_id)) AND (st.id = s.text_id)) AND (e.id = i.entity_id)) AND (etx.id = e.text_id)) AND (et.id = e.entity_type_id));


ALTER TABLE public.hdx_view_report_indicator_data OWNER TO cps;

--
-- Name: hdx_view_report_indicator_type_overview; Type: VIEW; Schema: public; Owner: cps
--

CREATE VIEW hdx_view_report_indicator_type_overview AS
 SELECT DISTINCT it.id AS indicator_type_id,
    it.code AS indicator_type_code,
    itt.default_value AS indicator_type_default_value,
    s.code AS source_code,
    st.default_value AS source_default_value,
    u.code AS unit_code,
    ut.default_value AS unit_default_value,
    dads.id AS data_summary_id,
    dads.default_value AS data_summary_default_value,
    dami.id AS more_info_id,
    dami.default_value AS more_info_default_value,
    datu.id AS terms_of_use_id,
    datu.default_value AS terms_of_use_default_value,
    damy.id AS methodology_id,
    damy.default_value AS methodology_default_value
   FROM ((((indicator_type it
     LEFT JOIN hdx_view_additional_data_text dads ON (((it.id = dads.indicator_type_id) AND ((dads.entry_key)::pg_catalog.text = 'DATASET_SUMMARY'::pg_catalog.text))))
     LEFT JOIN hdx_view_additional_data_text dami ON (((it.id = dami.indicator_type_id) AND ((dami.entry_key)::pg_catalog.text = 'MORE_INFO'::pg_catalog.text))))
     LEFT JOIN hdx_view_additional_data_text datu ON (((it.id = datu.indicator_type_id) AND ((datu.entry_key)::pg_catalog.text = 'TERMS_OF_USE'::pg_catalog.text))))
     LEFT JOIN hdx_view_additional_data_text damy ON (((it.id = damy.indicator_type_id) AND ((damy.entry_key)::pg_catalog.text = 'METHODOLOGY'::pg_catalog.text)))),
    hdx_view_additional_data_text ad,
    text itt,
    source s,
    text st,
    hdx_unit u,
    text ut
  WHERE ((((((itt.id = it.text_id) AND (st.id = s.text_id)) AND (u.id = it.unit_id)) AND (ut.id = u.text_id)) AND (s.id = ad.source_id)) AND (it.id = ad.indicator_type_id))
  ORDER BY it.id;


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
-- Name: hdx_dataserie_to_curated_datase_source_id_indicator_type_id_key; Type: CONSTRAINT; Schema: public; Owner: cps; Tablespace: 
--

ALTER TABLE ONLY hdx_dataserie_to_curated_dataset
    ADD CONSTRAINT hdx_dataserie_to_curated_datase_source_id_indicator_type_id_key UNIQUE (source_id, indicator_type_id);


--
-- Name: hdx_dataserie_to_curated_dataset_pkey; Type: CONSTRAINT; Schema: public; Owner: cps; Tablespace: 
--

ALTER TABLE ONLY hdx_dataserie_to_curated_dataset
    ADD CONSTRAINT hdx_dataserie_to_curated_dataset_pkey PRIMARY KEY (id);


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
-- Name: fk__dataserie_to_curated_data_to_indicator_type; Type: FK CONSTRAINT; Schema: public; Owner: cps
--

ALTER TABLE ONLY hdx_dataserie_to_curated_dataset
    ADD CONSTRAINT fk__dataserie_to_curated_data_to_indicator_type FOREIGN KEY (indicator_type_id) REFERENCES indicator_type(id);


--
-- Name: fk__dataserie_to_curated_data_to_source; Type: FK CONSTRAINT; Schema: public; Owner: cps
--

ALTER TABLE ONLY hdx_dataserie_to_curated_dataset
    ADD CONSTRAINT fk__dataserie_to_curated_data_to_source FOREIGN KEY (source_id) REFERENCES source(id);


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

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        