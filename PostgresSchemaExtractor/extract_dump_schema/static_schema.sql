--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: revision_baseline; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.revision_baseline (
    id bigint NOT NULL,
    date timestamp without time zone,
    description character varying(255),
    set boolean NOT NULL,
    revision_id character varying(255)
);


ALTER TABLE public.revision_baseline OWNER TO postgres;

--
-- Name: baseline_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.baseline_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.baseline_id_seq OWNER TO postgres;

--
-- Name: baseline_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.baseline_id_seq OWNED BY public.revision_baseline.id;


--
-- Name: revision_baseline id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revision_baseline ALTER COLUMN id SET DEFAULT nextval('public.baseline_id_seq'::regclass);


--
-- Name: revision_baseline revision_baseline_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revision_baseline
    ADD CONSTRAINT revision_baseline_pkey PRIMARY KEY (id);


--
-- Name: revision_baseline fk25ijfh6v63av3ojch644fqboy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revision_baseline
    ADD CONSTRAINT fk25ijfh6v63av3ojch644fqboy FOREIGN KEY (revision_id) REFERENCES public.revision_revision(id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: revision_build_structure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.revision_build_structure (
    id bigint NOT NULL,
    build_complete_time timestamp without time zone,
    build_location character varying(255),
    revision_id character varying(255)
);


ALTER TABLE public.revision_build_structure OWNER TO postgres;

--
-- Name: build_structure_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.build_structure_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.build_structure_id_seq OWNER TO postgres;

--
-- Name: build_structure_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.build_structure_id_seq OWNED BY public.revision_build_structure.id;


--
-- Name: revision_build_structure id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revision_build_structure ALTER COLUMN id SET DEFAULT nextval('public.build_structure_id_seq'::regclass);


--
-- Name: revision_build_structure build_structure_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revision_build_structure
    ADD CONSTRAINT build_structure_pkey PRIMARY KEY (id);


--
-- Name: revision_build_structure fkf9fdlkb8oxfohe25js5r6lgs6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revision_build_structure
    ADD CONSTRAINT fkf9fdlkb8oxfohe25js5r6lgs6 FOREIGN KEY (revision_id) REFERENCES public.revision_revision(id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: revision_file_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.revision_file_info (
    id bigint NOT NULL,
    excluded boolean NOT NULL,
    hash character varying(255),
    path character varying(255),
    system boolean NOT NULL,
    build_structure_id bigint,
    crc32 character varying(255)
);


ALTER TABLE public.revision_file_info OWNER TO postgres;

--
-- Name: file_info_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.file_info_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.file_info_id_seq OWNER TO postgres;

--
-- Name: file_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.file_info_id_seq OWNED BY public.revision_file_info.id;


--
-- Name: revision_file_info id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revision_file_info ALTER COLUMN id SET DEFAULT nextval('public.file_info_id_seq'::regclass);


--
-- Name: revision_file_info file_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revision_file_info
    ADD CONSTRAINT file_info_pkey PRIMARY KEY (id);


--
-- Name: revision_file_info fkkmv003ex1thk3ws4cy058t41t; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revision_file_info
    ADD CONSTRAINT fkkmv003ex1thk3ws4cy058t41t FOREIGN KEY (build_structure_id) REFERENCES public.revision_build_structure(id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: revision_module; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.revision_module (
    id bigint NOT NULL,
    link_flags character varying(4194304),
    link_type character varying(255),
    name character varying(4096),
    build_structure_id bigint
);


ALTER TABLE public.revision_module OWNER TO postgres;

--
-- Name: module_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.module_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.module_id_seq OWNER TO postgres;

--
-- Name: module_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.module_id_seq OWNED BY public.revision_module.id;


--
-- Name: revision_module id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revision_module ALTER COLUMN id SET DEFAULT nextval('public.module_id_seq'::regclass);


--
-- Name: revision_module module_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revision_module
    ADD CONSTRAINT module_pkey PRIMARY KEY (id);


--
-- Name: revision_module fkfqnd23vfsxa3woteap186v02j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revision_module
    ADD CONSTRAINT fkfqnd23vfsxa3woteap186v02j FOREIGN KEY (build_structure_id) REFERENCES public.revision_build_structure(id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: revision_project_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.revision_project_settings (
    id bigint NOT NULL
);


ALTER TABLE public.revision_project_settings OWNER TO postgres;

--
-- Name: project_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.project_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.project_settings_id_seq OWNER TO postgres;

--
-- Name: project_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.project_settings_id_seq OWNED BY public.revision_project_settings.id;


--
-- Name: revision_project_settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revision_project_settings ALTER COLUMN id SET DEFAULT nextval('public.project_settings_id_seq'::regclass);


--
-- Name: revision_project_settings revision_project_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revision_project_settings
    ADD CONSTRAINT revision_project_settings_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: revision_reserved_revision; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.revision_reserved_revision (
    id bigint NOT NULL,
    created timestamp without time zone,
    expires timestamp without time zone,
    resources character varying(255),
    status character varying(255)
);


ALTER TABLE public.revision_reserved_revision OWNER TO postgres;

--
-- Name: reserved_revision_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reserved_revision_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reserved_revision_id_seq OWNER TO postgres;

--
-- Name: reserved_revision_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reserved_revision_id_seq OWNED BY public.revision_reserved_revision.id;


--
-- Name: revision_reserved_revision id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revision_reserved_revision ALTER COLUMN id SET DEFAULT nextval('public.reserved_revision_id_seq'::regclass);


--
-- Name: revision_reserved_revision reserved_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revision_reserved_revision
    ADD CONSTRAINT reserved_revision_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: revision_module_dependencies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.revision_module_dependencies (
    module_id bigint NOT NULL,
    dependencies character varying(255)
);


ALTER TABLE public.revision_module_dependencies OWNER TO postgres;

--
-- Name: revision_module_dependencies fkqp8s48djc02l67epibou3jhdc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revision_module_dependencies
    ADD CONSTRAINT fkqp8s48djc02l67epibou3jhdc FOREIGN KEY (module_id) REFERENCES public.revision_module(id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: revision_module_source; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.revision_module_source (
    module_id bigint NOT NULL,
    source_id bigint NOT NULL
);


ALTER TABLE public.revision_module_source OWNER TO postgres;

--
-- Name: revision_module_source fk83qc7vhami4jx79syu4r7pamq; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revision_module_source
    ADD CONSTRAINT fk83qc7vhami4jx79syu4r7pamq FOREIGN KEY (module_id) REFERENCES public.revision_module(id);


--
-- Name: revision_module_source fkj8lkyfy6stpdg3uaa98vlv4em; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revision_module_source
    ADD CONSTRAINT fkj8lkyfy6stpdg3uaa98vlv4em FOREIGN KEY (source_id) REFERENCES public.revision_source(id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: revision_project; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.revision_project (
    project_key character varying(255) NOT NULL,
    project_id bigint NOT NULL,
    project_name character varying(4096)
);


ALTER TABLE public.revision_project OWNER TO postgres;

--
-- Name: revision_project revision_project_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revision_project
    ADD CONSTRAINT revision_project_pkey PRIMARY KEY (project_key);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: revision_project_settings_exclusions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.revision_project_settings_exclusions (
    project_settings_id bigint NOT NULL,
    exclusions character varying(255)
);


ALTER TABLE public.revision_project_settings_exclusions OWNER TO postgres;

--
-- Name: revision_project_settings_exclusions fkaqjnlnmor3tcl07kie9yiovda; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revision_project_settings_exclusions
    ADD CONSTRAINT fkaqjnlnmor3tcl07kie9yiovda FOREIGN KEY (project_settings_id) REFERENCES public.revision_project_settings(id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: revision_revision; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.revision_revision (
    id character varying(255) NOT NULL,
    added_defects bigint NOT NULL,
    deleted_defects bigint NOT NULL,
    finished_time timestamp without time zone,
    pa_version character varying(255),
    parsing_log character varying(255),
    project_id bigint NOT NULL,
    project_key character varying(255),
    project_name character varying(4096),
    sequence bigint NOT NULL,
    started_time timestamp without time zone,
    status integer,
    suppressed_defects bigint NOT NULL,
    total_defects bigint NOT NULL,
    user_email character varying(255),
    vcs_revision character varying(255),
    build_structure_id bigint,
    project_project_key character varying(255),
    project_settings_id bigint
);


ALTER TABLE public.revision_revision OWNER TO postgres;

--
-- Name: revision_revision revision_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revision_revision
    ADD CONSTRAINT revision_revision_pkey PRIMARY KEY (id);


--
-- Name: revision_revision fk2tkdim1lfjd29y8yjrvngduje; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revision_revision
    ADD CONSTRAINT fk2tkdim1lfjd29y8yjrvngduje FOREIGN KEY (project_settings_id) REFERENCES public.revision_project_settings(id);


--
-- Name: revision_revision fk3knys7bsugot27m4qaavrtbl2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revision_revision
    ADD CONSTRAINT fk3knys7bsugot27m4qaavrtbl2 FOREIGN KEY (build_structure_id) REFERENCES public.revision_build_structure(id);


--
-- Name: revision_revision fkfptx79spd5b32d23thxb7e2c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revision_revision
    ADD CONSTRAINT fkfptx79spd5b32d23thxb7e2c FOREIGN KEY (project_project_key) REFERENCES public.revision_project(project_key);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: revision_revision_rule_set_id; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.revision_revision_rule_set_id (
    revision_id character varying(255) NOT NULL,
    rule_set_id integer
);


ALTER TABLE public.revision_revision_rule_set_id OWNER TO postgres;

--
-- Name: revision_revision_rule_set_id fkkqhm2y4nnv85w2i60an7qaxw8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revision_revision_rule_set_id
    ADD CONSTRAINT fkkqhm2y4nnv85w2i60an7qaxw8 FOREIGN KEY (revision_id) REFERENCES public.revision_revision(id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: revision_source; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.revision_source (
    id bigint NOT NULL,
    compiler character varying(1024),
    file_hash character varying(255),
    language integer,
    normalized_flags character varying(262144),
    normalized_path character varying(4096),
    original_flags character varying(262144),
    original_path character varying(4096),
    tu_hash character varying(255),
    tuid_tu_hash character varying(255)
);


ALTER TABLE public.revision_source OWNER TO postgres;

--
-- Name: source_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.source_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.source_id_seq OWNER TO postgres;

--
-- Name: source_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.source_id_seq OWNED BY public.revision_source.id;


--
-- Name: revision_source id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revision_source ALTER COLUMN id SET DEFAULT nextval('public.source_id_seq'::regclass);


--
-- Name: revision_source source_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revision_source
    ADD CONSTRAINT source_pkey PRIMARY KEY (id);


--
-- Name: revision_source fkpws72qavtnofn4skigigesocx; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revision_source
    ADD CONSTRAINT fkpws72qavtnofn4skigigesocx FOREIGN KEY (tuid_tu_hash) REFERENCES public.revision_translation_unitid(tu_hash);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: revision_translation_unitid; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.revision_translation_unitid (
    tu_hash character varying(255) NOT NULL,
    analyzed boolean NOT NULL,
    sequence bigint NOT NULL,
    project_project_key character varying(255)
);


ALTER TABLE public.revision_translation_unitid OWNER TO postgres;

--
-- Name: revision_translation_unitid translation_unitid_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revision_translation_unitid
    ADD CONSTRAINT translation_unitid_pkey PRIMARY KEY (tu_hash);


--
-- Name: revision_translation_unitid fklptbaosgg8vd9l2417300wl5b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revision_translation_unitid
    ADD CONSTRAINT fklptbaosgg8vd9l2417300wl5b FOREIGN KEY (project_project_key) REFERENCES public.revision_project(project_key);


--
-- PostgreSQL database dump complete
--

