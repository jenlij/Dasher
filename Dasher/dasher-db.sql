--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.3
-- Dumped by pg_dump version 9.6.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: dashsettings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dashsettings (
    userid integer,
    widgetid integer,
    placement integer NOT NULL
);


--
-- Name: members; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE members (
    name character varying(200) NOT NULL,
    widgets text
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    userid integer NOT NULL,
    username character varying(100) NOT NULL,
    nickname character varying(100) NOT NULL,
    location character varying(100) DEFAULT 'ATL'::character varying NOT NULL,
    timezone character(3) DEFAULT 'EST'::bpchar NOT NULL
);


--
-- Name: users_userid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_userid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_userid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_userid_seq OWNED BY users.userid;


--
-- Name: widgets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE widgets (
    widgetid integer NOT NULL,
    widgetname character varying(200) NOT NULL
);


--
-- Name: widgets_widgetid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE widgets_widgetid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: widgets_widgetid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE widgets_widgetid_seq OWNED BY widgets.widgetid;


--
-- Name: users userid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN userid SET DEFAULT nextval('users_userid_seq'::regclass);


--
-- Name: widgets widgetid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY widgets ALTER COLUMN widgetid SET DEFAULT nextval('widgets_widgetid_seq'::regclass);


--
-- Data for Name: dashsettings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY dashsettings (userid, widgetid, placement) FROM stdin;
2	1	8
2	2	7
2	3	6
2	4	5
3	1	3
3	2	4
3	3	5
3	4	6
2	5	4
2	6	3
2	7	2
2	8	1
3	5	7
3	6	8
3	7	1
3	8	2
7	\N	1
7	\N	2
7	\N	3
7	\N	5
7	\N	6
7	\N	7
7	\N	8
7	3	4
1	4	1
1	4	2
1	4	3
1	4	4
1	4	5
1	4	6
1	4	7
1	4	8
\.


--
-- Data for Name: members; Type: TABLE DATA; Schema: public; Owner: -
--

COPY members (name, widgets) FROM stdin;
Test	Weather
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY users (userid, username, nickname, location, timezone) FROM stdin;
1	username1	user1	ATL	EST
2	username2	user2	LA	PST
3	username3	user3	CHI	CST
7	hksix	Hamza Haseeb	ATL	EST
\.


--
-- Name: users_userid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('users_userid_seq', 7, true);


--
-- Data for Name: widgets; Type: TABLE DATA; Schema: public; Owner: -
--

COPY widgets (widgetid, widgetname) FROM stdin;
1	clock
2	weather
3	news
4	greeting
5	widget5
6	widget6
7	widget7
8	widget8
\.


--
-- Name: widgets_widgetid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('widgets_widgetid_seq', 9, true);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (userid);


--
-- Name: widgets widgets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY widgets
    ADD CONSTRAINT widgets_pkey PRIMARY KEY (widgetid);


--
-- Name: dashsettings dashsettings_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dashsettings
    ADD CONSTRAINT dashsettings_userid_fkey FOREIGN KEY (userid) REFERENCES users(userid);


--
-- Name: dashsettings dashsettings_widgetid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dashsettings
    ADD CONSTRAINT dashsettings_widgetid_fkey FOREIGN KEY (widgetid) REFERENCES widgets(widgetid);


--
-- PostgreSQL database dump complete
--

