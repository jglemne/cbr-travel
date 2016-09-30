--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.1
-- Dumped by pg_dump version 9.5.1

SET statement_timeout = 0;
SET lock_timeout = 0;
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
-- Name: cases; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cases (
    id integer NOT NULL,
    case_name character varying(20),
    journey_code integer,
    holiday_type character varying(20),
    price integer,
    number_of_persons integer,
    region character varying(80),
    transportation character varying(20),
    duration integer,
    season character varying(20),
    accommodation character varying(30),
    hotel character varying(80)
);


--
-- Name: cases_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cases_id_seq OWNED BY cases.id;


--
-- Name: regions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE regions (
    id integer NOT NULL,
    region_name character varying(80),
    latitude double precision,
    longitude double precision
);


--
-- Name: regions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE regions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: regions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE regions_id_seq OWNED BY regions.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cases ALTER COLUMN id SET DEFAULT nextval('cases_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY regions ALTER COLUMN id SET DEFAULT nextval('regions_id_seq'::regclass);


--
-- Data for Name: cases; Type: TABLE DATA; Schema: public; Owner: -
--

COPY cases (id, case_name, journey_code, holiday_type, price, number_of_persons, region, transportation, duration, season, accommodation, hotel) FROM stdin;
1	Journey1	1	Bathing	2498	2	egypt	Plane	14	April	TwoStars	Hotel White House, Egypt.
2	Journey2	2	Bathing	3066	3	egypt	Plane	21	May	TwoStars	Hotel White House, Egypt.
3	Journey3	3	Active	2778	2	egypt	Plane	14	June	TwoStars	Hotel Geisum, Egypt.
4	Journey4	4	Bathing	3195	3	egypt	Plane	7	July	ThreeStars	Hotel Al Mashrabia, Egypt.
5	Journey5	5	Bathing	3158	2	egypt	Plane	14	September	ThreeStars	Hotel Al Mashrabia, Egypt.
6	Journey6	6	Active	3318	2	egypt	Plane	14	October	ThreeStars	Hotel Al Mashrabia, Egypt.
7	Journey7	7	Bathing	2458	2	egypt	Plane	14	June	FourStars	Hotel Winter Palace, Egypt.
8	Journey8	8	Active	2649	3	egypt	Plane	7	July	FourStars	Hotel Winter Palace, Egypt.
9	Journey9	9	Education	4638	2	egypt	Plane	21	April	FourStars	Anlage Arabia Beach, Egypt.
10	Journey10	10	Education	3738	2	egypt	Plane	14	October	FourStars	Anlage Arabia Beach, Egypt.
11	Journey11	11	City	1978	2	cairo	Plane	7	April	ThreeStars	Hotel Victoria, Cairo.
12	Journey12	12	City	1898	2	cairo	Plane	7	May	ThreeStars	Hotel Victoria, Cairo.
13	Journey13	13	City	2158	2	cairo	Plane	14	June	ThreeStars	Hotel Victoria, Cairo.
14	Journey14	14	City	1898	2	cairo	Plane	7	September	ThreeStars	Hotel Victoria, Cairo.
15	Journey15	15	City	1154	1	cairo	Plane	7	October	ThreeStars	Hotel New Marwa Palace, Cairo.
16	Journey16	16	City	2308	2	cairo	Plane	7	April	ThreeStars	Hotel New Marwa Palace, Cairo.
17	Journey17	17	City	2658	2	cairo	Plane	7	May	ThreeStars	Hotel New Marwa Palace, Cairo.
18	Journey18	18	City	1269	1	cairo	Plane	14	July	ThreeStars	Hotel New Marwa Palace, Cairo.
19	Journey19	19	City	2608	2	cairo	Plane	7	May	FiveStars	Hotel Moevenpick, Cairo.
20	Journey20	20	City	2468	2	cairo	Plane	7	August	FiveStars	Hotel Moevenpick, Cairo.
21	Journey21	21	Recreation	1568	2	belgium	Car	14	May	TwoStars	Hotel Ostend, Belgium.
22	Journey22	22	Active	798	3	belgium	Car	7	June	TwoStars	Hotel Ostend, Belgium.
23	Journey23	23	Recreation	978	3	belgium	Car	7	July	ThreeStars	Acces Hotel Mercure, Belgium.
24	Journey24	24	Recreation	978	2	belgium	Car	7	August	ThreeStars	Acces Hotel Mercure, Belgium.
25	Journey25	25	Active	1448	3	belgium	Car	14	September	HolidayFlat	H.Flat, Belgium.
26	Journey26	26	Recreation	1638	4	belgium	Car	14	June	HolidayFlat	H.Flat, Belgium.
27	Journey27	27	Recreation	1079	4	belgium	Car	7	July	HolidayFlat	H.Flat, Belgium.
28	Journey28	28	Bathing	499	4	belgium	Car	3	August	HolidayFlat	H.Flat, Belgium.
29	Journey29	29	Bathing	399	6	belgium	Car	3	September	HolidayFlat	H.Flat, Belgium.
30	Journey30	30	Recreation	1928	2	belgium	Train	14	July	ThreeStars	Acces Hotel Mercure, Belgium.
31	Journey31	31	Bathing	1598	2	bulgaria	Plane	14	June	TwoStars	Hotel Amfibia, Sunny Beach.
32	Journey32	32	Bathing	2043	3	bulgaria	Plane	14	July	TwoStars	Hotel Hemus, Sunny Beach.
33	Journey33	33	Bathing	1658	4	bulgaria	Plane	7	August	TwoStars	Hotel Raliza, Albena.
34	Journey34	34	Bathing	1558	2	bulgaria	Plane	7	July	ThreeStars	Hotel Phoenix, Sunny Beach.
35	Journey35	35	Active	1718	2	bulgaria	Plane	14	June	ThreeStars	Hotel Nessebar, Sunny Beach.
36	Journey36	36	Bathing	1383	3	bulgaria	Plane	7	August	ThreeStars	Hotel Gergana, Albena.
37	Journey37	37	Bathing	3628	4	bulgaria	Plane	21	August	ThreeStars	Hotel Orlav, Albena.
38	Journey38	38	Active	2739	3	bulgaria	Plane	14	July	FourStars	Hotel Burgas, Sunny Beach.
39	Journey39	39	Bathing	2399	2	bulgaria	Plane	14	September	FourStars	Grandhotel Varna, Albena.
40	Journey40	40	Bathing	2273	3	bornholm	Car	14	August	HolidayFlat	H.Flat Bornholm.
41	Journey41	41	Bathing	1729	5	bornholm	Car	7	July	HolidayFlat	H.Flat Bornholm.
42	Journey42	42	Bathing	1389	4	bornholm	Car	7	July	HolidayFlat	H.Flat Bornholm.
43	Journey43	43	Recreation	968	6	bornholm	Car	14	April	HolidayFlat	H.Flat Bornholm.
44	Journey44	44	Recreation	489	6	bornholm	Car	7	May	HolidayFlat	H.Flat Bornholm.
45	Journey45	45	Recreation	489	6	bornholm	Car	7	September	HolidayFlat	H.Flat Bornholm.
46	Journey46	46	Bathing	2838	4	fano	Car	14	July	HolidayFlat	H.Flat Fano.
47	Journey47	47	Bathing	1399	6	fano	Car	7	August	HolidayFlat	H.Flat Fano.
48	Journey48	48	Recreation	958	6	fano	Car	14	September	HolidayFlat	H.Flat Fano.
49	Journey49	49	Recreation	579	3	fano	Car	7	June	HolidayFlat	H.Flat Romo.
50	Journey50	50	Recreation	789	5	fano	Car	7	May	HolidayFlat	H.Flat Romo.
51	Journey51	51	Recreation	2839	10	fano	Car	7	July	HolidayFlat	H.Flat Romo.
52	Journey52	52	Bathing	629	6	lolland	Car	7	August	HolidayFlat	H.Flat Lolland.
53	Journey53	53	Bathing	1598	4	lolland	Car	14	July	HolidayFlat	H.Flat Lolland.
54	Journey54	54	Recreation	429	8	lolland	Car	7	September	HolidayFlat	H.Flat Lolland.
55	Journey55	55	Recreation	648	2	allgaeu	Car	7	June	TwoStars	Gasthaus Meier, Allgaeu.
56	Journey56	56	Wandering	972	4	allgaeu	Car	7	July	TwoStars	Gasthaus Alpenland, Allgaeu.
57	Journey57	57	Recreation	1060	3	allgaeu	Car	7	August	ThreeStars	Hotel Alpspitz, Allgaeu.
58	Journey58	58	Wandering	2110	3	allgaeu	Train	14	July	ThreeStars	Hotel Alpspitz, Allgaeu.
59	Journey59	59	Active	1835	2	allgaeu	Car	14	June	FiveStars	Hofgut Kuernach, Allgaeu.
60	Journey60	60	Wandering	951	2	allgaeu	Car	7	September	FiveStars	Hofgut Kuernach, Allgaeu.
61	Journey61	61	Recreation	794	4	allgaeu	Train	7	August	HolidayFlat	H.Flat, Allgaeu.
62	Journey62	62	Active	814	6	allgaeu	Car	7	July	HolidayFlat	H.Flat, Allgaeu.
63	Journey63	63	Wandering	1568	4	allgaeu	Car	14	June	HolidayFlat	H.Flat, Allgaeu.
64	Journey64	64	Wandering	644	4	allgaeu	Car	7	July	HolidayFlat	H.Flat, Allgaeu.
65	Journey65	65	Recreation	648	2	alps	Car	7	June	TwoStars	Pension Blueml, Upper Bavaria.
66	Journey66	66	Wandering	2232	3	alps	Car	14	July	TwoStars	Pension Blueml, Upper Bavaria.
67	Journey67	67	Recreation	2082	4	alps	Car	7	August	ThreeStars	Hotel Chiemgauer Hof, Upper Bavaria.
68	Journey68	68	Recreation	5185	3	alps	Car	21	June	ThreeStars	Hotel Chiemgauer Hof, Upper Bavaria.
69	Journey69	69	Active	2368	2	alps	Train	14	September	ThreeStars	Hotel Chiemgauer Hof, Upper Bavaria.
70	Journey70	70	Recreation	3758	2	alps	Car	21	July	FourStars	Hotel Zur Post, Upper Bavaria.
71	Journey71	71	Recreation	3135	3	alps	Car	14	August	FourStars	Hotel Zur Post, Upper Bavaria.
72	Journey72	72	Wandering	3762	4	alps	Car	14	July	FourStars	Hotel Zur Post, Upper Bavaria.
73	Journey73	73	Recreation	1254	4	alps	Car	7	June	HolidayFlat	H.Flat Upper Bavaria.
74	Journey74	74	Recreation	814	6	alps	Train	7	August	HolidayFlat	H.Flat Upper Bavaria.
75	Journey75	75	Recreation	1361	2	bavaria	Car	14	September	HolidayFlat	H.Flat Upper Bavaria.
76	Journey76	76	Recreation	1618	4	bavaria	Car	14	May	HolidayFlat	H.Flat Upper Bavaria.
77	Journey77	77	Recreation	1728	2	bavaria	Train	14	July	HolidayFlat	H.Flat Upper Bavaria.
78	Journey78	78	Wandering	609	3	bavaria	Car	7	June	HolidayFlat	H.Flat Upper Bavaria.
79	Journey79	79	Wandering	1069	6	bavaria	Car	7	August	HolidayFlat	H.Flat Upper Bavaria.
80	Journey80	80	Wandering	684	4	bavaria	Car	7	September	HolidayFlat	H.Flat Upper Bavaria.
81	Journey81	81	Active	1328	4	bavaria	Train	14	May	HolidayFlat	H.Flat Upper Bavaria.
82	Journey82	82	Active	779	2	bavaria	Car	7	June	HolidayFlat	H.Flat Upper Bavaria.
83	Journey83	83	Active	1639	5	bavaria	Car	7	July	HolidayFlat	H.Flat Upper Bavaria.
84	Journey84	84	Wandering	944	8	bavaria	Car	7	August	HolidayFlat	H.Flat Upper Bavaria.
85	Journey85	85	Wandering	758	2	erz gebirge	Car	7	June	TwoStars	Wolfsgruener Schloss, Erz Gebirge.
86	Journey86	86	Wandering	758	3	erz gebirge	Car	7	July	TwoStars	Wolfsgruener Schloss, Erz Gebirge.
87	Journey87	87	Recreation	1885	4	erz gebirge	Car	14	August	TwoStars	Wolfsgruener Schloss, Erz Gebirge.
88	Journey88	88	Recreation	758	3	erz gebirge	Car	7	September	TwoStars	Wolfsgruener Schloss, Erz Gebirge.
89	Journey89	89	Wandering	1828	2	erz gebirge	Car	14	May	ThreeStars	Hotel Am Fichtelberg, Erz Gebirge.
90	Journey90	90	Wandering	918	2	erz gebirge	Train	7	July	ThreeStars	Hotel Am Fichtelberg, Erz Gebirge.
91	Journey91	91	Wandering	2738	3	erz gebirge	Car	21	June	ThreeStars	Hotel Am Fichtelberg, Erz Gebirge.
92	Journey92	92	Recreation	1828	3	erz gebirge	Car	14	September	ThreeStars	Sporthotel, Erz Gebirge.
93	Journey93	93	Recreation	918	2	erz gebirge	Car	7	May	ThreeStars	Sporthotel, Erz Gebirge.
94	Journey94	94	Wandering	1580	4	erz gebirge	Train	7	August	FourStars	Kur- und Sporthotel, Erz Gebirge.
95	Journey95	95	Wandering	958	2	erz gebirge	Car	7	July	FourStars	Kur- und Sporthotel, Erz Gebirge.
96	Journey96	96	Wandering	2385	3	erz gebirge	Car	14	June	FourStars	Kur- und Sporthotel, Erz Gebirge.
97	Journey97	97	Recreation	1372	3	erz gebirge	Car	7	August	FourStars	Hotel Panorama, Erz Gebirge.
98	Journey98	98	Recreation	2188	2	erz gebirge	Car	14	September	FourStars	Hotel Panorama, Erz Gebirge.
99	Journey99	99	Active	1098	2	erz gebirge	Car	7	August	FourStars	Hotel Panorama, Erz Gebirge.
100	Journey100	100	Recreation	478	2	harz	Car	7	May	TwoStars	Hotel Brockenscheideck, Harz.
101	Journey101	101	Wandering	948	2	harz	Train	14	June	TwoStars	Hotel Brockenscheideck, Harz.
102	Journey102	102	Recreation	1072	3	harz	Car	7	July	ThreeStars	Hotel Waldfrieden, Harz.
103	Journey103	103	Recreation	1501	4	harz	Car	7	August	ThreeStars	Hotel Waldfrieden, Harz.
104	Journey104	104	Recreation	1868	2	harz	Car	14	September	ThreeStars	Hotel Waldfrieden, Harz.
105	Journey105	105	Wandering	1172	3	harz	Car	7	May	ThreeStars	Hotel Waldfrieden, Harz.
106	Journey106	106	Recreation	1888	2	harz	Car	7	June	FiveStars	Hotel Maritim, Harz.
107	Journey107	107	Recreation	1888	3	harz	Train	7	July	FiveStars	Hotel Maritim, Harz.
108	Journey108	108	Wandering	3768	2	harz	Car	14	May	FiveStars	Hotel Maritim, Harz.
109	Journey109	109	Recreation	484	2	harz	Car	7	August	HolidayFlat	H.Flat Harz.
110	Journey110	110	Recreation	374	4	harz	Car	7	September	HolidayFlat	H.Flat Harz.
111	Journey111	111	Recreation	589	3	harz	Car	7	June	HolidayFlat	H.Flat Harz.
112	Journey112	112	Wandering	719	4	harz	Train	7	July	HolidayFlat	H.Flat Harz.
113	Journey113	113	Wandering	1248	4	harz	Car	14	August	HolidayFlat	H.Flat Harz.
114	Journey114	114	Bathing	398	2	north sea	Car	7	July	OneStar	Pension Murra, North Sea.
115	Journey115	115	Recreation	398	2	north sea	Car	7	June	OneStar	Pension Murra, North Sea.
116	Journey116	116	Bathing	1348	3	north sea	Car	7	July	TwoStars	Pension Nina, North Sea.
117	Journey117	117	Bathing	1348	2	north sea	Car	7	August	TwoStars	Pension Nina, North Sea.
118	Journey118	118	Recreation	3228	2	north sea	Car	14	May	TwoStars	Hotel Silbermoeve, North Sea.
119	Journey119	119	Recreation	1618	2	north sea	Train	7	September	TwoStars	Hotel Silbermoeve, North Sea.
120	Journey120	120	Bathing	719	4	north sea	Car	7	August	HolidayFlat	H.Flat North Sea.
121	Journey121	121	Bathing	669	6	north sea	Car	7	July	HolidayFlat	H.Flat North Sea.
122	Journey122	122	Bathing	2108	4	north sea	Car	14	August	HolidayFlat	H.Flat North Sea.
123	Journey123	123	Recreation	579	4	north sea	Train	7	June	HolidayFlat	H.Flat North Sea.
124	Journey124	124	Recreation	664	5	north sea	Car	7	July	HolidayFlat	H.Flat North Sea.
125	Journey125	125	Recreation	1138	4	north sea	Car	14	August	HolidayFlat	H.Flat North Sea.
126	Journey126	126	Active	2198	3	north sea	Car	14	September	HolidayFlat	H.Flat North Sea.
127	Journey127	127	Recreation	1044	6	north sea	Train	7	June	HolidayFlat	H.Flat North Sea.
128	Journey128	128	Active	719	3	north sea	Car	7	August	HolidayFlat	H.Flat Sylt.
129	Journey129	129	Bathing	1828	2	baltic sea	Car	14	July	TwoStars	Hotel Stoertebeker, Zingst.
130	Journey130	130	Bathing	918	3	baltic sea	Car	7	August	TwoStars	Hotel Stoertebeker, Zingst.
131	Journey131	131	Recreation	918	2	baltic sea	Car	7	June	TwoStars	Hotel Am Leuchtturm, Warnemuende.
132	Journey132	132	Recreation	1147	3	baltic sea	Train	7	September	TwoStars	Hotel Am Leuchtturm, Warnemuende.
133	Journey133	133	Bathing	1047	3	baltic sea	Car	7	July	ThreeStars	Hotel Baltic, Usedom.
134	Journey134	134	Bathing	2472	4	baltic sea	Car	14	August	ThreeStars	Hotel Baltic, Usedom.
135	Journey135	135	Recreation	2226	3	baltic sea	Car	14	June	ThreeStars	NobisHotel, Ruegen.
136	Journey136	136	Bathing	1438	2	baltic sea	Car	7	August	FourStars	Ostseehotel, Wustrow.
137	Journey137	137	Active	1797	3	baltic sea	Car	7	July	FourStars	Ostseehotel, Wustrow.
138	Journey138	138	Bathing	1044	4	baltic sea	Train	7	August	HolidayFlat	H.Flat Baltic Sea.
139	Journey139	139	Bathing	639	2	baltic sea	Car	7	August	HolidayFlat	H.Flat Fehmarn.
140	Journey140	140	Bathing	1818	2	baltic sea	Car	14	July	HolidayFlat	H.Flat, Ruegen.
141	Journey141	141	Recreation	539	4	baltic sea	Car	7	June	HolidayFlat	H.Flat Baltic Sea.
142	Journey142	142	Recreation	709	6	baltic sea	Car	7	May	HolidayFlat	H.Flat Baltic Sea.
143	Journey143	143	Active	994	4	baltic sea	Train	14	July	HolidayFlat	H.Flat Baltic Sea.
144	Journey144	144	Wandering	547	3	black forest	Car	7	May	TwoStars	Hotel Hirschen, Black Forest.
145	Journey145	145	Recreation	868	2	black forest	Car	14	June	TwoStars	Hotel Hirschen, Black Forest.
146	Journey146	146	Wandering	907	3	black forest	Car	7	July	ThreeStars	Hotel Waldwinkel, Black Forest.
147	Journey147	147	Wandering	698	2	black forest	Car	14	August	ThreeStars	Hotel Waldwinkel, Black Forest.
148	Journey148	148	Wandering	738	2	black forest	Train	7	September	ThreeStars	Berghotel Kandel, Black Forest.
149	Journey149	149	Recreation	922	3	black forest	Car	7	August	ThreeStars	Berghotel Kandel, Black Forest.
150	Journey150	150	Wandering	3732	4	black forest	Car	14	July	FourStars	Kurhotel, Black Forest.
151	Journey151	151	Recreation	1138	2	black forest	Car	7	June	FourStars	Kurhotel, Black Forest.
152	Journey152	152	Wandering	449	2	black forest	Train	7	May	HolidayFlat	H.Flat Black Forest.
153	Journey153	153	Wandering	459	5	black forest	Car	7	June	HolidayFlat	H.Flat Black Forest.
154	Journey154	154	Wandering	1039	3	black forest	Car	7	July	HolidayFlat	H.Flat Black Forest.
155	Journey155	155	Wandering	2538	3	black forest	Car	14	August	HolidayFlat	H.Flat Black Forest.
156	Journey156	156	Recreation	1313	2	black forest	Car	14	September	HolidayFlat	H.Flat Black Forest.
157	Journey157	157	Recreation	904	6	black forest	Car	7	October	HolidayFlat	H.Flat Black Forest.
158	Journey158	158	Recreation	984	7	black forest	Train	7	July	HolidayFlat	H.Flat Black Forest.
159	Journey159	159	Recreation	638	2	thuringia	Car	7	May	ThreeStars	Berghotel Oberhof, Thuringia.
160	Journey160	160	Recreation	922	3	thuringia	Car	7	August	ThreeStars	Berghotel Oberhof, Thuringia.
161	Journey161	161	Active	998	2	thuringia	Car	7	June	ThreeStars	Hotel Finsterbergen, Thuringia.
162	Journey162	162	Wandering	2588	3	thuringia	Car	14	July	ThreeStars	Hotel Finsterbergen, Thuringia.
163	Journey163	163	Wandering	1377	4	thuringia	Train	7	August	FourStars	Hotel Rennsteig, Thuringia.
164	Journey164	164	Recreation	918	2	thuringia	Car	7	September	FourStars	Hotel Rennsteig, Thuringia.
165	Journey165	165	Active	2285	3	thuringia	Car	14	August	FourStars	Hotel Rennsteig, Thuringia.
166	Journey166	166	Recreation	2668	2	thuringia	Car	14	October	FourStars	Hotel Panorama, Thuringia.
167	Journey167	167	Active	1497	3	thuringia	Car	7	August	FourStars	Hotel Panorama, Thuringia.
168	Journey168	168	Active	2388	3	thuringia	Car	14	August	FourStars	Hotel Panorama, Thuringia.
169	Journey169	169	Recreation	589	4	thuringia	Car	7	July	HolidayFlat	H.Flat Thuringia.
170	Journey170	170	Recreation	1128	4	thuringia	Train	14	June	HolidayFlat	H.Flat Thuringia.
171	Journey171	171	Recreation	589	4	thuringia	Car	7	May	HolidayFlat	H.Flat Thuringia.
172	Journey172	172	Recreation	1148	4	thuringia	Car	14	July	HolidayFlat	H.Flat Thuringia.
173	Journey173	173	Wandering	574	4	thuringia	Car	7	August	HolidayFlat	H.Flat Thuringia.
174	Journey174	174	Bathing	858	4	atlantic	Car	14	May	HolidayFlat	H.Flat Atlantik, France.
175	Journey175	175	Bathing	2078	4	atlantic	Car	14	June	HolidayFlat	H.Flat Atlantik, France.
176	Journey176	176	Bathing	4718	7	atlantic	Car	14	July	HolidayFlat	H.Flat Atlantik, France.
177	Journey177	177	Bathing	1698	4	atlantic	Car	14	August	HolidayFlat	H.Flat Atlantik, France.
178	Journey178	178	Bathing	649	6	atlantic	Car	7	September	HolidayFlat	H.Flat Atlantik, France.
179	Journey179	179	Bathing	394	3	atlantic	Car	7	June	HolidayFlat	H.Flat Atlantik, France.
180	Journey180	180	Bathing	1289	5	atlantic	Car	7	July	HolidayFlat	H.Flat Atlantik, France.
181	Journey181	181	Bathing	879	4	atlantic	Car	7	August	HolidayFlat	H.Flat Atlantik, France.
182	Journey182	182	Bathing	1347	3	atlantic	Car	21	May	HolidayFlat	H.Flat Atlantik, France.
183	Journey183	183	Active	838	5	atlantic	Car	14	June	HolidayFlat	H.Flat Atlantik, France.
184	Journey184	184	Active	1938	6	atlantic	Car	14	July	HolidayFlat	H.Flat Atlantik, France.
185	Journey185	185	Active	849	6	atlantic	Car	7	August	HolidayFlat	H.Flat Atlantik, France.
186	Journey186	186	Active	1204	8	atlantic	Car	7	June	HolidayFlat	H.Flat Atlantik, France.
187	Journey187	187	Recreation	2878	8	atlantic	Car	14	July	HolidayFlat	H.Flat Atlantik, France.
188	Journey188	188	Recreation	2187	2	atlantic	Car	21	August	HolidayFlat	H.Flat Atlantik, France.
189	Journey189	189	Bathing	519	2	coted azur	Car	7	April	HolidayFlat	H.Flat Cote d'Azur.
190	Journey190	190	Bathing	479	3	coted azur	Car	7	May	HolidayFlat	H.Flat Cote d'Azur.
191	Journey191	191	Bathing	829	7	coted azur	Car	7	June	HolidayFlat	H.Flat Cote d'Azur.
192	Journey192	192	Bathing	1089	5	coted azur	Car	7	July	HolidayFlat	H.Flat Cote d'Azur.
193	Journey193	193	Bathing	1029	5	coted azur	Car	7	August	HolidayFlat	H.Flat Cote d'Azur.
194	Journey194	194	Bathing	799	6	coted azur	Car	7	September	HolidayFlat	H.Flat Cote d'Azur.
195	Journey195	195	Bathing	449	4	coted azur	Train	7	October	HolidayFlat	H.Flat Cote d'Azur.
196	Journey196	196	Bathing	1198	4	coted azur	Car	14	May	HolidayFlat	H.Flat Cote d'Azur.
197	Journey197	197	Bathing	1108	4	coted azur	Train	14	June	HolidayFlat	H.Flat Cote d'Azur.
198	Journey198	198	Bathing	4458	7	coted azur	Car	14	July	HolidayFlat	H.Flat Cote d'Azur.
199	Journey199	199	Active	2678	3	coted azur	Car	14	August	HolidayFlat	H.Flat Cote d'Azur.
200	Journey200	200	Active	1598	4	coted azur	Car	14	September	HolidayFlat	H.Flat Cote d'Azur.
201	Journey201	201	Active	589	6	coted azur	Car	7	May	HolidayFlat	H.Flat Cote d'Azur.
202	Journey202	202	Recreation	449	2	coted azur	Train	7	June	HolidayFlat	H.Flat Cote d'Azur.
203	Journey203	203	Recreation	1838	3	coted azur	Car	14	July	HolidayFlat	H.Flat Cote d'Azur.
204	Journey204	204	Bathing	1539	2	corsica	Plane	14	May	OneStar	Caravan La Pinede.
205	Journey205	205	Bathing	2469	3	corsica	Plane	14	June	OneStar	Hotel L'Esquinade.
206	Journey206	206	Bathing	5269	4	corsica	Plane	14	July	TwoStars	Feriendorf Vallicella.
207	Journey207	207	Bathing	2249	3	corsica	Plane	21	June	TwoStars	Mobilhomes La Pinede.
208	Journey208	208	Bathing	1898	2	corsica	Plane	7	August	TwoStars	Hotel Funtana Marina.
209	Journey209	209	Bathing	3522	4	corsica	Plane	7	July	TwoStars	Feriendorf Vallicella.
210	Journey210	210	Bathing	3459	3	corsica	Plane	14	August	ThreeStars	Calvi-Hotel.
211	Journey211	211	Bathing	2539	2	corsica	Plane	14	September	ThreeStars	Studios Le Rocher.
212	Journey212	212	Bathing	5659	3	corsica	Plane	21	July	ThreeStars	Hotel Pineto.
213	Journey213	213	Bathing	3298	2	corsica	Plane	14	June	ThreeStars	Hotel Orizonte.
214	Journey214	214	Active	2718	2	corsica	Plane	14	September	ThreeStars	Grand Hotel.
215	Journey215	215	Active	5678	3	corsica	Plane	21	August	ThreeStars	Grand Hotel.
216	Journey216	216	Active	2038	2	corsica	Plane	14	June	TwoStars	Mobilhomes La Pinede.
217	Journey217	217	Wandering	634	1	corsica	Plane	7	April	TwoStars	Mobilhomes La Pinede.
218	Journey218	218	Wandering	2578	2	corsica	Plane	14	May	ThreeStars	Grand Hotel.
219	Journey219	219	Bathing	659	4	normandy	Car	7	June	HolidayFlat	H.Flat Normandy.
220	Journey220	220	Bathing	709	2	normandy	Car	7	July	HolidayFlat	H.Flat Normandy.
221	Journey221	221	Active	809	4	normandy	Car	7	August	HolidayFlat	H.Flat Normandy.
222	Journey222	222	Active	1418	2	normandy	Car	14	August	HolidayFlat	H.Flat Normandy.
223	Journey223	223	Recreation	1618	4	normandy	Car	14	July	HolidayFlat	H.Flat Normandy.
224	Journey224	224	Bathing	689	4	brittany	Car	7	June	HolidayFlat	H.Flat Brittany.
225	Journey225	225	Bathing	1549	7	brittany	Car	7	July	HolidayFlat	H.Flat Brittany.
226	Journey226	226	Bathing	1064	5	brittany	Car	7	August	HolidayFlat	H.Flat Brittany.
227	Journey227	227	Bathing	519	4	brittany	Car	7	September	HolidayFlat	H.Flat Brittany.
228	Journey228	228	Active	1219	6	brittany	Car	7	August	HolidayFlat	H.Flat Brittany.
229	Journey229	229	Active	889	4	brittany	Car	7	July	HolidayFlat	H.Flat Brittany.
230	Journey230	230	Active	1268	4	brittany	Car	14	June	HolidayFlat	H.Flat Brittany.
231	Journey231	231	Recreation	2108	5	brittany	Car	14	July	HolidayFlat	H.Flat Brittany.
232	Journey232	232	Recreation	1258	4	brittany	Car	14	August	HolidayFlat	H.Flat Brittany.
233	Journey233	233	Recreation	1797	4	brittany	Car	21	June	HolidayFlat	H.Flat Brittany.
234	Journey234	234	Bathing	3485	3	attica	Plane	14	May	FourStars	Hotel Golden Coast, Attica.
235	Journey235	235	Bathing	2038	2	attica	Plane	14	April	TwoStars	Hotel Calamos Beach, Attica.
236	Journey236	236	Bathing	3129	4	attica	Plane	7	September	ThreeStars	Hotel Kalypso Club, Attica.
237	Journey237	237	Bathing	2518	2	attica	Plane	14	June	ThreeStars	Hotel Menexelis, Attica.
238	Journey238	238	Bathing	3215	3	attica	Plane	14	July	ThreeStars	Hotel Miramare, Attica.
239	Journey239	239	Bathing	4002	3	attica	Plane	21	September	FourStars	Hotel Holidays in Evia, Attica.
240	Journey240	240	Bathing	3216	4	attica	Plane	7	August	ThreeStars	Hotel Menexelis, Attica.
241	Journey241	241	Bathing	1149	1	attica	Plane	14	June	TwoStars	Hotel Calamos Beach, Attica.
242	Journey242	242	Bathing	3658	2	attica	Plane	14	July	FourStars	Hotel Golden Coast, Attica.
243	Journey243	243	Bathing	3458	2	attica	Plane	21	August	ThreeStars	Hotel Menexelis, Attica.
244	Journey244	244	Bathing	2742	3	attica	Plane	14	July	TwoStars	Hotel Calamos Beach, Attica.
245	Journey245	245	Recreation	2258	2	attica	Plane	7	June	FourStars	Hotel Golden Coast, Attica.
246	Journey246	246	Recreation	1169	1	attica	Plane	14	September	ThreeStars	Hotel Miramare, Attica.
247	Journey247	247	Recreation	3215	3	attica	Plane	14	August	ThreeStars	Hotel Miramare, Attica.
248	Journey248	248	Recreation	3378	2	attica	Plane	21	May	FourStars	Hotel Golden Coast, Attica.
249	Journey249	249	Bathing	2787	3	chalkidiki	Plane	14	July	TwoStars	Hotel Sermyli, Chalkidiki.
250	Journey250	250	Bathing	4673	4	chalkidiki	Plane	14	August	ThreeStars	Hotel Portes Beach, Chalkidiki.
251	Journey251	251	Bathing	2898	2	chalkidiki	Plane	21	September	ThreeStars	Hotel Mendi, Chalkidiki.
252	Journey252	252	Bathing	2538	2	chalkidiki	Plane	14	June	ThreeStars	Hotel Olympico, Chalkidiki.
253	Journey253	253	Bathing	2427	3	chalkidiki	Plane	7	July	ThreeStars	Hotel Olympico, Chalkidiki.
254	Journey254	254	Recreation	2358	2	chalkidiki	Plane	14	May	ThreeStars	Hotel Olympico, Chalkidiki.
255	Journey255	255	Recreation	2898	2	chalkidiki	Plane	21	September	ThreeStars	Hotel Mendi, Chalkidiki.
256	Journey256	256	Recreation	2398	2	chalkidiki	Plane	14	June	ThreeStars	Hotel Mendi, Chalkidiki.
257	Journey257	257	Active	3718	3	chalkidiki	Plane	14	July	FourStars	Hotel Sani Beach, Chalkidiki.
258	Journey258	258	Active	3299	3	chalkidiki	Plane	7	August	FourStars	Hotel Sani Beach, Chalkidik.
259	Journey259	259	Active	3318	2	chalkidiki	Plane	14	June	FourStars	Hotel Sani Beach, Chalkidik.
260	Journey260	260	Recreation	5329	4	chalkidiki	Plane	14	July	FourStars	Hotel Athos Palace, Chalkidiki.
261	Journey261	261	Recreation	3258	2	chalkidiki	Plane	21	May	FourStars	Hotel Athos Palace, Chalkidiki.
262	Journey262	262	Recreation	3038	2	chalkidiki	Plane	14	September	FourStars	Hotel Athos Palace, Chalkidiki.
263	Journey263	263	Education	2738	2	chalkidiki	Plane	21	October	FourStars	Hotel Athos Palace, Chalkidiki.
264	Journey264	264	Bathing	2831	3	corfu	Plane	14	June	TwoStars	Hotel Iliada, Corfu.
265	Journey265	265	Bathing	3644	4	corfu	Plane	14	July	TwoStars	Hotel Iliada, Corfu.
266	Journey266	266	Bathing	3258	2	corfu	Plane	21	September	ThreeStars	Hotel Belvedere, Corfu.
267	Journey267	267	Bathing	3793	3	corfu	Plane	14	August	ThreeStars	Hotel Belvedere, Corfu.
268	Journey268	268	Bathing	2779	3	corfu	Plane	7	August	ThreeStars	Hotel Belvedere, Corfu.
269	Journey269	269	Bathing	2698	2	corfu	Plane	14	June	ThreeStars	Hotel Coral, Corfu.
270	Journey270	270	Bathing	3649	3	corfu	Plane	21	September	ThreeStars	Hotel Coral, Corfu.
271	Journey271	271	Bathing	3078	2	corfu	Plane	14	July	ThreeStars	Hotel Coral, Corfu.
272	Journey272	272	Bathing	3198	2	corfu	Plane	14	September	ThreeStars	Hotel Mirabell, Corfu.
273	Journey273	273	Active	3758	2	corfu	Plane	21	June	ThreeStars	Hotel Mirabell, Corfu.
274	Journey274	274	Active	3198	3	corfu	Plane	14	August	ThreeStars	Hotel Mirabell, Corfu.
275	Journey275	275	Active	2158	2	corfu	Plane	7	July	FourStars	Hotel Regency, Corfu.
276	Journey276	276	Recreation	3418	2	corfu	Plane	21	June	FourStars	Hotel Regency, Corfu.
277	Journey277	277	Recreation	3038	2	corfu	Plane	14	September	FourStars	Hotel Kerkyra Golf, Corfu.
278	Journey278	278	Recreation	2043	3	corfu	Plane	7	May	FourStars	Hotel Kerkyra Golf, Corfu.
279	Journey279	279	Bathing	2498	2	crete	Plane	14	June	TwoStars	Hotel Oceanis, Crete.
280	Journey280	280	Bathing	2417	3	crete	Plane	14	July	TwoStars	Hotel Ilios, Crete.
281	Journey281	281	Active	2825	4	crete	Plane	7	August	TwoStars	Hotel Oceanis, Crete.
282	Journey282	282	Bathing	3498	2	crete	Plane	14	September	ThreeStars	Hotel Creta Beach, Crete.
283	Journey283	283	Bathing	4198	2	crete	Plane	21	June	ThreeStars	Hotel Creta Beach, Crete.
284	Journey284	284	Bathing	3847	3	crete	Plane	14	August	ThreeStars	Hotel Creta Beach, Crete.
285	Journey285	285	Bathing	3175	4	crete	Plane	7	July	ThreeStars	Hotel Gortyna, Crete.
286	Journey286	286	Active	3038	2	crete	Plane	14	September	ThreeStars	Hotel Gortyna, Crete.
287	Journey287	287	Active	2758	2	crete	Plane	14	June	ThreeStars	Hotel Gortyna, Crete.
288	Journey288	288	Bathing	3198	2	crete	Plane	14	June	FourStars	Hotel Fodele Beach, Crete.
289	Journey289	289	Bathing	2298	2	crete	Plane	7	May	FourStars	Hotel Fodele Beach, Crete.
290	Journey290	290	Bathing	6609	3	crete	Plane	21	July	FourStars	Hotel Bali Paradise, Crete.
291	Journey291	291	Active	4068	3	crete	Plane	14	August	FourStars	Hotel Bali Paradise, Crete.
292	Journey292	292	Active	4463	3	crete	Plane	21	June	FourStars	Hotel Europa Beach, Crete.
293	Journey293	293	Education	3038	2	crete	Plane	14	May	FourStars	Hotel Europa Beach, Crete.
294	Journey294	294	Bathing	2263	3	rhodes	Plane	14	May	TwoStars	Studios Argiro, Rhodes.
295	Journey295	295	Bathing	2428	2	rhodes	Plane	21	June	TwoStars	Studios Argiro, Rhodes.
296	Journey296	296	Bathing	2263	3	rhodes	Plane	7	July	ThreeStars	Hotel Dafni, Rhodes.
297	Journey297	297	Bathing	3553	4	rhodes	Plane	14	August	ThreeStars	Hotel Dafni, Rhodes.
298	Journey298	298	Bathing	2791	3	rhodes	Plane	14	July	ThreeStars	Hotel Dafni, Rhodes.
299	Journey299	299	Recreation	1968	2	rhodes	Plane	7	May	ThreeStars	Hotel Kalithea Sun, Rhodes.
300	Journey300	300	Active	2758	2	rhodes	Plane	14	June	ThreeStars	Hotel Kalithea Sun, Rhodes.
301	Journey301	301	Active	4364	3	rhodes	Plane	21	July	ThreeStars	Hotel Kalithea Sun, Rhodes.
302	Journey302	302	Education	2478	2	rhodes	Plane	14	October	ThreeStars	Hotel Kalithea Sun, Rhodes.
303	Journey303	303	Bathing	3869	3	rhodes	Plane	14	July	FourStars	Hotel Columbia Resort, Rhodes.
304	Journey304	304	Bathing	3958	2	rhodes	Plane	21	September	FourStars	Hotel Columbia Resort, Rhodes.
305	Journey305	305	Bathing	4925	4	rhodes	Plane	14	August	FourStars	Hotel Columbia Resort, Rhodes.
306	Journey306	306	Active	3498	2	rhodes	Plane	14	July	FourStars	Hotel Paradise Beach, Rhodes.
307	Journey307	307	Recreation	2298	2	rhodes	Plane	7	June	FourStars	Hotel Paradise Beach, Rhodes.
308	Journey308	308	Education	3098	2	rhodes	Plane	14	September	FourStars	Hotel Paradise Beach, Rhodes.
309	Journey309	309	Education	2068	4	england	Car	14	June	HolidayFlat	H.Flat England.
310	Journey310	310	Language	3582	6	england	Car	21	July	HolidayFlat	H.Flat England.
311	Journey311	311	Language	2398	8	england	Car	14	August	HolidayFlat	H.Flat England.
312	Journey312	312	Recreation	2298	7	england	Car	14	September	HolidayFlat	H.Flat England.
313	Journey313	313	Recreation	3297	6	england	Car	21	July	HolidayFlat	H.Flat England.
314	Journey314	314	Education	3208	8	ireland	Car	14	August	HolidayFlat	H.Flat Ireland.
315	Journey315	315	Language	2592	6	ireland	Car	21	June	HolidayFlat	H.Flat Ireland.
316	Journey316	316	Language	2048	7	ireland	Car	14	July	HolidayFlat	H.Flat Ireland.
317	Journey317	317	Recreation	2388	4	ireland	Car	14	August	HolidayFlat	H.Flat Ireland.
318	Journey318	318	Recreation	2457	8	ireland	Car	21	September	HolidayFlat	H.Flat Ireland.
319	Journey319	319	Education	2458	3	scotland	Car	14	June	HolidayFlat	H.Flat Scotland.
320	Journey320	320	Language	3282	2	scotland	Car	21	July	HolidayFlat	H.Flat Scotland.
321	Journey321	321	Language	3878	6	scotland	Car	14	August	HolidayFlat	H.Flat Scotland.
322	Journey322	322	Recreation	2738	2	scotland	Car	14	September	HolidayFlat	H.Flat Scotland.
323	Journey323	323	Recreation	2248	2	scotland	Car	21	July	HolidayFlat	H.Flat Scotland.
324	Journey324	324	Education	1808	5	wales	Car	14	June	HolidayFlat	H.Flat Wales.
325	Journey325	325	Language	3732	5	wales	Car	21	July	HolidayFlat	H.Flat Wales.
326	Journey326	326	Language	2628	6	wales	Car	14	August	HolidayFlat	H.Flat Wales.
327	Journey327	327	Recreation	1888	6	wales	Car	14	September	HolidayFlat	H.Flat Wales.
328	Journey328	328	Recreation	3297	6	wales	Car	21	July	HolidayFlat	H.Flat Wales.
329	Journey329	329	Bathing	1408	6	north sea	Car	14	June	HolidayFlat	H.Flat North Sea, Holland.
330	Journey330	330	Bathing	649	5	north sea	Car	7	July	HolidayFlat	H.Flat North Sea, Holland.
331	Journey331	331	Bathing	1478	3	north sea	Car	14	August	HolidayFlat	H.Flat North Sea, Holland.
332	Journey332	332	Active	1598	4	north sea	Car	14	July	HolidayFlat	H.Flat North Sea, Holland.
333	Journey333	333	Recreation	559	6	north sea	Train	7	August	HolidayFlat	H.Flat North Sea, Holland.
334	Journey334	334	Recreation	1198	3	north sea	Train	14	September	HolidayFlat	H.Flat North Sea, Holland.
335	Journey335	335	Active	514	5	north sea	Coach	7	June	HolidayFlat	H.Flat North Sea, Holland.
336	Journey336	336	Bathing	474	5	north sea	Car	3	June	HolidayFlat	H.Flat North Sea, Holland.
337	Journey337	337	Bathing	539	4	north sea	Car	3	May	HolidayFlat	H.Flat North Sea, Holland.
338	Journey338	338	Bathing	329	6	north sea	Car	3	June	HolidayFlat	H.Flat North Sea, Holland.
339	Journey339	339	Active	3280	4	holland	Car	14	April	HolidayFlat	Park Gran Dorado, Holland.
340	Journey340	340	Active	790	2	holland	Train	7	May	HolidayFlat	Park Gran Dorado, Holland.
341	Journey341	341	Active	2620	4	holland	Train	14	June	HolidayFlat	Park Gran Dorado, Holland.
342	Journey342	342	Active	1900	5	holland	Train	14	October	HolidayFlat	Park Gran Dorado, Holland.
343	Journey343	343	Recreation	2760	4	holland	Train	14	July	HolidayFlat	Park Gran Dorado, Holland.
344	Journey344	344	Recreation	1580	6	holland	Coach	7	August	HolidayFlat	Park Gran Dorado, Holland.
345	Journey345	345	Recreation	2468	2	holland	Coach	14	September	HolidayFlat	Park Gran Dorado, Holland.
346	Journey346	346	Recreation	2780	4	holland	Coach	14	July	HolidayFlat	Park Gran Dorado, Holland.
347	Journey347	347	Recreation	485	2	holland	Coach	3	May	HolidayFlat	Park Gran Dorado, Holland.
348	Journey348	348	Recreation	735	4	holland	Coach	4	June	HolidayFlat	Park Gran Dorado, Holland.
349	Journey349	349	Recreation	705	6	holland	Coach	3	September	HolidayFlat	Park Gran Dorado, Holland.
350	Journey350	350	Bathing	1438	2	adriatic sea	Car	14	June	TwoStars	Hotel Mexico, Adriatic Sea.
351	Journey351	351	Bathing	1375	3	adriatic sea	Car	7	July	TwoStars	Hotel Tropic, Adriatic Sea.
352	Journey352	352	Bathing	1547	4	adriatic sea	Car	14	August	TwoStars	Hotel Mexico, Adriatic Sea.
353	Journey353	353	Bathing	1238	2	adriatic sea	Car	14	September	TwoStars	Hotel Mexico, Adriatic Sea.
354	Journey354	354	Bathing	2311	3	adriatic sea	Car	14	August	TwoStars	Hotel Tropic, Adriatic Sea.
355	Journey355	355	Active	1193	3	adriatic sea	Car	7	July	TwoStars	Hotel Sporting, Adriatic Sea.
356	Journey356	356	Recreation	1758	2	adriatic sea	Car	21	May	TwoStars	Hotel Sporting, Adriatic Sea.
357	Journey357	357	Bathing	1678	2	adriatic sea	Car	14	July	ThreeStars	Hotel Nautilus, Adriatic Sea.
358	Journey358	358	Bathing	1349	4	adriatic sea	Car	7	August	ThreeStars	Hotel Nautilus, Adriatic Sea.
359	Journey359	359	Recreation	1278	2	adriatic sea	Car	14	June	ThreeStars	Hotel Nautilus, Adriatic Sea.
360	Journey360	360	Bathing	679	6	adriatic sea	Car	7	June	HolidayFlat	H.Flat Adriatic Sea.
361	Journey361	361	Bathing	699	4	adriatic sea	Car	7	July	HolidayFlat	H.Flat Adriatic Sea.
362	Journey362	362	Bathing	1139	5	adriatic sea	Car	7	August	HolidayFlat	H.Flat Adriatic Sea.
363	Journey363	363	Bathing	439	6	adriatic sea	Car	14	September	HolidayFlat	H.Flat Adriatic Sea.
364	Journey364	364	Bathing	598	2	adriatic sea	Car	14	May	HolidayFlat	H.Flat Adriatic Sea.
365	Journey365	365	Bathing	1538	3	adriatic sea	Car	14	July	HolidayFlat	H.Flat Adriatic Sea.
366	Journey366	366	Active	998	4	adriatic sea	Car	14	June	HolidayFlat	H.Flat Adriatic Sea.
367	Journey367	367	Active	1359	8	adriatic sea	Car	7	August	HolidayFlat	H.Flat Adriatic Sea.
368	Journey368	368	Recreation	798	3	adriatic sea	Car	14	September	HolidayFlat	H.Flat Adriatic Sea.
369	Journey369	369	Recreation	399	6	adriatic sea	Car	7	June	HolidayFlat	H.Flat Adriatic Sea.
370	Journey370	370	Recreation	1608	2	lake garda	Car	14	May	TwoStars	Hotel Palme, Lake Garda.
371	Journey371	371	Recreation	1838	2	lake garda	Car	14	June	TwoStars	Hotel Marco Polo, Lake Garda.
372	Journey372	372	Recreation	1593	4	lake garda	Car	7	July	TwoStars	Hotel Palme, Lake Garda.
373	Journey373	373	Bathing	2897	3	lake garda	Car	14	August	ThreeStars	Hotel Excelsior Bay, Lake Garda.
374	Journey374	374	Active	1098	2	lake garda	Car	7	September	ThreeStars	Hotel Excelsior Bay, Lake Garda.
375	Journey375	375	Active	2897	3	lake garda	Car	14	June	ThreeStars	Hotel Royal, Lake Garda.
376	Journey376	376	Wandering	5497	3	lake garda	Car	21	July	ThreeStars	Hotel Royal, Lake Garda.
377	Journey377	377	Recreation	2118	2	lake garda	Car	14	September	FourStars	Hotel Olimpo, Lake Garda.
378	Journey378	378	Recreation	3138	2	lake garda	Car	21	May	FourStars	Hotel Olimpo, Lake Garda.
379	Journey379	379	Wandering	3678	3	lake garda	Car	14	July	FourStars	Hotel Leonardo, Lake Garda.
380	Journey380	380	Recreation	798	4	lake garda	Car	14	May	HolidayFlat	H.Flat Gardasee, Italy.
381	Journey381	381	Recreation	1398	5	lake garda	Car	14	June	HolidayFlat	H.Flat Gardasee, Italy.
382	Journey382	382	Recreation	479	6	lake garda	Car	7	July	HolidayFlat	H.Flat Gardasee, Italy.
383	Journey383	383	Recreation	624	2	lake garda	Car	7	August	HolidayFlat	H.Flat Gardasee, Italy.
384	Journey384	384	Active	579	3	lake garda	Car	7	September	HolidayFlat	H.Flat Gardasee, Italy.
385	Journey385	385	Active	884	6	lake garda	Car	7	July	HolidayFlat	H.Flat Gardasee, Italy.
386	Journey386	386	Active	928	2	lake garda	Car	14	June	HolidayFlat	H.Flat Gardasee, Italy.
387	Journey387	387	Bathing	1099	3	lake garda	Car	7	August	HolidayFlat	H.Flat Gardasee, Italy.
388	Journey388	388	Wandering	599	4	lake garda	Car	7	September	HolidayFlat	H.Flat Gardasee, Italy.
389	Journey389	389	Wandering	1078	2	lake garda	Car	14	June	HolidayFlat	H.Flat Gardasee, Italy.
390	Journey390	390	Bathing	1178	2	riviera	Car	14	July	OneStar	Hotel Tritone, Ital. Riviera.
391	Journey391	391	Bathing	622	3	riviera	Car	7	August	OneStar	Hotel Tritone, Ital. Riviera.
392	Journey392	392	Recreation	648	2	riviera	Car	7	April	TwoStars	Hotel Al Sole, Ital. Riviera.
393	Journey393	393	Recreation	1508	2	riviera	Car	14	June	TwoStars	Hotel Al Sole, Ital. Riviera.
394	Journey394	394	Bathing	747	3	riviera	Car	7	September	TwoStars	Hotel La Vela, Ital. Riviera.
395	Journey395	395	Bathing	2222	4	riviera	Car	14	July	TwoStars	Hotel La Vela, Ital. Riviera.
396	Journey396	396	Bathing	869	5	riviera	Car	7	July	HolidayFlat	H.Flat Riviera, Italy.
397	Journey397	397	Bathing	484	3	riviera	Car	7	August	HolidayFlat	H.Flat Riviera, Italy.
398	Journey398	398	Bathing	599	2	riviera	Car	14	September	HolidayFlat	H.Flat Riviera, Italy.
399	Journey399	399	Bathing	2678	4	riviera	Car	14	August	HolidayFlat	H.Flat Riviera, Italy.
400	Journey400	400	Bathing	1738	3	riviera	Car	14	July	HolidayFlat	H.Flat Riviera, Italy.
401	Journey401	401	Recreation	429	6	riviera	Car	7	June	HolidayFlat	H.Flat Riviera, Italy.
402	Journey402	402	Recreation	1088	6	riviera	Car	14	May	HolidayFlat	H.Flat Riviera, Italy.
403	Journey403	403	Active	529	4	riviera	Car	7	June	HolidayFlat	H.Flat Riviera, Italy.
404	Journey404	404	Active	1588	2	riviera	Car	14	July	HolidayFlat	H.Flat Riviera, Italy.
405	Journey405	405	Wandering	1258	2	tyrol	Car	14	June	TwoStars	Pension garni Toni, South Tyrol.
406	Journey406	406	Recreation	822	3	tyrol	Car	7	May	TwoStars	Pension garni Toni, South Tyrol.
407	Journey407	407	Wandering	1499	3	tyrol	Car	14	July	ThreeStars	Hotel Untersteinerhof, South Tyrol.
408	Journey408	408	Wandering	718	2	tyrol	Car	7	September	ThreeStars	Hotel Untersteinerhof, South Tyrol.
409	Journey409	409	Recreation	1528	2	tyrol	Car	14	August	ThreeStars	Gasthof Adler, South Tyrol.
410	Journey410	410	Active	798	2	tyrol	Car	7	July	ThreeStars	Gasthof Adler, South Tyrol.
411	Journey411	411	Wandering	1479	3	tyrol	Car	7	June	FourStars	Posthotel Weisses Roessel, South Tyrol.
412	Journey412	412	Wandering	2658	2	tyrol	Car	14	July	FourStars	Posthotel Weisses Roessel, South Tyrol.
413	Journey413	413	Recreation	1997	4	tyrol	Car	7	September	FourStars	Hotel Nido, South Tyrol.
414	Journey414	414	Recreation	2888	2	tyrol	Car	14	June	FourStars	Hotel Nido, South Tyrol.
415	Journey415	415	Wandering	439	4	tyrol	Car	7	June	HolidayFlat	H.Flat Tirol, Italy.
416	Journey416	416	Wandering	319	3	tyrol	Car	7	July	HolidayFlat	H.Flat Tirol, Italy.
417	Journey417	417	Recreation	769	6	tyrol	Car	7	August	HolidayFlat	H.Flat Tirol, Italy.
418	Journey418	418	Recreation	1398	4	tyrol	Car	14	September	HolidayFlat	H.Flat Tirol, Italy.
419	Journey419	419	Active	559	4	tyrol	Car	7	May	HolidayFlat	H.Flat Tirol, Italy.
420	Journey420	420	Language	2039	1	malta	Plane	21	September	TwoStars	Sprachkurs, Malta.
421	Journey421	421	Language	4078	2	malta	Plane	21	July	TwoStars	Sprachkurs, Malta.
422	Journey422	422	Language	1539	1	malta	Plane	14	August	TwoStars	Sprachkurs, Malta.
423	Journey423	423	Bathing	1598	2	malta	Plane	14	June	TwoStars	Hotel Viking, Malta.
424	Journey424	424	Language	2039	1	malta	Plane	21	September	ThreeStars	Sprachkurs, Malta.
425	Journey425	425	Bathing	3637	3	malta	Plane	14	July	ThreeStars	Hotel Calypso, Malta.
426	Journey426	426	Bathing	4476	4	malta	Plane	14	August	ThreeStars	Hotel Calypso, Malta.
427	Journey427	427	Bathing	4729	3	malta	Plane	21	July	ThreeStars	Hotel Calypso, Malta.
428	Journey428	428	Active	3078	2	malta	Plane	14	September	ThreeStars	Hotel Atlantis, Malta.
429	Journey429	429	Recreation	3518	2	malta	Plane	21	May	ThreeStars	Hotel Atlantis, Malta.
430	Journey430	430	Bathing	4147	3	malta	Plane	14	August	FourStars	Hotel Suncrest, Malta.
431	Journey431	431	Bathing	3978	2	malta	Plane	21	June	FourStars	Hotel Suncrest, Malta.
432	Journey432	432	Active	3267	4	malta	Plane	7	July	FourStars	Hotel Suncrest, Malta.
433	Journey433	433	Active	4391	3	malta	Plane	14	August	FourStars	Hotel Cornucopia, Malta.
434	Journey434	434	Recreation	3278	2	malta	Plane	14	May	FourStars	Hotel Cornucopia, Malta.
435	Journey435	435	Wandering	1008	2	carinthia	Car	14	May	TwoStars	Pension Linde, Carinthia.
436	Journey436	436	Wandering	538	3	carinthia	Car	7	June	TwoStars	Pension Linde, Carinthia.
437	Journey437	437	Recreation	1472	3	carinthia	Car	14	July	TwoStars	Pension Seehof, Carinthia.
438	Journey438	438	Recreation	1438	2	carinthia	Car	21	August	TwoStars	Pension Seehof, Carinthia.
439	Journey439	439	Wandering	1498	2	carinthia	Car	14	September	ThreeStars	Aktivhotel Alte Muehle, Carinthia.
440	Journey440	440	Wandering	1326	5	carinthia	Car	7	August	ThreeStars	Ferienhotel Eichenhof, Carinthia.
441	Journey441	441	Wandering	1247	3	carinthia	Car	7	July	ThreeStars	Ferienhotel Eichenhof, Carinthia.
442	Journey442	442	Recreation	1058	2	carinthia	Car	7	June	ThreeStars	Hotel Ebner, Carinthia.
443	Journey443	443	Recreation	1698	2	carinthia	Car	14	May	ThreeStars	Hotel Ebner, Carinthia.
444	Journey444	444	Active	2572	3	carinthia	Car	14	July	ThreeStars	Aktivhotel Alte Muehle, Carinthia.
445	Journey445	445	Wandering	499	4	carinthia	Car	7	May	HolidayFlat	H.Flat Kaernten.
446	Journey446	446	Wandering	1049	6	carinthia	Car	7	June	HolidayFlat	H.Flat Kaernten.
447	Journey447	447	Wandering	779	4	carinthia	Car	7	July	HolidayFlat	H.Flat Kaernten.
448	Journey448	448	Wandering	1858	3	carinthia	Car	14	August	HolidayFlat	H.Flat Kaernten.
449	Journey449	449	Recreation	1149	6	carinthia	Car	7	September	HolidayFlat	H.Flat Kaernten.
450	Journey450	450	Recreation	559	3	carinthia	Car	7	May	HolidayFlat	H.Flat Kaernten.
451	Journey451	451	Recreation	1073	2	carinthia	Car	14	June	HolidayFlat	H.Flat Kaernten.
452	Journey452	452	Recreation	1358	3	carinthia	Car	14	July	HolidayFlat	H.Flat Kaernten.
453	Journey453	453	Active	829	6	carinthia	Car	7	August	HolidayFlat	H.Flat Kaernten.
454	Journey454	454	Active	579	4	carinthia	Car	7	September	HolidayFlat	H.Flat Kaernten.
455	Journey455	455	Wandering	778	2	salzberger land	Car	14	May	TwoStars	Pension Claudia, Salzb. Land.
456	Journey456	456	Recreation	418	2	salzberger land	Car	7	June	TwoStars	Pension Claudia, Salzb. Land.
457	Journey457	457	Wandering	1572	3	salzberger land	Car	14	July	ThreeStars	Hotel Tauernhof, Salzb. Land.
458	Journey458	458	Active	837	4	salzberger land	Car	7	August	ThreeStars	Hotel Tauernhof, Salzb. Land.
459	Journey459	459	Wandering	718	2	salzberger land	Car	7	September	ThreeStars	Gasthof Bachschmied, Salzb. Land.
460	Journey460	460	Recreation	2038	2	salzberger land	Car	21	May	ThreeStars	Gasthof Bachschmied, Salzb. Land.
461	Journey461	461	Wandering	1538	3	salzberger land	Car	14	June	FourStars	Hotel Eschbacher, Salzb. Land.
462	Journey462	462	Recreation	2322	3	salzberger land	Car	14	July	FourStars	Hotel Eschbacher, Salzb. Land.
463	Journey463	463	Wandering	2127	4	salzberger land	Car	7	August	FourStars	Hotel Norica, Salzb. Land.
464	Journey464	464	Active	2627	3	salzberger land	Car	14	September	FourStars	Hotel Norica, Salzb. Land.
465	Journey465	465	Wandering	1798	2	salzberger land	Car	7	July	FiveStars	Alpnerresidenz, Salzb. Land.
466	Journey466	466	Recreation	1518	2	salzberger land	Car	7	June	FiveStars	Alpnerresidenz, Salzb. Land.
467	Journey467	467	Wandering	684	4	salzberger land	Car	7	May	HolidayFlat	H.Flat Salzb. Land.
468	Journey468	468	Wandering	729	6	salzberger land	Car	7	June	HolidayFlat	H.Flat Salzb. Land.
469	Journey469	469	Wandering	699	4	salzberger land	Car	7	July	HolidayFlat	H.Flat Salzb. Land.
470	Journey470	470	Wandering	349	2	salzberger land	Car	14	August	HolidayFlat	H.Flat Salzb. Land.
471	Journey471	471	Recreation	354	3	salzberger land	Car	7	September	HolidayFlat	H.Flat Salzb. Land.
472	Journey472	472	Recreation	399	2	salzberger land	Car	7	August	HolidayFlat	H.Flat Salzb. Land.
473	Journey473	473	Recreation	719	6	salzberger land	Car	7	July	HolidayFlat	H.Flat Salzb. Land.
474	Journey474	474	Recreation	1223	4	salzberger land	Car	14	June	HolidayFlat	H.Flat Salzb. Land.
475	Journey475	475	Active	484	3	salzberger land	Car	7	July	HolidayFlat	H.Flat Salzb. Land.
476	Journey476	476	Active	1228	4	salzberger land	Car	14	June	HolidayFlat	H.Flat Salzb. Land.
477	Journey477	477	Wandering	898	2	styria	Car	14	June	TwoStars	Gasthof Mayer, Styria.
478	Journey478	478	Recreation	478	3	styria	Car	7	May	TwoStars	Gasthof Mayer, Styria.
479	Journey479	479	Wandering	2372	3	styria	Car	14	July	ThreeStars	Hotel Berghof, Styria.
480	Journey480	480	Wandering	1227	4	styria	Car	7	August	ThreeStars	Hotel Berghof, Styria.
481	Journey481	481	Active	1578	2	styria	Car	14	September	ThreeStars	Hotel Berghof, Styria.
482	Journey482	482	Wandering	847	3	styria	Car	7	May	FourStars	Hotel Haeuserl am Wald, Styria.
483	Journey483	483	Recreation	678	2	styria	Car	7	June	FourStars	Hotel Haeuserl am Wald, Styria.
484	Journey484	484	Wandering	379	2	styria	Car	7	July	HolidayFlat	H.Flat Styria.
485	Journey485	485	Wandering	369	4	styria	Car	7	August	HolidayFlat	H.Flat Styria.
486	Journey486	486	Wandering	708	2	styria	Car	14	September	HolidayFlat	H.Flat Styria.
487	Journey487	487	Recreation	569	6	styria	Car	7	August	HolidayFlat	H.Flat Styria.
488	Journey488	488	Recreation	379	4	styria	Car	7	July	HolidayFlat	H.Flat Styria.
489	Journey489	489	Recreation	429	4	styria	Car	7	June	HolidayFlat	H.Flat Styria.
490	Journey490	490	Recreation	348	2	styria	Car	14	May	HolidayFlat	H.Flat Styria.
491	Journey491	491	Active	909	4	styria	Car	7	July	HolidayFlat	H.Flat Styria.
492	Journey492	492	Wandering	548	2	tyrol	Car	7	May	OneStar	Gasthof Edelweiss, Tyrol.
493	Journey493	493	Wandering	685	3	tyrol	Car	7	June	OneStar	Gasthof Edelweiss, Tyrol.
494	Journey494	494	Wandering	897	4	tyrol	Car	7	July	TwoStars	Gasthof Post, Tyrol.
495	Journey495	495	Wandering	2322	3	tyrol	Car	14	August	TwoStars	Pension Tannenhof, Tyrol.
496	Journey496	496	Recreation	698	2	tyrol	Car	7	September	TwoStars	Gasthof Sonne, Tyrol.
497	Journey497	497	Wandering	798	2	tyrol	Car	7	August	ThreeStars	Gasthof Panorama, Tyrol.
498	Journey498	498	Wandering	1808	2	tyrol	Car	14	July	ThreeStars	Gasthof Panorama, Tyrol.
499	Journey499	499	Recreation	1972	3	tyrol	Car	14	June	ThreeStars	Ferienhotel Neuwirt, Tyrol.
500	Journey500	500	Active	818	2	tyrol	Car	7	June	ThreeStars	Ferienhotel Neuwirt, Tyrol.
501	Journey501	501	Wandering	738	2	tyrol	Car	7	May	FourStars	Hotel Wastlhof, Tyrol.
502	Journey502	502	Wandering	3267	4	tyrol	Car	14	July	FourStars	Hotel Klausen, Tyrol.
503	Journey503	503	Recreation	1571	5	tyrol	Car	7	August	FourStars	Hotel Unterwirt, Tyrol.
504	Journey504	504	Wandering	1198	2	tyrol	Car	7	September	FiveStars	Hotel Alpenresidence, Tyrol.
505	Journey505	505	Recreation	1847	3	tyrol	Car	7	July	FiveStars	Hotel Alpenresidence, Tyrol.
506	Journey506	506	Active	3098	3	tyrol	Car	14	August	FiveStars	Aparthotel Hopfgarten.
507	Journey507	507	Wandering	449	3	tyrol	Car	7	May	HolidayFlat	H.Flat Tyrol.
508	Journey508	508	Wandering	654	5	tyrol	Car	7	June	HolidayFlat	H.Flat Tyrol.
509	Journey509	509	Wandering	539	4	tyrol	Car	7	July	HolidayFlat	H.Flat Tyrol.
510	Journey510	510	Wandering	609	5	tyrol	Car	7	August	HolidayFlat	H.Flat Tyrol.
511	Journey511	511	Wandering	484	2	tyrol	Car	7	September	HolidayFlat	H.Flat Tyrol.
512	Journey512	512	Wandering	789	6	tyrol	Car	7	August	HolidayFlat	H.Flat Tyrol.
513	Journey513	513	Wandering	838	3	tyrol	Car	14	July	HolidayFlat	H.Flat Tyrol.
514	Journey514	514	Wandering	728	2	tyrol	Car	14	June	HolidayFlat	H.Flat Tyrol.
515	Journey515	515	Recreation	729	5	tyrol	Car	7	May	HolidayFlat	H.Flat Tyrol.
516	Journey516	516	Recreation	849	6	tyrol	Car	7	June	HolidayFlat	H.Flat Tyrol.
517	Journey517	517	Recreation	494	3	tyrol	Car	7	July	HolidayFlat	H.Flat Tyrol.
518	Journey518	518	Recreation	599	5	tyrol	Car	7	August	HolidayFlat	H.Flat Tyrol.
519	Journey519	519	Recreation	688	2	tyrol	Car	14	September	HolidayFlat	H.Flat Tyrol.
520	Journey520	520	Active	789	7	tyrol	Car	7	June	HolidayFlat	H.Flat Tyrol.
521	Journey521	521	Active	1538	4	tyrol	Car	14	July	HolidayFlat	H.Flat Tyrol.
522	Journey522	522	Bathing	2518	2	algarve	Plane	14	May	TwoStars	Anlage Aldeia, Algarve.
523	Journey523	523	Bathing	2562	3	algarve	Plane	14	June	TwoStars	Anlage Aldeia, Algarve.
524	Journey524	524	Active	2371	3	algarve	Plane	7	July	TwoStars	Anlage Aldeia, Algarve.
525	Journey525	525	Bathing	3271	3	algarve	Plane	21	September	ThreeStars	Hotel Tropico, Algarve.
526	Journey526	526	Bathing	3398	2	algarve	Plane	14	August	ThreeStars	Hotel Tropico, Algarve.
527	Journey527	527	Bathing	2998	2	algarve	Plane	14	June	ThreeStars	Hotel Tropico, Algarve.
528	Journey528	528	Bathing	4253	4	algarve	Plane	7	July	ThreeStars	Hotel California, Algarve.
529	Journey529	529	Bathing	3758	2	algarve	Plane	14	September	ThreeStars	Hotel California, Algarve.
530	Journey530	530	Active	4885	3	algarve	Plane	14	June	ThreeStars	Hotel California, Algarve.
531	Journey531	531	Active	3958	2	algarve	Plane	21	May	ThreeStars	Hotel California, Algarve.
532	Journey532	532	Active	2678	2	algarve	Plane	7	July	ThreeStars	Eurotel Altura, Algarve.
533	Journey533	533	Recreation	3078	2	algarve	Plane	14	April	ThreeStars	Eurotel Altura, Algarve.
534	Journey534	534	Recreation	2158	2	algarve	Plane	7	October	ThreeStars	Eurotel Altura, Algarve.
535	Journey535	535	Bathing	3642	3	algarve	Plane	14	July	FourStars	Hotel Neptuno, Algarve.
536	Journey536	536	Active	4533	4	algarve	Plane	14	August	FourStars	Hotel Neptuno, Algarve.
537	Journey537	537	Bathing	3518	2	madeira	Plane	14	June	TwoStars	Anlage Canico, Madeira.
538	Journey538	538	Bathing	3440	3	madeira	Plane	14	July	TwoStars	Anlage Canico, Madeira.
539	Journey539	539	Bathing	4126	3	madeira	Plane	21	August	TwoStars	Anlage Canico, Madeira.
540	Journey540	540	Active	3518	2	madeira	Plane	14	September	TwoStars	Anlage Canico, Madeira.
541	Journey541	541	Bathing	3238	2	madeira	Plane	14	June	ThreeStars	Hotel Mimosa, Madeira.
542	Journey542	542	Bathing	4091	4	madeira	Plane	7	July	ThreeStars	Hotel Mimosa, Madeira.
543	Journey543	543	Bathing	4452	3	madeira	Plane	21	September	ThreeStars	Hotel Mimosa, Madeira.
544	Journey544	544	Active	3598	2	madeira	Plane	14	August	ThreeStars	Hotel Orca Praia, Madeira.
545	Journey545	545	Active	4438	2	madeira	Plane	21	September	ThreeStars	Hotel Orca Praia, Madeira.
546	Journey546	546	Recreation	4318	2	madeira	Plane	21	May	ThreeStars	Hotel Orca Praia, Madeira.
547	Journey547	547	Recreation	3318	2	madeira	Plane	14	October	ThreeStars	Hotel Orca Praia, Madeira.
548	Journey548	548	Bathing	2922	3	madeira	Plane	7	July	FourStars	Hotel Raga, Madeira.
549	Journey549	549	Bathing	5225	4	madeira	Plane	14	August	FourStars	Hotel Raga, Madeira.
550	Journey550	550	Active	3989	2	madeira	Plane	14	June	FourStars	Hotel Oasis Atlantic, Madeira.
551	Journey551	551	Active	3897	3	madeira	Plane	7	July	FourStars	Hotel Oasis Atlantic, Madeira.
552	Journey552	552	Recreation	469	4	sweden	Car	7	June	HolidayFlat	H.Flat Sweden.
553	Journey553	553	Recreation	799	6	sweden	Car	7	July	HolidayFlat	H.Flat Sweden.
554	Journey554	554	Recreation	519	5	sweden	Car	7	August	HolidayFlat	H.Flat Sweden.
555	Journey555	555	Recreation	539	4	sweden	Car	7	September	HolidayFlat	H.Flat Sweden.
556	Journey556	556	Recreation	989	6	sweden	Car	7	October	HolidayFlat	H.Flat Sweden.
557	Journey557	557	Recreation	649	6	sweden	Car	7	August	HolidayFlat	H.Flat Sweden.
558	Journey558	558	Recreation	779	4	sweden	Car	7	July	HolidayFlat	H.Flat Sweden.
559	Journey559	559	Recreation	1578	4	sweden	Car	14	June	HolidayFlat	H.Flat Sweden.
560	Journey560	560	Recreation	1538	4	sweden	Car	14	July	HolidayFlat	H.Flat Sweden.
561	Journey561	561	Recreation	1318	4	sweden	Car	14	August	HolidayFlat	H.Flat Sweden.
562	Journey562	562	Recreation	1178	6	sweden	Car	14	September	HolidayFlat	H.Flat Sweden.
563	Journey563	563	Wandering	639	6	sweden	Car	7	June	HolidayFlat	H.Flat Sweden.
564	Journey564	564	Wandering	799	6	sweden	Car	7	July	HolidayFlat	H.Flat Sweden.
565	Journey565	565	Wandering	789	4	sweden	Car	7	August	HolidayFlat	H.Flat Sweden.
566	Journey566	566	Wandering	938	4	sweden	Car	14	September	HolidayFlat	H.Flat Sweden.
567	Journey567	567	Wandering	764	3	alps	Car	7	May	HolidayFlat	H.Flat Switzerland.
568	Journey568	568	Wandering	494	2	alps	Car	7	June	HolidayFlat	H.Flat Switzerland.
569	Journey569	569	Wandering	989	6	alps	Car	7	July	HolidayFlat	H.Flat Switzerland.
570	Journey570	570	Wandering	799	4	alps	Car	7	August	HolidayFlat	H.Flat Switzerland.
571	Journey571	571	Wandering	839	2	alps	Car	7	September	HolidayFlat	H.Flat Switzerland.
572	Journey572	572	Wandering	799	3	alps	Car	7	June	HolidayFlat	H.Flat Switzerland.
573	Journey573	573	Wandering	779	6	alps	Car	7	July	HolidayFlat	H.Flat Switzerland.
574	Journey574	574	Wandering	529	4	alps	Car	7	August	HolidayFlat	H.Flat Switzerland.
575	Journey575	575	Wandering	858	3	alps	Car	14	September	HolidayFlat	H.Flat Switzerland.
576	Journey576	576	Wandering	1303	4	alps	Car	14	June	HolidayFlat	H.Flat Switzerland.
577	Journey577	577	Wandering	738	6	alps	Car	14	May	HolidayFlat	H.Flat Switzerland.
578	Journey578	578	Wandering	908	2	alps	Car	14	July	HolidayFlat	H.Flat Switzerland.
579	Journey579	579	Recreation	729	3	alps	Car	7	May	HolidayFlat	H.Flat Switzerland.
580	Journey580	580	Recreation	779	6	alps	Car	7	June	HolidayFlat	H.Flat Switzerland.
581	Journey581	581	Recreation	519	4	alps	Car	7	July	HolidayFlat	H.Flat Switzerland.
582	Journey582	582	Recreation	1184	4	alps	Car	7	August	HolidayFlat	H.Flat Switzerland.
583	Journey583	583	Recreation	629	2	alps	Car	7	September	HolidayFlat	H.Flat Switzerland.
584	Journey584	584	Recreation	858	3	alps	Car	14	June	HolidayFlat	H.Flat Switzerland.
585	Journey585	585	Recreation	1298	4	alps	Car	14	July	HolidayFlat	H.Flat Switzerland.
586	Journey586	586	Recreation	1958	6	alps	Car	14	August	HolidayFlat	H.Flat Switzerland.
587	Journey587	587	Bathing	1317	4	costa blanca	Car	7	August	TwoStars	Hotel Torre Dorada, Costa Blanca.
588	Journey588	588	Bathing	2800	3	costa blanca	Car	14	July	ThreeStars	Hotel Galetamar, Costa Blanca.
589	Journey589	589	Bathing	1058	2	costa blanca	Car	7	August	FourStars	Hotel Roca Esmeralda, Costa Blanca.
590	Journey590	590	Bathing	3222	3	costa blanca	Car	14	July	FourStars	Hotel Roca Esmeralda, Costa Blanca.
591	Journey591	591	Recreation	1014	10	costa blanca	Car	7	May	HolidayFlat	H.Flat Costa Blanca.
592	Journey592	592	Recreation	539	4	costa blanca	Car	14	June	HolidayFlat	H.Flat Costa Blanca.
593	Journey593	593	Active	1039	6	costa blanca	Car	7	July	HolidayFlat	H.Flat Costa Blanca.
594	Journey594	594	Active	678	4	costa blanca	Car	14	September	HolidayFlat	H.Flat Costa Blanca.
595	Journey595	595	Bathing	1039	8	costa blanca	Car	7	June	HolidayFlat	H.Flat Costa Blanca.
596	Journey596	596	Bathing	2324	12	costa blanca	Car	7	July	HolidayFlat	H.Flat Costa Blanca.
597	Journey597	597	Bathing	1229	2	costa blanca	Car	7	August	HolidayFlat	H.Flat Costa Blanca.
598	Journey598	598	Bathing	789	5	costa blanca	Car	7	September	HolidayFlat	H.Flat Costa Blanca.
599	Journey599	599	Bathing	649	3	costa blanca	Car	7	July	HolidayFlat	H.Flat Costa Blanca.
600	Journey600	600	Bathing	1259	3	costa blanca	Car	7	August	HolidayFlat	H.Flat Costa Blanca.
601	Journey601	601	Bathing	1038	4	costa blanca	Car	14	June	HolidayFlat	H.Flat Costa Blanca.
602	Journey602	602	Bathing	1798	4	costa blanca	Car	14	July	HolidayFlat	H.Flat Costa Blanca.
603	Journey603	603	Bathing	2038	8	costa blanca	Car	14	September	HolidayFlat	H.Flat Costa Blanca.
604	Journey604	604	Bathing	1998	2	costa brava	Car	14	June	TwoStars	Hotel La Huerta, Costa Brava.
605	Journey605	605	Bathing	2550	3	costa brava	Car	14	July	TwoStars	Hotel La Huerta, Costa Brava.
606	Journey606	606	Active	2696	3	costa brava	Car	21	August	TwoStars	Hotel Mar Eden, Costa Brava.
607	Journey607	607	Recreation	1558	2	costa brava	Car	7	September	TwoStars	Hotel Mar Eden, Costa Brava.
608	Journey608	608	Bathing	2518	2	costa brava	Car	14	June	ThreeStars	Hotel Surf Mar, Costa Brava.
609	Journey609	609	Bathing	6971	4	costa brava	Car	21	August	ThreeStars	Hotel Surf Mar, Costa Brava.
610	Journey610	610	Bathing	3099	3	costa brava	Car	14	July	ThreeStars	Hotel Surf Mar, Costa Brava.
611	Journey611	611	Bathing	1738	2	costa brava	Car	7	July	ThreeStars	Hotel Albatros, Costa Brava.
612	Journey612	612	Active	2198	2	costa brava	Car	14	June	ThreeStars	Hotel Albatros, Costa Brava.
613	Journey613	613	Recreation	2360	3	costa brava	Car	14	May	ThreeStars	Hotel Albatros, Costa Brava.
614	Journey614	614	Bathing	2186	3	costa brava	Car	7	July	FourStars	Hotel Olympic Park, Costa Brava.
615	Journey615	615	Bathing	2418	2	costa brava	Car	14	June	FourStars	Hotel Olympic Park, Costa Brava.
616	Journey616	616	Bathing	3737	3	costa brava	Car	14	August	FourStars	Hotel Olympic Park, Costa Brava.
617	Journey617	617	Active	3048	2	costa brava	Car	21	September	FourStars	Golden Hotel Port Salou, Costa Brava.
618	Journey618	618	Recreation	3912	4	costa brava	Car	14	July	FourStars	Golden Hotel Port Salou, Costa Brava.
619	Journey619	619	Bathing	3528	2	fuerteventura	Plane	14	May	ThreeStars	Hotel Oliva Beach, Fuerteventura.
620	Journey620	620	Bathing	4402	3	fuerteventura	Plane	14	June	ThreeStars	Hotel Oliva Beach, Fuerteventura.
621	Journey621	621	Bathing	6357	3	fuerteventura	Plane	21	July	ThreeStars	Hotel Oliva Beach, Fuerteventura.
622	Journey622	622	Bathing	3417	4	fuerteventura	Plane	14	August	ThreeStars	Appartm. Rio Tropical, Fuerteventura.
623	Journey623	623	Active	2598	2	fuerteventura	Plane	14	September	ThreeStars	Appartm. Rio Tropical, Fuerteventura.
624	Journey624	624	Active	2252	3	fuerteventura	Plane	7	July	ThreeStars	Appartm. Rio Tropical, Fuerteventura.
625	Journey625	625	Active	3678	2	fuerteventura	Plane	14	August	ThreeStars	Hotel Crystal Beach, Fuerteventura.
626	Journey626	626	Recreation	3578	2	fuerteventura	Plane	14	June	ThreeStars	Hotel Crystal Beach, Fuerteventura.
627	Journey627	627	Bathing	7161	3	fuerteventura	Plane	21	June	FourStars	Hotel Rio Ventura, Fuerteventura.
628	Journey628	628	Bathing	5709	3	fuerteventura	Plane	14	July	FourStars	Hotel Rio Ventura, Fuerteventura.
629	Journey629	629	Bathing	6369	4	fuerteventura	Plane	14	August	FourStars	Hotel Rio Ventura, Fuerteventura.
630	Journey630	630	Bathing	3188	2	fuerteventura	Plane	7	June	FourStars	Hotel Rio Ventura, Fuerteventura.
631	Journey631	631	Active	3428	2	fuerteventura	Plane	14	September	FourStars	Hotel Rio Maxarota, Fuerteventura.
632	Journey632	632	Active	4602	3	fuerteventura	Plane	14	July	FourStars	Hotel Rio Maxarota, Fuerteventura.
633	Journey633	633	Recreation	3188	2	fuerteventura	Plane	14	May	FourStars	Hotel Rio Maxarota, Fuerteventura.
634	Journey634	634	Bathing	2412	3	gran canaria	Plane	14	May	TwoStars	Studios Puerto Plata, Gran Canaria.
635	Journey635	635	Bathing	3125	3	gran canaria	Plane	21	July	TwoStars	Studios Puerto Plata, Gran Canaria.
636	Journey636	636	Bathing	2378	2	gran canaria	Plane	14	September	TwoStars	Studios Brisamar, Gran Canaria.
637	Journey637	637	Active	3177	4	gran canaria	Plane	14	August	TwoStars	Studios Brisamar, Gran Canaria.
638	Journey638	638	Bathing	2788	2	gran canaria	Plane	14	May	ThreeStars	Hotel Riosol, Gran Canaria.
639	Journey639	639	Bathing	4100	3	gran canaria	Plane	21	June	ThreeStars	Hotel Riosol, Gran Canaria.
640	Journey640	640	Bathing	2723	3	gran canaria	Plane	7	July	ThreeStars	Hotel Caserio, Gran Canaria.
641	Journey641	641	Active	4261	3	gran canaria	Plane	14	August	ThreeStars	IFA Beach Hotel, Gran Canaria.
642	Journey642	642	Active	3778	2	gran canaria	Plane	21	September	ThreeStars	IFA Beach Hotel, Gran Canaria.
643	Journey643	643	Recreation	2508	2	gran canaria	Plane	7	August	ThreeStars	IFA Beach Hotel, Gran Canaria.
644	Journey644	644	Bathing	3258	2	gran canaria	Plane	14	June	FourStars	Hotel Las Margaritas, Gran Canaria.
645	Journey645	645	Bathing	4252	3	gran canaria	Plane	14	July	FourStars	Hotel Las Margaritas, Gran Canaria.
646	Journey646	646	Bathing	3498	2	gran canaria	Plane	21	September	FourStars	Hotel Caserio, Gran Canaria.
647	Journey647	647	Active	2848	2	gran canaria	Plane	14	May	FourStars	Hotel Caserio, Gran Canaria.
648	Journey648	648	Active	3551	3	gran canaria	Plane	14	August	FourStars	Hotel Caserio, Gran Canaria.
649	Journey649	649	Bathing	2078	2	ibiza	Plane	14	June	TwoStars	Pension Central, Ibiza.
650	Journey650	650	Bathing	2498	2	ibiza	Plane	21	September	TwoStars	Pension Central, Ibiza.
651	Journey651	651	Bathing	2427	3	ibiza	Plane	14	July	TwoStars	Hotel Llevant, Ibiza.
652	Journey652	652	Active	2852	4	ibiza	Plane	14	August	TwoStars	Hotel Llevant, Ibiza.
653	Journey653	653	Active	1995	3	ibiza	Plane	7	July	TwoStars	Hotel Llevant, Ibiza.
654	Journey654	654	Bathing	2798	2	ibiza	Plane	14	June	ThreeStars	Hotel Helios II, Ibiza.
655	Journey655	655	Bathing	2878	2	ibiza	Plane	14	July	ThreeStars	Hotel Helios II, Ibiza.
656	Journey656	656	Bathing	3258	2	ibiza	Plane	21	May	ThreeStars	Hotel Helios II, Ibiza.
657	Journey657	657	Bathing	2343	3	ibiza	Plane	7	August	ThreeStars	Hotel Atlantic, Ibiza.
658	Journey658	658	Bathing	3217	3	ibiza	Plane	14	June	ThreeStars	Hotel Atlantic, Ibiza.
659	Journey659	659	Active	4832	4	ibiza	Plane	14	July	ThreeStars	Hotel Atlantic, Ibiza.
660	Journey660	660	Active	3558	2	ibiza	Plane	21	September	ThreeStars	Hotel Atlantic, Ibiza.
661	Journey661	661	Bathing	4398	2	ibiza	Plane	14	June	FourStars	Club La Mola, Ibiza.
662	Journey662	662	Bathing	4958	2	ibiza	Plane	14	July	FourStars	Club La Mola, Ibiza.
663	Journey663	663	Active	2090	3	ibiza	Plane	7	August	FourStars	Hotel Nereida, Ibiza.
664	Journey664	664	Bathing	1558	2	mallorca	Plane	14	June	OneStar	Pension Marina, Mallorca.
665	Journey665	665	Bathing	2397	3	mallorca	Plane	14	July	OneStar	Pension Marina, Mallorca.
666	Journey666	666	Bathing	2481	2	mallorca	Plane	21	September	OneStar	Pension El Golea, Mallorca.
667	Journey667	667	Bathing	1718	2	mallorca	Plane	14	June	TwoStars	Pension Alcina, Mallorca.
668	Journey668	668	Bathing	2410	4	mallorca	Plane	7	August	TwoStars	Pension Alcina, Mallorca.
669	Journey669	669	Recreation	1285	3	mallorca	Plane	4	May	TwoStars	Hotel Manaus, Mallorca.
670	Journey670	670	Active	1798	2	mallorca	Plane	14	June	TwoStars	Hotel Vaquer, Mallorca.
671	Journey671	671	Wandering	1676	3	mallorca	Plane	7	September	TwoStars	Hotel Vaquer, Mallorca.
672	Journey672	672	Bathing	2198	2	mallorca	Plane	14	June	ThreeStars	Hotel Samu, Mallorca.
673	Journey673	673	Bathing	3530	4	mallorca	Plane	14	July	ThreeStars	Hotel Samu, Mallorca.
674	Journey674	674	Bathing	1607	3	mallorca	Plane	4	August	ThreeStars	Hotel Flamingo, Mallorca.
675	Journey675	675	Bathing	3697	3	mallorca	Plane	14	July	ThreeStars	Hotel Sol Lux, Mallorca.
676	Journey676	676	Bathing	1858	2	mallorca	Plane	7	August	ThreeStars	Hotel Sol Lux, Mallorca.
677	Journey677	677	Bathing	2598	3	mallorca	Plane	14	September	ThreeStars	Hotel Saturno, Mallorca.
678	Journey678	678	Active	3058	2	mallorca	Plane	21	May	ThreeStars	Hotel Saturno, Mallorca.
679	Journey679	679	Bathing	1478	2	mallorca	Plane	4	June	FourStars	Hotel Gran Fiesta, Mallorca.
680	Journey680	680	Bathing	3644	4	mallorca	Plane	7	July	FourStars	Anlage Lago Playa, Mallorca.
681	Journey681	681	Bathing	3605	3	mallorca	Plane	14	August	FourStars	Anlage Lago Playa, Mallorca.
682	Journey682	682	Active	2678	2	mallorca	Plane	14	June	FourStars	Lagotel-Club, Mallorca.
683	Journey683	683	Active	1898	2	mallorca	Plane	7	September	FourStars	Lagotel-Club, Mallorca.
684	Journey684	684	Bathing	3417	3	teneriffe	Plane	14	June	TwoStars	Studios Mare Verde, Teneriffe.
685	Journey685	685	Bathing	2698	2	teneriffe	Plane	21	September	TwoStars	Studios Mare Verde, Teneriffe.
686	Journey686	686	Bathing	3837	3	teneriffe	Plane	14	July	ThreeStars	Appartm. Parque Royal, Teneriffe.
687	Journey687	687	Bathing	3507	4	teneriffe	Plane	14	August	ThreeStars	Appartm. Parque Royal, Teneriffe.
688	Journey688	688	Bathing	2278	2	teneriffe	Plane	14	June	ThreeStars	Appartm. Parque Royal, Teneriffe.
746	Journey746	746	Recreation	2058	2	tunisia	Plane	14	May	TwoStars	Hotel-Club Ramses, Tunisia.
689	Journey689	689	Bathing	3194	3	teneriffe	Plane	14	August	ThreeStars	Hotel Las Pyramides, Teneriffe.
690	Journey690	690	Bathing	2858	2	teneriffe	Plane	14	July	ThreeStars	Hotel Las Pyramides, Teneriffe.
691	Journey691	691	Bathing	2068	2	teneriffe	Plane	7	May	ThreeStars	Hotel Las Pyramides, Teneriffe.
692	Journey692	692	Active	3278	2	teneriffe	Plane	21	June	ThreeStars	Hotel Internacional, Teneriffe.
693	Journey693	693	Recreation	2178	2	teneriffe	Plane	7	October	ThreeStars	Hotel Internacional, Teneriffe.
694	Journey694	694	Bathing	4011	3	teneriffe	Plane	14	August	FourStars	Hotel Sol, Teneriffe.
695	Journey695	695	Bathing	4287	3	teneriffe	Plane	14	July	FourStars	Hotel Sol, Teneriffe.
696	Journey696	696	Bathing	2488	2	teneriffe	Plane	7	June	FourStars	Hotel Sol, Teneriffe.
697	Journey697	697	Active	5532	4	teneriffe	Plane	14	August	FourStars	Hotel Florida, Teneriffe.
698	Journey698	698	Active	4810	3	teneriffe	Plane	21	May	FourStars	Hotel Florida, Teneriffe.
699	Journey699	699	Wandering	758	2	giant mountains	Car	7	May	TwoStars	Hotel Bedrichov, Giant Mountains.
700	Journey700	700	Wandering	858	2	giant mountains	Car	7	June	TwoStars	Hotel Bedrichov, Giant Mountains.
701	Journey701	701	Wandering	1118	4	giant mountains	Car	7	July	TwoStars	Hotel Energetik, Giant Mountains.
702	Journey702	702	Wandering	1698	3	giant mountains	Car	14	August	TwoStars	Hotel Energetik, Giant Mountains.
703	Journey703	703	Wandering	1138	2	giant mountains	Car	14	September	TwoStars	Hotel Karolina, Giant Mountains.
704	Journey704	704	Recreation	798	2	giant mountains	Car	7	August	TwoStars	Hotel Karolina, Giant Mountains.
705	Journey705	705	Recreation	678	3	giant mountains	Car	7	July	TwoStars	Waldhotel Trakce, Giant Mountains.
706	Journey706	706	Recreation	938	2	giant mountains	Car	7	June	ThreeStars	Hotel Arnika, Giant Mountains.
707	Journey707	707	Recreation	1498	2	giant mountains	Car	14	May	ThreeStars	Hotel Arnika, Giant Mountains.
708	Journey708	708	Wandering	698	2	giant mountains	Car	7	June	ThreeStars	Hotel Horal, Giant Mountains.
709	Journey709	709	Wandering	1806	3	giant mountains	Car	14	September	ThreeStars	Hotel Horal, Giant Mountains.
710	Journey710	710	Wandering	807	3	giant mountains	Coach	7	May	TwoStars	Hotel Bedrichov, Giant Mountains.
711	Journey711	711	Recreation	2274	4	giant mountains	Coach	14	June	TwoStars	Hotel Bedrichov, Giant Mountains.
712	Journey712	712	Recreation	1185	3	giant mountains	Train	7	August	ThreeStars	Hotel Horal, Giant Mountains.
713	Journey713	713	Wandering	698	2	giant mountains	Train	7	September	ThreeStars	Hotel Horal, Giant Mountains.
714	Journey714	714	Bathing	2178	2	turkish aegean sea	Plane	14	June	TwoStars	Hotel Villa Soel, Turk. Aegean Sea.
715	Journey715	715	Bathing	2483	3	turkish aegean sea	Plane	14	July	TwoStars	Hotel Villa Soel, Turk. Aegean Sea.
716	Journey716	716	Bathing	4770	4	turkish aegean sea	Plane	21	August	ThreeStars	Hotel Alinda, Turk. Aegean Sea.
717	Journey717	717	Active	2578	2	turkish aegean sea	Plane	14	September	ThreeStars	Hotel Alinda, Turk. Aegean Sea.
718	Journey718	718	Active	3065	3	turkish aegean sea	Plane	7	July	ThreeStars	Hotel Turunc, Turk. Aegean Sea.
719	Journey719	719	Bathing	2758	2	turkish aegean sea	Plane	14	August	ThreeStars	Hotel Turunc, Turk. Aegean Sea.
720	Journey720	720	Education	2878	2	turkish aegean sea	Plane	14	May	FourStars	Hotel Marti, Turk. Aegean Sea.
721	Journey721	721	Bathing	1958	2	turkish aegean sea	Plane	14	June	TwoStars	Hotel Talat, Turk. Aegean Sea.
722	Journey722	722	Bathing	3171	3	turkish aegean sea	Plane	14	July	ThreeStars	Club Pigale, Turk. Aegean Sea.
723	Journey723	723	Bathing	2412	3	turkish aegean sea	Plane	7	August	ThreeStars	Club Pigale, Turk. Aegean Sea.
724	Journey724	724	Bathing	2878	2	turkish aegean sea	Plane	14	September	ThreeStars	Hotel Batihan, Turk. Aegean Sea.
725	Journey725	725	Education	3278	2	turkish aegean sea	Plane	21	May	ThreeStars	Hotel Batihan, Turk. Aegean Sea.
726	Journey726	726	Bathing	4313	4	turkish aegean sea	Plane	14	August	FourStars	Hotel Biltur, Turk. Aegean Sea.
727	Journey727	727	Bathing	3010	3	turkish aegean sea	Plane	7	July	FourStars	Hotel Biltur, Turk. Aegean Sea.
728	Journey728	728	Active	2918	2	turkish aegean sea	Plane	14	June	FourStars	Club Ephesus Princess, Turk. Aegean Sea.
729	Journey729	729	Bathing	2298	2	turkish riviera	Plane	14	June	TwoStars	Hotel Alaiye, Turk. Riviera.
730	Journey730	730	Bathing	2941	3	turkish riviera	Plane	14	July	TwoStars	Hotel Alaiye, Turk. Riviera.
731	Journey731	731	Active	3160	3	turkish riviera	Plane	21	September	TwoStars	Hotel Alaiye, Turk. Riviera.
732	Journey732	732	Bathing	4107	4	turkish riviera	Plane	14	August	ThreeStars	Hotel Panorama, Turk. Riviera.
733	Journey733	733	Bathing	2838	2	turkish riviera	Plane	14	July	ThreeStars	Hotel Panorama, Turk. Riviera.
734	Journey734	734	Bathing	2738	2	turkish riviera	Plane	14	June	ThreeStars	Hotel Panorama, Turk. Riviera.
735	Journey735	735	Bathing	2258	2	turkish riviera	Plane	7	August	ThreeStars	Hotel Akropol, Turk. Riviera.
736	Journey736	736	Bathing	3891	3	turkish riviera	Plane	21	June	ThreeStars	Hotel Akropol, Turk. Riviera.
737	Journey737	737	Active	3058	2	turkish riviera	Plane	14	September	ThreeStars	Hotel Sueral Garden, Turk. Riviera.
738	Journey738	738	Education	2698	2	turkish riviera	Plane	14	May	ThreeStars	Hotel Sueral Garden, Turk. Riviera.
739	Journey739	739	Bathing	3258	2	turkish riviera	Plane	14	June	FourStars	Hotel Botanik, Turk. Riviera.
740	Journey740	740	Bathing	3325	3	turkish riviera	Plane	7	July	FourStars	Hotel Botanik, Turk. Riviera.
741	Journey741	741	Bathing	3258	3	turkish riviera	Plane	14	September	FourStars	Hotel Botanik, Turk. Riviera.
742	Journey742	742	Active	2898	2	turkish riviera	Plane	14	May	FourStars	Hotel Sueral, Turk. Riviera.
743	Journey743	743	Education	2498	2	turkish riviera	Plane	14	October	FourStars	Hotel Sueral, Turk. Riviera.
744	Journey744	744	Bathing	2778	3	tunisia	Plane	14	July	TwoStars	Hotel Solymar, Tunisia.
745	Journey745	745	Bathing	1778	2	tunisia	Plane	14	June	TwoStars	Hotel Solymar, Tunisia.
747	Journey747	747	Active	2637	3	tunisia	Plane	14	September	TwoStars	Hotel-Club Ramses, Tunisia.
748	Journey748	748	Bathing	4114	3	tunisia	Plane	14	June	ThreeStars	Hotel Montazah, Tunisia.
749	Journey749	749	Bathing	3464	4	tunisia	Plane	7	July	ThreeStars	Hotel Montazah, Tunisia.
750	Journey750	750	Bathing	3203	3	tunisia	Plane	14	August	ThreeStars	Hotel-Club Nador, Tunisia.
751	Journey751	751	Recreation	2768	2	tunisia	Plane	21	June	ThreeStars	Hotel-Club Nador, Tunisia.
752	Journey752	752	Recreation	2258	2	tunisia	Plane	14	May	ThreeStars	Hotel Aqua Viva, Tunisia.
753	Journey753	753	Active	2964	3	tunisia	Plane	14	September	ThreeStars	Hotel Aqua Viva, Tunisia.
754	Journey754	754	Bathing	2808	2	tunisia	Plane	14	June	FourStars	Hotel Paradise, Tunisia.
755	Journey755	755	Bathing	4773	4	tunisia	Plane	14	July	FourStars	Hotel Paradise, Tunisia.
756	Journey756	756	Recreation	1888	2	tunisia	Plane	14	May	FourStars	Hotel Royal Golf, Tunisia.
757	Journey757	757	Bathing	2228	2	tunisia	Plane	7	June	FourStars	Hotel Royal Golf, Tunisia.
758	Journey758	758	Active	2898	2	tunisia	Plane	14	August	FourStars	Hotel Jockey Club, Tunisia.
759	Journey759	759	Active	2879	3	tunisia	Plane	14	September	FourStars	Hotel Jockey Club, Tunisia.
760	Journey760	760	Bathing	3537	4	balaton	Car	14	July	ThreeStars	Hotel Marina, Balaton.
761	Journey761	761	Bathing	2447	3	balaton	Car	21	August	ThreeStars	Hotel Marina, Balaton.
762	Journey762	762	Bathing	2758	3	balaton	Car	14	July	FourStars	Hotel Helikon, Balaton.
763	Journey763	763	Recreation	2758	2	balaton	Car	14	June	FourStars	Hotel Helikon, Balaton.
764	Journey764	764	Bathing	879	9	balaton	Car	7	June	HolidayFlat	H.Flat Balaton.
765	Journey765	765	Bathing	759	5	balaton	Car	7	July	HolidayFlat	H.Flat Balaton.
766	Journey766	766	Bathing	798	2	balaton	Car	14	August	HolidayFlat	H.Flat Balaton.
767	Journey767	767	Recreation	658	3	balaton	Car	14	May	HolidayFlat	H.Flat Balaton.
768	Journey768	768	Recreation	279	2	balaton	Car	7	June	HolidayFlat	H.Flat Balaton.
769	Journey769	769	Active	1498	7	balaton	Car	14	September	HolidayFlat	H.Flat Balaton.
770	Journey770	770	Recreation	434	2	belgium	Car	7	November	HolidayFlat	Ferienpark Atlantis, Belgium.
771	Journey771	771	Recreation	434	3	belgium	Car	7	December	HolidayFlat	Ferienpark Atlantis, Belgium.
772	Journey772	772	Recreation	739	4	belgium	Car	14	February	HolidayFlat	Ferienpark Atlantis, Belgium.
773	Journey773	773	Active	434	2	belgium	Car	7	November	HolidayFlat	Ferienpark Atlantis, Belgium.
774	Journey774	774	Active	1068	4	belgium	Car	14	March	HolidayFlat	Ferienpark Atlantis, Belgium.
775	Journey775	775	Recreation	314	2	belgium	Car	3	November	HolidayFlat	Ferienpark Atlantis, Belgium.
776	Journey776	776	Active	394	6	belgium	Car	4	January	HolidayFlat	Ferienpark Atlantis, Belgium.
777	Journey777	777	Recreation	649	4	belgium	Car	7	November	HolidayFlat	SunParks De Haan,Belgium.
778	Journey778	778	Active	879	8	belgium	Car	7	December	HolidayFlat	SunParks De Haan,Belgium.
779	Journey779	779	Recreation	719	6	belgium	Car	7	January	HolidayFlat	SunParks De Haan,Belgium.
780	Journey780	780	Active	369	4	belgium	Car	4	December	HolidayFlat	SunParks De Haan,Belgium.
781	Journey781	781	Recreation	849	3	belgium	Car	7	February	HolidayFlat	SunParks Groendyk, Belgium.
782	Journey782	782	Active	649	6	belgium	Car	7	November	HolidayFlat	SunParks Groendyk, Belgium.
783	Journey783	783	Recreation	339	5	belgium	Car	4	February	HolidayFlat	SunParks Groendyk, Belgium.
784	Journey784	784	Recreation	1338	4	belgium	Car	14	January	HolidayFlat	SunParks Rauwse Meren, Belgium.
785	Journey785	785	Active	959	5	belgium	Car	7	February	HolidayFlat	SunParks Rauwse Meren, Belgium.
786	Journey786	786	Active	499	4	belgium	Car	3	December	HolidayFlat	SunParks Rauwse Meren, Belgium.
787	Journey787	787	Recreation	649	4	belgium	Car	7	March	HolidayFlat	SunParks Vielsalm, Belgium.
788	Journey788	788	Active	919	8	belgium	Car	7	November	HolidayFlat	SunParks Vielsalm, Belgium.
789	Journey789	789	Recreation	619	6	belgium	Car	4	March	HolidayFlat	SunParks Vielsalm, Belgium.
790	Journey790	790	Recreation	699	2	denmark	Car	7	November	HolidayFlat	Ferienpark Lalandia, Denmark.
791	Journey791	791	Recreation	699	3	denmark	Car	7	December	HolidayFlat	Ferienpark Lalandia, Denmark.
792	Journey792	792	Active	439	4	denmark	Car	4	January	HolidayFlat	Ferienpark Lalandia, Denmark.
793	Journey793	793	Recreation	639	4	denmark	Car	7	February	HolidayFlat	Feriencenter Rodhus Klit, Denmark.
794	Journey794	794	Active	639	5	denmark	Car	7	March	HolidayFlat	Feriencenter Rodhus Klit, Denmark.
795	Journey795	795	Active	1278	4	denmark	Car	14	November	HolidayFlat	Feriencenter Rodhus Klit, Denmark.
796	Journey796	796	Recreation	629	4	denmark	Car	7	February	HolidayFlat	Feriencenter Vigso, Denmark.
797	Journey797	797	Active	629	6	denmark	Car	7	January	HolidayFlat	Feriencenter Vigso, Denmark.
798	Journey798	798	Recreation	509	4	denmark	Car	7	March	HolidayFlat	Feriencenter Danland, Denmark.
799	Journey799	799	Active	889	8	denmark	Car	7	February	HolidayFlat	Feriencenter Danland, Denmark.
800	Journey800	800	Recreation	579	2	denmark	Car	7	January	HolidayFlat	H.Flat Ronbjerg Strand, Denmark.
801	Journey801	801	Recreation	719	4	denmark	Car	7	February	HolidayFlat	H.Flat Ronbjerg Strand, Denmark.
802	Journey802	802	Active	1638	6	denmark	Car	14	March	HolidayFlat	H.Flat Ronbjerg Strand, Denmark.
803	Journey803	803	Recreation	849	4	fano	Car	7	January	HolidayFlat	Ferienpark Fano, Denmark.
804	Journey804	804	Active	1089	6	fano	Car	7	March	HolidayFlat	Ferienpark Fano, Denmark.
805	Journey805	805	Recreation	499	3	holland	Car	7	November	HolidayFlat	Ferienpark Port Greve, Holland.
806	Journey806	806	Recreation	529	4	holland	Car	7	December	HolidayFlat	Ferienpark Port Greve, Holland.
807	Journey807	807	Active	609	6	holland	Car	7	February	HolidayFlat	Ferienpark Port Greve, Holland.
808	Journey808	808	Recreation	354	4	holland	Car	3	January	HolidayFlat	Ferienpark Port Greve, Holland.
809	Journey809	809	Active	339	2	holland	Car	4	November	HolidayFlat	Ferienpark Port Greve, Holland.
810	Journey810	810	Active	538	2	poland	Car	7	January	ThreeStars	Hotel Maurizius, Poland.
811	Journey811	811	Skiing	822	3	poland	Car	7	February	ThreeStars	Hotel Maurizius, Poland.
812	Journey812	812	Recreation	1076	4	poland	Car	7	February	ThreeStars	Hotel Maurizius, Poland.
813	Journey813	813	Active	1602	3	poland	Car	14	January	TwoStars	Hotel Anna Maria, Poland.
814	Journey814	814	Skiing	558	2	poland	Car	7	February	TwoStars	Hotel Anna Maria, Poland.
815	Journey815	815	Recreation	807	4	poland	Car	7	March	TwoStars	Hotel Anna Maria, Poland.
816	Journey816	816	Active	898	2	poland	Car	14	January	TwoStars	Hotel Karolinka, Poland.
817	Journey817	817	Skiing	478	2	poland	Car	7	February	TwoStars	Hotel Karolinka, Poland.
818	Journey818	818	Recreation	687	3	poland	Car	7	March	TwoStars	Hotel Karolinka, Poland.
819	Journey819	819	Active	319	2	poland	Car	7	January	TwoStars	Hotel Ametyst, Poland.
820	Journey820	820	Skiing	1962	4	poland	Car	14	February	TwoStars	Hotel Ametyst, Poland.
821	Journey821	821	Recreation	329	2	poland	Car	7	February	TwoStars	Hotel Ametyst, Poland.
822	Journey822	822	Active	987	3	poland	Car	7	February	TwoStars	Hotel Piecuch, Poland.
823	Journey823	823	Skiing	638	2	poland	Car	7	March	TwoStars	Hotel Piecuch, Poland.
824	Journey824	824	Recreation	1276	4	poland	Car	7	January	TwoStars	Hotel Piecuch, Poland.
825	Journey825	825	Active	858	2	slowakei	Car	7	January	TwoStars	Hotel Banik, High Tatra.
826	Journey826	826	Skiing	1647	3	slowakei	Car	7	February	TwoStars	Hotel Banik, High Tatra.
827	Journey827	827	Active	1028	2	slowakei	Car	14	February	ThreeStars	Hotel Fis, High Tatra.
828	Journey828	828	Skiing	1098	2	slowakei	Car	7	March	ThreeStars	Hotel Fis, High Tatra.
829	Journey829	829	Skiing	1572	3	slowakei	Car	7	January	ThreeStars	Hotel Patria, High Tatra.
830	Journey830	830	Recreation	1738	2	slowakei	Car	7	February	ThreeStars	Hotel Patria, High Tatra.
831	Journey831	831	Active	3777	3	slowakei	Car	14	February	ThreeStars	Hotel Panorama, High Tatra.
832	Journey832	832	Skiing	1048	2	slowakei	Car	7	March	ThreeStars	Hotel Panorama, High Tatra.
833	Journey833	833	Skiing	598	2	slowakei	Car	7	January	ThreeStars	Hotel Hutnik, High Tatra.
834	Journey834	834	Active	1816	4	slowakei	Car	7	February	ThreeStars	Hotel Hutnik, High Tatra.
835	Journey835	835	Active	2097	3	slowakei	Car	7	February	ThreeStars	Hotel Slovakia, High Tatra.
836	Journey836	836	Recreation	1198	2	slowakei	Car	7	March	ThreeStars	Hotel Slovakia, High Tatra.
837	Journey837	837	Skiing	1257	3	slowakei	Car	14	March	TwoStars	Hotel Vesel, High Tatra.
838	Journey838	838	Recreation	2036	4	slowakei	Car	7	February	TwoStars	Hotel Vesel, High Tatra.
839	Journey839	839	Active	2334	6	slowakei	Car	14	February	TwoStars	Hotel Zornicka, High Tatra.
840	Journey840	840	Skiing	1795	5	slowakei	Car	7	January	TwoStars	Hotel Zornicka, High Tatra.
841	Journey841	841	Active	748	2	slowakei	Car	7	January	TwoStars	Hotel Sverma, High Tatra.
842	Journey842	842	Skiing	1497	3	slowakei	Car	7	February	TwoStars	Hotel Sverma, High Tatra.
843	Journey843	843	Skiing	1272	3	slowakei	Car	7	February	OneStar	Pension Bjoernson, High Tatra.
844	Journey844	844	Skiing	888	2	slowakei	Car	7	March	OneStar	Pension Bjoernson, High Tatra.
845	Journey845	845	Skiing	1152	4	czechia	Car	7	January	ThreeStars	Hotel Horal, Giant Mountains.
846	Journey846	846	Skiing	1414	3	czechia	Car	7	February	ThreeStars	Hotel Horal, Giant Mountains.
847	Journey847	847	Active	798	2	czechia	Car	14	March	ThreeStars	Hotel Horal, Giant Mountains.
848	Journey848	848	Skiing	698	2	czechia	Car	7	January	ThreeStars	Hotel Montana, Giant Mountains.
849	Journey849	849	Active	1372	3	czechia	Car	7	February	ThreeStars	Hotel Montana, Giant Mountains.
850	Journey850	850	Skiing	1737	3	czechia	Car	7	February	ThreeStars	Hotel Arnika, Giant Mountains.
851	Journey851	851	Skiing	998	2	czechia	Car	7	March	ThreeStars	Hotel Arnika, Giant Mountains.
852	Journey852	852	Recreation	1737	3	czechia	Car	14	January	ThreeStars	Hotel Arnika, Giant Mountains.
853	Journey853	853	Skiing	1596	4	czechia	Car	7	February	TwoStars	Hotel Energetik, Giant Mountains.
854	Journey854	854	Active	638	2	czechia	Car	7	March	TwoStars	Hotel Energetik, Giant Mountains.
855	Journey855	855	Skiing	897	3	czechia	Car	14	February	OneStar	Hotel Central, Giant Mountains.
856	Journey856	856	Active	458	2	czechia	Car	7	January	OneStar	Hotel Central, Giant Mountains.
857	Journey857	857	Skiing	698	2	czechia	Car	7	March	TwoStars	Berghotel Cubat, Giant Mountains.
858	Journey858	858	Skiing	1047	3	czechia	Car	7	February	TwoStars	Berghotel Cubat, Giant Mountains.
859	Journey859	859	Active	488	2	czechia	Car	7	January	OneStar	Pension Trakce, Giant Mountains.
860	Journey860	860	Recreation	1096	4	czechia	Car	7	February	OneStar	Pension Trakce, Giant Mountains.
861	Journey861	861	Skiing	458	2	czechia	Car	7	March	OneStar	Pension Protez, Giant Mountains.
862	Journey862	862	Recreation	1180	3	czechia	Car	14	February	OneStar	Pension Protez, Giant Mountains.
863	Journey863	863	Active	892	4	czechia	Car	7	January	OneStar	Hotel Sirena, Giant Mountains.
864	Journey864	864	Skiing	718	2	czechia	Car	7	February	OneStar	Hotel Sirena, Giant Mountains.
865	Journey865	865	Skiing	974	5	czechia	Car	7	March	HolidayFlat	H.Flat Giant Mountains.
866	Journey866	866	Skiing	974	3	czechia	Car	7	February	HolidayFlat	H.Flat Giant Mountains.
867	Journey867	867	Skiing	1108	4	czechia	Car	14	January	HolidayFlat	H.Flat Adlergebirge.
868	Journey868	868	Active	579	6	czechia	Car	7	March	HolidayFlat	H.Flat Bohemian Forest.
869	Journey869	869	Active	664	4	czechia	Car	7	February	HolidayFlat	H.Flat Bohemian Forest.
870	Journey870	870	Active	4332	4	allgaeu	Car	7	December	FiveStars	Hofgut Kuernach, Allgaeu.
871	Journey871	871	Skiing	1868	2	allgaeu	Car	7	January	FiveStars	Hofgut Kuernach, Allgaeu.
872	Journey872	872	Recreation	2428	3	allgaeu	Car	7	February	FiveStars	Hofgut Kuernach, Allgaeu.
873	Journey873	873	Active	1822	3	allgaeu	Car	14	March	ThreeStars	Hotel Alpenblick, Allgaeu.
874	Journey874	874	Skiing	1458	2	allgaeu	Car	7	February	ThreeStars	Hotel Alpenblick, Allgaeu.
875	Journey875	875	Skiing	1822	3	allgaeu	Car	7	January	ThreeStars	Hotel Alpenblick, Allgaeu.
876	Journey876	876	Active	2248	2	allgaeu	Car	7	December	FiveStars	Alpenhotel, Allgaeu.
877	Journey877	877	Skiing	2447	3	allgaeu	Car	7	January	FiveStars	Alpenhotel, Allgaeu.
878	Journey878	878	Recreation	2937	4	allgaeu	Car	7	February	FiveStars	Alpenhotel, Allgaeu.
879	Journey879	879	Active	1058	3	allgaeu	Car	14	March	TwoStars	Gaestehaus Meier, Allgaeu.
880	Journey880	880	Skiing	1587	4	allgaeu	Car	7	February	TwoStars	Gaestehaus Meier, Allgaeu.
881	Journey881	881	Recreation	688	2	allgaeu	Car	7	January	TwoStars	Gaestehaus Meier, Allgaeu.
882	Journey882	882	Skiing	530	4	allgaeu	Car	7	December	HolidayFlat	H.Flat Nadenberg, Allgaeu.
883	Journey883	883	Active	645	8	allgaeu	Car	7	January	HolidayFlat	H.Flat Nadenberg, Allgaeu.
884	Journey884	884	Skiing	745	6	allgaeu	Car	7	February	HolidayFlat	H.Flat Nadenberg, Allgaeu.
885	Journey885	885	Skiing	1188	2	allgaeu	Car	14	March	HolidayFlat	H.Flat Oberallgaeu.
886	Journey886	886	Recreation	879	4	allgaeu	Car	7	February	HolidayFlat	H.Flat Oberallgaeu.
887	Journey887	887	Active	624	3	allgaeu	Car	7	January	HolidayFlat	H.Flat Oberallgaeu.
888	Journey888	888	Skiing	459	3	allgaeu	Car	8	December	HolidayFlat	H.Flat Alpina, Allgaeu.
889	Journey889	889	Skiing	424	4	allgaeu	Car	7	January	HolidayFlat	H.Flat Alpina, Allgaeu.
890	Journey890	890	Recreation	1568	4	allgaeu	Car	14	February	HolidayFlat	H.Flat Alpina, Allgaeu.
891	Journey891	891	Skiing	854	4	allgaeu	Car	7	March	HolidayFlat	H.Flat Reichenbach, Allgaeu.
892	Journey892	892	Active	984	6	allgaeu	Car	7	February	HolidayFlat	H.Flat Reichenbach, Allgaeu.
893	Journey893	893	Recreation	439	2	allgaeu	Car	7	January	HolidayFlat	H.Flat Sonnenhalde, Allgaeu.
894	Journey894	894	Recreation	799	3	allgaeu	Car	10	December	HolidayFlat	H.Flat Sonnenhalde, Allgaeu.
895	Journey895	895	Active	998	3	bavaria	Car	7	December	ThreeStars	Sporthotel Rosenberger, Bavaria.
896	Journey896	896	Skiing	798	2	bavaria	Car	7	January	ThreeStars	Sporthotel Rosenberger, Bavaria.
897	Journey897	897	Skiing	998	3	bavaria	Car	7	February	ThreeStars	Sporthotel Rosenberger, Bavaria.
898	Journey898	898	Active	1348	2	bavaria	Car	7	December	FourStars	H.Flat Eichenbuehl, Allgaeu.
899	Journey899	899	Skiing	1147	3	bavaria	Car	7	January	FourStars	H.Flat Eichenbuehl, Allgaeu.
900	Journey900	900	Recreation	3188	2	bavaria	Car	14	February	ThreeStars	Hotel Bavaria, Bavaria.
901	Journey901	901	Active	3448	2	bavaria	Car	10	December	ThreeStars	Hotel Bavaria, Bavaria.
902	Journey902	902	Active	1658	2	bavaria	Car	7	January	FourStars	Residenz Ludwig, Bavaria.
903	Journey903	903	Skiing	2072	3	bavaria	Car	7	February	FourStars	Residenz Ludwig, Bavaria.
904	Journey904	904	Active	2985	3	bavaria	Car	14	February	FourStars	Hotel Seidlpark, Bavaria.
905	Journey905	905	Skiing	1658	2	bavaria	Car	7	March	FourStars	Hotel Seidlpark, Bavaria.
906	Journey906	906	Active	745	3	bavaria	Car	7	January	TwoStars	Pension Laerchenhof, Bavaria.
907	Journey907	907	Recreation	949	4	bavaria	Car	7	February	TwoStars	Pension Laerchenhof, Bavaria.
908	Journey908	908	Active	684	2	bavaria	Car	7	January	HolidayFlat	H.Flat Chiemgau, Bavaria.
909	Journey909	909	Skiing	1164	5	bavaria	Car	14	February	HolidayFlat	H.Flat Chiemgau, Bavaria.
910	Journey910	910	Active	529	4	bavaria	Car	7	December	HolidayFlat	H.Flat Reiterhof, Bavaria.
911	Journey911	911	Recreation	484	2	bavaria	Car	7	February	HolidayFlat	H.Flat Reiterhof, Bavaria.
912	Journey912	912	Skiing	449	2	bavaria	Car	7	January	HolidayFlat	H.Flat Wildgatter, Bavaria.
913	Journey913	913	Skiing	774	6	bavaria	Car	7	February	HolidayFlat	H.Flat Wildgatter, Bavaria.
914	Journey914	914	Active	379	2	bavaria	Car	7	January	HolidayFlat	H.Flat Am Hochwald, Bavaria.
915	Journey915	915	Recreation	459	3	bavaria	Car	14	February	HolidayFlat	H.Flat Am Hochwald, Bavaria.
916	Journey916	916	Active	454	3	bavaria	Car	7	January	HolidayFlat	H.Flat Christopherhof, Bavaria.
917	Journey917	917	Skiing	774	8	bavaria	Car	7	March	HolidayFlat	H.Flat Christopherhof, Bavaria.
918	Journey918	918	Recreation	699	6	bavaria	Car	7	January	HolidayFlat	H.Flat Jaegerwiesen, Bavaria.
919	Journey919	919	Active	1018	3	bavaria	Car	14	February	HolidayFlat	H.Flat Jaegerwiesen, Bavaria.
920	Journey920	920	Recreation	1338	2	erz gebirge	Car	7	December	ThreeStars	Hotel Lugsteinhof, Erz Gebirge.
921	Journey921	921	Skiing	1472	3	erz gebirge	Car	7	January	ThreeStars	Hotel Lugsteinhof, Erz Gebirge.
922	Journey922	922	Recreation	1257	4	erz gebirge	Car	7	February	ThreeStars	Hotel Am Fichtelberg, Erz Gebirge.
923	Journey923	923	Skiing	1178	2	erz gebirge	Car	7	March	ThreeStars	Hotel Am Fichtelberg, Erz Gebirge.
924	Journey924	924	Active	1257	4	erz gebirge	Car	7	February	ThreeStars	Sporthotel Oberwiesenthal, Erz Gebirge.
925	Journey925	925	Skiing	1338	2	erz gebirge	Car	7	December	ThreeStars	Sporthotel Oberwiesenthal, Erz Gebirge.
926	Journey926	926	Recreation	1235	3	erz gebirge	Car	7	January	ThreeStars	Rathaushotel, Erz Gebirge.
927	Journey927	927	Active	1482	4	erz gebirge	Car	7	February	ThreeStars	Rathaushotel, Erz Gebirge.
928	Journey928	928	Recreation	838	2	erz gebirge	Car	14	March	ThreeStars	Hotel Stephanshoehe, Erz Gebirge.
929	Journey929	929	Recreation	1472	3	erz gebirge	Car	7	February	ThreeStars	Hotel Stephanshoehe, Erz Gebirge.
930	Journey930	930	Skiing	604	2	erz gebirge	Car	14	December	ThreeStars	Hotel Vogtland, Erz Gebirge.
931	Journey931	931	Recreation	1782	4	erz gebirge	Car	7	January	ThreeStars	Hotel Vogtland, Erz Gebirge.
932	Journey932	932	Active	2935	3	erz gebirge	Car	14	January	ThreeStars	Kurhotel Am See, Erz Gebirge.
933	Journey933	933	Recreation	838	2	erz gebirge	Car	7	March	ThreeStars	Kurhotel Am See, Erz Gebirge.
934	Journey934	934	Recreation	1257	4	erz gebirge	Car	7	February	ThreeStars	Kurhotel Am See, Erz Gebirge.
935	Journey935	935	Recreation	559	6	erz gebirge	Car	7	December	HolidayFlat	H.Flat Haus Vogtland, Erz Gebirge.
936	Journey936	936	Recreation	549	7	erz gebirge	Car	7	January	HolidayFlat	H.Flat Haus Vogtland, Erz Gebirge.
937	Journey937	937	Active	1098	5	erz gebirge	Car	14	March	HolidayFlat	H.Flat Haus Vogtland, Erz Gebirge.
938	Journey938	938	Active	549	6	erz gebirge	Car	7	February	HolidayFlat	H.Flat Haus Vogtland, Erz Gebirge.
939	Journey939	939	Skiing	549	4	erz gebirge	Car	7	February	HolidayFlat	H.Flat Haus Vogtland, Erz Gebirge.
940	Journey940	940	Recreation	2128	2	harz	Car	7	December	ThreeStars	Aparthotel Bocksberg, Harz.
941	Journey941	941	Recreation	1910	3	harz	Car	7	January	ThreeStars	Aparthotel Bocksberg, Harz.
942	Journey942	942	Wandering	1648	2	harz	Car	7	February	ThreeStars	Aparthotel Bocksberg, Harz.
943	Journey943	943	Skiing	2007	4	harz	Car	7	March	ThreeStars	Aparthotel Bocksberg, Harz.
944	Journey944	944	Recreation	2368	2	harz	Car	10	December	ThreeStars	Travelhotel Waldfrieden, Harz.
945	Journey945	945	Recreation	1485	3	harz	Car	7	January	ThreeStars	Travelhotel Waldfrieden, Harz.
946	Journey946	946	Wandering	1298	2	harz	Car	7	February	ThreeStars	Travelhotel Waldfrieden, Harz.
947	Journey947	947	Active	1782	4	harz	Car	7	March	ThreeStars	Travelhotel Waldfrieden, Harz.
948	Journey948	948	Recreation	2007	4	harz	Car	7	December	TwoStars	Hotel Harzquell, Harz.
949	Journey949	949	Wandering	1168	2	harz	Car	14	January	TwoStars	Hotel Harzquell, Harz.
950	Journey950	950	Skiing	1460	3	harz	Car	7	February	TwoStars	Hotel Harzquell, Harz.
951	Journey951	951	Recreation	1522	3	harz	Car	7	December	TwoStars	Hotel Fuerstenhoeh, Harz.
952	Journey952	952	Recreation	1482	4	harz	Car	7	January	TwoStars	Hotel Fuerstenhoeh, Harz.
953	Journey953	953	Skiing	1235	3	harz	Car	7	February	TwoStars	Hotel Fuerstenhoeh, Harz.
954	Journey954	954	Wandering	599	3	harz	Car	14	November	HolidayFlat	H.Flat Panoramic, Harz.
955	Journey955	955	Recreation	679	5	harz	Car	7	January	HolidayFlat	H.Flat Panoramic, Harz.
956	Journey956	956	Recreation	419	2	harz	Car	7	February	HolidayFlat	H.Flat Ferienpark, Harz.
957	Journey957	957	Wandering	1114	4	harz	Car	10	December	HolidayFlat	H.Flat Ferienpark, Harz.
958	Journey958	958	Skiing	324	3	harz	Car	7	December	HolidayFlat	H.Flat Teichtal, Harz.
959	Journey959	959	Skiing	499	6	harz	Car	7	February	HolidayFlat	H.Flat Teichtal, Harz.
960	Journey960	960	Wandering	1227	4	black forest	Car	7	December	TwoStars	Hotel Hirschen, Black Forest.
961	Journey961	961	Active	748	2	black forest	Car	7	January	TwoStars	Hotel Hirschen, Black Forest.
962	Journey962	962	Skiing	1735	3	black forest	Car	7	February	FourStars	Treff-Hotel, Black Forest.
963	Journey963	963	Wandering	2768	2	black forest	Car	14	March	FourStars	Treff-Hotel, Black Forest.
964	Journey964	964	Recreation	1737	4	black forest	Car	7	February	ThreeStars	Berghotel Kandel, Black Forest.
965	Journey965	965	Wandering	818	2	black forest	Car	7	January	ThreeStars	Berghotel Kandel, Black Forest.
966	Journey966	966	Recreation	2322	3	black forest	Car	10	December	ThreeStars	Berghotel Mummelsee, Black Forest.
967	Journey967	967	Skiing	1158	2	black forest	Car	7	February	ThreeStars	Berghotel Mummelsee, Black Forest.
968	Journey968	968	Active	1008	2	black forest	Car	7	January	ThreeStars	Hotel Waldwinkel, Black Forest.
969	Journey969	969	Recreation	1260	3	black forest	Car	14	February	ThreeStars	Hotel Waldwinkel, Black Forest.
970	Journey970	970	Wandering	1257	4	black forest	Car	7	March	TwoStars	Gasthof Hochkopfhaus, Black Forest.
971	Journey971	971	Skiing	838	2	black forest	Car	7	February	TwoStars	Gasthof Hochkopfhaus, Black Forest.
972	Journey972	972	Recreation	897	3	black forest	Car	7	January	TwoStars	Landgasthof Schuetzen, Black Forest.
973	Journey973	973	Wandering	688	2	black forest	Car	6	December	TwoStars	Landgasthof Schuetzen, Black Forest.
974	Journey974	974	Active	454	4	black forest	Car	7	January	HolidayFlat	H.Flat Ferienpark Black Forest.
975	Journey975	975	Active	514	6	black forest	Car	7	February	HolidayFlat	H.Flat Ferienpark Black Forest.
976	Journey976	976	Recreation	459	2	black forest	Car	7	March	HolidayFlat	H.Flat Schwarzwaldgrund.
977	Journey977	977	Recreation	1068	4	black forest	Car	14	February	HolidayFlat	H.Flat Schwarzwaldgrund.
978	Journey978	978	Skiing	549	6	black forest	Car	7	January	HolidayFlat	H.Flat Sonnenrain, Black Forest.
979	Journey979	979	Recreation	679	2	black forest	Car	7	December	HolidayFlat	H.Flat Schwarzwaldblick.
980	Journey980	980	Recreation	599	4	black forest	Car	7	January	HolidayFlat	H.Flat Schwarzwaldblick.
981	Journey981	981	Skiing	464	3	black forest	Car	7	February	HolidayFlat	H.Flat Schwiezer Hof, Black Forest.
982	Journey982	982	Wandering	1033	5	black forest	Car	14	March	HolidayFlat	H.Flat Schwiezer Hof, Black Forest.
983	Journey983	983	Recreation	989	4	black forest	Car	7	February	HolidayFlat	H.Flat Panorama-Blick, Black Forest.
984	Journey984	984	Wandering	839	6	black forest	Car	7	January	HolidayFlat	H.Flat Panorama-Blick, Black Forest.
985	Journey985	985	Wandering	1672	3	thuringia	Car	7	December	ThreeStars	Berghotel Friedrichroda, Thuringia.
986	Journey986	986	Recreation	1178	2	thuringia	Car	7	January	ThreeStars	Berghotel Friedrichroda, Thuringia.
987	Journey987	987	Active	4092	4	thuringia	Car	14	February	ThreeStars	Hotel Finsterbergen, Thuringia.
988	Journey988	988	Wandering	1368	2	thuringia	Car	7	March	ThreeStars	Hotel Finsterbergen, Thuringia.
989	Journey989	989	Wandering	1104	3	thuringia	Car	7	February	TwoStars	Hotel Schoene Aussicht, Thuringia.
990	Journey990	990	Skiing	883	2	thuringia	Car	7	January	TwoStars	Hotel Schoene Aussicht, Thuringia.
991	Journey991	991	Recreation	688	2	thuringia	Car	7	December	ThreeStars	Berghotel Oberhof, Thuringia.
992	Journey992	992	Wandering	1773	3	thuringia	Car	14	November	ThreeStars	Berghotel Oberhof, Thuringia.
993	Journey993	993	Wandering	1138	2	thuringia	Car	7	January	FourStars	Hotel Panorama, Thuringia.
994	Journey994	994	Recreation	1647	3	thuringia	Car	7	March	FourStars	Hotel Panorama, Thuringia.
995	Journey995	995	Skiing	1977	4	thuringia	Car	7	February	FourStars	Hotel Panorama, Thuringia.
996	Journey996	996	Wandering	1294	2	thuringia	Car	14	January	TwoStars	Hotel Am Schuetzenberg, Thuringia.
997	Journey997	997	Recreation	785	3	thuringia	Car	7	December	TwoStars	Hotel Am Schuetzenberg, Thuringia.
998	Journey998	998	Active	987	4	thuringia	Car	7	February	TwoStars	Hotel Frankenwald, Thuringia.
999	Journey999	999	Wandering	598	2	thuringia	Car	7	March	TwoStars	Hotel Frankenwald, Thuringia.
1000	Journey1000	1000	Wandering	389	3	thuringia	Car	7	February	HolidayFlat	H.Flat Schmeheim, Thuringia.
1001	Journey1001	1001	Wandering	389	4	thuringia	Car	7	March	HolidayFlat	H.Flat Schmeheim, Thuringia.
1002	Journey1002	1002	Recreation	389	3	thuringia	Car	7	January	HolidayFlat	H.Flat Schmeheim, Thuringia.
1003	Journey1003	1003	Active	924	4	thuringia	Car	9	December	HolidayFlat	H.Flat Schmeheim, Thuringia.
1004	Journey1004	1004	Skiing	389	4	thuringia	Car	7	February	HolidayFlat	H.Flat Schmeheim, Thuringia.
1005	Journey1005	1005	Wandering	855	4	thuringia	Car	14	March	HolidayFlat	H.Flat Ruppertus, Thuringia.
1006	Journey1006	1006	Wandering	483	4	thuringia	Car	7	January	HolidayFlat	H.Flat Ruppertus, Thuringia.
1007	Journey1007	1007	Recreation	774	4	thuringia	Car	9	December	HolidayFlat	H.Flat Ruppertus, Thuringia.
1008	Journey1008	1008	Active	483	3	thuringia	Car	7	January	HolidayFlat	H.Flat Ruppertus, Thuringia.
1009	Journey1009	1009	Skiing	483	4	thuringia	Car	7	February	HolidayFlat	H.Flat Ruppertus, Thuringia.
1010	Journey1010	1010	Active	624	4	france	Car	7	December	HolidayFlat	H.Flat Maeva, France.
1011	Journey1011	1011	Skiing	624	4	france	Car	7	January	HolidayFlat	H.Flat Maeva, France.
1012	Journey1012	1012	Recreation	1624	5	france	Car	7	February	HolidayFlat	H.Flat Maeva, France.
1013	Journey1013	1013	Active	844	4	france	Car	7	March	HolidayFlat	H.Flat Le Cervin, France.
1014	Journey1014	1014	Skiing	1654	5	france	Car	7	February	HolidayFlat	H.Flat Le Cervin, France.
1015	Journey1015	1015	Recreation	824	6	france	Car	7	January	HolidayFlat	H.Flat Le Cervin, France.
1016	Journey1016	1016	Active	764	4	france	Car	7	December	HolidayFlat	H.Flat Bellecote, France.
1017	Journey1017	1017	Skiing	3368	5	france	Car	14	January	HolidayFlat	H.Flat Bellecote, France.
1018	Journey1018	1018	Recreation	1014	4	france	Car	7	February	HolidayFlat	H.Flat Bellecote, France.
1019	Journey1019	1019	Active	1339	4	france	Car	7	March	HolidayFlat	H.Flat Cheval Blanc, France.
1020	Journey1020	1020	Skiing	1094	5	france	Car	7	February	HolidayFlat	H.Flat Cheval Blanc, France.
1021	Journey1021	1021	Recreation	1728	6	france	Car	14	January	HolidayFlat	H.Flat Cheval Blanc, France.
1022	Journey1022	1022	Active	589	4	france	Car	7	December	HolidayFlat	H.Flat Les Olympiades, France.
1023	Journey1023	1023	Skiing	589	4	france	Car	7	January	HolidayFlat	H.Flat Les Olympiades, France.
1024	Journey1024	1024	Recreation	1574	4	france	Car	7	February	HolidayFlat	H.Flat Les Olympiades, France.
1025	Journey1025	1025	Active	1744	6	france	Car	7	March	HolidayFlat	H.Flat Le Hameau, France.
1026	Journey1026	1026	Skiing	1319	5	france	Car	7	February	HolidayFlat	H.Flat Le Hameau, France.
1027	Journey1027	1027	Recreation	1478	4	france	Car	14	January	HolidayFlat	H.Flat Le Hameau, France.
1028	Journey1028	1028	Active	629	4	france	Car	7	December	HolidayFlat	H.Flat Charmettoger, France.
1029	Journey1029	1029	Skiing	799	4	france	Car	7	January	HolidayFlat	H.Flat Charmettoger, France.
1030	Journey1030	1030	Recreation	1149	6	france	Car	7	February	HolidayFlat	H.Flat Charmettoger, France.
1031	Journey1031	1031	Active	814	3	france	Car	7	March	HolidayFlat	H.Flat Orion, France.
1032	Journey1032	1032	Active	2028	4	france	Car	14	February	HolidayFlat	H.Flat Orion, France.
1033	Journey1033	1033	Skiing	919	4	france	Car	7	January	HolidayFlat	H.Flat Orion, France.
1034	Journey1034	1034	Recreation	1164	6	france	Car	7	December	HolidayFlat	H.Flat Orion, France.
1035	Journey1035	1035	Active	1397	3	carinthia	Car	10	December	TwoStars	Landhaus Almrausch, Carinthia.
1036	Journey1036	1036	Skiing	658	2	carinthia	Car	7	January	TwoStars	Landhaus Almrausch, Carinthia.
1037	Journey1037	1037	Recreation	1167	4	carinthia	Car	7	February	ThreeStars	Pension Gerlitzen, Carinthia.
1038	Journey1038	1038	Active	778	2	carinthia	Car	7	March	ThreeStars	Pension Gerlitzen, Carinthia.
1039	Journey1039	1039	Skiing	997	3	carinthia	Car	7	February	ThreeStars	Hotel Oswald, Carinthia.
1040	Journey1040	1040	Skiing	1448	2	carinthia	Car	14	January	ThreeStars	Hotel Oswald, Carinthia.
1041	Journey1041	1041	Recreation	1647	3	carinthia	Car	10	December	TwoStars	Hotel Alpenhof, Carinthia.
1042	Journey1042	1042	Recreation	758	2	carinthia	Car	7	January	TwoStars	Hotel Alpenhof, Carinthia.
1043	Journey1043	1043	Active	1617	4	carinthia	Car	7	February	ThreeStars	Gasthof Post, Carinthia.
1044	Journey1044	1044	Skiing	998	2	carinthia	Car	7	March	ThreeStars	Gasthof Post, Carinthia.
1045	Journey1045	1045	Active	678	2	carinthia	Car	7	February	ThreeStars	Hotel Breznik, Carinthia.
1046	Journey1046	1046	Skiing	847	3	carinthia	Car	7	January	ThreeStars	Hotel Breznik, Carinthia.
1047	Journey1047	1047	Skiing	779	2	carinthia	Car	10	December	HolidayFlat	H.Flat Austria, Carinthia.
1048	Journey1048	1048	Active	1078	4	carinthia	Car	14	January	HolidayFlat	H.Flat Austria, Carinthia.
1049	Journey1049	1049	Active	919	6	carinthia	Car	7	February	HolidayFlat	H.Flat Austria, Carinthia.
1050	Journey1050	1050	Active	1049	8	carinthia	Car	7	February	HolidayFlat	H.Flat Austria, Carinthia.
1051	Journey1051	1051	Active	794	3	carinthia	Car	7	February	HolidayFlat	H.Flat Kaerntnerhof, Carinthia.
1052	Journey1052	1052	Recreation	554	2	carinthia	Car	7	March	HolidayFlat	H.Flat Kaerntnerhof, Carinthia.
1053	Journey1053	1053	Skiing	669	3	carinthia	Car	7	February	HolidayFlat	H.Flat Rainer, Carinthia.
1054	Journey1054	1054	Skiing	629	4	carinthia	Car	7	January	HolidayFlat	H.Flat Rainer, Carinthia.
1055	Journey1055	1055	Active	1189	3	carinthia	Car	10	December	HolidayFlat	H.Flat Lindenhof, Carinthia.
1056	Journey1056	1056	Recreation	569	3	carinthia	Car	7	January	HolidayFlat	H.Flat Lindenhof, Carinthia.
1057	Journey1057	1057	Skiing	649	4	carinthia	Car	7	February	HolidayFlat	H.Flat Lindenhof, Carinthia.
1058	Journey1058	1058	Skiing	499	2	carinthia	Car	7	March	HolidayFlat	H.Flat Rosenock, Carinthia.
1059	Journey1059	1059	Recreation	879	4	carinthia	Car	7	February	HolidayFlat	H.Flat Rosenock, Carinthia.
1060	Journey1060	1060	Active	849	2	lower austria	Car	10	December	HolidayFlat	H.Flat Litschau, Lower Austria.
1061	Journey1061	1061	Active	399	2	lower austria	Car	7	January	HolidayFlat	H.Flat Litschau, Lower Austria.
1062	Journey1062	1062	Active	399	2	lower austria	Car	7	February	HolidayFlat	H.Flat Litschau, Lower Austria.
1063	Journey1063	1063	Active	669	4	lower austria	Car	14	March	HolidayFlat	H.Flat Litschau, Lower Austria.
1064	Journey1064	1064	Skiing	1629	4	lower austria	Car	10	December	HolidayFlat	H.Flat Litschau, Lower Austria.
1065	Journey1065	1065	Skiing	669	4	lower austria	Car	7	January	HolidayFlat	H.Flat Litschau, Lower Austria.
1066	Journey1066	1066	Skiing	669	4	lower austria	Car	7	February	HolidayFlat	H.Flat Litschau, Lower Austria.
1067	Journey1067	1067	Skiing	1338	4	lower austria	Car	14	March	HolidayFlat	H.Flat Litschau, Lower Austria.
1068	Journey1068	1068	Recreation	899	6	lower austria	Car	7	January	HolidayFlat	H.Flat Litschau, Lower Austria.
1069	Journey1069	1069	Recreation	899	6	lower austria	Car	7	February	HolidayFlat	H.Flat Litschau, Lower Austria.
1070	Journey1070	1070	Skiing	1307	3	tyrol	Car	14	March	ThreeStars	Gasthof Jaegerwirt, Tyrol.
1071	Journey1071	1071	Active	1227	4	tyrol	Car	7	February	ThreeStars	Gasthof Jaegerwirt, Tyrol.
1072	Journey1072	1072	Skiing	1218	2	tyrol	Car	7	January	FourStars	Hotel Pachmair, Tyrol.
1073	Journey1073	1073	Active	2238	2	tyrol	Car	10	December	FourStars	Hotel Pachmair, Tyrol.
1074	Journey1074	1074	Skiing	1197	3	tyrol	Car	7	January	ThreeStars	Ferienhotel Frieden, Tyrol.
1075	Journey1075	1075	Recreation	1647	4	tyrol	Car	7	February	ThreeStars	Ferienhotel Frieden, Tyrol.
1076	Journey1076	1076	Skiing	733	2	tyrol	Car	7	March	ThreeStars	Hotel Laerchenhof, Tyrol.
1077	Journey1077	1077	Skiing	1238	2	tyrol	Car	7	February	ThreeStars	Hotel Laerchenhof, Tyrol.
1078	Journey1078	1078	Active	1508	2	tyrol	Car	14	January	ThreeStars	Hotel Laerchenhof, Tyrol.
1079	Journey1079	1079	Skiing	1347	3	tyrol	Car	10	December	ThreeStars	Pension Post, Tyrol.
1080	Journey1080	1080	Recreation	987	3	tyrol	Car	7	January	ThreeStars	Pension Post, Tyrol.
1081	Journey1081	1081	Skiing	1707	4	tyrol	Car	7	February	ThreeStars	Gasthof Berghof, Tyrol.
1082	Journey1082	1082	Active	1138	2	tyrol	Car	7	February	ThreeStars	Gasthof Berghof, Tyrol.
1083	Journey1083	1083	Skiing	1272	3	tyrol	Car	7	January	ThreeStars	Wirtshaus Kofler, Tyrol.
1084	Journey1084	1084	Recreation	1158	2	tyrol	Car	7	March	ThreeStars	Wirtshaus Kofler, Tyrol.
1085	Journey1085	1085	Skiing	1498	2	tyrol	Car	14	February	ThreeStars	Pension Alpenhof, Tyrol.
1086	Journey1086	1086	Active	1047	4	tyrol	Car	7	January	ThreeStars	Pension Alpenhof, Tyrol.
1087	Journey1087	1087	Skiing	1958	2	tyrol	Car	10	December	FourStars	Hotel Alpenland, Tyrol.
1088	Journey1088	1088	Recreation	978	2	tyrol	Car	7	January	FourStars	Hotel Alpenland, Tyrol.
1089	Journey1089	1089	Skiing	699	3	tyrol	Car	7	February	HolidayFlat	H.Flat Eberl, Tyrol.
1090	Journey1090	1090	Skiing	889	5	tyrol	Car	7	January	HolidayFlat	H.Flat Eberl, Tyrol.
1091	Journey1091	1091	Active	749	6	tyrol	Car	7	March	HolidayFlat	H.Flat Eberl, Tyrol.
1092	Journey1092	1092	Skiing	1853	4	tyrol	Car	14	February	HolidayFlat	H.Flat Zillertal, Tyrol.
1093	Journey1093	1093	Active	844	4	tyrol	Car	7	January	HolidayFlat	H.Flat Zillertal, Tyrol.
1094	Journey1094	1094	Recreation	2144	6	tyrol	Car	10	December	HolidayFlat	H.Flat Zillertal, Tyrol.
1095	Journey1095	1095	Skiing	729	3	tyrol	Car	7	February	HolidayFlat	H.Flat Alpenrose, Tyrol.
1096	Journey1096	1096	Skiing	899	4	tyrol	Car	7	January	HolidayFlat	H.Flat Alpenrose, Tyrol.
1097	Journey1097	1097	Active	1039	4	tyrol	Car	7	March	HolidayFlat	H.Flat Alpenrose, Tyrol.
1098	Journey1098	1098	Skiing	2089	4	tyrol	Car	10	December	HolidayFlat	H.Flat Raich, Tyrol.
1099	Journey1099	1099	Active	979	4	tyrol	Car	7	January	HolidayFlat	H.Flat Raich, Tyrol.
1100	Journey1100	1100	Skiing	1409	6	tyrol	Car	7	February	HolidayFlat	H.Flat Raich, Tyrol.
1101	Journey1101	1101	Recreation	539	4	tyrol	Car	7	March	HolidayFlat	H.Flat Wildauer, Tyrol.
1102	Journey1102	1102	Skiing	1038	4	tyrol	Car	14	February	HolidayFlat	H.Flat Wildauer, Tyrol.
1103	Journey1103	1103	Active	809	6	tyrol	Car	7	January	HolidayFlat	H.Flat Wildauer, Tyrol.
1104	Journey1104	1104	Skiing	934	3	tyrol	Car	10	December	HolidayFlat	H.Flat Auhof, Tyrol.
1105	Journey1105	1105	Skiing	404	2	tyrol	Car	7	January	HolidayFlat	H.Flat Auhof, Tyrol.
1106	Journey1106	1106	Recreation	864	6	tyrol	Car	7	February	HolidayFlat	H.Flat Auhof, Tyrol.
1107	Journey1107	1107	Skiing	619	4	tyrol	Car	7	January	HolidayFlat	H.Flat St.Jakob, Tyrol.
1108	Journey1108	1108	Active	1008	2	tyrol	Car	14	March	HolidayFlat	H.Flat St.Jakob, Tyrol.
1109	Journey1109	1109	Skiing	1458	2	salzberger land	Car	10	December	ThreeStars	Gasthof Roemerhof, Salzb. Land.
1110	Journey1110	1110	Active	997	3	salzberger land	Car	7	January	ThreeStars	Gasthof Roemerhof, Salzb. Land.
1111	Journey1111	1111	Skiing	1317	4	salzberger land	Car	7	February	ThreeStars	Gasthof Roemerhof, Salzb. Land.
1112	Journey1112	1112	Skiing	1218	2	salzberger land	Car	7	March	FourStars	St.Hubertushof, Salzb. Land.
1113	Journey1113	1113	Active	1378	2	salzberger land	Car	7	February	FourStars	St.Hubertushof, Salzb. Land.
1114	Journey1114	1114	Recreation	1522	3	salzberger land	Car	7	January	FourStars	St.Hubertushof, Salzb. Land.
1115	Journey1115	1115	Skiing	2672	3	salzberger land	Car	10	December	FourStars	Hotel Latini, Salzb. Land.
1116	Journey1116	1116	Skiing	1358	2	salzberger land	Car	7	January	FourStars	Hotel Latini, Salzb. Land.
1117	Journey1117	1117	Active	4647	4	salzberger land	Car	14	February	FourStars	Hotel Latini, Salzb. Land.
1118	Journey1118	1118	Skiing	788	2	salzberger land	Car	7	March	TwoStars	Pension Elisabeth, Salzb. Land.
1119	Journey1119	1119	Skiing	828	2	salzberger land	Car	7	February	TwoStars	Pension Elisabeth, Salzb. Land.
1120	Journey1120	1120	Recreation	985	3	salzberger land	Car	7	January	TwoStars	Pension Elisabeth, Salzb. Land.
1121	Journey1121	1121	Skiing	1009	3	salzberger land	Car	10	December	HolidayFlat	H.Flat Domizil, Salzb. Land.
1122	Journey1122	1122	Skiing	669	3	salzberger land	Car	14	January	HolidayFlat	H.Flat Domizil, Salzb. Land.
1123	Journey1123	1123	Active	879	4	salzberger land	Car	7	February	HolidayFlat	H.Flat Domizil, Salzb. Land.
1124	Journey1124	1124	Skiing	784	3	salzberger land	Car	7	March	HolidayFlat	H.Flat Erlberg, Salzb. Land.
1125	Journey1125	1125	Recreation	1254	4	salzberger land	Car	7	February	HolidayFlat	H.Flat Erlberg, Salzb. Land.
1126	Journey1126	1126	Active	543	2	salzberger land	Car	7	January	HolidayFlat	H.Flat Erlberg, Salzb. Land.
1127	Journey1127	1127	Skiing	948	3	salzberger land	Car	14	December	HolidayFlat	H.Flat Schuettdorf, Salzb. Land.
1128	Journey1128	1128	Skiing	474	3	salzberger land	Car	7	January	HolidayFlat	H.Flat Schuettdorf, Salzb. Land.
1129	Journey1129	1129	Recreation	599	3	salzberger land	Car	7	February	HolidayFlat	H.Flat Schuettdorf, Salzb. Land.
1130	Journey1130	1130	Skiing	554	3	salzberger land	Car	7	March	HolidayFlat	H.Flat Sonnbichl, Salzb. Land.
1131	Journey1131	1131	Skiing	1149	4	salzberger land	Car	7	February	HolidayFlat	H.Flat Sonnbichl, Salzb. Land.
1132	Journey1132	1132	Active	310	2	salzberger land	Car	7	January	HolidayFlat	H.Flat Sonnbichl, Salzb. Land.
1133	Journey1133	1133	Active	3009	6	salzberger land	Car	10	December	HolidayFlat	H.Flat Sonnbichl, Salzb. Land.
1134	Journey1134	1134	Skiing	1153	2	salzkammergut	Car	14	January	ThreeStars	Gaestehaus Berghof, Salkammergut.
1135	Journey1135	1135	Skiing	1182	4	salzkammergut	Car	7	February	ThreeStars	Gaestehaus Berghof, Salkammergut.
1136	Journey1136	1136	Active	985	3	salzkammergut	Car	7	March	ThreeStars	Gaestehaus Berghof, Salkammergut.
1137	Journey1137	1137	Recreation	985	3	salzkammergut	Car	7	February	ThreeStars	Gaestehaus Berghof, Salkammergut.
1138	Journey1138	1138	Skiing	758	2	salzkammergut	Car	7	January	ThreeStars	Gastehof Hubertus, Salzkammergut.
1139	Journey1139	1139	Skiing	1368	2	salzkammergut	Car	10	December	ThreeStars	Gastehof Hubertus, Salzkammergut.
1140	Journey1140	1140	Active	947	3	salzkammergut	Car	7	January	ThreeStars	Gastehof Hubertus, Salzkammergut.
1141	Journey1141	1141	Recreation	1137	4	salzkammergut	Car	7	February	ThreeStars	Gastehof Hubertus, Salzkammergut.
1142	Journey1142	1142	Skiing	1998	2	salzkammergut	Car	7	March	FourStars	Dorfhotel Gosau, Salzkammergut.
1143	Journey1143	1143	Skiing	2648	2	salzkammergut	Car	7	February	FourStars	Dorfhotel Gosau, Salzkammergut.
1144	Journey1144	1144	Active	2607	3	salzkammergut	Car	14	January	FourStars	Dorfhotel Gosau, Salzkammergut.
1145	Journey1145	1145	Recreation	3498	2	salzkammergut	Car	10	December	FourStars	Dorfhotel Gosau, Salzkammergut.
1146	Journey1146	1146	Skiing	2907	3	salzkammergut	Car	7	January	FourStars	Dorfhotel Heiligenblut, Salzkammergut.
1147	Journey1147	1147	Skiing	2478	2	salzkammergut	Car	7	February	FourStars	Dorfhotel Heiligenblut, Salzkammergut.
1148	Journey1148	1148	Active	2378	2	salzkammergut	Car	7	March	FourStars	Dorfhotel Heiligenblut, Salzkammergut.
1149	Journey1149	1149	Recreation	8007	3	salzkammergut	Car	14	February	FourStars	Dorfhotel Heiligenblut, Salzkammergut.
1150	Journey1150	1150	Skiing	243	2	salzkammergut	Car	7	January	HolidayFlat	H.Flat Seebad, Salzkammergut.
1151	Journey1151	1151	Skiing	1084	4	salzkammergut	Car	10	December	HolidayFlat	H.Flat Seebad, Salzkammergut.
1152	Journey1152	1152	Skiing	460	4	salzkammergut	Car	7	January	HolidayFlat	H.Flat Seebad, Salzkammergut.
1153	Journey1153	1153	Active	674	5	salzkammergut	Car	7	February	HolidayFlat	H.Flat Seebad, Salzkammergut.
1154	Journey1154	1154	Active	739	6	salzkammergut	Car	7	March	HolidayFlat	H.Flat Seebad, Salzkammergut.
1155	Journey1155	1155	Recreation	614	4	salzkammergut	Car	7	February	HolidayFlat	H.Flat Seebad, Salzkammergut.
1156	Journey1156	1156	Skiing	1098	2	styria	Car	10	December	TwoStars	Gasthof Heimathaus, Styria.
1157	Journey1157	1157	Skiing	1165	3	styria	Car	14	January	TwoStars	Gasthof Heimathaus, Styria.
1158	Journey1158	1158	Active	1017	4	styria	Car	7	February	TwoStars	Gasthof Heimathaus, Styria.
1159	Journey1159	1159	Recreation	635	3	styria	Car	7	March	TwoStars	Gasthof Heimathaus, Styria.
1160	Journey1160	1160	Skiing	778	2	styria	Car	7	February	ThreeStars	Gasthof Pruggerhof, Styria.
1161	Journey1161	1161	Skiing	738	2	styria	Car	7	January	ThreeStars	Gasthof Pruggerhof, Styria.
1162	Journey1162	1162	Active	1597	3	styria	Car	10	December	ThreeStars	Gasthof Pruggerhof, Styria.
1163	Journey1163	1163	Active	738	2	styria	Car	7	March	ThreeStars	Gasthof Pruggerhof, Styria.
1164	Journey1164	1164	Skiing	1797	4	styria	Car	7	February	ThreeStars	Hotel Tauernhof, Styria.
1165	Journey1165	1165	Skiing	1198	2	styria	Car	7	February	ThreeStars	Hotel Tauernhof, Styria.
1166	Journey1166	1166	Recreation	1272	3	styria	Car	7	March	ThreeStars	Hotel Tauernhof, Styria.
1167	Journey1167	1167	Active	2577	4	styria	Car	10	December	ThreeStars	Hotel Tauernhof, Styria.
1168	Journey1168	1168	Skiing	239	4	styria	Car	7	January	HolidayFlat	H.Flat Wieland, Styria.
1169	Journey1169	1169	Skiing	549	3	styria	Car	7	February	HolidayFlat	H.Flat Wieland, Styria.
1170	Journey1170	1170	Active	919	4	styria	Car	10	December	HolidayFlat	H.Flat Wieland, Styria.
1171	Journey1171	1171	Skiing	385	4	styria	Car	7	March	HolidayFlat	H.Flat Schilcherhof, Styria.
1172	Journey1172	1172	Active	514	4	styria	Car	7	February	HolidayFlat	H.Flat Schilcherhof, Styria.
1173	Journey1173	1173	Recreation	244	3	styria	Car	7	January	HolidayFlat	H.Flat Schilcherhof, Styria.
1174	Journey1174	1174	Skiing	239	4	styria	Car	14	January	HolidayFlat	H.Flat Peinhaupt, Styria.
1175	Journey1175	1175	Skiing	889	4	styria	Car	10	December	HolidayFlat	H.Flat Peinhaupt, Styria.
1176	Journey1176	1176	Active	351	3	styria	Car	7	March	HolidayFlat	H.Flat Peinhaupt, Styria.
1177	Journey1177	1177	Recreation	351	4	styria	Car	7	February	HolidayFlat	H.Flat Peinhaupt, Styria.
1178	Journey1178	1178	Skiing	299	4	styria	Car	7	January	HolidayFlat	H.Flat Berger, Styria.
1179	Journey1179	1179	Skiing	359	4	styria	Car	14	February	HolidayFlat	H.Flat Berger, Styria.
1180	Journey1180	1180	Active	359	3	styria	Car	7	March	HolidayFlat	H.Flat Berger, Styria.
1181	Journey1181	1181	Active	2051	3	tyrol	Car	7	February	FiveStars	Hotel Feldmuellerhof, South Tyrol.
1182	Journey1182	1182	Recreation	2323	2	tyrol	Car	14	March	FiveStars	Hotel Feldmuellerhof, South Tyrol.
1183	Journey1183	1183	Skiing	1120	2	tyrol	Car	7	January	FiveStars	Hotel Feldmuellerhof, South Tyrol.
1184	Journey1184	1184	Skiing	508	2	tyrol	Car	7	January	ThreeStars	Hotel Adler South Tyrol.
1185	Journey1185	1185	Skiing	1247	3	tyrol	Car	7	December	ThreeStars	Hotel Adler South Tyrol.
1186	Journey1186	1186	Active	762	4	tyrol	Car	7	January	ThreeStars	Hotel Adler South Tyrol.
1187	Journey1187	1187	Skiing	2097	4	tyrol	Car	14	February	ThreeStars	Pension Schoenwald, South Tyrol.
1188	Journey1188	1188	Recreation	720	3	tyrol	Car	7	March	ThreeStars	Pension Schoenwald, South Tyrol.
1189	Journey1189	1189	Skiing	657	4	tyrol	Car	7	February	TwoStars	Pension garni Priska, South Tyrol.
1190	Journey1190	1190	Active	398	2	tyrol	Car	7	January	TwoStars	Pension garni Priska, South Tyrol.
1191	Journey1191	1191	Skiing	694	4	tyrol	Car	10	December	HolidayFlat	H.Flat Klausberg, South Tyrol.
1192	Journey1192	1192	Skiing	514	3	tyrol	Car	14	January	HolidayFlat	H.Flat Klausberg, South Tyrol.
1193	Journey1193	1193	Skiing	684	4	tyrol	Car	7	February	HolidayFlat	H.Flat Klausberg, South Tyrol.
1194	Journey1194	1194	Skiing	319	3	tyrol	Car	7	February	HolidayFlat	H.Flat Jaufenthaler, South Tyrol.
1195	Journey1195	1195	Skiing	499	4	tyrol	Car	7	March	HolidayFlat	H.Flat Jaufenthaler, South Tyrol.
1196	Journey1196	1196	Active	499	5	tyrol	Car	14	January	HolidayFlat	H.Flat Jaufenthaler, South Tyrol.
1197	Journey1197	1197	Active	329	2	tyrol	Car	7	January	HolidayFlat	H.Flat Frankbachhof, South Tyrol.
1198	Journey1198	1198	Active	809	5	tyrol	Car	7	February	HolidayFlat	H.Flat Frankbachhof, South Tyrol.
1199	Journey1199	1199	Recreation	389	4	tyrol	Car	7	March	HolidayFlat	H.Flat Des Alpes, South Tyrol.
1200	Journey1200	1200	Recreation	1698	6	tyrol	Car	14	February	HolidayFlat	H.Flat Des Alpes, South Tyrol.
1201	Journey1201	1201	Skiing	898	2	dolomites	Car	7	January	FourStars	Hotel Hofer, Dolomites.
1202	Journey1202	1202	Skiing	1647	4	dolomites	Car	7	February	FourStars	Hotel Hofer, Dolomites.
1203	Journey1203	1203	Active	1372	3	dolomites	Car	7	March	FourStars	Hotel Hofer, Dolomites.
1204	Journey1204	1204	Recreation	2672	3	dolomites	Car	14	February	FourStars	Hotel Hofer, Dolomites.
1205	Journey1205	1205	Skiing	772	3	dolomites	Car	7	January	TwoStars	Hotel Tannenheim, Dolomites.
1206	Journey1206	1206	Skiing	1478	2	dolomites	Car	10	December	TwoStars	Hotel Tannenheim, Dolomites.
1207	Journey1207	1207	Active	618	2	dolomites	Car	7	March	TwoStars	Hotel Tannenheim, Dolomites.
1208	Journey1208	1208	Recreation	1107	4	dolomites	Car	7	February	TwoStars	Hotel Tannenheim, Dolomites.
1209	Journey1209	1209	Skiing	754	4	dolomites	Car	7	January	HolidayFlat	H.Flat Panorama, Dolomites.
1210	Journey1210	1210	Skiing	754	2	dolomites	Car	7	January	HolidayFlat	H.Flat Panorama, Dolomites.
1211	Journey1211	1211	Active	1974	4	dolomites	Car	10	December	HolidayFlat	H.Flat Panorama, Dolomites.
1212	Journey1212	1212	Active	1214	3	dolomites	Car	7	March	HolidayFlat	H.Flat Panorama, Dolomites.
1213	Journey1213	1213	Skiing	719	4	dolomites	Car	7	February	HolidayFlat	H.Flat Centro Vacanze, Dolomites.
1214	Journey1214	1214	Skiing	899	5	dolomites	Car	7	January	HolidayFlat	H.Flat Centro Vacanze, Dolomites.
1215	Journey1215	1215	Active	709	4	dolomites	Car	7	January	HolidayFlat	H.Flat Centro Vacanze, Dolomites.
1216	Journey1216	1216	Recreation	1478	4	dolomites	Car	14	February	HolidayFlat	H.Flat Centro Vacanze, Dolomites.
1217	Journey1217	1217	Skiing	449	4	dolomites	Car	7	March	HolidayFlat	H.Flat Parkanlage, Dolomites.
1218	Journey1218	1218	Skiing	379	3	dolomites	Car	7	February	HolidayFlat	H.Flat Parkanlage, Dolomites.
1219	Journey1219	1219	Active	379	2	dolomites	Car	14	January	HolidayFlat	H.Flat Parkanlage, Dolomites.
1220	Journey1220	1220	Recreation	929	4	dolomites	Car	10	December	HolidayFlat	H.Flat Parkanlage, Dolomites.
1221	Journey1221	1221	Bathing	2618	2	egypt	Plane	14	November	FourStars	Novotel, Egypt.
1222	Journey1222	1222	Bathing	3065	3	egypt	Plane	7	December	FourStars	Novotel, Egypt.
1223	Journey1223	1223	Active	3298	2	egypt	Plane	14	January	FourStars	Novotel, Egypt.
1224	Journey1224	1224	Recreation	3718	2	egypt	Plane	14	February	FourStars	Novotel, Egypt.
1225	Journey1225	1225	Bathing	3363	3	egypt	Plane	14	March	ThreeStars	Giftun Village, Egypt.
1226	Journey1226	1226	Bathing	2158	2	egypt	Plane	7	November	ThreeStars	Giftun Village, Egypt.
1227	Journey1227	1227	Active	2945	3	egypt	Plane	14	December	ThreeStars	Giftun Village, Egypt.
1228	Journey1228	1228	Recreation	4552	4	egypt	Plane	14	January	ThreeStars	Giftun Village, Egypt.
1229	Journey1229	1229	Bathing	3598	2	egypt	Plane	14	February	FourStars	Hotel Arabia Beach, Egypt.
1230	Journey1230	1230	Bathing	3598	2	egypt	Plane	14	March	FourStars	Hotel Arabia Beach, Egypt.
1231	Journey1231	1231	Active	3478	2	egypt	Plane	14	November	FourStars	Hotel Arabia Beach, Egypt.
1232	Journey1232	1232	Recreation	3515	3	egypt	Plane	14	December	FourStars	Hotel Arabia Beach, Egypt.
1233	Journey1233	1233	Bathing	2578	2	egypt	Plane	7	January	ThreeStars	Hotel Sand Beach, Egypt.
1234	Journey1234	1234	Bathing	4552	4	egypt	Plane	14	February	ThreeStars	Hotel Sand Beach, Egypt.
1235	Journey1235	1235	Active	2678	2	egypt	Plane	14	March	ThreeStars	Hotel Sand Beach, Egypt.
1236	Journey1236	1236	Bathing	4658	2	madeira	Plane	7	November	FourStars	Aparthotel Eden mare, Madeira.
1237	Journey1237	1237	Bathing	6113	3	madeira	Plane	14	December	FourStars	Aparthotel Eden mare, Madeira.
1238	Journey1238	1238	Recreation	4298	2	madeira	Plane	14	January	FourStars	Aparthotel Eden mare, Madeira.
1239	Journey1239	1239	Active	4398	2	madeira	Plane	14	February	FourStars	Aparthotel Eden mare, Madeira.
1240	Journey1240	1240	Bathing	3498	2	madeira	Plane	14	March	ThreeStars	App. Florasol, Madeira.
1241	Journey1241	1241	Bathing	4956	4	madeira	Plane	14	November	ThreeStars	App. Florasol, Madeira.
1242	Journey1242	1242	Recreation	2388	2	madeira	Plane	7	December	ThreeStars	App. Florasol, Madeira.
1243	Journey1243	1243	Recreation	4157	3	madeira	Plane	14	January	ThreeStars	App. Florasol, Madeira.
1244	Journey1244	1244	Bathing	3598	2	madeira	Plane	14	February	ThreeStars	Hotel Do Carmo, Madeira.
1245	Journey1245	1245	Bathing	4367	3	madeira	Plane	14	March	ThreeStars	Hotel Do Carmo, Madeira.
1246	Journey1246	1246	Recreation	4022	3	madeira	Plane	14	November	ThreeStars	Hotel Do Carmo, Madeira.
1247	Journey1247	1247	Active	5576	4	madeira	Plane	14	December	ThreeStars	Hotel Do Carmo, Madeira.
1248	Journey1248	1248	Bathing	3438	2	madeira	Plane	14	January	ThreeStars	Hotel Mimosa, Madeira.
1249	Journey1249	1249	Bathing	3578	2	madeira	Plane	14	February	ThreeStars	Hotel Mimosa, Madeira.
1250	Journey1250	1250	Recreation	4847	3	madeira	Plane	14	March	ThreeStars	Hotel Mimosa, Madeira.
1251	Journey1251	1251	Recreation	3578	2	madeira	Plane	14	November	ThreeStars	Hotel Mimosa, Madeira.
1252	Journey1252	1252	Bathing	2498	2	madeira	Plane	14	December	TwoStars	Anlage Canico, Madeira.
1253	Journey1253	1253	Bathing	2769	3	madeira	Plane	7	January	TwoStars	Anlage Canico, Madeira.
1254	Journey1254	1254	Recreation	3765	3	madeira	Plane	14	February	TwoStars	Anlage Canico, Madeira.
1255	Journey1255	1255	Active	3278	2	madeira	Plane	14	March	TwoStars	Anlage Canico, Madeira.
1256	Journey1256	1256	Bathing	2527	3	cyprus	Plane	7	November	ThreeStars	Hotel Paphian Bay, Cyprus.
1257	Journey1257	1257	Bathing	2338	2	cyprus	Plane	14	December	ThreeStars	Hotel Paphian Bay, Cyprus.
1258	Journey1258	1258	Active	2527	3	cyprus	Plane	14	January	ThreeStars	Hotel Paphian Bay, Cyprus.
1259	Journey1259	1259	Recreation	2907	4	cyprus	Plane	14	February	ThreeStars	Hotel Paphian Bay, Cyprus.
1260	Journey1260	1260	Bathing	3018	2	cyprus	Plane	14	March	ThreeStars	App. Aliathon Village, Cyprus.
1261	Journey1261	1261	Recreation	2498	2	cyprus	Plane	14	January	ThreeStars	App. Aliathon Village, Cyprus.
1262	Journey1262	1262	Bathing	2613	3	cyprus	Plane	14	November	ThreeStars	App. Aliathon Village, Cyprus.
1263	Journey1263	1263	Bathing	2138	2	cyprus	Plane	14	December	ThreeStars	Hotel Karpasiana, Cyprus.
1264	Journey1264	1264	Bathing	2493	3	cyprus	Plane	7	March	ThreeStars	Hotel Karpasiana, Cyprus.
1265	Journey1265	1265	Active	2138	2	cyprus	Plane	14	January	ThreeStars	Hotel Karpasiana, Cyprus.
1266	Journey1266	1266	Recreation	2138	2	cyprus	Plane	14	February	ThreeStars	Hotel Karpasiana, Cyprus.
1267	Journey1267	1267	Bathing	3077	4	cyprus	Plane	14	November	ThreeStars	Hotel Napia Star, Cyprus.
1268	Journey1268	1268	Bathing	2418	2	cyprus	Plane	14	December	ThreeStars	Hotel Napia Star, Cyprus.
1269	Journey1269	1269	Active	2418	2	cyprus	Plane	14	January	ThreeStars	Hotel Napia Star, Cyprus.
1270	Journey1270	1270	Recreation	2659	3	cyprus	Plane	14	February	ThreeStars	Hotel Napia Star, Cyprus.
1271	Journey1271	1271	Bathing	2439	3	cyprus	Plane	7	March	FourStars	Hotel Sandy Beach, Cyprus.
1272	Journey1272	1272	Bathing	2958	2	cyprus	Plane	14	November	FourStars	Hotel Sandy Beach, Cyprus.
1273	Journey1273	1273	Active	2578	2	cyprus	Plane	14	December	FourStars	Hotel Sandy Beach, Cyprus.
1274	Journey1274	1274	Recreation	2578	2	cyprus	Plane	14	January	FourStars	Hotel Sandy Beach, Cyprus.
1275	Journey1275	1275	Bathing	2879	3	cyprus	Plane	14	March	FourStars	Hotel Odessa, Cyprus.
1276	Journey1276	1276	Bathing	2558	2	cyprus	Plane	14	November	FourStars	Hotel Odessa, Cyprus.
1277	Journey1277	1277	Active	2278	2	cyprus	Plane	14	February	FourStars	Hotel Odessa, Cyprus.
1278	Journey1278	1278	Recreation	2349	3	cyprus	Plane	14	January	TwoStars	App. Basilica, Cyprus.
1279	Journey1279	1279	Bathing	2738	2	cyprus	Plane	14	November	TwoStars	App. Basilica, Cyprus.
1280	Journey1280	1280	Active	1917	3	cyprus	Plane	7	December	TwoStars	App. Basilica, Cyprus.
1281	Journey1281	1281	Bathing	1570	3	malta	Plane	7	November	FourStars	Hotel Preluna, Malta.
1282	Journey1282	1282	Recreation	1998	2	malta	Plane	14	December	FourStars	Hotel Preluna, Malta.
1283	Journey1283	1283	Recreation	2318	2	malta	Plane	14	January	FourStars	Hotel Preluna, Malta.
1284	Journey1284	1284	Active	2329	3	malta	Plane	14	February	FourStars	Hotel Preluna, Malta.
1285	Journey1285	1285	Bathing	1478	2	malta	Plane	14	November	ThreeStars	Hotel Patricia, Malta.
1286	Journey1286	1286	Recreation	2600	4	malta	Plane	14	March	ThreeStars	Hotel Patricia, Malta.
1287	Journey1287	1287	Recreation	1618	2	malta	Plane	14	December	ThreeStars	Hotel Patricia, Malta.
1288	Journey1288	1288	Active	1258	2	malta	Plane	7	January	ThreeStars	Hotel Patricia, Malta.
1289	Journey1289	1289	Bathing	2519	3	malta	Plane	14	November	ThreeStars	Hotel Galaxy, Malta.
1290	Journey1290	1290	Recreation	2038	2	malta	Plane	14	February	ThreeStars	Hotel Galaxy, Malta.
1291	Journey1291	1291	Active	2238	2	malta	Plane	14	December	ThreeStars	Hotel Galaxy, Malta.
1292	Journey1292	1292	Recreation	2519	3	malta	Plane	14	January	ThreeStars	Hotel Galaxy, Malta.
1293	Journey1293	1293	Bathing	1978	2	malta	Plane	14	November	FourStars	App. Sunny Coast, Malta.
1294	Journey1294	1294	Recreation	1922	3	malta	Plane	14	December	FourStars	App. Sunny Coast, Malta.
1295	Journey1295	1295	Active	1428	2	malta	Plane	7	March	FourStars	App. Sunny Coast, Malta.
1296	Journey1296	1296	Bathing	2758	2	morocco	Plane	14	November	ThreeStars	Club Tamlelt, Morocco.
1297	Journey1297	1297	Bathing	3654	3	morocco	Plane	14	November	ThreeStars	Club Tamlelt, Morocco.
1298	Journey1298	1298	Recreation	4502	3	morocco	Plane	14	December	ThreeStars	Club Tamlelt, Morocco.
1299	Journey1299	1299	Active	2268	2	morocco	Plane	7	January	ThreeStars	Club Tamlelt, Morocco.
1300	Journey1300	1300	Bathing	3309	3	morocco	Plane	14	November	ThreeStars	Hotel Sangho, Morocco.
1301	Journey1301	1301	Recreation	3138	2	morocco	Plane	14	February	ThreeStars	Hotel Sangho, Morocco.
1302	Journey1302	1302	Recreation	4422	3	morocco	Plane	14	March	ThreeStars	Hotel Sangho, Morocco.
1303	Journey1303	1303	Active	4079	4	morocco	Plane	14	April	ThreeStars	Hotel Sangho, Morocco.
1304	Journey1304	1304	Bathing	1918	2	morocco	Plane	7	November	ThreeStars	Hotel Kamal, Morocco.
1305	Journey1305	1305	Bathing	3237	3	morocco	Plane	14	November	ThreeStars	Hotel Kamal, Morocco.
1306	Journey1306	1306	Recreation	2438	2	morocco	Plane	14	January	ThreeStars	Hotel Kamal, Morocco.
1307	Journey1307	1307	Active	3615	3	morocco	Plane	14	December	ThreeStars	Hotel Kamal, Morocco.
1308	Journey1308	1308	Bathing	2642	3	morocco	Plane	14	November	ThreeStars	Hotel Aladin, Morocco.
1309	Journey1309	1309	Active	2518	2	morocco	Plane	14	February	ThreeStars	Hotel Aladin, Morocco.
1310	Journey1310	1310	Recreation	3507	3	morocco	Plane	14	March	ThreeStars	Hotel Aladin, Morocco.
1311	Journey1311	1311	Recreation	3687	4	morocco	Plane	14	April	ThreeStars	Hotel Aladin, Morocco.
1312	Journey1312	1312	Bathing	2778	2	morocco	Plane	14	November	ThreeStars	Hotel Ali Baba, Morocco.
1313	Journey1313	1313	Bathing	3680	3	morocco	Plane	14	November	ThreeStars	Hotel Ali Baba, Morocco.
1314	Journey1314	1314	Active	4237	3	morocco	Plane	7	December	ThreeStars	Hotel Ali Baba, Morocco.
1315	Journey1315	1315	Recreation	2938	2	morocco	Plane	14	January	ThreeStars	Hotel Ali Baba, Morocco.
1316	Journey1316	1316	Bathing	3033	3	gran canaria	Plane	14	November	ThreeStars	App. Taboga, Gran Canaria.
1317	Journey1317	1317	Bathing	2758	2	gran canaria	Plane	14	December	ThreeStars	App. Taboga, Gran Canaria.
1318	Journey1318	1318	Active	2638	2	gran canaria	Plane	14	January	ThreeStars	App. Taboga, Gran Canaria.
1319	Journey1319	1319	Bathing	2440	4	gran canaria	Plane	7	February	ThreeStars	Bung. Dona Rosa, Gran Canaria.
1320	Journey1320	1320	Bathing	2770	3	gran canaria	Plane	14	March	ThreeStars	Bung. Dona Rosa, Gran Canaria.
1321	Journey1321	1321	Recreation	2778	2	gran canaria	Plane	14	April	ThreeStars	Bung. Dona Rosa, Gran Canaria.
1322	Journey1322	1322	Bathing	2949	3	gran canaria	Plane	14	January	TwoStars	App. El Cisne, Gran Canaria.
1323	Journey1323	1323	Active	2558	2	gran canaria	Plane	14	February	TwoStars	App. El Cisne, Gran Canaria.
1324	Journey1324	1324	Recreation	2541	3	gran canaria	Plane	14	November	TwoStars	App. El Cisne, Gran Canaria.
1325	Journey1325	1325	Bathing	4077	4	gran canaria	Plane	7	December	TwoStars	App. Las Dunas, Gran Canaria.
1326	Journey1326	1326	Bathing	2758	2	gran canaria	Plane	14	March	TwoStars	App. Las Dunas, Gran Canaria.
1327	Journey1327	1327	Recreation	2658	2	gran canaria	Plane	14	April	TwoStars	App. Las Dunas, Gran Canaria.
1328	Journey1328	1328	Bathing	3495	3	gran canaria	Plane	14	November	FourStars	Hotel Las Margaritas, Gran Canaria.
1329	Journey1329	1329	Active	3338	2	gran canaria	Plane	14	December	FourStars	Hotel Las Margaritas, Gran Canaria.
1330	Journey1330	1330	Recreation	3495	3	gran canaria	Plane	14	January	FourStars	Hotel Las Margaritas, Gran Canaria.
1331	Journey1331	1331	Bathing	4245	3	gran canaria	Plane	14	February	ThreeStars	Bung. Green Golf, Gran Canaria.
1332	Journey1332	1332	Bathing	3538	2	gran canaria	Plane	14	March	ThreeStars	Bung. Green Golf, Gran Canaria.
1333	Journey1333	1333	Active	2781	3	gran canaria	Plane	7	April	ThreeStars	Bung. Green Golf, Gran Canaria.
1334	Journey1334	1334	Bathing	2978	2	gran canaria	Plane	14	November	ThreeStars	App. Koala Garden, Gran Canaria.
1335	Journey1335	1335	Bathing	3717	3	gran canaria	Plane	14	December	ThreeStars	App. Koala Garden, Gran Canaria.
1336	Journey1336	1336	Active	4169	4	gran canaria	Plane	14	January	ThreeStars	App. Koala Garden, Gran Canaria.
1337	Journey1337	1337	Recreation	3158	2	gran canaria	Plane	14	February	ThreeStars	App. Koala Garden, Gran Canaria.
1338	Journey1338	1338	Bathing	3696	3	gran canaria	Plane	14	March	TwoStars	Studio Puerto Plata, Gran Canaria.
1339	Journey1339	1339	Active	2618	2	gran canaria	Plane	14	April	TwoStars	Studio Puerto Plata, Gran Canaria.
1340	Journey1340	1340	Recreation	2618	2	gran canaria	Plane	14	November	TwoStars	Studio Puerto Plata, Gran Canaria.
1341	Journey1341	1341	Bathing	5208	3	fuerteventura	Plane	14	November	FourStars	Hotel Duna Park, Fuerteventura.
1342	Journey1342	1342	Bathing	4398	2	fuerteventura	Plane	14	December	FourStars	Hotel Duna Park, Fuerteventura.
1343	Journey1343	1343	Active	3858	2	fuerteventura	Plane	14	January	FourStars	Hotel Duna Park, Fuerteventura.
1344	Journey1344	1344	Recreation	5937	3	fuerteventura	Plane	14	February	FourStars	Hotel Duna Park, Fuerteventura.
1345	Journey1345	1345	Bathing	3947	3	fuerteventura	Plane	7	November	ThreeStars	App. Las Agujas, Fuerteventura.
1346	Journey1346	1346	Bathing	3298	2	fuerteventura	Plane	14	December	ThreeStars	App. Las Agujas, Fuerteventura.
1347	Journey1347	1347	Active	3298	2	fuerteventura	Plane	14	March	ThreeStars	App. Las Agujas, Fuerteventura.
1348	Journey1348	1348	Recreation	4737	4	fuerteventura	Plane	14	April	ThreeStars	App. Las Agujas, Fuerteventura.
1349	Journey1349	1349	Bathing	4585	3	fuerteventura	Plane	14	November	ThreeStars	Hotel Taro Beach, Fuerteventura.
1350	Journey1350	1350	Bathing	2788	2	fuerteventura	Plane	7	December	ThreeStars	Hotel Taro Beach, Fuerteventura.
1351	Journey1351	1351	Active	4835	3	fuerteventura	Plane	14	January	ThreeStars	Hotel Taro Beach, Fuerteventura.
1352	Journey1352	1352	Active	4048	2	fuerteventura	Plane	14	February	ThreeStars	Hotel Taro Beach, Fuerteventura.
1353	Journey1353	1353	Bathing	3513	3	fuerteventura	Plane	14	November	ThreeStars	App. Rio Tropical, Fuerteventura.
1354	Journey1354	1354	Bathing	4099	4	fuerteventura	Plane	14	November	ThreeStars	App. Rio Tropical, Fuerteventura.
1355	Journey1355	1355	Active	2238	2	fuerteventura	Plane	7	March	ThreeStars	App. Rio Tropical, Fuerteventura.
1356	Journey1356	1356	Recreation	2828	2	fuerteventura	Plane	14	April	ThreeStars	App. Rio Tropical, Fuerteventura.
1357	Journey1357	1357	Bathing	4303	3	fuerteventura	Plane	14	November	ThreeStars	Hotel Crystal Beach, Fuerteventura.
1358	Journey1358	1358	Bathing	3488	2	fuerteventura	Plane	14	December	ThreeStars	Hotel Crystal Beach, Fuerteventura.
1359	Journey1359	1359	Active	4708	3	fuerteventura	Plane	14	February	ThreeStars	Hotel Crystal Beach, Fuerteventura.
1360	Journey1360	1360	Recreation	4708	3	fuerteventura	Plane	14	March	ThreeStars	Hotel Crystal Beach, Fuerteventura.
1361	Journey1361	1361	Bathing	2228	2	fuerteventura	Plane	14	January	ThreeStars	Bung. Solymae, Fuerteventura.
1362	Journey1362	1362	Bathing	2601	3	fuerteventura	Plane	14	November	ThreeStars	Bung. Solymae, Fuerteventura.
1363	Journey1363	1363	Bathing	3231	4	fuerteventura	Plane	14	December	ThreeStars	Bung. Solymae, Fuerteventura.
1364	Journey1364	1364	Active	1898	2	fuerteventura	Plane	7	February	ThreeStars	Bung. Solymae, Fuerteventura.
1365	Journey1365	1365	Recreation	2308	2	fuerteventura	Plane	14	March	ThreeStars	Bung. Solymae, Fuerteventura.
1366	Journey1366	1366	Bathing	1868	2	lanzarote	Plane	7	November	TwoStars	App. Lanzarote Beach, Lanzarote.
1367	Journey1367	1367	Bathing	2688	3	lanzarote	Plane	14	December	TwoStars	App. Lanzarote Beach, Lanzarote.
1368	Journey1368	1368	Active	2298	2	lanzarote	Plane	14	January	TwoStars	App. Lanzarote Beach, Lanzarote.
1369	Journey1369	1369	Recreation	2688	3	lanzarote	Plane	14	February	TwoStars	App. Lanzarote Beach, Lanzarote.
1370	Journey1370	1370	Bathing	3298	2	lanzarote	Plane	14	March	ThreeStars	Hotel Costa Salinas, Lanzarote.
1371	Journey1371	1371	Bathing	4947	4	lanzarote	Plane	14	April	ThreeStars	Hotel Costa Salinas, Lanzarote.
1372	Journey1372	1372	Active	2268	2	lanzarote	Plane	7	November	ThreeStars	Hotel Costa Salinas, Lanzarote.
1373	Journey1373	1373	Recreation	3298	2	lanzarote	Plane	14	December	ThreeStars	Hotel Costa Salinas, Lanzarote.
1374	Journey1374	1374	Bathing	5716	4	lanzarote	Plane	14	January	TwoStars	App. Los Rosales, Lanzarote.
1375	Journey1375	1375	Bathing	3158	2	lanzarote	Plane	14	February	TwoStars	App. Los Rosales, Lanzarote.
1376	Journey1376	1376	Active	4317	3	lanzarote	Plane	14	March	TwoStars	App. Los Rosales, Lanzarote.
1377	Journey1377	1377	Recreation	2318	2	lanzarote	Plane	7	April	TwoStars	App. Los Rosales, Lanzarote.
1378	Journey1378	1378	Bathing	3438	2	lanzarote	Plane	14	November	FourStars	Hotel SOL Lanzarote, Lanzarote.
1379	Journey1379	1379	Bathing	4872	3	lanzarote	Plane	14	December	FourStars	Hotel SOL Lanzarote, Lanzarote.
1380	Journey1380	1380	Active	3638	2	lanzarote	Plane	14	January	FourStars	Hotel SOL Lanzarote, Lanzarote.
1381	Journey1381	1381	Recreation	4872	3	lanzarote	Plane	14	February	FourStars	Hotel SOL Lanzarote, Lanzarote.
1382	Journey1382	1382	Bathing	3657	4	lanzarote	Plane	14	March	TwoStars	App. Los Lajones, Lanzarote.
1383	Journey1383	1383	Bathing	2438	2	lanzarote	Plane	14	April	TwoStars	App. Los Lajones, Lanzarote.
1384	Journey1384	1384	Active	2308	2	lanzarote	Plane	7	November	TwoStars	App. Los Lajones, Lanzarote.
1385	Journey1385	1385	Recreation	3047	3	lanzarote	Plane	14	December	TwoStars	App. Los Lajones, Lanzarote.
1386	Journey1386	1386	Bathing	3188	2	teneriffe	Plane	14	November	ThreeStars	Hotel SOL Teneriffe, Teneriffe.
1387	Journey1387	1387	Bathing	4356	3	teneriffe	Plane	14	December	ThreeStars	Hotel SOL Teneriffe, Teneriffe.
1388	Journey1388	1388	Active	2308	2	teneriffe	Plane	7	January	ThreeStars	Hotel SOL Teneriffe, Teneriffe.
1389	Journey1389	1389	Recreation	5854	4	teneriffe	Plane	14	February	ThreeStars	Hotel SOL Teneriffe, Teneriffe.
1390	Journey1390	1390	Bathing	4535	3	teneriffe	Plane	14	March	ThreeStars	App. Lagos de Fanabe, Teneriffe.
1391	Journey1391	1391	Bathing	4120	4	teneriffe	Plane	14	April	ThreeStars	App. Lagos de Fanabe, Teneriffe.
1392	Journey1392	1392	Recreation	3368	2	teneriffe	Plane	14	November	ThreeStars	App. Lagos de Fanabe, Teneriffe.
1393	Journey1393	1393	Active	3468	2	teneriffe	Plane	14	December	ThreeStars	App. Lagos de Fanabe, Teneriffe.
1394	Journey1394	1394	Bathing	2138	2	teneriffe	Plane	7	January	ThreeStars	Hotel Paraiso Floral, Teneriffe.
1395	Journey1395	1395	Bathing	3482	3	teneriffe	Plane	14	February	ThreeStars	Hotel Paraiso Floral, Teneriffe.
1396	Journey1396	1396	Recreation	3482	3	teneriffe	Plane	14	March	ThreeStars	Hotel Paraiso Floral, Teneriffe.
1397	Journey1397	1397	Active	3624	4	teneriffe	Plane	14	April	ThreeStars	Hotel Paraiso Floral, Teneriffe.
1398	Journey1398	1398	Bathing	3098	2	teneriffe	Plane	14	November	FourStars	Hotel Esmeralda Playa, Teneriffe.
1399	Journey1399	1399	Bathing	2805	3	teneriffe	Plane	7	December	FourStars	Hotel Esmeralda Playa, Teneriffe.
1400	Journey1400	1400	Active	3098	2	teneriffe	Plane	14	January	FourStars	Hotel Esmeralda Playa, Teneriffe.
1401	Journey1401	1401	Recreation	3578	2	teneriffe	Plane	14	February	FourStars	Hotel Esmeralda Playa, Teneriffe.
1402	Journey1402	1402	Bathing	2922	3	teneriffe	Plane	14	March	TwoStars	Studio Malibu Park, Teneriffe.
1403	Journey1403	1403	Bathing	3297	4	teneriffe	Plane	14	April	TwoStars	Studio Malibu Park, Teneriffe.
1404	Journey1404	1404	Active	1758	2	teneriffe	Plane	7	November	TwoStars	Studio Malibu Park, Teneriffe.
1405	Journey1405	1405	Recreation	2108	2	teneriffe	Plane	14	December	TwoStars	Studio Malibu Park, Teneriffe.
1406	Journey1406	1406	Bathing	3548	2	teneriffe	Plane	14	January	FourStars	Hotel Conquistador, Teneriffe.
1407	Journey1407	1407	Recreation	4977	3	teneriffe	Plane	14	February	FourStars	Hotel Conquistador, Teneriffe.
1408	Journey1408	1408	Bathing	4182	4	teneriffe	Plane	14	March	ThreeStars	Anlage El Chaparral, Teneriffe.
1409	Journey1409	1409	Bathing	2664	3	teneriffe	Plane	7	April	ThreeStars	Anlage El Chaparral, Teneriffe.
1410	Journey1410	1410	Active	2698	2	teneriffe	Plane	14	November	ThreeStars	Anlage El Chaparral, Teneriffe.
1411	Journey1411	1411	Bathing	2628	2	lanzarote	Plane	14	November	ThreeStars	Studio Hyde Park, Lanzarote.
1412	Journey1412	1412	Bathing	3510	3	lanzarote	Plane	14	December	ThreeStars	Studio Hyde Park, Lanzarote.
1413	Journey1413	1413	Active	3460	3	lanzarote	Plane	14	January	ThreeStars	Studio Hyde Park, Lanzarote.
1414	Journey1414	1414	Recreation	2108	2	lanzarote	Plane	7	February	ThreeStars	Studio Hyde Park, Lanzarote.
1415	Journey1415	1415	Bathing	3597	3	lanzarote	Plane	14	March	ThreeStars	Hotel Puerto Carmen, Lanzarote.
1416	Journey1416	1416	Bathing	2788	2	lanzarote	Plane	14	April	ThreeStars	Hotel Puerto Carmen, Lanzarote.
1417	Journey1417	1417	Active	2788	2	lanzarote	Plane	14	November	ThreeStars	Hotel Puerto Carmen, Lanzarote.
1418	Journey1418	1418	Recreation	3597	3	lanzarote	Plane	14	December	ThreeStars	Hotel Puerto Carmen, Lanzarote.
1419	Journey1419	1419	Bathing	6132	4	lanzarote	Plane	7	January	FourStars	Hotel La Geria, Lanzarote.
1420	Journey1420	1420	Bathing	4288	2	lanzarote	Plane	14	February	FourStars	Hotel La Geria, Lanzarote.
1421	Journey1421	1421	Active	4088	2	lanzarote	Plane	14	January	FourStars	Hotel La Geria, Lanzarote.
1422	Journey1422	1422	Recreation	5360	3	lanzarote	Plane	14	March	FourStars	Hotel La Geria, Lanzarote.
1423	Journey1423	1423	Bathing	3627	4	lanzarote	Plane	14	April	TwoStars	Bung. Playa Roca, Lanzarote.
1424	Journey1424	1424	Bathing	2558	2	lanzarote	Plane	14	November	TwoStars	Bung. Playa Roca, Lanzarote.
1425	Journey1425	1425	Active	6045	5	lanzarote	Plane	7	December	TwoStars	Bung. Playa Roca, Lanzarote.
1426	Journey1426	1426	Active	3102	3	lanzarote	Plane	14	January	TwoStars	Bung. Playa Roca, Lanzarote.
1427	Journey1427	1427	Bathing	3328	2	lanzarote	Plane	14	February	ThreeStars	Hotel Lanzarote Gardens, Lanzarote.
1428	Journey1428	1428	Bathing	3827	3	lanzarote	Plane	14	March	ThreeStars	Hotel Lanzarote Gardens, Lanzarote.
1429	Journey1429	1429	Active	2988	2	lanzarote	Plane	14	April	ThreeStars	Hotel Lanzarote Gardens, Lanzarote.
1430	Journey1430	1430	Recreation	3436	3	lanzarote	Plane	14	November	ThreeStars	Hotel Lanzarote Gardens, Lanzarote.
1431	Journey1431	1431	Bathing	3658	2	lanzarote	Plane	14	December	FourStars	Hotel Lanzarote Princess, Lanzarote.
1432	Journey1432	1432	Active	4247	3	lanzarote	Plane	14	January	FourStars	Hotel Lanzarote Princess, Lanzarote.
1433	Journey1433	1433	Recreation	3658	2	lanzarote	Plane	14	February	FourStars	Hotel Lanzarote Princess, Lanzarote.
1434	Journey1434	1434	Bathing	2688	4	lanzarote	Plane	14	March	FourStars	Bung. Atlantic Gardens, Lanzarote.
1435	Journey1435	1435	Active	2548	2	lanzarote	Plane	14	April	FourStars	Bung. Atlantic Gardens, Lanzarote.
1436	Journey1436	1436	Bathing	2278	2	turkish riviera	Plane	14	November	FiveStars	Hotel Favori Aqua Resort, Turk. Riviera.
1437	Journey1437	1437	Bathing	2181	3	turkish riviera	Plane	7	December	FiveStars	Hotel Favori Aqua Resort, Turk. Riviera.
1438	Journey1438	1438	Active	2278	2	turkish riviera	Plane	14	January	FiveStars	Hotel Favori Aqua Resort, Turk. Riviera.
1439	Journey1439	1439	Recreation	2378	2	turkish riviera	Plane	14	February	FiveStars	Hotel Favori Aqua Resort, Turk. Riviera.
1440	Journey1440	1440	Bathing	2358	2	turkish riviera	Plane	14	November	FiveStars	Club-Hotel Sera, Turk. Riviera.
1441	Journey1441	1441	Bathing	3065	3	turkish riviera	Plane	14	December	FiveStars	Club-Hotel Sera, Turk. Riviera.
1442	Journey1442	1442	Recreation	2418	2	turkish riviera	Plane	14	March	FiveStars	Club-Hotel Sera, Turk. Riviera.
1443	Journey1443	1443	Bathing	1518	2	turkish riviera	Plane	14	December	ThreeStars	Hotel Santana, Turk. Riviera.
1444	Journey1444	1444	Bathing	1817	4	turkish riviera	Plane	7	November	ThreeStars	Hotel Santana, Turk. Riviera.
1445	Journey1445	1445	Active	1578	2	turkish riviera	Plane	14	February	ThreeStars	Hotel Santana, Turk. Riviera.
1446	Journey1446	1446	Active	1518	2	turkish riviera	Plane	14	January	ThreeStars	Hotel Santana, Turk. Riviera.
1447	Journey1447	1447	Bathing	2394	3	turkish riviera	Plane	14	December	FourStars	Hotel Sueral, Turk. Riviera.
1448	Journey1448	1448	Bathing	2038	2	turkish riviera	Plane	14	January	FourStars	Hotel Sueral, Turk. Riviera.
1449	Journey1449	1449	Active	2104	3	turkish riviera	Plane	7	February	FourStars	Hotel Sueral, Turk. Riviera.
1450	Journey1450	1450	Recreation	2238	2	turkish riviera	Plane	14	March	FourStars	Hotel Sueral, Turk. Riviera.
1451	Journey1451	1451	Bathing	1498	2	tunisia	Plane	14	November	ThreeStars	Hotel Aqua Viva, Tunisia.
1452	Journey1452	1452	Active	1607	3	tunisia	Plane	7	December	ThreeStars	Hotel Aqua Viva, Tunisia.
1453	Journey1453	1453	Recreation	1607	3	tunisia	Plane	14	January	ThreeStars	Hotel Aqua Viva, Tunisia.
1454	Journey1454	1454	Recreation	1895	4	tunisia	Plane	7	February	ThreeStars	Hotel Aqua Viva, Tunisia.
1455	Journey1455	1455	Bathing	1518	2	tunisia	Plane	14	November	TwoStars	Hotel Amilcar, Tunisia.
1456	Journey1456	1456	Active	1658	2	tunisia	Plane	14	March	TwoStars	Hotel Amilcar, Tunisia.
1457	Journey1457	1457	Recreation	1745	3	tunisia	Plane	7	November	TwoStars	Hotel Amilcar, Tunisia.
1458	Journey1458	1458	Active	1518	2	tunisia	Plane	14	December	TwoStars	Hotel Amilcar, Tunisia.
1459	Journey1459	1459	Bathing	2118	2	tunisia	Plane	14	November	FourStars	Club Calimera, Tunisia.
1460	Journey1460	1460	Active	2078	2	tunisia	Plane	14	January	FourStars	Club Calimera, Tunisia.
1461	Journey1461	1461	Active	3297	3	tunisia	Plane	21	February	FourStars	Club Calimera, Tunisia.
1462	Journey1462	1462	Active	3957	4	tunisia	Plane	14	March	FourStars	Club Calimera, Tunisia.
1463	Journey1463	1463	Bathing	2373	3	tunisia	Plane	7	November	ThreeStars	Hotel Quatre Saisons, Tunisia.
1464	Journey1464	1464	Active	2346	4	tunisia	Plane	14	November	ThreeStars	Hotel Quatre Saisons, Tunisia.
1465	Journey1465	1465	Recreation	1878	2	tunisia	Plane	14	December	ThreeStars	Hotel Quatre Saisons, Tunisia.
1466	Journey1466	1466	Recreation	1765	3	tunisia	Plane	7	January	ThreeStars	Hotel Quatre Saisons, Tunisia.
1467	Journey1467	1467	Bathing	1438	2	tunisia	Plane	14	November	TwoStars	Hotel El Ksar, Tunisia.
1468	Journey1468	1468	Active	1905	3	tunisia	Plane	14	February	TwoStars	Hotel El Ksar, Tunisia.
1469	Journey1469	1469	Recreation	1438	2	tunisia	Plane	7	March	TwoStars	Hotel El Ksar, Tunisia.
1470	Journey1470	1470	Recreation	1438	2	tunisia	Plane	14	November	TwoStars	Hotel El Ksar, Tunisia.
\.


--
-- Name: cases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('cases_id_seq', 1470, true);


--
-- Data for Name: regions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY regions (id, region_name, latitude, longitude) FROM stdin;
1	malta	35.937496000000003	14.3754159999999995
2	north sea	56.511018	3.515625
3	atlantic	46.5135160000000027	-1.73583979999999993
4	lower austria	48.1080770000000015	15.8049560000000007
5	carinthia	46.7222030000000004	14.1805880000000002
6	england	52.3555179999999964	-1.17432000000000003
7	bavaria	48.7904470000000003	11.4978890000000007
8	lanzarote	29.0468539999999997	-13.5899730000000005
9	holland	52.1326329999999984	5.29126600000000025
10	algarve	37.2454248000000021	-8.15092517307923004
11	bulgaria	42.7338829999999987	25.48583
12	czechia	49.8174920000000014	15.4729620000000008
13	fano	43.839815999999999	13.0194200000000002
14	riviera	44.4971519999999998	8.95343599999999995
15	dolomites	46.4102120000000014	11.8440349999999999
16	attica	40.2942040000000006	-87.2488989999999944
17	lolland	54.7275429999999972	11.4649300000000007
18	ireland	53.4129099999999966	-8.24389000000000038
19	slowakei	48.6690260000000023	19.6990240000000014
20	allgaeu	47.7852786999999992	11.6243292999999994
21	cairo	30.0444199999999988	31.2357119999999995
22	alps	46.8876190000000008	9.65699960000000068
23	salzberger land	47.8094899999999967	13.0550099999999993
24	scotland	56.490670999999999	-4.20264599999999966
25	balaton	46.8302679999999967	17.7340440000000008
26	black forest	47.841543999999999	7.96064099999999986
27	egypt	26.8205530000000003	30.8024979999999999
28	styria	47.3593440000000001	14.4699829999999992
29	corfu	39.6242620000000016	19.921678
30	lake garda	45.6049390000000017	10.6351410000000008
31	corsica	42.0396039999999971	9.01289300000000004
32	thuringia	51.0109890000000021	10.8453459999999993
33	harz	51.8095250000000007	10.2383609999999994
34	tunisia	33.8869169999999968	9.53749900000000039
35	rhodes	36.4349630000000033	28.2174830000000014
36	mallorca	39.6952629999999971	3.01757099999999978
37	costa brava	42.2755269999999967	3.01757099999999978
38	fuerteventura	28.3587440000000015	-14.0536759999999994
39	salzkammergut	47.7000000000000028	13.5800000000000001
40	madeira	32.7607069999999965	-16.9594720000000017
41	crete	35.2401169999999979	24.8092690000000005
42	bornholm	55.1604280000000031	14.8668840000000007
43	erz gebirge	50.5799999999999983	13
44	coted azur	43.1203590000000005	6.92091299999999965
45	giant mountains	50.7672219999999967	15.6222220000000007
46	chalkidiki	40.3695000000000022	23.2870850000000011
47	brittany	48.2020470000000003	-2.93264399999999981
48	teneriffe	28.291564000000001	-16.62913
49	baltic sea	58.4879519999999999	19.8632810000000006
50	turkish aegean sea	39.0504279999999966	23.429984000000001
51	wales	52.1306610000000035	-3.78371199999999996
52	poland	51.9194379999999995	19.1451360000000008
53	ibiza	38.9067340000000002	1.42059800000000003
54	adriatic sea	43.7021513999999982	14.6679464999999993
55	cyprus	35.1264129999999994	33.4298590000000004
56	tyrol	47.253740999999998	11.6014870000000005
57	morocco	31.7917020000000008	-7.09262000000000015
58	gran canaria	27.9202200000000005	-15.5474370000000004
59	turkish riviera	37.0025529999999989	28.0151369999999993
60	denmark	56.2639199999999988	9.50178499999999993
61	belgium	50.5038869999999989	4.46993599999999969
62	france	46.2276379999999989	2.21374899999999997
63	costa blanca	38.5043840000000017	-0.264344999999999997
64	sweden	60.1281609999999986	18.6435010000000005
65	normandy	48.8798699999999968	0.171252999999999989
\.


--
-- Name: regions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('regions_id_seq', 65, true);


--
-- Name: cases_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cases
    ADD CONSTRAINT cases_pkey PRIMARY KEY (id);


--
-- Name: regions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (id);


--
-- Name: public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

