--
-- PostgreSQL database dump
--

-- Dumped from database version 15.12
-- Dumped by pg_dump version 15.12

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
-- Name: analytics; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.analytics (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json NOT NULL
);


ALTER TABLE public.analytics OWNER TO wikijs;

--
-- Name: apiKeys; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."apiKeys" (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    key text NOT NULL,
    expiration character varying(255) NOT NULL,
    "isRevoked" boolean DEFAULT false NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL
);


ALTER TABLE public."apiKeys" OWNER TO wikijs;

--
-- Name: apiKeys_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."apiKeys_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."apiKeys_id_seq" OWNER TO wikijs;

--
-- Name: apiKeys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."apiKeys_id_seq" OWNED BY public."apiKeys".id;


--
-- Name: assetData; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."assetData" (
    id integer NOT NULL,
    data bytea NOT NULL
);


ALTER TABLE public."assetData" OWNER TO wikijs;

--
-- Name: assetFolders; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."assetFolders" (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    "parentId" integer
);


ALTER TABLE public."assetFolders" OWNER TO wikijs;

--
-- Name: assetFolders_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."assetFolders_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."assetFolders_id_seq" OWNER TO wikijs;

--
-- Name: assetFolders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."assetFolders_id_seq" OWNED BY public."assetFolders".id;


--
-- Name: assets; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.assets (
    id integer NOT NULL,
    filename character varying(255) NOT NULL,
    hash character varying(255) NOT NULL,
    ext character varying(255) NOT NULL,
    kind text DEFAULT 'binary'::text NOT NULL,
    mime character varying(255) DEFAULT 'application/octet-stream'::character varying NOT NULL,
    "fileSize" integer,
    metadata json,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "folderId" integer,
    "authorId" integer,
    CONSTRAINT assets_kind_check CHECK ((kind = ANY (ARRAY['binary'::text, 'image'::text])))
);


ALTER TABLE public.assets OWNER TO wikijs;

--
-- Name: COLUMN assets."fileSize"; Type: COMMENT; Schema: public; Owner: wikijs
--

COMMENT ON COLUMN public.assets."fileSize" IS 'In kilobytes';


--
-- Name: assets_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.assets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.assets_id_seq OWNER TO wikijs;

--
-- Name: assets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.assets_id_seq OWNED BY public.assets.id;


--
-- Name: authentication; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.authentication (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json NOT NULL,
    "selfRegistration" boolean DEFAULT false NOT NULL,
    "domainWhitelist" json NOT NULL,
    "autoEnrollGroups" json NOT NULL,
    "order" integer DEFAULT 0 NOT NULL,
    "strategyKey" character varying(255) DEFAULT ''::character varying NOT NULL,
    "displayName" character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.authentication OWNER TO wikijs;

--
-- Name: brute; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.brute (
    key character varying(255),
    "firstRequest" bigint,
    "lastRequest" bigint,
    lifetime bigint,
    count integer
);


ALTER TABLE public.brute OWNER TO wikijs;

--
-- Name: commentProviders; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."commentProviders" (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json NOT NULL
);


ALTER TABLE public."commentProviders" OWNER TO wikijs;

--
-- Name: comments; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.comments (
    id integer NOT NULL,
    content text NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "pageId" integer,
    "authorId" integer,
    render text DEFAULT ''::text NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    ip character varying(255) DEFAULT ''::character varying NOT NULL,
    "replyTo" integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.comments OWNER TO wikijs;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comments_id_seq OWNER TO wikijs;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: editors; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.editors (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json NOT NULL
);


ALTER TABLE public.editors OWNER TO wikijs;

--
-- Name: groups; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.groups (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    permissions json NOT NULL,
    "pageRules" json NOT NULL,
    "isSystem" boolean DEFAULT false NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "redirectOnLogin" character varying(255) DEFAULT '/'::character varying NOT NULL
);


ALTER TABLE public.groups OWNER TO wikijs;

--
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.groups_id_seq OWNER TO wikijs;

--
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.groups_id_seq OWNED BY public.groups.id;


--
-- Name: locales; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.locales (
    code character varying(5) NOT NULL,
    strings json,
    "isRTL" boolean DEFAULT false NOT NULL,
    name character varying(255) NOT NULL,
    "nativeName" character varying(255) NOT NULL,
    availability integer DEFAULT 0 NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL
);


ALTER TABLE public.locales OWNER TO wikijs;

--
-- Name: loggers; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.loggers (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    level character varying(255) DEFAULT 'warn'::character varying NOT NULL,
    config json
);


ALTER TABLE public.loggers OWNER TO wikijs;

--
-- Name: migrations; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    name character varying(255),
    batch integer,
    migration_time timestamp with time zone
);


ALTER TABLE public.migrations OWNER TO wikijs;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO wikijs;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: migrations_lock; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.migrations_lock (
    index integer NOT NULL,
    is_locked integer
);


ALTER TABLE public.migrations_lock OWNER TO wikijs;

--
-- Name: migrations_lock_index_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.migrations_lock_index_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_lock_index_seq OWNER TO wikijs;

--
-- Name: migrations_lock_index_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.migrations_lock_index_seq OWNED BY public.migrations_lock.index;


--
-- Name: navigation; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.navigation (
    key character varying(255) NOT NULL,
    config json
);


ALTER TABLE public.navigation OWNER TO wikijs;

--
-- Name: pageHistory; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."pageHistory" (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    hash character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    description character varying(255),
    "isPrivate" boolean DEFAULT false NOT NULL,
    "isPublished" boolean DEFAULT false NOT NULL,
    "publishStartDate" character varying(255),
    "publishEndDate" character varying(255),
    action character varying(255) DEFAULT 'updated'::character varying,
    "pageId" integer,
    content text,
    "contentType" character varying(255) NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "editorKey" character varying(255),
    "localeCode" character varying(5),
    "authorId" integer,
    "versionDate" character varying(255) DEFAULT ''::character varying NOT NULL,
    extra json DEFAULT '{}'::json NOT NULL
);


ALTER TABLE public."pageHistory" OWNER TO wikijs;

--
-- Name: pageHistoryTags; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."pageHistoryTags" (
    id integer NOT NULL,
    "pageId" integer,
    "tagId" integer
);


ALTER TABLE public."pageHistoryTags" OWNER TO wikijs;

--
-- Name: pageHistoryTags_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."pageHistoryTags_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."pageHistoryTags_id_seq" OWNER TO wikijs;

--
-- Name: pageHistoryTags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."pageHistoryTags_id_seq" OWNED BY public."pageHistoryTags".id;


--
-- Name: pageHistory_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."pageHistory_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."pageHistory_id_seq" OWNER TO wikijs;

--
-- Name: pageHistory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."pageHistory_id_seq" OWNED BY public."pageHistory".id;


--
-- Name: pageLinks; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."pageLinks" (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    "localeCode" character varying(5) NOT NULL,
    "pageId" integer
);


ALTER TABLE public."pageLinks" OWNER TO wikijs;

--
-- Name: pageLinks_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."pageLinks_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."pageLinks_id_seq" OWNER TO wikijs;

--
-- Name: pageLinks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."pageLinks_id_seq" OWNED BY public."pageLinks".id;


--
-- Name: pageTags; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."pageTags" (
    id integer NOT NULL,
    "pageId" integer,
    "tagId" integer
);


ALTER TABLE public."pageTags" OWNER TO wikijs;

--
-- Name: pageTags_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."pageTags_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."pageTags_id_seq" OWNER TO wikijs;

--
-- Name: pageTags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."pageTags_id_seq" OWNED BY public."pageTags".id;


--
-- Name: pageTree; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."pageTree" (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    depth integer NOT NULL,
    title character varying(255) NOT NULL,
    "isPrivate" boolean DEFAULT false NOT NULL,
    "isFolder" boolean DEFAULT false NOT NULL,
    "privateNS" character varying(255),
    parent integer,
    "pageId" integer,
    "localeCode" character varying(5),
    ancestors json
);


ALTER TABLE public."pageTree" OWNER TO wikijs;

--
-- Name: pages; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.pages (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    hash character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    description character varying(255),
    "isPrivate" boolean DEFAULT false NOT NULL,
    "isPublished" boolean DEFAULT false NOT NULL,
    "privateNS" character varying(255),
    "publishStartDate" character varying(255),
    "publishEndDate" character varying(255),
    content text,
    render text,
    toc json,
    "contentType" character varying(255) NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "editorKey" character varying(255),
    "localeCode" character varying(5),
    "authorId" integer,
    "creatorId" integer,
    extra json DEFAULT '{}'::json NOT NULL
);


ALTER TABLE public.pages OWNER TO wikijs;

--
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.pages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pages_id_seq OWNER TO wikijs;

--
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.pages_id_seq OWNED BY public.pages.id;


--
-- Name: renderers; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.renderers (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json
);


ALTER TABLE public.renderers OWNER TO wikijs;

--
-- Name: searchEngines; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."searchEngines" (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json
);


ALTER TABLE public."searchEngines" OWNER TO wikijs;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.sessions (
    sid character varying(255) NOT NULL,
    sess json NOT NULL,
    expired timestamp with time zone NOT NULL
);


ALTER TABLE public.sessions OWNER TO wikijs;

--
-- Name: settings; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.settings (
    key character varying(255) NOT NULL,
    value json,
    "updatedAt" character varying(255) NOT NULL
);


ALTER TABLE public.settings OWNER TO wikijs;

--
-- Name: storage; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.storage (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    mode character varying(255) DEFAULT 'push'::character varying NOT NULL,
    config json,
    "syncInterval" character varying(255),
    state json
);


ALTER TABLE public.storage OWNER TO wikijs;

--
-- Name: tags; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.tags (
    id integer NOT NULL,
    tag character varying(255) NOT NULL,
    title character varying(255),
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL
);


ALTER TABLE public.tags OWNER TO wikijs;

--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tags_id_seq OWNER TO wikijs;

--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;


--
-- Name: userAvatars; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."userAvatars" (
    id integer NOT NULL,
    data bytea NOT NULL
);


ALTER TABLE public."userAvatars" OWNER TO wikijs;

--
-- Name: userGroups; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."userGroups" (
    id integer NOT NULL,
    "userId" integer,
    "groupId" integer
);


ALTER TABLE public."userGroups" OWNER TO wikijs;

--
-- Name: userGroups_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."userGroups_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."userGroups_id_seq" OWNER TO wikijs;

--
-- Name: userGroups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."userGroups_id_seq" OWNED BY public."userGroups".id;


--
-- Name: userKeys; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."userKeys" (
    id integer NOT NULL,
    kind character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "validUntil" character varying(255) NOT NULL,
    "userId" integer
);


ALTER TABLE public."userKeys" OWNER TO wikijs;

--
-- Name: userKeys_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."userKeys_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."userKeys_id_seq" OWNER TO wikijs;

--
-- Name: userKeys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."userKeys_id_seq" OWNED BY public."userKeys".id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "providerId" character varying(255),
    password character varying(255),
    "tfaIsActive" boolean DEFAULT false NOT NULL,
    "tfaSecret" character varying(255),
    "jobTitle" character varying(255) DEFAULT ''::character varying,
    location character varying(255) DEFAULT ''::character varying,
    "pictureUrl" character varying(255),
    timezone character varying(255) DEFAULT 'America/New_York'::character varying NOT NULL,
    "isSystem" boolean DEFAULT false NOT NULL,
    "isActive" boolean DEFAULT false NOT NULL,
    "isVerified" boolean DEFAULT false NOT NULL,
    "mustChangePwd" boolean DEFAULT false NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "providerKey" character varying(255) DEFAULT 'local'::character varying NOT NULL,
    "localeCode" character varying(5) DEFAULT 'en'::character varying NOT NULL,
    "defaultEditor" character varying(255) DEFAULT 'markdown'::character varying NOT NULL,
    "lastLoginAt" character varying(255),
    "dateFormat" character varying(255) DEFAULT ''::character varying NOT NULL,
    appearance character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.users OWNER TO wikijs;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO wikijs;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: apiKeys id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."apiKeys" ALTER COLUMN id SET DEFAULT nextval('public."apiKeys_id_seq"'::regclass);


--
-- Name: assetFolders id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."assetFolders" ALTER COLUMN id SET DEFAULT nextval('public."assetFolders_id_seq"'::regclass);


--
-- Name: assets id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.assets ALTER COLUMN id SET DEFAULT nextval('public.assets_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: groups id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.groups ALTER COLUMN id SET DEFAULT nextval('public.groups_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: migrations_lock index; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.migrations_lock ALTER COLUMN index SET DEFAULT nextval('public.migrations_lock_index_seq'::regclass);


--
-- Name: pageHistory id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistory" ALTER COLUMN id SET DEFAULT nextval('public."pageHistory_id_seq"'::regclass);


--
-- Name: pageHistoryTags id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistoryTags" ALTER COLUMN id SET DEFAULT nextval('public."pageHistoryTags_id_seq"'::regclass);


--
-- Name: pageLinks id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageLinks" ALTER COLUMN id SET DEFAULT nextval('public."pageLinks_id_seq"'::regclass);


--
-- Name: pageTags id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTags" ALTER COLUMN id SET DEFAULT nextval('public."pageTags_id_seq"'::regclass);


--
-- Name: pages id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.pages ALTER COLUMN id SET DEFAULT nextval('public.pages_id_seq'::regclass);


--
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- Name: userGroups id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userGroups" ALTER COLUMN id SET DEFAULT nextval('public."userGroups_id_seq"'::regclass);


--
-- Name: userKeys id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userKeys" ALTER COLUMN id SET DEFAULT nextval('public."userKeys_id_seq"'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: analytics; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.analytics (key, "isEnabled", config) FROM stdin;
azureinsights	f	{"instrumentationKey":""}
baidutongji	f	{"propertyTrackingId":""}
countly	f	{"appKey":"","serverUrl":""}
elasticapm	f	{"serverUrl":"http://apm.example.com:8200","serviceName":"wiki-js","environment":""}
fathom	f	{"host":"","siteId":""}
fullstory	f	{"org":""}
google	f	{"propertyTrackingId":""}
gtm	f	{"containerTrackingId":""}
hotjar	f	{"siteId":""}
matomo	f	{"siteId":1,"serverHost":"https://example.matomo.cloud"}
newrelic	f	{"licenseKey":"","appId":"","beacon":"bam.nr-data.net","errorBeacon":"bam.nr-data.net"}
plausible	f	{"domain":"","plausibleJsSrc":"https://plausible.io/js/plausible.js"}
statcounter	f	{"projectId":"","securityToken":""}
umami	f	{"websiteID":"","url":""}
umami2	f	{"websiteID":"","url":""}
yandex	f	{"tagNumber":""}
\.


--
-- Data for Name: apiKeys; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."apiKeys" (id, name, key, expiration, "isRevoked", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: assetData; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."assetData" (id, data) FROM stdin;
\.


--
-- Data for Name: assetFolders; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."assetFolders" (id, name, slug, "parentId") FROM stdin;
\.


--
-- Data for Name: assets; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.assets (id, filename, hash, ext, kind, mime, "fileSize", metadata, "createdAt", "updatedAt", "folderId", "authorId") FROM stdin;
\.


--
-- Data for Name: authentication; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.authentication (key, "isEnabled", config, "selfRegistration", "domainWhitelist", "autoEnrollGroups", "order", "strategyKey", "displayName") FROM stdin;
local	t	{}	f	{"v":[]}	{"v":[]}	0	local	Local
\.


--
-- Data for Name: brute; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.brute (key, "firstRequest", "lastRequest", lifetime, count) FROM stdin;
\.


--
-- Data for Name: commentProviders; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."commentProviders" (key, "isEnabled", config) FROM stdin;
artalk	f	{"server":"","siteName":""}
commento	f	{"instanceUrl":"https://cdn.commento.io"}
default	t	{"akismet":"","minDelay":30}
disqus	f	{"accountName":""}
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.comments (id, content, "createdAt", "updatedAt", "pageId", "authorId", render, name, email, ip, "replyTo") FROM stdin;
1	This is a comment!	2025-03-11T19:31:38.758Z	2025-03-11T19:31:38.758Z	2	1	<p>This is a comment!</p>\n	Administrator	motorcycle_mania@gmail.com	172.19.0.1	0
\.


--
-- Data for Name: editors; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.editors (key, "isEnabled", config) FROM stdin;
api	f	{}
asciidoc	f	{}
ckeditor	f	{}
code	f	{}
markdown	t	{}
redirect	f	{}
wysiwyg	f	{}
\.


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.groups (id, name, permissions, "pageRules", "isSystem", "createdAt", "updatedAt", "redirectOnLogin") FROM stdin;
1	Administrators	["manage:system"]	[]	t	2025-03-11T03:11:18.308Z	2025-03-11T03:11:18.308Z	/
2	Guests	["read:pages","read:assets","read:comments"]	[{"id":"guest","roles":["read:pages","read:assets","read:comments"],"match":"START","deny":false,"path":"","locales":[]}]	t	2025-03-11T03:11:18.311Z	2025-03-11T03:11:18.311Z	/
\.


--
-- Data for Name: locales; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.locales (code, strings, "isRTL", name, "nativeName", availability, "createdAt", "updatedAt") FROM stdin;
en	{"common":{"footer":{"poweredBy":"Powered by","copyright":"© {{year}} {{company}}. All rights reserved.","license":"Content is available under the {{license}}, by {{company}}."},"actions":{"save":"Save","cancel":"Cancel","download":"Download","upload":"Upload","discard":"Discard","clear":"Clear","create":"Create","edit":"Edit","delete":"Delete","refresh":"Refresh","saveChanges":"Save Changes","proceed":"Proceed","ok":"OK","add":"Add","apply":"Apply","browse":"Browse...","close":"Close","page":"Page","discardChanges":"Discard Changes","move":"Move","rename":"Rename","optimize":"Optimize","preview":"Preview","properties":"Properties","insert":"Insert","fetch":"Fetch","generate":"Generate","confirm":"Confirm","copy":"Copy","returnToTop":"Return to top","exit":"Exit","select":"Select","convert":"Convert"},"newpage":{"title":"This page does not exist yet.","subtitle":"Would you like to create it now?","create":"Create Page","goback":"Go back"},"unauthorized":{"title":"Unauthorized","action":{"view":"You cannot view this page.","source":"You cannot view the page source.","history":"You cannot view the page history.","edit":"You cannot edit the page.","create":"You cannot create the page.","download":"You cannot download the page content.","downloadVersion":"You cannot download the content for this page version.","sourceVersion":"You cannot view the source of this version of the page."},"goback":"Go Back","login":"Login As..."},"notfound":{"gohome":"Home","title":"Not Found","subtitle":"This page does not exist."},"welcome":{"title":"Welcome to your wiki!","subtitle":"Let's get started and create the home page.","createhome":"Create Home Page","goadmin":"Administration"},"header":{"home":"Home","newPage":"New Page","currentPage":"Current Page","view":"View","edit":"Edit","history":"History","viewSource":"View Source","move":"Move / Rename","delete":"Delete","assets":"Assets","imagesFiles":"Images & Files","search":"Search...","admin":"Administration","account":"Account","myWiki":"My Wiki","profile":"Profile","logout":"Logout","login":"Login","searchHint":"Type at least 2 characters to start searching...","searchLoading":"Searching...","searchNoResult":"No pages matching your query.","searchResultsCount":"Found {{total}} results","searchDidYouMean":"Did you mean...","searchClose":"Close","searchCopyLink":"Copy Search Link","language":"Language","browseTags":"Browse by Tags","siteMap":"Site Map","pageActions":"Page Actions","duplicate":"Duplicate","convert":"Convert"},"page":{"lastEditedBy":"Last edited by","unpublished":"Unpublished","editPage":"Edit Page","toc":"Page Contents","bookmark":"Bookmark","share":"Share","printFormat":"Print Format","delete":"Delete Page","deleteTitle":"Are you sure you want to delete page {{title}}?","deleteSubtitle":"The page can be restored from the administration area.","viewingSource":"Viewing source of page {{path}}","returnNormalView":"Return to Normal View","id":"ID {{id}}","published":"Published","private":"Private","global":"Global","loading":"Loading Page...","viewingSourceVersion":"Viewing source as of {{date}} of page {{path}}","versionId":"Version ID {{id}}","unpublishedWarning":"This page is not published.","tags":"Tags","tagsMatching":"Pages matching tags","convert":"Convert Page","convertTitle":"Select the editor you want to use going forward for the page {{title}}:","convertSubtitle":"The page content will be converted into the format of the newly selected editor. Note that some formatting or non-rendered content may be lost as a result of the conversion. A snapshot will be added to the page history and can be restored at any time.","editExternal":"Edit on {{name}}"},"error":{"unexpected":"An unexpected error occurred."},"password":{"veryWeak":"Very Weak","weak":"Weak","average":"Average","strong":"Strong","veryStrong":"Very Strong"},"user":{"search":"Search User","searchPlaceholder":"Search Users..."},"duration":{"every":"Every","minutes":"Minute(s)","hours":"Hour(s)","days":"Day(s)","months":"Month(s)","years":"Year(s)"},"outdatedBrowserWarning":"Your browser is outdated. Upgrade to a {{modernBrowser}}.","modernBrowser":"modern browser","license":{"none":"None","ccby":" Creative Commons Attribution License","ccbysa":"Creative Commons Attribution-ShareAlike License","ccbynd":"Creative Commons Attribution-NoDerivs License","ccbync":"Creative Commons Attribution-NonCommercial License","ccbyncsa":"Creative Commons Attribution-NonCommercial-ShareAlike License","ccbyncnd":"Creative Commons Attribution-NonCommercial-NoDerivs License","cc0":"Public Domain","alr":"All Rights Reserved"},"sidebar":{"browse":"Browse","mainMenu":"Main Menu","currentDirectory":"Current Directory","root":"(root)"},"comments":{"title":"Comments","newPlaceholder":"Write a new comment...","fieldName":"Your Name","fieldEmail":"Your Email Address","markdownFormat":"Markdown Format","postComment":"Post Comment","loading":"Loading comments...","postingAs":"Posting as {{name}}","beFirst":"Be the first to comment.","none":"No comments yet.","updateComment":"Update Comment","deleteConfirmTitle":"Confirm Delete","deleteWarn":"Are you sure you want to permanently delete this comment?","deletePermanentWarn":"This action cannot be undone!","modified":"modified {{reldate}}","postSuccess":"New comment posted successfully.","contentMissingError":"Comment is empty or too short!","updateSuccess":"Comment was updated successfully.","deleteSuccess":"Comment was deleted successfully.","viewDiscussion":"View Discussion","newComment":"New Comment","fieldContent":"Comment Content","sdTitle":"Talk"},"pageSelector":{"createTitle":"Select New Page Location","moveTitle":"Move / Rename Page Location","selectTitle":"Select a Page","virtualFolders":"Virtual Folders","pages":"Pages","folderEmptyWarning":"This folder is empty."}},"auth":{"loginRequired":"Login required","fields":{"emailUser":"Email / Username","password":"Password","email":"Email Address","verifyPassword":"Verify Password","name":"Name","username":"Username"},"actions":{"login":"Log In","register":"Register"},"errors":{"invalidLogin":"Invalid Login","invalidLoginMsg":"The email or password is invalid.","invalidUserEmail":"Invalid User Email","loginError":"Login error","notYetAuthorized":"You have not been authorized to login to this site yet.","tooManyAttempts":"Too many attempts!","tooManyAttemptsMsg":"You've made too many failed attempts in a short period of time, please try again {{time}}.","userNotFound":"User not found"},"providers":{"local":"Local","windowslive":"Microsoft Account","azure":"Azure Active Directory","google":"Google ID","facebook":"Facebook","github":"GitHub","slack":"Slack","ldap":"LDAP / Active Directory"},"tfa":{"title":"Two Factor Authentication","subtitle":"Security code required:","placeholder":"XXXXXX","verifyToken":"Verify"},"registerTitle":"Create an account","switchToLogin":{"text":"Already have an account? {{link}}","link":"Login instead"},"loginUsingStrategy":"Login using {{strategy}}","forgotPasswordLink":"Forgot your password?","orLoginUsingStrategy":"or login using...","switchToRegister":{"text":"Don't have an account yet? {{link}}","link":"Create an account"},"invalidEmailUsername":"Enter a valid email / username.","invalidPassword":"Enter a valid password.","loginSuccess":"Login Successful! Redirecting...","signingIn":"Signing In...","genericError":"Authentication is unavailable.","registerSubTitle":"Fill-in the form below to create your account.","pleaseWait":"Please wait","registerSuccess":"Account created successfully!","registering":"Creating account...","missingEmail":"Missing email address.","invalidEmail":"Email address is invalid.","missingPassword":"Missing password.","passwordTooShort":"Password is too short.","passwordNotMatch":"Both passwords do not match.","missingName":"Name is missing.","nameTooShort":"Name is too short.","nameTooLong":"Name is too long.","forgotPasswordCancel":"Cancel","sendResetPassword":"Reset Password","forgotPasswordSubtitle":"Enter your email address to receive the instructions to reset your password:","registerCheckEmail":"Check your emails to activate your account.","changePwd":{"subtitle":"Choose a new password","instructions":"You must choose a new password:","newPasswordPlaceholder":"New Password","newPasswordVerifyPlaceholder":"Verify New Password","proceed":"Change Password","loading":"Changing password..."},"forgotPasswordLoading":"Requesting password reset...","forgotPasswordSuccess":"Check your emails for password reset instructions!","selectAuthProvider":"Select Authentication Provider","enterCredentials":"Enter your credentials","forgotPasswordTitle":"Forgot your password","tfaFormTitle":"Enter the security code generated from your trusted device:","tfaSetupTitle":"Your administrator has required Two-Factor Authentication (2FA) to be enabled on your account.","tfaSetupInstrFirst":"1) Scan the QR code below from your mobile 2FA application:","tfaSetupInstrSecond":"2) Enter the security code generated from your trusted device:"},"admin":{"dashboard":{"title":"Dashboard","subtitle":"Wiki.js","pages":"Pages","users":"Users","groups":"Groups","versionLatest":"You are running the latest version.","versionNew":"A new version is available: {{version}}","contributeSubtitle":"Wiki.js is a free and open source project. There are several ways you can contribute to the project.","contributeHelp":"We need your help!","contributeLearnMore":"Learn More","recentPages":"Recent Pages","mostPopularPages":"Most Popular Pages","lastLogins":"Last Logins"},"general":{"title":"General","subtitle":"Main settings of your wiki","siteInfo":"Site Info","siteBranding":"Site Branding","general":"General","siteUrl":"Site URL","siteUrlHint":"Full URL to your wiki, without the trailing slash. (e.g. https://wiki.example.com)","siteTitle":"Site Title","siteTitleHint":"Displayed in the top bar and appended to all pages meta title.","logo":"Logo","uploadLogo":"Upload Logo","uploadClear":"Clear","uploadSizeHint":"An image of {{size}} pixels is recommended for best results.","uploadTypesHint":"{{typeList}} or {{lastType}} files only","footerCopyright":"Footer Copyright","companyName":"Company / Organization Name","companyNameHint":"Name to use when displaying copyright notice in the footer. Leave empty to hide.","siteDescription":"Site Description","siteDescriptionHint":"Default description when none is provided for a page.","metaRobots":"Meta Robots","metaRobotsHint":"Default: Index, Follow. Can also be set on a per-page basis.","logoUrl":"Logo URL","logoUrlHint":"Specify an image to use as the logo. SVG, PNG, JPG are supported, in a square ratio, 34x34 pixels or larger. Click the button on the right to upload a new image.","contentLicense":"Content License","contentLicenseHint":"License shown in the footer of all content pages.","siteTitleInvalidChars":"Site Title contains invalid characters.","saveSuccess":"Site configuration saved successfully.","pageExtensions":"Page Extensions","pageExtensionsHint":"A comma-separated list of URL extensions that will be treated as pages. For example, adding md will treat /foobar.md the same as /foobar.","editMenuExternalName":"Button Site Name","editMenuExternalNameHint":"The name of the external site to display on the edit button. Do not include the \\"Edit on\\" prefix.","editMenuExternalIcon":"Button Icon","editMenuExternalIconHint":"The icon to display on the edit button. For example, mdi-github to display the GitHub icon.","editMenuExternalUrl":"Button URL","editMenuExternalUrlHint":"Url to the page on the external repository. Use the {filename} placeholder where the filename should be included. (e.g. https://github.com/foo/bar/blob/main/{filename} )","editShortcuts":"Edit Shortcuts","editFab":"FAB Quick Edit Menu","editFabHint":"Display the edit floating action button (FAB) with a speed-dial menu in the bottom right corner of the screen.","editMenuBar":"Edit Menu Bar","displayEditMenuBar":"Display Edit Menu Bar","displayEditMenuBarHint":"Display the edit menu bar in the page header.","displayEditMenuBtn":"Display Edit Button","displayEditMenuBtnHint":"Display a button to edit the current page.","displayEditMenuExternalBtn":"Display External Edit Button","displayEditMenuExternalBtnHint":"Display a button linking to an external repository (e.g. GitHub) where users can edit or submit a PR for the current page.","footerOverride":"Footer Text Override","footerOverrideHint":"Optionally override the footer text with a custom message. Useful if none of the above licenses are appropriate."},"locale":{"title":"Locale","subtitle":"Set localization options for your wiki","settings":"Locale Settings","namespacing":"Multilingual Namespacing","downloadTitle":"Download Locale","base":{"labelWithNS":"Base Locale","hint":"All UI text elements will be displayed in selected language.","label":"Site Locale"},"autoUpdate":{"label":"Update Automatically","hintWithNS":"Automatically download updates to all namespaced locales enabled below.","hint":"Automatically download updates to this locale as they become available."},"namespaces":{"label":"Multilingual Namespaces","hint":"Enables multiple language versions of the same page."},"activeNamespaces":{"label":"Active Namespaces","hint":"List of locales enabled for multilingual namespacing. The base locale defined above will always be included regardless of this selection."},"namespacingPrefixWarning":{"title":"The locale code will be prefixed to all paths. (e.g. /{{langCode}}/page-name)","subtitle":"Paths without a locale code will be automatically redirected to the base locale defined above."},"sideload":"Sideload Locale Package","sideloadHelp":"If you are not connected to the internet or cannot download locale files using the method above, you can instead sideload packages manually by uploading them below.","code":"Code","name":"Name","nativeName":"Native Name","rtl":"RTL","availability":"Availability","download":"Download"},"stats":{"title":"Statistics"},"theme":{"title":"Theme","subtitle":"Modify the look & feel of your wiki","siteTheme":"Site Theme","siteThemeHint":"Themes affect how content pages are displayed. Other site sections (such as the editor or admin area) are not affected.","darkMode":"Dark Mode","darkModeHint":"Not recommended for accessibility. May not be supported by all themes.","codeInjection":"Code Injection","cssOverride":"CSS Override","cssOverrideHint":"CSS code to inject after system default CSS. Consider using custom themes if you have a large amount of css code. Injecting too much CSS code will result in poor page load performance! CSS will automatically be minified.","headHtmlInjection":"Head HTML Injection","headHtmlInjectionHint":"HTML code to be injected just before the closing head tag. Usually for script tags.","bodyHtmlInjection":"Body HTML Injection","bodyHtmlInjectionHint":"HTML code to be injected just before the closing body tag.","downloadThemes":"Download Themes","iconset":"Icon Set","iconsetHint":"Set of icons to use for the sidebar navigation.","downloadName":"Name","downloadAuthor":"Author","downloadDownload":"Download","cssOverrideWarning":"{{caution}} When adding styles for page content, you must scope them to the {{cssClass}} class. Omitting this could break the layout of the editor!","cssOverrideWarningCaution":"CAUTION:","options":"Theme Options","tocHeadingLevels":"Default TOC Heading Levels","tocHeadingLevelsHint":"The table of contents will show headings from and up to the selected levels by default."},"groups":{"title":"Groups"},"users":{"title":"Users","active":"Active","inactive":"Inactive","verified":"Verified","unverified":"Unverified","edit":"Edit User","id":"ID {{id}}","basicInfo":"Basic Info","email":"Email","displayName":"Display Name","authentication":"Authentication","authProvider":"Provider","password":"Password","changePassword":"Change Password","newPassword":"New Password","tfa":"Two Factor Authentication (2FA)","toggle2FA":"Toggle 2FA","authProviderId":"Provider Id","groups":"User Groups","noGroupAssigned":"This user is not assigned to any group yet. You must assign at least 1 group to a user.","selectGroup":"Select Group...","groupAssign":"Assign","extendedMetadata":"Extended Metadata","location":"Location","jobTitle":"Job Title","timezone":"Timezone","userUpdateSuccess":"User updated successfully.","userAlreadyAssignedToGroup":"User is already assigned to this group!","deleteConfirmTitle":"Delete User?","deleteConfirmText":"Are you sure you want to delete user {{username}}?","updateUser":"Update User","groupAssignNotice":"Note that you cannot assign users to the Administrators or Guests groups from this panel.","deleteConfirmForeignNotice":"Note that you cannot delete a user that already created content. You must instead either deactivate the user or delete all content that was created by that user.","userVerifySuccess":"User has been verified successfully.","userActivateSuccess":"User has been activated successfully.","userDeactivateSuccess":"User deactivated successfully.","deleteConfirmReplaceWarn":"Any content (pages, uploads, comments, etc.) that was created by this user will be reassigned to the user selected below. It is recommended to create a dummy target user (e.g. Deleted User) if you don't want the content to be reassigned to any current active user.","userTFADisableSuccess":"2FA was disabled successfully.","userTFAEnableSuccess":"2FA was enabled successfully."},"auth":{"title":"Authentication","subtitle":"Configure the authentication settings of your wiki","strategies":"Strategies","globalAdvSettings":"Global Advanced Settings","jwtAudience":"JWT Audience","jwtAudienceHint":"Audience URN used in JWT issued upon login. Usually your domain name. (e.g. urn:your.domain.com)","tokenExpiration":"Token Expiration","tokenExpirationHint":"The expiration period of a token until it must be renewed. (default: 30m)","tokenRenewalPeriod":"Token Renewal Period","tokenRenewalPeriodHint":"The maximum period a token can be renewed when expired. (default: 14d)","strategyState":"This strategy is {{state}} {{locked}}","strategyStateActive":"active","strategyStateInactive":"not active","strategyStateLocked":"and cannot be disabled.","strategyConfiguration":"Strategy Configuration","strategyNoConfiguration":"This strategy has no configuration options you can modify.","registration":"Registration","selfRegistration":"Allow self-registration","selfRegistrationHint":"Allow any user successfully authorized by the strategy to access the wiki.","domainsWhitelist":"Limit to specific email domains","domainsWhitelistHint":"A list of domains authorized to register. The user email address domain must match one of these to gain access.","autoEnrollGroups":"Assign to group","autoEnrollGroupsHint":"Automatically assign new users to these groups.","security":"Security","force2fa":"Force all users to use Two-Factor Authentication (2FA)","force2faHint":"Users will be required to setup 2FA the first time they login and cannot be disabled by the user.","configReference":"Configuration Reference","configReferenceSubtitle":"Some strategies may require some configuration values to be set on your provider. These are provided for reference only and may not be needed by the current strategy.","siteUrlNotSetup":"You must set a valid {{siteUrl}} first! Click on {{general}} in the left sidebar.","allowedWebOrigins":"Allowed Web Origins","callbackUrl":"Callback URL / Redirect URI","loginUrl":"Login URL","logoutUrl":"Logout URL","tokenEndpointAuthMethod":"Token Endpoint Authentication Method","refreshSuccess":"List of strategies has been refreshed.","saveSuccess":"Authentication configuration saved successfully.","activeStrategies":"Active Strategies","addStrategy":"Add Strategy","strategyIsEnabled":"Active","strategyIsEnabledHint":"Are users able to login using this strategy?","displayName":"Display Name","displayNameHint":"The title shown to the end user for this authentication strategy."},"editor":{"title":"Editor"},"logging":{"title":"Logging"},"rendering":{"title":"Rendering","subtitle":"Configure the page rendering pipeline"},"search":{"title":"Search Engine","subtitle":"Configure the search capabilities of your wiki","rebuildIndex":"Rebuild Index","searchEngine":"Search Engine","engineConfig":"Engine Configuration","engineNoConfig":"This engine has no configuration options you can modify.","listRefreshSuccess":"List of search engines has been refreshed.","configSaveSuccess":"Search engine configuration saved successfully.","indexRebuildSuccess":"Index rebuilt successfully."},"storage":{"title":"Storage","subtitle":"Set backup and sync targets for your content","targets":"Targets","status":"Status","lastSync":"Last synchronization {{time}}","lastSyncAttempt":"Last attempt was {{time}}","errorMsg":"Error Message","noTarget":"You don't have any active storage target.","targetConfig":"Target Configuration","noConfigOption":"This storage target has no configuration options you can modify.","syncDirection":"Sync Direction","syncDirectionSubtitle":"Choose how content synchronization is handled for this storage target.","syncDirBi":"Bi-directional","syncDirPush":"Push to target","syncDirPull":"Pull from target","unsupported":"Unsupported","syncDirBiHint":"In bi-directional mode, content is first pulled from the storage target. Any newer content overwrites local content. New content since last sync is then pushed to the storage target, overwriting any content on target if present.","syncDirPushHint":"Content is always pushed to the storage target, overwriting any existing content. This is safest choice for backup scenarios.","syncDirPullHint":"Content is always pulled from the storage target, overwriting any local content which already exists. This choice is usually reserved for single-use content import. Caution with this option as any local content will always be overwritten!","syncSchedule":"Sync Schedule","syncScheduleHint":"For performance reasons, this storage target synchronize changes on an interval-based schedule, instead of on every change. Define at which interval should the synchronization occur.","syncScheduleCurrent":"Currently set to every {{schedule}}.","syncScheduleDefault":"The default is every {{schedule}}.","actions":"Actions","actionRun":"Run","targetState":"This storage target is {{state}}","targetStateActive":"active","targetStateInactive":"inactive","actionsInactiveWarn":"You must enable this storage target and apply changes before you can run actions."},"api":{"title":"API Access","subtitle":"Manage keys to access the API","enabled":"API Enabled","disabled":"API Disabled","enableButton":"Enable API","disableButton":"Disable API","newKeyButton":"New API Key","headerName":"Name","headerKeyEnding":"Key Ending","headerExpiration":"Expiration","headerCreated":"Created","headerLastUpdated":"Last Updated","headerRevoke":"Revoke","noKeyInfo":"No API keys have been generated yet.","revokeConfirm":"Revoke API Key?","revokeConfirmText":"Are you sure you want to revoke key {{name}}? This action cannot be undone!","revoke":"Revoke","refreshSuccess":"List of API keys has been refreshed.","revokeSuccess":"The key has been revoked successfully.","newKeyTitle":"New API Key","newKeySuccess":"API key created successfully.","newKeyNameError":"Name is missing or invalid.","newKeyGroupError":"You must select a group.","newKeyGuestGroupError":"The guests group cannot be used for API keys.","newKeyNameHint":"Purpose of this key","newKeyName":"Name","newKeyExpiration":"Expiration","newKeyExpirationHint":"You can still revoke a key anytime regardless of the expiration.","newKeyPermissionScopes":"Permission Scopes","newKeyFullAccess":"Full Access","newKeyGroupPermissions":"or use group permissions...","newKeyGroup":"Group","newKeyGroupHint":"The API key will have the same permissions as the selected group.","expiration30d":"30 days","expiration90d":"90 days","expiration180d":"180 days","expiration1y":"1 year","expiration3y":"3 years","newKeyCopyWarn":"Copy the key shown below as {{bold}}","newKeyCopyWarnBold":"it will NOT be shown again","toggleStateEnabledSuccess":"API has been enabled successfully.","toggleStateDisabledSuccess":"API has been disabled successfully."},"system":{"title":"System Info","subtitle":"Information about your system","hostInfo":"Host Information","currentVersion":"Current Version","latestVersion":"Latest Version","published":"Published","os":"Operating System","hostname":"Hostname","cpuCores":"CPU Cores","totalRAM":"Total RAM","workingDirectory":"Working Directory","configFile":"Configuration File","ramUsage":"RAM Usage: {{used}} / {{total}}","dbPartialSupport":"Your database version is not fully supported. Some functionality may be limited or not work as expected.","refreshSuccess":"System Info has been refreshed."},"utilities":{"title":"Utilities","subtitle":"Maintenance and miscellaneous tools","tools":"Tools","authTitle":"Authentication","authSubtitle":"Various tools for authentication / users","cacheTitle":"Flush Cache","cacheSubtitle":"Flush cache of various components","graphEndpointTitle":"GraphQL Endpoint","graphEndpointSubtitle":"Change the GraphQL endpoint for Wiki.js","importv1Title":"Import from Wiki.js 1.x","importv1Subtitle":"Migrate data from a previous 1.x installation","telemetryTitle":"Telemetry","telemetrySubtitle":"Enable/Disable telemetry or reset the client ID","contentTitle":"Content","contentSubtitle":"Various tools for pages","exportTitle":"Export to Disk","exportSubtitle":"Save content to tarball for backup / migration"},"dev":{"title":"Developer Tools","flags":{"title":"Flags"},"graphiql":{"title":"GraphiQL"},"voyager":{"title":"Voyager"}},"contribute":{"title":"Contribute to Wiki.js","subtitle":"Help support Wiki.js development and operations","fundOurWork":"Fund our work","spreadTheWord":"Spread the word","talkToFriends":"Talk to your friends and colleagues about how awesome Wiki.js is!","followUsOnTwitter":"Follow us on {{0}}.","submitAnIdea":"Submit an idea or vote on a proposed one on the {{0}}.","submitAnIdeaLink":"feature requests board","foundABug":"Found a bug? Submit an issue on {{0}}.","helpTranslate":"Help translate Wiki.js in your language. Let us know on {{0}}.","makeADonation":"Make a donation","contribute":"Contribute","openCollective":"Wiki.js is also part of the Open Collective initiative, a transparent fund that goes toward community resources. You can contribute financially by making a monthly or one-time donation:","needYourHelp":"We need your help to keep improving the software and run the various associated services (e.g. hosting and networking).","openSource":"Wiki.js is a free and open-source software brought to you with {{0}} by {{1}} and {{2}}.","openSourceContributors":"contributors","tshirts":"You can also buy Wiki.js t-shirts to support the project financially:","shop":"Wiki.js Shop","becomeAPatron":"Become a Patron","patreon":"Become a backer or sponsor via Patreon (goes directly into supporting lead developer Nicolas Giard's goal of working full-time on Wiki.js)","paypal":"Make a one-time or recurring donation via Paypal:","ethereum":"We accept donations using Ethereum:","github":"Become a sponsor via GitHub Sponsors (goes directly into supporting lead developer Nicolas Giard's goal of working full-time on Wiki.js)","becomeASponsor":"Become a Sponsor"},"nav":{"site":"Site","users":"Users","modules":"Modules","system":"System"},"pages":{"title":"Pages"},"navigation":{"title":"Navigation","subtitle":"Manage the site navigation","link":"Link","divider":"Divider","header":"Header","label":"Label","icon":"Icon","targetType":"Target Type","target":"Target","noSelectionText":"Select a navigation item on the left.","untitled":"Untitled {{kind}}","navType":{"external":"External Link","home":"Home","page":"Page","searchQuery":"Search Query","externalblank":"External Link (New Window)"},"edit":"Edit {{kind}}","delete":"Delete {{kind}}","saveSuccess":"Navigation saved successfully.","noItemsText":"Click the Add button to add your first navigation item.","emptyList":"Navigation is empty","visibilityMode":{"all":"Visible to everyone","restricted":"Visible to select groups..."},"selectPageButton":"Select Page...","mode":"Navigation Mode","modeSiteTree":{"title":"Site Tree","description":"Classic Tree-based Navigation"},"modeCustom":{"title":"Custom Navigation","description":"Static Navigation Menu + Site Tree Button"},"modeNone":{"title":"None","description":"Disable Site Navigation"},"copyFromLocale":"Copy from locale...","sourceLocale":"Source Locale","sourceLocaleHint":"The locale from which navigation items will be copied from.","copyFromLocaleInfoText":"Select the locale from which items will be copied from. Items will be appended to the current list of items in the active locale.","modeStatic":{"title":"Static Navigation","description":"Static Navigation Menu Only"}},"mail":{"title":"Mail","subtitle":"Configure mail settings","configuration":"Configuration","dkim":"DKIM (optional)","test":"Send a test email","testRecipient":"Recipient Email Address","testSend":"Send Email","sender":"Sender","senderName":"Sender Name","senderEmail":"Sender Email","smtp":"SMTP Settings","smtpHost":"Host","smtpPort":"Port","smtpPortHint":"Usually 465 (recommended), 587 or 25.","smtpTLS":"Secure (TLS)","smtpTLSHint":"Should be enabled when using port 465, otherwise turned off (587 or 25).","smtpUser":"Username","smtpPwd":"Password","dkimHint":"DKIM (DomainKeys Identified Mail) provides a layer of security on all emails sent from Wiki.js by providing the means for recipients to validate the domain name and ensure the message authenticity.","dkimUse":"Use DKIM","dkimDomainName":"Domain Name","dkimKeySelector":"Key Selector","dkimPrivateKey":"Private Key","dkimPrivateKeyHint":"Private key for the selector in PEM format","testHint":"Send a test email to ensure your SMTP configuration is working.","saveSuccess":"Configuration saved successfully.","sendTestSuccess":"A test email was sent successfully.","smtpVerifySSL":"Verify SSL Certificate","smtpVerifySSLHint":"Some hosts requires SSL certificate checking to be disabled. Leave enabled for proper security.","smtpName":"Client Identifying Hostname","smtpNameHint":"An optional name to send to the SMTP server to identify your mailer. Leave empty to use server hostname. For Google Workspace customers, this should be your main domain name."},"webhooks":{"title":"Webhooks","subtitle":"Manage webhooks to external services"},"adminArea":"Administration Area","analytics":{"title":"Analytics","subtitle":"Add analytics and tracking tools to your wiki","providers":"Providers","providerConfiguration":"Provider Configuration","providerNoConfiguration":"This provider has no configuration options you can modify.","refreshSuccess":"List of providers refreshed successfully.","saveSuccess":"Analytics configuration saved successfully"},"comments":{"title":"Comments","provider":"Provider","subtitle":"Add discussions to your wiki pages","providerConfig":"Provider Configuration","providerNoConfig":"This provider has no configuration options you can modify.","configSaveSuccess":"Comments configuration saved successfully."},"tags":{"title":"Tags","subtitle":"Manage page tags","emptyList":"No tags to display.","edit":"Edit Tag","tag":"Tag","label":"Label","date":"Created {{created}} and last updated {{updated}}.","delete":"Delete this tag","noSelectionText":"Select a tag from the list on the left.","noItemsText":"Add a tag to a page to get started.","refreshSuccess":"Tags have been refreshed.","deleteSuccess":"Tag deleted successfully.","saveSuccess":"Tag has been saved successfully.","filter":"Filter...","viewLinkedPages":"View Linked Pages","deleteConfirm":"Delete Tag?","deleteConfirmText":"Are you sure you want to delete tag {{tag}}? The tag will also be unlinked from all pages."},"ssl":{"title":"SSL","subtitle":"Manage SSL configuration","provider":"Provider","providerHint":"Select Custom Certificate if you have your own certificate already.","domain":"Domain","domainHint":"Enter the fully qualified domain pointing to your wiki. (e.g. wiki.example.com)","providerOptions":"Provider Options","providerDisabled":"Disabled","providerLetsEncrypt":"Let's Encrypt","providerCustomCertificate":"Custom Certificate","ports":"Ports","httpPort":"HTTP Port","httpPortHint":"Non-SSL port the server will listen to for HTTP requests. Usually 80 or 3000.","httpsPort":"HTTPS Port","httpsPortHint":"SSL port the server will listen to for HTTPS requests. Usually 443.","httpPortRedirect":"Redirect HTTP requests to HTTPS","httpPortRedirectHint":"Will automatically redirect any requests on the HTTP port to HTTPS.","writableConfigFileWarning":"Note that your config file must be writable in order to persist ports configuration.","renewCertificate":"Renew Certificate","status":"Certificate Status","expiration":"Certificate Expiration","subscriberEmail":"Subscriber Email","currentState":"Current State","httpPortRedirectTurnOn":"Turn On","httpPortRedirectTurnOff":"Turn Off","renewCertificateLoadingTitle":"Renewing Certificate...","renewCertificateLoadingSubtitle":"Do not leave this page.","renewCertificateSuccess":"Certificate renewed successfully.","httpPortRedirectSaveSuccess":"HTTP Redirection changed successfully."},"security":{"title":"Security","maxUploadSize":"Max Upload Size","maxUploadBatch":"Max Files per Upload","maxUploadBatchHint":"How many files can be uploaded in a single batch?","maxUploadSizeHint":"The maximum size for a single file.","maxUploadSizeSuffix":"bytes","maxUploadBatchSuffix":"files","uploads":"Uploads","uploadsInfo":"These settings only affect Wiki.js. If you're using a reverse-proxy (e.g. nginx, apache, Cloudflare), you must also change its settings to match.","subtitle":"Configure security settings","login":"Login","loginScreen":"Login Screen","jwt":"JWT Configuration","bypassLogin":"Bypass Login Screen","bypassLoginHint":"Should the user be redirected automatically to the first authentication provider.","loginBgUrl":"Login Background Image URL","loginBgUrlHint":"Specify an image to use as the login background. PNG and JPG are supported, 1920x1080 recommended. Leave empty for default. Click the button on the right to upload a new image. Note that the Guests group must have read-access to the selected image!","hideLocalLogin":"Hide Local Authentication Provider","hideLocalLoginHint":"Don't show the local authentication provider on the login screen. Add ?all to the URL to temporarily use it.","loginSecurity":"Security","enforce2fa":"Enforce 2FA","enforce2faHint":"Force all users to use Two-Factor Authentication when using an authentication provider with a user / password form."},"extensions":{"title":"Extensions","subtitle":"Install extensions for extra functionality"}},"editor":{"page":"Page","save":{"processing":"Rendering","pleaseWait":"Please wait...","createSuccess":"Page created successfully.","error":"An error occurred while creating the page","updateSuccess":"Page updated successfully.","saved":"Saved"},"props":{"pageProperties":"Page Properties","pageInfo":"Page Info","title":"Title","shortDescription":"Short Description","shortDescriptionHint":"Shown below the title","pathCategorization":"Path & Categorization","locale":"Locale","path":"Path","pathHint":"Do not include any leading or trailing slashes.","tags":"Tags","tagsHint":"Use tags to categorize your pages and make them easier to find.","publishState":"Publishing State","publishToggle":"Published","publishToggleHint":"Unpublished pages are still visible to users with write permissions on this page.","publishStart":"Publish starting on...","publishStartHint":"Leave empty for no start date","publishEnd":"Publish ending on...","publishEndHint":"Leave empty for no end date","info":"Info","scheduling":"Scheduling","social":"Social","categorization":"Categorization","socialFeatures":"Social Features","allowComments":"Allow Comments","allowCommentsHint":"Enable commenting abilities on this page.","allowRatings":"Allow Ratings","displayAuthor":"Display Author Info","displaySharingBar":"Display Sharing Toolbar","displaySharingBarHint":"Show a toolbar with buttons to share and print this page","displayAuthorHint":"Show the page author along with the last edition time.","allowRatingsHint":"Enable rating capabilities on this page.","scripts":"Scripts","css":"CSS","cssHint":"CSS will automatically be minified upon saving. Do not include surrounding style tags, only the actual CSS code.","styles":"Styles","html":"HTML","htmlHint":"You must surround your javascript code with HTML script tags.","toc":"TOC","tocTitle":"Table of Contents","tocUseDefault":"Use Site Defaults","tocHeadingLevels":"TOC Heading Levels","tocHeadingLevelsHint":"The table of contents will show headings from and up to the selected levels."},"unsaved":{"title":"Discard Unsaved Changes?","body":"You have unsaved changes. Are you sure you want to leave the editor and discard any modifications you made since the last save?"},"select":{"title":"Which editor do you want to use for this page?","cannotChange":"This cannot be changed once the page is created.","customView":"or create a custom view?"},"assets":{"title":"Assets","newFolder":"New Folder","folderName":"Folder Name","folderNameNamingRules":"Must follow the asset folder {{namingRules}}.","folderNameNamingRulesLink":"naming rules","folderEmpty":"This asset folder is empty.","fileCount":"{{count}} files","headerId":"ID","headerFilename":"Filename","headerType":"Type","headerFileSize":"File Size","headerAdded":"Added","headerActions":"Actions","uploadAssets":"Upload Assets","uploadAssetsDropZone":"Browse or Drop files here...","fetchImage":"Fetch Remote Image","imageAlign":"Image Alignment","renameAsset":"Rename Asset","renameAssetSubtitle":"Enter the new name for this asset:","deleteAsset":"Delete Asset","deleteAssetConfirm":"Are you sure you want to delete asset","deleteAssetWarn":"This action cannot be undone!","refreshSuccess":"List of assets refreshed successfully.","uploadFailed":"File upload failed.","folderCreateSuccess":"Asset folder created successfully.","renameSuccess":"Asset renamed successfully.","deleteSuccess":"Asset deleted successfully.","noUploadError":"You must choose a file to upload first!"},"backToEditor":"Back to Editor","markup":{"bold":"Bold","italic":"Italic","strikethrough":"Strikethrough","heading":"Heading {{level}}","subscript":"Subscript","superscript":"Superscript","blockquote":"Blockquote","blockquoteInfo":"Info Blockquote","blockquoteSuccess":"Success Blockquote","blockquoteWarning":"Warning Blockquote","blockquoteError":"Error Blockquote","unorderedList":"Unordered List","orderedList":"Ordered List","inlineCode":"Inline Code","keyboardKey":"Keyboard Key","horizontalBar":"Horizontal Bar","togglePreviewPane":"Hide / Show Preview Pane","insertLink":"Insert Link","insertAssets":"Insert Assets","insertBlock":"Insert Block","insertCodeBlock":"Insert Code Block","insertVideoAudio":"Insert Video / Audio","insertDiagram":"Insert Diagram","insertMathExpression":"Insert Math Expression","tableHelper":"Table Helper","distractionFreeMode":"Distraction Free Mode","markdownFormattingHelp":"Markdown Formatting Help","noSelectionError":"Text must be selected first!","toggleSpellcheck":"Toggle Spellcheck"},"ckeditor":{"stats":"{{chars}} chars, {{words}} words"},"conflict":{"title":"Resolve Save Conflict","useLocal":"Use Local","useRemote":"Use Remote","useRemoteHint":"Discard local changes and use latest version","useLocalHint":"Use content in the left panel","viewLatestVersion":"View Latest Version","infoGeneric":"A more recent version of this page was saved by {{authorName}}, {{date}}","whatToDo":"What do you want to do?","whatToDoLocal":"Use your current local version and ignore the latest changes.","whatToDoRemote":"Use the remote version (latest) and discard your changes.","overwrite":{"title":"Overwrite with Remote Version?","description":"Are you sure you want to replace your current version with the latest remote content? {{refEditsLost}}","editsLost":"Your current edits will be lost."},"localVersion":"Local Version {{refEditable}}","editable":"(editable)","readonly":"(read-only)","remoteVersion":"Remote Version {{refReadOnly}}","leftPanelInfo":"Your current edit, based on page version from {{date}}","rightPanelInfo":"Last edited by {{authorName}}, {{date}}","pageTitle":"Title:","pageDescription":"Description:","warning":"Save conflict! Another user has already modified this page."},"unsavedWarning":"You have unsaved edits. Are you sure you want to leave the editor?"},"tags":{"currentSelection":"Current Selection","clearSelection":"Clear Selection","selectOneMoreTags":"Select one or more tags","searchWithinResultsPlaceholder":"Search within results...","locale":"Locale","orderBy":"Order By","selectOneMoreTagsHint":"Select one or more tags on the left.","retrievingResultsLoading":"Retrieving page results...","noResults":"Couldn't find any page with the selected tags.","noResultsWithFilter":"Couldn't find any page matching the current filtering options.","pageLastUpdated":"Last Updated {{date}}","orderByField":{"creationDate":"Creation Date","ID":"ID","lastModified":"Last Modified","path":"Path","title":"Title"},"localeAny":"Any"},"history":{"restore":{"confirmTitle":"Restore page version?","confirmText":"Are you sure you want to restore this page content as it was on {{date}}? This version will be copied on top of the current history. As such, newer versions will still be preserved.","confirmButton":"Restore","success":"Page version restored succesfully!"}},"profile":{"displayName":"Display Name","location":"Location","jobTitle":"Job Title","timezone":"Timezone","title":"Profile","subtitle":"My personal info","myInfo":"My Info","viewPublicProfile":"View Public Profile","auth":{"title":"Authentication","provider":"Provider","changePassword":"Change Password","currentPassword":"Current Password","newPassword":"New Password","verifyPassword":"Confirm New Password","changePassSuccess":"Password changed successfully."},"groups":{"title":"Groups"},"activity":{"title":"Activity","joinedOn":"Joined on","lastUpdatedOn":"Profile last updated on","lastLoginOn":"Last login on","pagesCreated":"Pages created","commentsPosted":"Comments posted"},"save":{"success":"Profile saved successfully."},"pages":{"title":"Pages","subtitle":"List of pages I created or last modified","emptyList":"No pages to display.","refreshSuccess":"Page list has been refreshed.","headerTitle":"Title","headerPath":"Path","headerCreatedAt":"Created","headerUpdatedAt":"Last Updated"},"comments":{"title":"Comments"},"preferences":"Preferences","dateFormat":"Date Format","localeDefault":"Locale Default","appearance":"Appearance","appearanceDefault":"Site Default","appearanceLight":"Light","appearanceDark":"Dark"}}	f	English	English	100	2025-03-11T03:11:18.303Z	2025-03-13T23:55:42.167Z
\.


--
-- Data for Name: loggers; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.loggers (key, "isEnabled", level, config) FROM stdin;
airbrake	f	warn	{}
bugsnag	f	warn	{"key":""}
disk	f	info	{}
eventlog	f	warn	{}
loggly	f	warn	{"token":"","subdomain":""}
logstash	f	warn	{}
newrelic	f	warn	{}
papertrail	f	warn	{"host":"","port":0}
raygun	f	warn	{}
rollbar	f	warn	{"key":""}
sentry	f	warn	{"key":""}
syslog	f	warn	{}
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.migrations (id, name, batch, migration_time) FROM stdin;
1	2.0.0.js	1	2025-03-11 03:04:33.21+00
2	2.1.85.js	1	2025-03-11 03:04:33.211+00
3	2.2.3.js	1	2025-03-11 03:04:33.218+00
4	2.2.17.js	1	2025-03-11 03:04:33.22+00
5	2.3.10.js	1	2025-03-11 03:04:33.221+00
6	2.3.23.js	1	2025-03-11 03:04:33.222+00
7	2.4.13.js	1	2025-03-11 03:04:33.225+00
8	2.4.14.js	1	2025-03-11 03:04:33.233+00
9	2.4.36.js	1	2025-03-11 03:04:33.236+00
10	2.4.61.js	1	2025-03-11 03:04:33.237+00
11	2.5.1.js	1	2025-03-11 03:04:33.242+00
12	2.5.12.js	1	2025-03-11 03:04:33.243+00
13	2.5.108.js	1	2025-03-11 03:04:33.244+00
14	2.5.118.js	1	2025-03-11 03:04:33.245+00
15	2.5.122.js	1	2025-03-11 03:04:33.252+00
16	2.5.128.js	1	2025-03-11 03:04:33.254+00
\.


--
-- Data for Name: migrations_lock; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.migrations_lock (index, is_locked) FROM stdin;
1	0
\.


--
-- Data for Name: navigation; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.navigation (key, config) FROM stdin;
site	[{"locale":"en","items":[{"id":"8b06d3b9-0200-4f64-8a2d-75fd59900e5b","icon":"mdi-home","kind":"link","label":"Home","target":"/","targetType":"home","visibilityMode":"all","visibilityGroups":null}]}]
\.


--
-- Data for Name: pageHistory; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."pageHistory" (id, path, hash, title, description, "isPrivate", "isPublished", "publishStartDate", "publishEndDate", action, "pageId", content, "contentType", "createdAt", "editorKey", "localeCode", "authorId", "versionDate", extra) FROM stdin;
1	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	Index	Categorization of other pages	f	t			updated	1	# Welcome to the World of Arinthar Wiki\n\nWelcome to the official wiki of Arinthar, a rich and mysterious fantasy world full of powerful beings, ancient histories, and legendary events. This wiki serves as a comprehensive guide to all that exists within this magical realm, from the farthest reaches of the Highlands to the deepest caverns of the Underdark.\n\n## Table of Contents\n\n### 1. **Places**\n- [The Kingdom of Eldrath](#the-kingdom-of-eldrath): A sprawling kingdom known for its towering castles and skilled knights.\n- [The Emerald Forest](#the-emerald-forest): A vast woodland home to elusive creatures and ancient trees.\n- [Shattered Isles](#shattered-isles): A cluster of islands believed to be remnants of a once mighty empire.\n- [Ruins of Valmara](#ruins-of-valmara): The lost city buried beneath shifting sands, said to be cursed.\n- [Tarnheim Peak](#tarnheim-peak): A dangerous mountain inhabited by dragons and other flying creatures.\n\n### 2. **Creatures**\n- [Drakes of the Highwind Mountains](#drakes-of-the-highwind-mountains): A breed of winged dragons that control the skies above Arinthar.\n- [Wyrmbeasts](#wyrmbeasts): Massive, earth-shaking creatures said to dwell beneath the surface of the world.\n- [Faerie Folk](#faerie-folk): A magical race of beings who dwell in the fae realm, known for their trickery and beauty.\n- [Elder Spirits](#elder-spirits): Ghostly entities that have transcended death, existing in a state between the physical and ethereal planes.\n\n### 3. **Races**\n- [Aelirian Elves](#aelirian-elves): A race of immortal beings who have mastered magic and the arts.\n- [Dwarves of Karak-Dur](#dwarves-of-karak-dur): Stout and resilient, these warriors thrive in the mountains and are expert craftsmen.\n- [Hurokin](#hurokin): A nomadic race of shape-shifters, known for their agility and adaptability.\n- [Orcs of the Wastes](#orcs-of-the-wastes): Fierce warriors from the arid deserts, often misunderstood but fiercely loyal.\n- [The Shadar](#the-shadar): A mysterious race that exists in the shadows, unseen by most but ever-present in the world.\n\n### 4. **People**\n- [King Alaric of Eldrath](#king-alaric-of-eldrath): The wise and just ruler of Eldrath, known for his diplomatic skills and military prowess.\n- [Sethrin the Bold](#sethrin-the-bold): A legendary warrior who led the charge against the Great Horde during the War of the Broken Sky.\n- [Lady Sylara Moonshadow](#lady-sylara-moonshadow): A powerful sorceress whose magic is feared across the lands.\n- [Gorruk the Eternal](#gorruk-the-eternal): An immortal being believed to be older than Arinthar itself, rumored to control time itself.\n- [Prince Anselm of the Shattered Isles](#prince-anselm-of-the-shattered-isles): The last surviving royal of the Shattered Isles, with ambitions to restore his kingdom.\n\n### 5. **Events**\n- [The War of the Broken Sky](#the-war-of-the-broken-sky): A cataclysmic war that nearly tore the world apart.\n- [The Rise of the Blood Moon](#the-rise-of-the-blood-moon): A prophecy that foretells the coming of a dark age, heralded by the appearance of a blood-red moon.\n- [The Great Exodus](#the-great-exodus): The migration of several races from the sinking continent of Vaelgrun.\n- [The Fall of Valmara](#the-fall-of-valmara): The mysterious event that led to the downfall of an ancient city, leaving only ruins behind.\n\n### 6. **Magic**\n- [The Arcane Arts](#the-arcane-arts): The study and mastery of magical forces that govern the world.\n- [Rune Magic](#rune-magic): A powerful form of magic that taps into the ancient runes of Arinthar.\n- [Divination](#divination): The art of foreseeing future events through mystical means.\n- [Elemental Binding](#elemental-binding): The practice of controlling the elemental forces of fire, water, air, and earth.\n\n---\n\nExplore the rich tapestry of Arinthar, from its vast landscapes to the intriguing lives of its inhabitants. This wiki is your portal to a world full of adventure, mystery, and wonder.\n\n	markdown	2025-03-11T19:31:21.191Z	markdown	en	1	2025-03-11T03:16:18.618Z	{}
2	elemental-binding	44fbe07df39fa274d471ea9807d389a4ea0fe067	Elemental Binding	Elemental Binding: The practice of controlling the elemental forces of fire, water, air, and earth.	f	t			updated	28	Elemental Binding: The practice of controlling the elemental forces of fire, water, air, and earth.	markdown	2025-03-13T22:38:14.594Z	markdown	en	1	2025-03-13T22:01:31.496Z	{}
3	the-arcane-arts	2767206d1bbc4ccae02feff0feab69d119ac2f7a	The Arcane Arts	The study and mastery of magical forces that govern the world.	f	t			updated	25	The study and mastery of magical forces that govern the world.	markdown	2025-03-13T22:44:59.485Z	markdown	en	1	2025-03-13T22:00:27.624Z	{}
4	elemental-binding	44fbe07df39fa274d471ea9807d389a4ea0fe067	Elemental Binding	Elemental Binding: The practice of controlling the elemental forces of fire, water, air, and earth.	f	t			updated	28	Elemental Binding: The practice of controlling the elemental forces of fire, water, air, and earth.	markdown	2025-03-13T22:45:40.360Z	markdown	en	1	2025-03-13T22:38:15.513Z	{}
5	divination	a4d8c87c46cb09b42e4b1835b93c2dfbebf377e3	Divination	The art of foreseeing future events through mystical means.	f	t			updated	27	The art of foreseeing future events through mystical means.	markdown	2025-03-13T22:46:04.485Z	markdown	en	1	2025-03-13T22:01:08.514Z	{}
6	rune-magic	3769ff4eef4def578784a32cb8c8ef64e565c6ca	Rune Magic	A powerful form of magic that taps into the ancient runes of Arinthar.	f	t			updated	26	A powerful form of magic that taps into the ancient runes of Arinthar.	markdown	2025-03-13T22:48:22.982Z	markdown	en	1	2025-03-13T22:00:47.896Z	{}
7	the-kingdom-of-eldrath	b664e6b885ecfbc50f7aa598cdb7f5ac7d1b799a	The Kingdom of Eldrath	The Kingdom of Eldrath: A sprawling kingdom known for its towering castles and skilled knights.	f	t			updated	2	The Kingdom of Eldrath: A sprawling kingdom known for its towering castles and skilled knights.	markdown	2025-03-13T22:49:23.077Z	markdown	en	1	2025-03-11T03:19:22.862Z	{}
8	the-emerald-forest	f7d5cf12b10ef6ac42b50ef55908ab4a7fbd7787	The Emerald Forest	The Emerald Forest: A vast woodland home to elusive creatures and ancient trees.	f	t			updated	3	The Emerald Forest: A vast woodland home to elusive creatures and ancient trees.	markdown	2025-03-13T22:50:02.296Z	markdown	en	1	2025-03-11T03:19:41.536Z	{}
9	shattered-isles	69ac3315dd23b955e668067b3f0b5a3bcdc1a50a	The Emerald Forest	A vast woodland home to elusive creatures and ancient trees.	f	t			updated	4	The Emerald Forest: A vast woodland home to elusive creatures and ancient trees.	markdown	2025-03-13T22:50:53.781Z	markdown	en	1	2025-03-11T03:20:18.901Z	{}
10	ruins-of-valmara	d3b0735d8fc29fe6c70890abd7375c037bfabad1	Shattered Isles	A cluster of islands believed to be remnants of a once mighty empire.	f	t			updated	5	Shattered Isles: A cluster of islands believed to be remnants of a once mighty empire.	markdown	2025-03-13T22:51:16.214Z	markdown	en	1	2025-03-11T03:20:42.081Z	{}
11	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	Index	Categorization of other pages	f	t			updated	1	# Welcome to the World of Arinthar Wiki\n\nWelcome to the official wiki of Arinthar, a rich and mysterious fantasy world full of powerful beings, ancient histories, and legendary events. This wiki serves as a comprehensive guide to all that exists within this magical realm, from the farthest reaches of the Highlands to the deepest caverns of the Underdark.\n\n## Table of Contents\n\n### 1. **Places**\n- [The Kingdom of Eldrath](/the-kingdom-of-eldrath): A sprawling kingdom known for its towering castles and skilled knights.\n- [The Emerald Forest](/the-emerald-forest): A vast woodland home to elusive creatures and ancient trees.\n- [Shattered Isles](/shattered-isles): A cluster of islands believed to be remnants of a once mighty empire.\n- [Ruins of Valmara](/ruins-of-valmara): The lost city buried beneath shifting sands, said to be cursed.\n- [Tarnheim Peak](/tarnheim-peak): A dangerous mountain inhabited by dragons and other flying creatures.\n\n### 2. **Creatures**\n- [Drakes of the Highwind Mountains](/drakes-of-the-highwind-mountains): A breed of winged dragons that control the skies above Arinthar.\n- [Wyrmbeasts](/wyrmbeasts): Massive, earth-shaking creatures said to dwell beneath the surface of the world.\n- [Faerie Folk](/faerie-folk): A magical race of beings who dwell in the fae realm, known for their trickery and beauty.\n- [Elder Spirits](/elder-spirits): Ghostly entities that have transcended death, existing in a state between the physical and ethereal planes.\n\n### 3. **Races**\n- [Aelirian Elves](/aelirian-elves): A race of immortal beings who have mastered magic and the arts.\n- [Dwarves of Karak-Dur](/dwarves-of-karak-dur): Stout and resilient, these warriors thrive in the mountains and are expert craftsmen.\n- [Hurokin](/hurokin): A nomadic race of shape-shifters, known for their agility and adaptability.\n- [Orcs of the Wastes](/orcs-of-the-wastes): Fierce warriors from the arid deserts, often misunderstood but fiercely loyal.\n- [The Shadar](/the-shadar): A mysterious race that exists in the shadows, unseen by most but ever-present in the world.\n\n### 4. **People**\n- [King Alaric of Eldrath](/king-alaric-of-eldrath): The wise and just ruler of Eldrath, known for his diplomatic skills and military prowess.\n- [Sethrin the Bold](/sethrin-the-bold): A legendary warrior who led the charge against the Great Horde during the War of the Broken Sky.\n- [Lady Sylara Moonshadow](/lady-sylara-moonshadow): A powerful sorceress whose magic is feared across the lands.\n- [Gorruk the Eternal](/gorruk-the-eternal): An immortal being believed to be older than Arinthar itself, rumored to control time itself.\n- [Prince Anselm of the Shattered Isles](/prince-anselm-of-the-shattered-isles): The last surviving royal of the Shattered Isles, with ambitions to restore his kingdom.\n\n### 5. **Events**\n- [The War of the Broken Sky](/the-war-of-the-broken-sky): A cataclysmic war that nearly tore the world apart.\n- [The Rise of the Blood Moon](/the-rise-of-the-blood-moon): A prophecy that foretells the coming of a dark age, heralded by the appearance of a blood-red moon.\n- [The Great Exodus](/the-great-exodus): The migration of several races from the sinking continent of Vaelgrun.\n- [The Fall of Valmara](/the-fall-of-valmara): The mysterious event that led to the downfall of an ancient city, leaving only ruins behind.\n\n### 6. **Magic**\n- [The Arcane Arts](/the-arcane-arts): The study and mastery of magical forces that govern the world.\n- [Rune Magic](/rune-magic): A powerful form of magic that taps into the ancient runes of Arinthar.\n- [Divination](/divination): The art of foreseeing future events through mystical means.\n- [Elemental Binding](/elemental-binding): The practice of controlling the elemental forces of fire, water, air, and earth.\n\n---\n\nExplore the rich tapestry of Arinthar, from its vast landscapes to the intriguing lives of its inhabitants. This wiki is your portal to a world full of adventure, mystery, and wonder.\n\n	markdown	2025-03-13T23:10:41.884Z	markdown	en	1	2025-03-13T22:01:31.912Z	{}
12	tarnheim-peak	7287396839641f637aff74a6aec973647e74c39a	Tarnheim Peak	A dangerous mountain inhabited by dragons and other flying creatures.	f	t			updated	13	A dangerous mountain inhabited by dragons and other flying creatures.	markdown	2025-03-13T23:11:58.672Z	markdown	en	1	2025-03-13T21:54:37.734Z	{}
13	drakes-of-the-highwind-mountains	b12aec62d0e2b8d280b81f663109bb3cd9294e9b	Drakes of the Highwind Mountains	A breed of winged dragons that control the skies above Arinthar.	f	t			updated	14	A breed of winged dragons that control the skies above Arinthar.	markdown	2025-03-13T23:13:05.959Z	markdown	en	1	2025-03-13T21:55:38.512Z	{}
14	wyrmbeasts	99e31480a35f50e40fdd78711cece24c2c24c0a0	Wyrmbeasts	Massive, earth-shaking creatures said to dwell beneath the surface of the world.	f	t			updated	15	Massive, earth-shaking creatures said to dwell beneath the surface of the world.	markdown	2025-03-13T23:13:19.351Z	markdown	en	1	2025-03-13T21:56:00.225Z	{}
15	faerie-folk	3ba2a900dd5d49090d77710b50e66c536b4f3961	Faerie Folk	 A magical race of beings who dwell in the fae realm, known for their trickery and beauty.	f	t			updated	12	 A magical race of beings who dwell in the fae realm, known for their trickery and beauty.	markdown	2025-03-13T23:13:40.997Z	markdown	en	1	2025-03-13T21:51:25.553Z	{}
16	elder-spirits	a3a9d606eac1cd2006028546a0edad792834ad87	Elder Spirits	Ghostly entities that have transcended death, existing in a state between the physical and ethereal planes.	f	t			updated	11	Ghostly entities that have transcended death, existing in a state between the physical and ethereal planes.	markdown	2025-03-13T23:13:55.502Z	markdown	en	1	2025-03-13T21:51:04.578Z	{}
17	king-alaric-of-eldrath	d4743c9bc811313502f8721c231d7d030251290b	King Alaric of Eldrath	 The wise and just ruler of Eldrath, known for his diplomatic skills and military prowess.	f	t			updated	6	The wise and just ruler of Eldrath, known for his diplomatic skills and military prowess.	markdown	2025-03-13T23:14:29.377Z	markdown	en	1	2025-03-13T21:48:46.372Z	{}
18	sethrin-the-bold	14c2676e318870431f61884005e010cc915e4c90	Sethrin the Bold	A legendary warrior who led the charge against the Great Horde during the War of the Broken Sky.	f	t			updated	17	A legendary warrior who led the charge against the Great Horde during the War of the Broken Sky.	markdown	2025-03-13T23:14:45.053Z	markdown	en	1	2025-03-13T21:57:29.974Z	{}
19	lady-sylara-moonshadow	6fbd3d3e8a4848ca935a501a6526a79842befc94	Lady Sylara Moonshadow	A powerful sorceress whose magic is feared across the lands.	f	t			updated	18	A powerful sorceress whose magic is feared across the lands.	markdown	2025-03-13T23:14:59.473Z	markdown	en	1	2025-03-13T21:57:52.826Z	{}
20	gorruk-the-eternal	a14cdea1f3c06dc3cee4f899915e34e76461afca	Gorruk the Eternal	An immortal being believed to be older than Arinthar itself, rumored to control time itself.	f	t			updated	19	An immortal being believed to be older than Arinthar itself, rumored to control time itself.	markdown	2025-03-13T23:15:17.438Z	markdown	en	1	2025-03-13T21:58:15.507Z	{}
21	prince-anselm-of-the-shattered-isles	cea71df075b0e033e329698b288fc3034332ffda	Prince Anselm of the Shattered Isles	The last surviving royal of the Shattered Isles, with ambitions to restore his kingdom.	f	t			updated	20	 The last surviving royal of the Shattered Isles, with ambitions to restore his kingdom.	markdown	2025-03-13T23:15:49.182Z	markdown	en	1	2025-03-13T21:58:36.662Z	{}
22	aelirian-elves	95305783a75e504aab17ba110dbddc1b435b181e	Aelirian Elves	A race of immortal beings who have mastered magic and the arts.	f	t			updated	10	A race of immortal beings who have mastered magic and the arts.	markdown	2025-03-13T23:16:15.580Z	markdown	en	1	2025-03-13T21:50:41.269Z	{}
23	dwarves-of-karak-dur	130567fe76c61e2701f1945d620ec8c5a2608718	Dwarves of Karak-Dur	Stout and resilient, these warriors thrive in the mountains and are expert craftsmen.	f	t			updated	9	Stout and resilient, these warriors thrive in the mountains and are expert craftsmen.	markdown	2025-03-13T23:16:31.639Z	markdown	en	1	2025-03-13T21:50:20.258Z	{}
24	hurokin	35ac48caeaa7835c17ef59e85174aaf33385d2c6	Hurokin	A nomadic race of shape-shifters, known for their agility and adaptability.	f	t			updated	8	A nomadic race of shape-shifters, known for their agility and adaptability.	markdown	2025-03-13T23:16:45.282Z	markdown	en	1	2025-03-13T21:49:52.810Z	{}
25	orcs-of-the-wastes	7eb24ff38f12e657511a779256701a0b660fd52c	Orcs of the Wastes	Fierce warriors from the arid deserts, often misunderstood but fiercely loyal.	f	t			updated	7	Fierce warriors from the arid deserts, often misunderstood but fiercely loyal.	markdown	2025-03-13T23:17:02.878Z	markdown	en	1	2025-03-13T21:49:17.378Z	{}
26	the-shadar	d8105999800f19f7b0bec5545ba5456a4a315d17	The Shadar	A mysterious race that exists in the shadows, unseen by most but ever-present in the world.	f	t			updated	16	A mysterious race that exists in the shadows, unseen by most but ever-present in the world.	markdown	2025-03-13T23:17:14.885Z	markdown	en	1	2025-03-13T21:56:49.451Z	{}
27	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	Index	Categorization of other pages	f	t			updated	1	# Welcome to the World of Arinthar Wiki\n\nWelcome to the official wiki of Arinthar, a rich and mysterious fantasy world full of powerful beings, ancient histories, and legendary events. This wiki serves as a comprehensive guide to all that exists within this magical realm, from the farthest reaches of the Highlands to the deepest caverns of the Underdark.\n\n## Table of Contents\n\n### 1. **Places**\n- [The Kingdom of Eldrath](/the-kingdom-of-eldrath): A sprawling kingdom known for its towering castles and skilled knights.\n- [The Emerald Forest](/the-emerald-forest): A vast woodland home to elusive creatures and ancient trees.\n- [Shattered Isles](/shattered-isles): A cluster of islands believed to be remnants of a once mighty empire.\n- [Ruins of Valmara](/ruins-of-valmara): The lost city buried beneath shifting sands, said to be cursed.\n- [Tarnheim Peak](/tarnheim-peak): A dangerous mountain inhabited by dragons and other flying creatures.\n\n### 2. **Creatures**\n- [Drakes of the Highwind Mountains](/drakes-of-the-highwind-mountains): A breed of winged dragons that control the skies above Arinthar.\n- [Wyrmbeasts](/wyrmbeasts): Massive, earth-shaking creatures said to dwell beneath the surface of the world.\n- [Faerie Folk](/faerie-folk): A magical race of beings who dwell in the fae realm, known for their trickery and beauty.\n- [Elder Spirits](/elder-spirits): Ghostly entities that have transcended death, existing in a state between the physical and ethereal planes.\n\n### 3. **Races**\n- [Aelirian Elves](/aelirian-elves): A race of immortal beings who have mastered magic and the arts.\n- [Dwarves of Karak-Dur](/dwarves-of-karak-dur): Stout and resilient, these warriors thrive in the mountains and are expert craftsmen.\n- [Hurokin](/hurokin): A nomadic race of shape-shifters, known for their agility and adaptability.\n- [Orcs of the Wastes](/orcs-of-the-wastes): Fierce warriors from the arid deserts, often misunderstood but fiercely loyal.\n- [The Shadar](/the-shadar): A mysterious race that exists in the shadows, unseen by most but ever-present in the world.\n\n### 4. **People**\n- [King Alaric of Eldrath](/king-alaric-of-eldrath): The wise and just ruler of Eldrath, known for his diplomatic skills and military prowess.\n- [Sethrin the Bold](/sethrin-the-bold): A legendary warrior who led the charge against the Great Horde during the War of the Broken Sky.\n- [Lady Sylara Moonshadow](/lady-sylara-moonshadow): A powerful sorceress whose magic is feared across the lands.\n- [Gorruk the Eternal](/gorruk-the-eternal): An immortal being believed to be older than Arinthar itself, rumored to control time itself.\n- [Prince Anselm of the Shattered Isles](/prince-anselm-of-the-shattered-isles): The last surviving royal of the Shattered Isles, with ambitions to restore his kingdom.\n\n### 5. **Events**\n- [The War of the Broken Sky](/the-war-of-the-broken-sky): A cataclysmic war that nearly tore the world apart.\n- [The Rise of the Blood Moon](/the-rise-of-the-blood-moon): A prophecy that foretells the coming of a dark age, heralded by the appearance of a blood-red moon.\n- [The Great Exodus](/the-great-exodus): The migration of several races from the sinking continent of Vaelgrun.\n- [The Fall of Valmara](/the-fall-of-valmara): The mysterious event that led to the downfall of an ancient city, leaving only ruins behind.\n\n### 6. **Magic**\n- [The Arcane Arts](/the-arcane-arts): The study and mastery of magical forces that govern the world.\n- [Rune Magic](/rune-magic): A powerful form of magic that taps into the ancient runes of Arinthar.\n- [Divination](/divination): The art of foreseeing future events through mystical means.\n- [Elemental Binding](/elemental-binding): The practice of controlling the elemental forces of fire, water, air, and earth.\n\n---\n\nExplore the rich tapestry of Arinthar, from its vast landscapes to the intriguing lives of its inhabitants. This wiki is your portal to a world full of adventure, mystery, and wonder.\n\n	markdown	2025-03-13T23:19:06.013Z	markdown	en	1	2025-03-13T23:10:43.376Z	{}
28	the-fall-of-valmara	8cead464725f7f5190eb9d4aaad787cf774da0c3	The Fall of Valmara	The mysterious event that led to the downfall of an ancient city, leaving only ruins behind.	f	t			updated	24	The mysterious event that led to the downfall of an ancient city, leaving only ruins behind.	markdown	2025-03-13T23:21:32.976Z	markdown	en	1	2025-03-13T22:00:09.449Z	{}
29	the-kingdom-of-eldrath	b664e6b885ecfbc50f7aa598cdb7f5ac7d1b799a	The Kingdom of Eldrath	The Kingdom of Eldrath: A sprawling kingdom known for its towering castles and skilled knights.	f	t			updated	2	The Kingdom of Eldrath: A sprawling kingdom known for its towering castles and skilled knights.	markdown	2025-03-13T23:28:39.312Z	markdown	en	1	2025-03-13T22:49:24.006Z	{}
30	the-kingdom-of-eldrath	b664e6b885ecfbc50f7aa598cdb7f5ac7d1b799a	The Kingdom of Eldrath	A sprawling kingdom known for its towering castles and skilled knights.	f	t			updated	2	## The Kingdom of Eldrath  \n\nThe **Kingdom of Eldrath** is one of the most powerful and enduring realms in the world of Arinthar. A land of towering castles, rolling green fields, and bustling cities, Eldrath stands as a beacon of civilization and order. It is a kingdom steeped in tradition, ruled by a long line of monarchs who have defended its borders from countless threats, both mortal and mystical.  \n\n### **Geography & Landscape**  \nEldrath is a vast kingdom with diverse landscapes, including:  \n- **The Capital City of Elarion** – A grand city built around the magnificent Ivory Keep, home to the royal family and center of governance.  \n- **The Golden Plains** – Fertile lands that provide the kingdom with abundant crops and serve as the heart of trade.  \n- **The Frostveil Highlands** – A rugged, snow-covered region in the north, inhabited by hardy mountain clans.  \n- **The Eldenwood Forest** – A vast and ancient woodland, rumored to be home to mystical creatures and hidden elven enclaves.  \n- **The Silver Coast** – A stretch of coastline with bustling port towns that engage in trade with distant lands.  \n\n### **Government & Leadership**  \nEldrath is ruled by the **House of Valdris**, a noble bloodline that has governed the kingdom for over five centuries. The current ruler, **King Alaric Valdris**, is a wise and just leader known for his diplomatic prowess and military strategy. The kingdom follows a **feudal system**, with noble houses overseeing different regions in service to the crown.  \n\n### **Culture & Society**  \nThe people of Eldrath value honor, chivalry, and craftsmanship. The kingdom has a rich tradition of knightly orders, such as:  \n- **The Knights of the Silver Hawk** – An elite order dedicated to protecting the royal family and the realm.  \n- **The Order of the Dawnblade** – A sect of holy warriors sworn to eradicate dark magic and demonic threats.  \n\nThe **Eldran Academy of Magic** is a prestigious institution where gifted individuals learn the arcane arts. While magic is respected in Eldrath, its practice is strictly regulated to prevent misuse.  \n\n### **Military & Defense**  \nEldrath boasts a formidable army, known as the **Eldran Legions**, composed of well-trained soldiers, cavalry, and siege engineers. The kingdom has repelled numerous invasions from rival empires, marauding orcs, and even supernatural threats. The **Wall of Aegis**, a massive fortified structure in the north, stands as a testament to Eldrath’s vigilance against external threats.  \n\n### **Notable Events in Eldrath’s History**  \n- **The War of the Broken Sky** – A devastating conflict where Eldrath led an alliance against the Great Horde, securing peace for the continent.  \n- **The Mage Rebellion** – A dark chapter where rogue sorcerers sought to overthrow the monarchy, resulting in the banishment of unregulated magic.  \n- **The Coronation of King Alaric** – Marked by prophecy, his rise to the throne was seen as the beginning of a golden era for Eldrath.  \n\n### **Legends & Myths**  \nEldrath is rich with folklore, including tales of the **Eldran Blade**, a mythical sword said to be forged by celestial beings, and the **Lost Heir**, a hidden descendant of the royal bloodline prophesied to return in times of great peril.  \n\n### **Current State**  \nWhile Eldrath enjoys relative peace, tensions stir on the horizon. Dark forces move in the shadows, and old enemies plot their return. As King Alaric strengthens alliances and fortifies his armies, the fate of the kingdom remains uncertain. Will it stand against the coming storm, or will Eldrath’s golden age fade into legend?  \n\n	markdown	2025-03-13T23:30:58.836Z	markdown	en	1	2025-03-13T23:28:40.569Z	{}
31	the-kingdom-of-eldrath	b664e6b885ecfbc50f7aa598cdb7f5ac7d1b799a	The Kingdom of Eldrath	A sprawling kingdom known for its towering castles and skilled knights.	f	t			updated	2	## The Kingdom of Eldrath  \n\nThe **Kingdom of Eldrath** is one of the most powerful and enduring realms in the world of Arinthar. A land of towering castles, rolling green fields, and bustling cities, Eldrath stands as a beacon of civilization and order. It is a kingdom steeped in tradition, ruled by a long line of monarchs who have defended its borders from countless threats, both mortal and mystical.  \n\n### **Geography & Landscape**  \nEldrath is a vast kingdom with diverse landscapes, including:  \n- **The Capital City of Elarion** – A grand city built around the magnificent Ivory Keep, home to the royal family and center of governance.  \n- **The Golden Plains** – Fertile lands that provide the kingdom with abundant crops and serve as the heart of trade.  \n- **The Frostveil Highlands** – A rugged, snow-covered region in the north, inhabited by hardy mountain clans.  \n- **The Eldenwood Forest** – A vast and ancient woodland, rumored to be home to mystical creatures and hidden elven enclaves.  \n- **The Silver Coast** – A stretch of coastline with bustling port towns that engage in trade with distant lands.  \n\n### **Government & Leadership**  \nEldrath is ruled by the **House of Valdris**, a noble bloodline that has governed the kingdom for over five centuries. The current ruler, **King Alaric Valdris**, is a wise and just leader known for his diplomatic prowess and military strategy. The kingdom follows a **feudal system**, with noble houses overseeing different regions in service to the crown.  \n\n### **Culture & Society**  \nThe people of Eldrath value honor, chivalry, and craftsmanship. The kingdom has a rich tradition of knightly orders, such as:  \n- **The Knights of the Silver Hawk** – An elite order dedicated to protecting the royal family and the realm.  \n- **The Order of the Dawnblade** – A sect of holy warriors sworn to eradicate dark magic and demonic threats.  \n\nThe **Eldran Academy of Magic** is a prestigious institution where gifted individuals learn the arcane arts. While magic is respected in Eldrath, its practice is strictly regulated to prevent misuse.  \n\n### **Military & Defense**  \nEldrath boasts a formidable army, known as the **Eldran Legions**, composed of well-trained soldiers, cavalry, and siege engineers. The kingdom has repelled numerous invasions from rival empires, marauding orcs, and even supernatural threats. The **Wall of Aegis**, a massive fortified structure in the north, stands as a testament to Eldrath’s vigilance against external threats.  \n\n### **Notable Events in Eldrath’s History**  \n- **The War of the Broken Sky** – A devastating conflict where Eldrath led an alliance against the Great Horde, securing peace for the continent.  \n- **The Mage Rebellion** – A dark chapter where rogue sorcerers sought to overthrow the monarchy, resulting in the banishment of unregulated magic.  \n- **The Coronation of (King Alaric)[/king-alaric-of-eldrath](/king-alaric-of-eldrath)** – Marked by prophecy, his rise to the throne was seen as the beginning of a golden era for Eldrath.  \n\n### **Legends & Myths**  \nEldrath is rich with folklore, including tales of the **Eldran Blade**, a mythical sword said to be forged by celestial beings, and the **Lost Heir**, a hidden descendant of the royal bloodline prophesied to return in times of great peril.  \n\n### **Current State**  \nWhile Eldrath enjoys relative peace, tensions stir on the horizon. Dark forces move in the shadows, and old enemies plot their return. As King Alaric strengthens alliances and fortifies his armies, the fate of the kingdom remains uncertain. Will it stand against the coming storm, or will Eldrath’s golden age fade into legend?  \n\n	markdown	2025-03-13T23:31:01.451Z	markdown	en	1	2025-03-13T23:31:00.117Z	{}
32	the-kingdom-of-eldrath	b664e6b885ecfbc50f7aa598cdb7f5ac7d1b799a	The Kingdom of Eldrath	A sprawling kingdom known for its towering castles and skilled knights.	f	t			updated	2	## The Kingdom of Eldrath  \n\nThe **Kingdom of Eldrath** is one of the most powerful and enduring realms in the world of Arinthar. A land of towering castles, rolling green fields, and bustling cities, Eldrath stands as a beacon of civilization and order. It is a kingdom steeped in tradition, ruled by a long line of monarchs who have defended its borders from countless threats, both mortal and mystical.  \n\n### **Geography & Landscape**  \nEldrath is a vast kingdom with diverse landscapes, including:  \n- **The Capital City of Elarion** – A grand city built around the magnificent Ivory Keep, home to the royal family and center of governance.  \n- **The Golden Plains** – Fertile lands that provide the kingdom with abundant crops and serve as the heart of trade.  \n- **The Frostveil Highlands** – A rugged, snow-covered region in the north, inhabited by hardy mountain clans.  \n- **The Eldenwood Forest** – A vast and ancient woodland, rumored to be home to mystical creatures and hidden elven enclaves.  \n- **The Silver Coast** – A stretch of coastline with bustling port towns that engage in trade with distant lands.  \n\n### **Government & Leadership**  \nEldrath is ruled by the **House of Valdris**, a noble bloodline that has governed the kingdom for over five centuries. The current ruler, **King Alaric Valdris**, is a wise and just leader known for his diplomatic prowess and military strategy. The kingdom follows a **feudal system**, with noble houses overseeing different regions in service to the crown.  \n\n### **Culture & Society**  \nThe people of Eldrath value honor, chivalry, and craftsmanship. The kingdom has a rich tradition of knightly orders, such as:  \n- **The Knights of the Silver Hawk** – An elite order dedicated to protecting the royal family and the realm.  \n- **The Order of the Dawnblade** – A sect of holy warriors sworn to eradicate dark magic and demonic threats.  \n\nThe **Eldran Academy of Magic** is a prestigious institution where gifted individuals learn the arcane arts. While magic is respected in Eldrath, its practice is strictly regulated to prevent misuse.  \n\n### **Military & Defense**  \nEldrath boasts a formidable army, known as the **Eldran Legions**, composed of well-trained soldiers, cavalry, and siege engineers. The kingdom has repelled numerous invasions from rival empires, marauding orcs, and even supernatural threats. The **Wall of Aegis**, a massive fortified structure in the north, stands as a testament to Eldrath’s vigilance against external threats.  \n\n### **Notable Events in Eldrath’s History**  \n- **The War of the Broken Sky** – A devastating conflict where Eldrath led an alliance against the Great Horde, securing peace for the continent.  \n- **The Mage Rebellion** – A dark chapter where rogue sorcerers sought to overthrow the monarchy, resulting in the banishment of unregulated magic.  \n- **The Coronation of (King Alaric)[/king-alaric-of-eldrath](/king-alaric-of-eldrath)** – Marked by prophecy, his rise to the throne was seen as the beginning of a golden era for Eldrath.  \n\n### **Legends & Myths**  \nEldrath is rich with folklore, including tales of the **Eldran Blade**, a mythical sword said to be forged by celestial beings, and the **Lost Heir**, a hidden descendant of the royal bloodline prophesied to return in times of great peril.  \n\n### **Current State**  \nWhile Eldrath enjoys relative peace, tensions stir on the horizon. Dark forces move in the shadows, and old enemies plot their return. As King Alaric strengthens alliances and fortifies his armies, the fate of the kingdom remains uncertain. Will it stand against the coming storm, or will Eldrath’s golden age fade into legend?  \n\n	markdown	2025-03-13T23:31:39.808Z	markdown	en	1	2025-03-13T23:31:02.747Z	{}
33	the-kingdom-of-eldrath	b664e6b885ecfbc50f7aa598cdb7f5ac7d1b799a	The Kingdom of Eldrath	A sprawling kingdom known for its towering castles and skilled knights.	f	t			updated	2	## The Kingdom of Eldrath  \n\nThe **Kingdom of Eldrath** is one of the most powerful and enduring realms in the world of Arinthar. A land of towering castles, rolling green fields, and bustling cities, Eldrath stands as a beacon of civilization and order. It is a kingdom steeped in tradition, ruled by a long line of monarchs who have defended its borders from countless threats, both mortal and mystical.  \n\n### **Geography & Landscape**  \nEldrath is a vast kingdom with diverse landscapes, including:  \n- **The Capital City of Elarion** – A grand city built around the magnificent Ivory Keep, home to the royal family and center of governance.  \n- **The Golden Plains** – Fertile lands that provide the kingdom with abundant crops and serve as the heart of trade.  \n- **The Frostveil Highlands** – A rugged, snow-covered region in the north, inhabited by hardy mountain clans.  \n- **The Eldenwood Forest** – A vast and ancient woodland, rumored to be home to mystical creatures and hidden elven enclaves.  \n- **The Silver Coast** – A stretch of coastline with bustling port towns that engage in trade with distant lands.  \n\n### **Government & Leadership**  \nEldrath is ruled by the **House of Valdris**, a noble bloodline that has governed the kingdom for over five centuries. The current ruler, **King Alaric Valdris**, is a wise and just leader known for his diplomatic prowess and military strategy. The kingdom follows a **feudal system**, with noble houses overseeing different regions in service to the crown.  \n\n### **Culture & Society**  \nThe people of Eldrath value honor, chivalry, and craftsmanship. The kingdom has a rich tradition of knightly orders, such as:  \n- **The Knights of the Silver Hawk** – An elite order dedicated to protecting the royal family and the realm.  \n- **The Order of the Dawnblade** – A sect of holy warriors sworn to eradicate dark magic and demonic threats.  \n\nThe **Eldran Academy of Magic** is a prestigious institution where gifted individuals learn the arcane arts. While magic is respected in Eldrath, its practice is strictly regulated to prevent misuse.  \n\n### **Military & Defense**  \nEldrath boasts a formidable army, known as the **Eldran Legions**, composed of well-trained soldiers, cavalry, and siege engineers. The kingdom has repelled numerous invasions from rival empires, marauding orcs, and even supernatural threats. The **Wall of Aegis**, a massive fortified structure in the north, stands as a testament to Eldrath’s vigilance against external threats.  \n\n### **Notable Events in Eldrath’s History**  \n- **The War of the Broken Sky** – A devastating conflict where Eldrath led an alliance against the Great Horde, securing peace for the continent.  \n- **The Mage Rebellion** – A dark chapter where rogue sorcerers sought to overthrow the monarchy, resulting in the banishment of unregulated magic.  \n- **The Coronation of [King Alaric](/king-alaric-of-eldrath)(/king-alaric-of-eldrath)** – Marked by prophecy, his rise to the throne was seen as the beginning of a golden era for Eldrath.  \n\n### **Legends & Myths**  \nEldrath is rich with folklore, including tales of the **Eldran Blade**, a mythical sword said to be forged by celestial beings, and the **Lost Heir**, a hidden descendant of the royal bloodline prophesied to return in times of great peril.  \n\n### **Current State**  \nWhile Eldrath enjoys relative peace, tensions stir on the horizon. Dark forces move in the shadows, and old enemies plot their return. As King Alaric strengthens alliances and fortifies his armies, the fate of the kingdom remains uncertain. Will it stand against the coming storm, or will Eldrath’s golden age fade into legend?  \n\n	markdown	2025-03-13T23:33:32.460Z	markdown	en	1	2025-03-13T23:31:41.091Z	{}
34	the-kingdom-of-eldrath	b664e6b885ecfbc50f7aa598cdb7f5ac7d1b799a	The Kingdom of Eldrath	A sprawling kingdom known for its towering castles and skilled knights.	f	t			updated	2	## The Kingdom of Eldrath  \n\nThe **Kingdom of Eldrath** is one of the most powerful and enduring realms in the world of Arinthar. A land of towering castles, rolling green fields, and bustling cities, Eldrath stands as a beacon of civilization and order. It is a kingdom steeped in tradition, ruled by a long line of monarchs who have defended its borders from countless threats, both mortal and mystical.  \n\n### **Geography & Landscape**  \nEldrath is a vast kingdom with diverse landscapes, including:  \n- **The Capital City of Elarion** – A grand city built around the magnificent Ivory Keep, home to the royal family and center of governance.  \n- **The Golden Plains** – Fertile lands that provide the kingdom with abundant crops and serve as the heart of trade.  \n- **The Frostveil Highlands** – A rugged, snow-covered region in the north, inhabited by hardy mountain clans.  \n- **The Eldenwood Forest** – A vast and ancient woodland, rumored to be home to mystical creatures and hidden elven enclaves.  \n- **The Silver Coast** – A stretch of coastline with bustling port towns that engage in trade with distant lands.  \n\n### **Government & Leadership**  \nEldrath is ruled by the **House of Valdris**, a noble bloodline that has governed the kingdom for over five centuries. The current ruler, **King Alaric Valdris**, is a wise and just leader known for his diplomatic prowess and military strategy. The kingdom follows a **feudal system**, with noble houses overseeing different regions in service to the crown.  \n\n### **Culture & Society**  \nThe people of Eldrath value honor, chivalry, and craftsmanship. The kingdom has a rich tradition of knightly orders, such as:  \n- **The Knights of the Silver Hawk** – An elite order dedicated to protecting the royal family and the realm.  \n- **The Order of the Dawnblade** – A sect of holy warriors sworn to eradicate dark magic and demonic threats.  \n\nThe **Eldran Academy of Magic** is a prestigious institution where gifted individuals learn the arcane arts. While magic is respected in Eldrath, its practice is strictly regulated to prevent misuse.  \n\n### **Military & Defense**  \nEldrath boasts a formidable army, known as the **Eldran Legions**, composed of well-trained soldiers, cavalry, and siege engineers. The kingdom has repelled numerous invasions from rival empires, marauding orcs, and even supernatural threats. The **Wall of Aegis**, a massive fortified structure in the north, stands as a testament to Eldrath’s vigilance against external threats.  \n\n### **Notable Events in Eldrath’s History**  \n- **The War of the Broken Sky** – A devastating conflict where Eldrath led an alliance against the Great Horde, securing peace for the continent.  \n- **The Mage Rebellion** – A dark chapter where rogue sorcerers sought to overthrow the monarchy, resulting in the banishment of unregulated magic.  \n- **The Coronation of [King Alaric](/king-alaric-of-eldrath)** – Marked by prophecy, his rise to the throne was seen as the beginning of a golden era for Eldrath.  \n\n### **Legends & Myths**  \nEldrath is rich with folklore, including tales of the **Eldran Blade**, a mythical sword said to be forged by celestial beings, and the **Lost Heir**, a hidden descendant of the royal bloodline prophesied to return in times of great peril.  \n\n### **Current State**  \nWhile Eldrath enjoys relative peace, tensions stir on the horizon. Dark forces move in the shadows, and old enemies plot their return. As King Alaric strengthens alliances and fortifies his armies, the fate of the kingdom remains uncertain. Will it stand against the coming storm, or will Eldrath’s golden age fade into legend?  \n\n	markdown	2025-03-13T23:33:34.678Z	markdown	en	1	2025-03-13T23:33:33.764Z	{}
35	the-kingdom-of-eldrath	b664e6b885ecfbc50f7aa598cdb7f5ac7d1b799a	The Kingdom of Eldrath	A sprawling kingdom known for its towering castles and skilled knights.	f	t			updated	2	## The Kingdom of Eldrath  \n\nThe **Kingdom of Eldrath** is one of the most powerful and enduring realms in the world of Arinthar. A land of towering castles, rolling green fields, and bustling cities, Eldrath stands as a beacon of civilization and order. It is a kingdom steeped in tradition, ruled by a long line of monarchs who have defended its borders from countless threats, both mortal and mystical.  \n\n### **Geography & Landscape**  \nEldrath is a vast kingdom with diverse landscapes, including:  \n- **The Capital City of Elarion** – A grand city built around the magnificent Ivory Keep, home to the royal family and center of governance.  \n- **The Golden Plains** – Fertile lands that provide the kingdom with abundant crops and serve as the heart of trade.  \n- **The Frostveil Highlands** – A rugged, snow-covered region in the north, inhabited by hardy mountain clans.  \n- **The Eldenwood Forest** – A vast and ancient woodland, rumored to be home to mystical creatures and hidden elven enclaves.  \n- **The Silver Coast** – A stretch of coastline with bustling port towns that engage in trade with distant lands.  \n\n### **Government & Leadership**  \nEldrath is ruled by the **House of Valdris**, a noble bloodline that has governed the kingdom for over five centuries. The current ruler, **King Alaric Valdris**, is a wise and just leader known for his diplomatic prowess and military strategy. The kingdom follows a **feudal system**, with noble houses overseeing different regions in service to the crown.  \n\n### **Culture & Society**  \nThe people of Eldrath value honor, chivalry, and craftsmanship. The kingdom has a rich tradition of knightly orders, such as:  \n- **The Knights of the Silver Hawk** – An elite order dedicated to protecting the royal family and the realm.  \n- **The Order of the Dawnblade** – A sect of holy warriors sworn to eradicate dark magic and demonic threats.  \n\nThe **Eldran Academy of Magic** is a prestigious institution where gifted individuals learn the arcane arts. While magic is respected in Eldrath, its practice is strictly regulated to prevent misuse.  \n\n### **Military & Defense**  \nEldrath boasts a formidable army, known as the **Eldran Legions**, composed of well-trained soldiers, cavalry, and siege engineers. The kingdom has repelled numerous invasions from rival empires, marauding orcs, and even supernatural threats. The **Wall of Aegis**, a massive fortified structure in the north, stands as a testament to Eldrath’s vigilance against external threats.  \n\n### **Notable Events in Eldrath’s History**  \n- **The War of the Broken Sky** – A devastating conflict where Eldrath led an alliance against the Great Horde, securing peace for the continent.  \n- **The Mage Rebellion** – A dark chapter where rogue sorcerers sought to overthrow the monarchy, resulting in the banishment of unregulated magic.  \n- **The Coronation of [King Alaric](/king-alaric-of-eldrath)** – Marked by prophecy, his rise to the throne was seen as the beginning of a golden era for Eldrath.  \n\n### **Legends & Myths**  \nEldrath is rich with folklore, including tales of the **Eldran Blade**, a mythical sword said to be forged by celestial beings, and the **Lost Heir**, a hidden descendant of the royal bloodline prophesied to return in times of great peril.  \n\n### **Current State**  \nWhile Eldrath enjoys relative peace, tensions stir on the horizon. Dark forces move in the shadows, and old enemies plot their return. As King Alaric strengthens alliances and fortifies his armies, the fate of the kingdom remains uncertain. Will it stand against the coming storm, or will Eldrath’s golden age fade into legend?  \n\n	markdown	2025-03-13T23:34:30.961Z	markdown	en	1	2025-03-13T23:33:35.993Z	{}
36	the-emerald-forest	f7d5cf12b10ef6ac42b50ef55908ab4a7fbd7787	The Emerald Forest	The Emerald Forest: A vast woodland home to elusive creatures and ancient trees.	f	t			updated	3	The Emerald Forest: A vast woodland home to elusive creatures and ancient trees.	markdown	2025-03-13T23:38:17.573Z	markdown	en	1	2025-03-13T22:50:03.150Z	{}
37	the-emerald-forest	f7d5cf12b10ef6ac42b50ef55908ab4a7fbd7787	The Emerald Forest	The Emerald Forest: A vast woodland home to elusive creatures and ancient trees.	f	t			updated	3	The Emerald Forest\nThe Emerald Forest is an ancient and mystical woodland located at the heart of Arinthar. Named for its ever-glowing green canopy, the forest is a realm of wonder and danger, home to enchanted creatures, forgotten ruins, and powerful druidic magic. Legends say that the forest is alive, watching over those who enter, and deciding their fate based on the purity of their hearts.\n\nGeography & Landscape\nThe Emerald Forest spans miles of lush, untamed wilderness, its terrain ranging from dense woodlands to hidden glades and sparkling rivers. Among its most notable landmarks are:\n\nThe Heartglade – A sacred clearing where an ancient, colossal oak known as the Elderbloom stands, radiating natural magic.\nThe Veilwood – A mysterious section of the forest where the trees appear translucent under the moonlight, allowing glimpses into the Fae Realm.\nThe Whispering Thicket – A shadowy expanse where the trees seem to murmur secrets to those who dare to listen.\nThe Sylvan Ruins – Remnants of an ancient elven city, now overgrown and hidden within the forest’s depths.\nInhabitants & Creatures\nThe Emerald Forest is home to a variety of beings, both benevolent and malevolent:\n\nFaerie Folk – Mischievous yet wise creatures that dwell between the mortal world and the Fae Realm.\nDryads & Treants – Guardians of the forest who protect the land from outsiders with ill intent.\nMoonstalkers – Ghostly wolves that appear only on nights of the full moon, guiding lost travelers—or hunting them.\nThe Verdant Warden – A legendary druid rumored to have merged his soul with the forest, granting him dominion over its magic.\nShadowspore Mycelings – Intelligent fungal beings that dwell beneath the forest floor, rumored to have knowledge of the world's oldest secrets.\nMagic & Mysticism\nThe Emerald Forest is infused with ancient magic, making it a place of great spiritual and mystical significance. The druids of Eldrath frequently seek guidance here, and those attuned to nature can hear the whisper of the leaves, a phenomenon believed to be the voice of the forest itself. The Leyspring, a hidden font of pure magical energy, is said to lie deep within the woods, empowering those who find it.\n\nLegends & Myths\nThe Emerald Forest is woven with countless tales, including:\n\nThe Lost Crown of Vaelora – An enchanted diadem hidden within the forest, said to grant wisdom and foresight to its wearer.\nThe Slumbering Titan – A giant stone figure buried beneath the roots of the Elderbloom, believed to awaken in times of great peril.\nThe Phantom Path – A mystical road that only appears under the light of the blood moon, leading to either great fortune or doom.\nCurrent State\nThe Emerald Forest remains a place of mystery, its secrets guarded by time and nature. However, dark rumors stir—whispers of a creeping corruption spreading through the Veilwood, of shadows moving where none should be. Those who dare to enter must tread carefully, for the forest welcomes only those it deems worthy—and those who are not may never return.	markdown	2025-03-13T23:40:04.539Z	markdown	en	1	2025-03-13T23:38:18.839Z	{}
38	the-emerald-forest	f7d5cf12b10ef6ac42b50ef55908ab4a7fbd7787	The Emerald Forest	The Emerald Forest: A vast woodland home to elusive creatures and ancient trees.	f	t			updated	3	## The Emerald Forest  \n\nThe **Emerald Forest** is an ancient and mystical woodland located at the heart of Arinthar. Named for its ever-glowing green canopy, the forest is a realm of wonder and danger, home to enchanted creatures, forgotten ruins, and powerful druidic magic. Legends say that the forest is alive, watching over those who enter, and deciding their fate based on the purity of their hearts.  \n\n### **Geography & Landscape**  \nThe Emerald Forest spans miles of lush, untamed wilderness, its terrain ranging from dense woodlands to hidden glades and sparkling rivers. Among its most notable landmarks are:  \n- **The Heartglade** – A sacred clearing where an ancient, colossal oak known as the **Elderbloom** stands, radiating natural magic.  \n- **The Veilwood** – A mysterious section of the forest where the trees appear translucent under the moonlight, allowing glimpses into the Fae Realm.  \n- **The Whispering Thicket** – A shadowy expanse where the trees seem to murmur secrets to those who dare to listen.  \n- **The Sylvan Ruins** – Remnants of an ancient elven city, now overgrown and hidden within the forest’s depths.  \n\n### **Inhabitants & Creatures**  \nThe Emerald Forest is home to a variety of beings, both benevolent and malevolent:  \n- **Faerie Folk** – Mischievous yet wise creatures that dwell between the mortal world and the Fae Realm.  \n- **Dryads & Treants** – Guardians of the forest who protect the land from outsiders with ill intent.  \n- **Moonstalkers** – Ghostly wolves that appear only on nights of the full moon, guiding lost travelers—or hunting them.  \n- **The Verdant Warden** – A legendary druid rumored to have merged his soul with the forest, granting him dominion over its magic.  \n- **Shadowspore Mycelings** – Intelligent fungal beings that dwell beneath the forest floor, rumored to have knowledge of the world's oldest secrets.  \n\n### **Magic & Mysticism**  \nThe Emerald Forest is infused with ancient magic, making it a place of great spiritual and mystical significance. The druids of Eldrath frequently seek guidance here, and those attuned to nature can hear the **whisper of the leaves**, a phenomenon believed to be the voice of the forest itself. The **Leyspring**, a hidden font of pure magical energy, is said to lie deep within the woods, empowering those who find it.  \n\n### **Legends & Myths**  \nThe Emerald Forest is woven with countless tales, including:  \n- **The Lost Crown of Vaelora** – An enchanted diadem hidden within the forest, said to grant wisdom and foresight to its wearer.  \n- **The Slumbering Titan** – A giant stone figure buried beneath the roots of the Elderbloom, believed to awaken in times of great peril.  \n- **The Phantom Path** – A mystical road that only appears under the light of the blood moon, leading to either great fortune or doom.  \n\n### **Current State**  \nThe Emerald Forest remains a place of mystery, its secrets guarded by time and nature. However, dark rumors stir—whispers of **a creeping corruption** spreading through the Veilwood, of shadows moving where none should be. Those who dare to enter must tread carefully, for the forest **welcomes only those it deems worthy**—and those who are not may never return.	markdown	2025-03-13T23:41:41.114Z	markdown	en	1	2025-03-13T23:40:05.797Z	{}
39	ruins-of-valmara	d3b0735d8fc29fe6c70890abd7375c037bfabad1	Shattered Isles	A cluster of islands believed to be remnants of a once mighty empire.	f	t			updated	5	Shattered Isles: A cluster of islands believed to be remnants of a once mighty empire.	markdown	2025-03-13T23:47:24.344Z	markdown	en	1	2025-03-13T22:51:17.472Z	{}
40	tarnheim-peak	7287396839641f637aff74a6aec973647e74c39a	Tarnheim Peak	A dangerous mountain inhabited by dragons and other flying creatures.	f	t			updated	13	A dangerous mountain inhabited by dragons and other flying creatures.	markdown	2025-03-13T23:48:04.545Z	markdown	en	1	2025-03-13T23:11:59.922Z	{}
41	shattered-isles	69ac3315dd23b955e668067b3f0b5a3bcdc1a50a	The Emerald Forest	A vast woodland home to elusive creatures and ancient trees.	f	t			updated	4	The Emerald Forest: A vast woodland home to elusive creatures and ancient trees.	markdown	2025-03-13T23:50:31.895Z	markdown	en	1	2025-03-13T22:50:54.618Z	{}
42	tarnheim-peak	7287396839641f637aff74a6aec973647e74c39a	Tarnheim Peak	A dangerous mountain inhabited by dragons and other flying creatures.	f	t			updated	13	A dangerous mountain inhabited by dragons and other flying creatures.\n\n[hurokin](/hurokin)\n\n[sethrin-the-bold](/sethrin-the-bold)\n\n	markdown	2025-03-13T23:52:09.452Z	markdown	en	1	2025-03-13T23:48:05.767Z	{}
43	the-war-of-the-broken-sky	104560ef3e2714e604b5cab0444e5b3ae7187364	The War of the Broken Sky	A cataclysmic war that nearly tore the world apart.	f	t			updated	21	A cataclysmic war that nearly tore the world apart.	markdown	2025-03-13T23:52:43.528Z	markdown	en	1	2025-03-13T21:58:56.742Z	{}
44	the-rise-of-the-blood-moon	9c85d1c9ff5e30ad86e0f2e3fe93bba49b0192ba	The Rise of the Blood Moon	A prophecy that foretells the coming of a dark age, heralded by the appearance of a blood-red moon.	f	t			updated	22	A prophecy that foretells the coming of a dark age, heralded by the appearance of a blood-red moon.	markdown	2025-03-13T23:53:19.848Z	markdown	en	1	2025-03-13T21:59:24.524Z	{}
45	prince-anselm-of-the-shattered-isles	cea71df075b0e033e329698b288fc3034332ffda	Prince Anselm of the Shattered Isles	The last surviving royal of the Shattered Isles, with ambitions to restore his kingdom.	f	t			updated	20	 The last surviving royal of the Shattered Isles, with ambitions to restore his kingdom.	markdown	2025-03-13T23:53:47.916Z	markdown	en	1	2025-03-13T23:15:50.404Z	{}
\.


--
-- Data for Name: pageHistoryTags; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."pageHistoryTags" (id, "pageId", "tagId") FROM stdin;
\.


--
-- Data for Name: pageLinks; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."pageLinks" (id, path, "localeCode", "pageId") FROM stdin;
1	the-kingdom-of-eldrath	en	1
2	the-emerald-forest	en	1
3	shattered-isles	en	1
4	ruins-of-valmara	en	1
5	tarnheim-peak	en	1
6	drakes-of-the-highwind-mountains	en	1
7	wyrmbeasts	en	1
8	faerie-folk	en	1
9	elder-spirits	en	1
10	aelirian-elves	en	1
11	dwarves-of-karak-dur	en	1
12	hurokin	en	1
13	orcs-of-the-wastes	en	1
14	the-shadar	en	1
15	king-alaric-of-eldrath	en	1
16	sethrin-the-bold	en	1
17	lady-sylara-moonshadow	en	1
18	gorruk-the-eternal	en	1
19	prince-anselm-of-the-shattered-isles	en	1
20	the-war-of-the-broken-sky	en	1
21	the-rise-of-the-blood-moon	en	1
22	the-great-exodus	en	1
23	the-fall-of-valmara	en	1
24	the-arcane-arts	en	1
25	rune-magic	en	1
26	divination	en	1
27	elemental-binding	en	1
28	king-alaric-of-eldrath	en	2
29	the-war-of-the-broken-sky	en	2
30	faerie-folk	en	3
31	elder-spirits	en	5
32	the-war-of-the-broken-sky	en	5
33	hurokin	en	13
34	sethrin-the-bold	en	13
35	lady-sylara-moonshadow	en	4
36	drakes-of-the-highwind-mountains	en	13
37	dwarves-of-karak-dur	en	13
38	gorruk-the-eternal	en	21
39	the-great-exodus	en	22
40	ruins-of-valmara	en	20
\.


--
-- Data for Name: pageTags; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."pageTags" (id, "pageId", "tagId") FROM stdin;
1	25	1
2	28	1
3	27	1
4	26	1
5	2	2
6	3	2
7	4	2
8	5	2
10	13	2
11	14	3
12	15	3
13	12	3
14	11	3
15	6	4
16	17	4
17	18	4
18	19	4
19	20	4
20	10	5
21	9	5
22	8	5
23	7	5
24	16	5
25	24	6
26	2	7
\.


--
-- Data for Name: pageTree; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."pageTree" (id, path, depth, title, "isPrivate", "isFolder", "privateNS", parent, "pageId", "localeCode", ancestors) FROM stdin;
1	aelirian-elves	1	Aelirian Elves	f	f	\N	\N	10	en	[]
2	divination	1	Divination	f	f	\N	\N	27	en	[]
3	drakes-of-the-highwind-mountains	1	Drakes of the Highwind Mountains	f	f	\N	\N	14	en	[]
4	dwarves-of-karak-dur	1	Dwarves of Karak-Dur	f	f	\N	\N	9	en	[]
5	elder-spirits	1	Elder Spirits	f	f	\N	\N	11	en	[]
6	elemental-binding	1	Elemental Binding	f	f	\N	\N	28	en	[]
7	faerie-folk	1	Faerie Folk	f	f	\N	\N	12	en	[]
8	gorruk-the-eternal	1	Gorruk the Eternal	f	f	\N	\N	19	en	[]
9	home	1	Index	f	f	\N	\N	1	en	[]
10	hurokin	1	Hurokin	f	f	\N	\N	8	en	[]
11	king-alaric-of-eldrath	1	King Alaric of Eldrath	f	f	\N	\N	6	en	[]
12	lady-sylara-moonshadow	1	Lady Sylara Moonshadow	f	f	\N	\N	18	en	[]
13	orcs-of-the-wastes	1	Orcs of the Wastes	f	f	\N	\N	7	en	[]
14	prince-anselm-of-the-shattered-isles	1	Prince Anselm of the Shattered Isles	f	f	\N	\N	20	en	[]
15	ruins-of-valmara	1	Shattered Isles	f	f	\N	\N	5	en	[]
16	rune-magic	1	Rune Magic	f	f	\N	\N	26	en	[]
17	sethrin-the-bold	1	Sethrin the Bold	f	f	\N	\N	17	en	[]
18	shattered-isles	1	The Emerald Forest	f	f	\N	\N	4	en	[]
19	tarnheim-peak	1	Tarnheim Peak	f	f	\N	\N	13	en	[]
20	the-arcane-arts	1	The Arcane Arts	f	f	\N	\N	25	en	[]
21	the-emerald-forest	1	The Emerald Forest	f	f	\N	\N	3	en	[]
22	the-fall-of-valmara	1	The Fall of Valmara	f	f	\N	\N	24	en	[]
23	the-great-exodus	1	The Great Exodus	f	f	\N	\N	23	en	[]
24	the-kingdom-of-eldrath	1	The Kingdom of Eldrath	f	f	\N	\N	2	en	[]
25	the-rise-of-the-blood-moon	1	The Rise of the Blood Moon	f	f	\N	\N	22	en	[]
26	the-shadar	1	The Shadar	f	f	\N	\N	16	en	[]
27	the-war-of-the-broken-sky	1	The War of the Broken Sky	f	f	\N	\N	21	en	[]
28	wyrmbeasts	1	Wyrmbeasts	f	f	\N	\N	15	en	[]
\.


--
-- Data for Name: pages; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.pages (id, path, hash, title, description, "isPrivate", "isPublished", "privateNS", "publishStartDate", "publishEndDate", content, render, toc, "contentType", "createdAt", "updatedAt", "editorKey", "localeCode", "authorId", "creatorId", extra) FROM stdin;
3	the-emerald-forest	f7d5cf12b10ef6ac42b50ef55908ab4a7fbd7787	The Emerald Forest	The Emerald Forest: A vast woodland home to elusive creatures and ancient trees.	f	t	\N			## The Emerald Forest  \n\nThe **Emerald Forest** is an ancient and mystical woodland located at the heart of Arinthar. Named for its ever-glowing green canopy, the forest is a realm of wonder and danger, home to enchanted creatures, forgotten ruins, and powerful druidic magic. Legends say that the forest is alive, watching over those who enter, and deciding their fate based on the purity of their hearts.  \n\n### **Geography & Landscape**  \nThe Emerald Forest spans miles of lush, untamed wilderness, its terrain ranging from dense woodlands to hidden glades and sparkling rivers. Among its most notable landmarks are:  \n- **The Heartglade** – A sacred clearing where an ancient, colossal oak known as the **Elderbloom** stands, radiating natural magic.  \n- **The Veilwood** – A mysterious section of the forest where the trees appear translucent under the moonlight, allowing glimpses into the Fae Realm.  \n- **The Whispering Thicket** – A shadowy expanse where the trees seem to murmur secrets to those who dare to listen.  \n- **The Sylvan Ruins** – Remnants of an ancient elven city, now overgrown and hidden within the forest’s depths.  \n\n### **Inhabitants & Creatures**  \nThe Emerald Forest is home to a variety of beings, both benevolent and malevolent:  \n- **[Faerie Folk](/faerie-folk)** – Mischievous yet wise creatures that dwell between the mortal world and the Fae Realm.  \n- **Dryads & Treants** – Guardians of the forest who protect the land from outsiders with ill intent.  \n- **Moonstalkers** – Ghostly wolves that appear only on nights of the full moon, guiding lost travelers—or hunting them.  \n- **The Verdant Warden** – A legendary druid rumored to have merged his soul with the forest, granting him dominion over its magic.  \n- **Shadowspore Mycelings** – Intelligent fungal beings that dwell beneath the forest floor, rumored to have knowledge of the world's oldest secrets.  \n\n### **Magic & Mysticism**  \nThe Emerald Forest is infused with ancient magic, making it a place of great spiritual and mystical significance. The druids of Eldrath frequently seek guidance here, and those attuned to nature can hear the **whisper of the leaves**, a phenomenon believed to be the voice of the forest itself. The **Leyspring**, a hidden font of pure magical energy, is said to lie deep within the woods, empowering those who find it.  \n\n### **Legends & Myths**  \nThe Emerald Forest is woven with countless tales, including:  \n- **The Lost Crown of Vaelora** – An enchanted diadem hidden within the forest, said to grant wisdom and foresight to its wearer.  \n- **The Slumbering Titan** – A giant stone figure buried beneath the roots of the Elderbloom, believed to awaken in times of great peril.  \n- **The Phantom Path** – A mystical road that only appears under the light of the blood moon, leading to either great fortune or doom.  \n\n### **Current State**  \nThe Emerald Forest remains a place of mystery, its secrets guarded by time and nature. However, dark rumors stir—whispers of **a creeping corruption** spreading through the Veilwood, of shadows moving where none should be. Those who dare to enter must tread carefully, for the forest **welcomes only those it deems worthy**—and those who are not may never return.	<h2 class="toc-header" id="the-emerald-forest"><a href="#the-emerald-forest" class="toc-anchor">¶</a> The Emerald Forest</h2>\n<p>The <strong>Emerald Forest</strong> is an ancient and mystical woodland located at the heart of Arinthar. Named for its ever-glowing green canopy, the forest is a realm of wonder and danger, home to enchanted creatures, forgotten ruins, and powerful druidic magic. Legends say that the forest is alive, watching over those who enter, and deciding their fate based on the purity of their hearts.</p>\n<h3 class="toc-header" id="geography-landscape"><a href="#geography-landscape" class="toc-anchor">¶</a> <strong>Geography &amp; Landscape</strong></h3>\n<p>The Emerald Forest spans miles of lush, untamed wilderness, its terrain ranging from dense woodlands to hidden glades and sparkling rivers. Among its most notable landmarks are:</p>\n<ul>\n<li><strong>The Heartglade</strong> – A sacred clearing where an ancient, colossal oak known as the <strong>Elderbloom</strong> stands, radiating natural magic.</li>\n<li><strong>The Veilwood</strong> – A mysterious section of the forest where the trees appear translucent under the moonlight, allowing glimpses into the Fae Realm.</li>\n<li><strong>The Whispering Thicket</strong> – A shadowy expanse where the trees seem to murmur secrets to those who dare to listen.</li>\n<li><strong>The Sylvan Ruins</strong> – Remnants of an ancient elven city, now overgrown and hidden within the forest’s depths.</li>\n</ul>\n<h3 class="toc-header" id="inhabitants-creatures"><a href="#inhabitants-creatures" class="toc-anchor">¶</a> <strong>Inhabitants &amp; Creatures</strong></h3>\n<p>The Emerald Forest is home to a variety of beings, both benevolent and malevolent:</p>\n<ul>\n<li><strong><a class="is-internal-link is-valid-page" href="/faerie-folk">Faerie Folk</a></strong> – Mischievous yet wise creatures that dwell between the mortal world and the Fae Realm.</li>\n<li><strong>Dryads &amp; Treants</strong> – Guardians of the forest who protect the land from outsiders with ill intent.</li>\n<li><strong>Moonstalkers</strong> – Ghostly wolves that appear only on nights of the full moon, guiding lost travelers—or hunting them.</li>\n<li><strong>The Verdant Warden</strong> – A legendary druid rumored to have merged his soul with the forest, granting him dominion over its magic.</li>\n<li><strong>Shadowspore Mycelings</strong> – Intelligent fungal beings that dwell beneath the forest floor, rumored to have knowledge of the world's oldest secrets.</li>\n</ul>\n<h3 class="toc-header" id="magic-mysticism"><a href="#magic-mysticism" class="toc-anchor">¶</a> <strong>Magic &amp; Mysticism</strong></h3>\n<p>The Emerald Forest is infused with ancient magic, making it a place of great spiritual and mystical significance. The druids of Eldrath frequently seek guidance here, and those attuned to nature can hear the <strong>whisper of the leaves</strong>, a phenomenon believed to be the voice of the forest itself. The <strong>Leyspring</strong>, a hidden font of pure magical energy, is said to lie deep within the woods, empowering those who find it.</p>\n<h3 class="toc-header" id="legends-myths"><a href="#legends-myths" class="toc-anchor">¶</a> <strong>Legends &amp; Myths</strong></h3>\n<p>The Emerald Forest is woven with countless tales, including:</p>\n<ul>\n<li><strong>The Lost Crown of Vaelora</strong> – An enchanted diadem hidden within the forest, said to grant wisdom and foresight to its wearer.</li>\n<li><strong>The Slumbering Titan</strong> – A giant stone figure buried beneath the roots of the Elderbloom, believed to awaken in times of great peril.</li>\n<li><strong>The Phantom Path</strong> – A mystical road that only appears under the light of the blood moon, leading to either great fortune or doom.</li>\n</ul>\n<h3 class="toc-header" id="current-state"><a href="#current-state" class="toc-anchor">¶</a> <strong>Current State</strong></h3>\n<p>The Emerald Forest remains a place of mystery, its secrets guarded by time and nature. However, dark rumors stir—whispers of <strong>a creeping corruption</strong> spreading through the Veilwood, of shadows moving where none should be. Those who dare to enter must tread carefully, for the forest <strong>welcomes only those it deems worthy</strong>—and those who are not may never return.</p>\n	[{"title":"The Emerald Forest","anchor":"#the-emerald-forest","children":[{"title":"Geography & Landscape","anchor":"#geography-landscape","children":[]},{"title":"Inhabitants & Creatures","anchor":"#inhabitants-creatures","children":[]},{"title":"Magic & Mysticism","anchor":"#magic-mysticism","children":[]},{"title":"Legends & Myths","anchor":"#legends-myths","children":[]},{"title":"Current State","anchor":"#current-state","children":[]}]}]	markdown	2025-03-11T03:19:40.253Z	2025-03-13T23:41:42.373Z	markdown	en	1	1	{"js":"","css":""}
8	hurokin	35ac48caeaa7835c17ef59e85174aaf33385d2c6	Hurokin	A nomadic race of shape-shifters, known for their agility and adaptability.	f	t	\N			A nomadic race of shape-shifters, known for their agility and adaptability.	<p>A nomadic race of shape-shifters, known for their agility and adaptability.</p>\n	[]	markdown	2025-03-13T21:49:51.916Z	2025-03-13T23:16:46.553Z	markdown	en	1	1	{"js":"","css":""}
7	orcs-of-the-wastes	7eb24ff38f12e657511a779256701a0b660fd52c	Orcs of the Wastes	Fierce warriors from the arid deserts, often misunderstood but fiercely loyal.	f	t	\N			Fierce warriors from the arid deserts, often misunderstood but fiercely loyal.	<p>Fierce warriors from the arid deserts, often misunderstood but fiercely loyal.</p>\n	[]	markdown	2025-03-13T21:49:16.509Z	2025-03-13T23:17:04.129Z	markdown	en	1	1	{"js":"","css":""}
10	aelirian-elves	95305783a75e504aab17ba110dbddc1b435b181e	Aelirian Elves	A race of immortal beings who have mastered magic and the arts.	f	t	\N			A race of immortal beings who have mastered magic and the arts.	<p>A race of immortal beings who have mastered magic and the arts.</p>\n	[]	markdown	2025-03-13T21:50:40.419Z	2025-03-13T23:16:16.810Z	markdown	en	1	1	{"js":"","css":""}
9	dwarves-of-karak-dur	130567fe76c61e2701f1945d620ec8c5a2608718	Dwarves of Karak-Dur	Stout and resilient, these warriors thrive in the mountains and are expert craftsmen.	f	t	\N			Stout and resilient, these warriors thrive in the mountains and are expert craftsmen.	<p>Stout and resilient, these warriors thrive in the mountains and are expert craftsmen.</p>\n	[]	markdown	2025-03-13T21:50:19.403Z	2025-03-13T23:16:32.924Z	markdown	en	1	1	{"js":"","css":""}
6	king-alaric-of-eldrath	d4743c9bc811313502f8721c231d7d030251290b	King Alaric of Eldrath	 The wise and just ruler of Eldrath, known for his diplomatic skills and military prowess.	f	t	\N			The wise and just ruler of Eldrath, known for his diplomatic skills and military prowess.	<p>The wise and just ruler of Eldrath, known for his diplomatic skills and military prowess.</p>\n	[]	markdown	2025-03-13T21:48:45.373Z	2025-03-13T23:14:30.605Z	markdown	en	1	1	{"js":"","css":""}
11	elder-spirits	a3a9d606eac1cd2006028546a0edad792834ad87	Elder Spirits	Ghostly entities that have transcended death, existing in a state between the physical and ethereal planes.	f	t	\N			Ghostly entities that have transcended death, existing in a state between the physical and ethereal planes.	<p>Ghostly entities that have transcended death, existing in a state between the physical and ethereal planes.</p>\n	[]	markdown	2025-03-13T21:51:03.706Z	2025-03-13T23:13:56.790Z	markdown	en	1	1	{"js":"","css":""}
15	wyrmbeasts	99e31480a35f50e40fdd78711cece24c2c24c0a0	Wyrmbeasts	Massive, earth-shaking creatures said to dwell beneath the surface of the world.	f	t	\N			Massive, earth-shaking creatures said to dwell beneath the surface of the world.	<p>Massive, earth-shaking creatures said to dwell beneath the surface of the world.</p>\n	[]	markdown	2025-03-13T21:55:59.351Z	2025-03-13T23:13:20.574Z	markdown	en	1	1	{"js":"","css":""}
14	drakes-of-the-highwind-mountains	b12aec62d0e2b8d280b81f663109bb3cd9294e9b	Drakes of the Highwind Mountains	A breed of winged dragons that control the skies above Arinthar.	f	t	\N			A breed of winged dragons that control the skies above Arinthar.	<p>A breed of winged dragons that control the skies above Arinthar.</p>\n	[]	markdown	2025-03-13T21:55:37.633Z	2025-03-13T23:13:07.274Z	markdown	en	1	1	{"js":"","css":""}
12	faerie-folk	3ba2a900dd5d49090d77710b50e66c536b4f3961	Faerie Folk	 A magical race of beings who dwell in the fae realm, known for their trickery and beauty.	f	t	\N			 A magical race of beings who dwell in the fae realm, known for their trickery and beauty.	<p>A magical race of beings who dwell in the fae realm, known for their trickery and beauty.</p>\n	[]	markdown	2025-03-13T21:51:24.689Z	2025-03-13T23:13:42.255Z	markdown	en	1	1	{"js":"","css":""}
5	ruins-of-valmara	d3b0735d8fc29fe6c70890abd7375c037bfabad1	Shattered Isles	A cluster of islands believed to be remnants of a once mighty empire.	f	t	\N			Shattered Isles: A cluster of islands believed to be remnants of a once mighty empire.\n\n[elder-spirits](/elder-spirits)\n\n[the-war-of-the-broken-sky](/the-war-of-the-broken-sky)	<p>Shattered Isles: A cluster of islands believed to be remnants of a once mighty empire.</p>\n<p><a class="is-internal-link is-valid-page" href="/elder-spirits">elder-spirits</a></p>\n<p><a class="is-internal-link is-valid-page" href="/the-war-of-the-broken-sky">the-war-of-the-broken-sky</a></p>\n	[]	markdown	2025-03-11T03:20:40.781Z	2025-03-13T23:47:25.585Z	markdown	en	1	1	{"js":"","css":""}
4	shattered-isles	69ac3315dd23b955e668067b3f0b5a3bcdc1a50a	The Emerald Forest	A vast woodland home to elusive creatures and ancient trees.	f	t	\N			The Emerald Forest: A vast woodland home to elusive creatures and ancient trees.\n\n[lady-sylara-moonshadow](/lady-sylara-moonshadow)	<p>The Emerald Forest: A vast woodland home to elusive creatures and ancient trees.</p>\n<p><a class="is-internal-link is-valid-page" href="/lady-sylara-moonshadow">lady-sylara-moonshadow</a></p>\n	[]	markdown	2025-03-11T03:20:16.838Z	2025-03-13T23:50:33.166Z	markdown	en	1	1	{"js":"","css":""}
16	the-shadar	d8105999800f19f7b0bec5545ba5456a4a315d17	The Shadar	A mysterious race that exists in the shadows, unseen by most but ever-present in the world.	f	t	\N			A mysterious race that exists in the shadows, unseen by most but ever-present in the world.	<p>A mysterious race that exists in the shadows, unseen by most but ever-present in the world.</p>\n	[]	markdown	2025-03-13T21:56:48.601Z	2025-03-13T23:17:16.083Z	markdown	en	1	1	{"js":"","css":""}
17	sethrin-the-bold	14c2676e318870431f61884005e010cc915e4c90	Sethrin the Bold	A legendary warrior who led the charge against the Great Horde during the War of the Broken Sky.	f	t	\N			A legendary warrior who led the charge against the Great Horde during the War of the Broken Sky.	<p>A legendary warrior who led the charge against the Great Horde during the War of the Broken Sky.</p>\n	[]	markdown	2025-03-13T21:57:29.099Z	2025-03-13T23:14:46.258Z	markdown	en	1	1	{"js":"","css":""}
20	prince-anselm-of-the-shattered-isles	cea71df075b0e033e329698b288fc3034332ffda	Prince Anselm of the Shattered Isles	The last surviving royal of the Shattered Isles, with ambitions to restore his kingdom.	f	t	\N			 The last surviving royal of the Shattered Isles, with ambitions to restore his kingdom.\n \n [ruins-of-valmara](/ruins-of-valmara)	<p>The last surviving royal of the Shattered Isles, with ambitions to restore his kingdom.</p>\n<p><a class="is-internal-link is-valid-page" href="/ruins-of-valmara">ruins-of-valmara</a></p>\n	[]	markdown	2025-03-13T21:58:35.779Z	2025-03-13T23:53:49.147Z	markdown	en	1	1	{"js":"","css":""}
18	lady-sylara-moonshadow	6fbd3d3e8a4848ca935a501a6526a79842befc94	Lady Sylara Moonshadow	A powerful sorceress whose magic is feared across the lands.	f	t	\N			A powerful sorceress whose magic is feared across the lands.	<p>A powerful sorceress whose magic is feared across the lands.</p>\n	[]	markdown	2025-03-13T21:57:51.957Z	2025-03-13T23:15:00.710Z	markdown	en	1	1	{"js":"","css":""}
19	gorruk-the-eternal	a14cdea1f3c06dc3cee4f899915e34e76461afca	Gorruk the Eternal	An immortal being believed to be older than Arinthar itself, rumored to control time itself.	f	t	\N			An immortal being believed to be older than Arinthar itself, rumored to control time itself.	<p>An immortal being believed to be older than Arinthar itself, rumored to control time itself.</p>\n	[]	markdown	2025-03-13T21:58:14.650Z	2025-03-13T23:15:18.665Z	markdown	en	1	1	{"js":"","css":""}
23	the-great-exodus	8524eac671f91de397620033750dffed2fee05b0	The Great Exodus	The migration of several races from the sinking continent of Vaelgrun.	f	t	\N			 The migration of several races from the sinking continent of Vaelgrun.	<p>The migration of several races from the sinking continent of Vaelgrun.</p>\n	[]	markdown	2025-03-13T21:59:47.940Z	2025-03-13T21:59:48.814Z	markdown	en	1	1	{"js":"","css":""}
21	the-war-of-the-broken-sky	104560ef3e2714e604b5cab0444e5b3ae7187364	The War of the Broken Sky	A cataclysmic war that nearly tore the world apart.	f	t	\N			A cataclysmic war that nearly tore the world apart.\n\n[gorruk-the-eternal](/gorruk-the-eternal)	<p>A cataclysmic war that nearly tore the world apart.</p>\n<p><a class="is-internal-link is-valid-page" href="/gorruk-the-eternal">gorruk-the-eternal</a></p>\n	[]	markdown	2025-03-13T21:58:55.877Z	2025-03-13T23:52:44.794Z	markdown	en	1	1	{"js":"","css":""}
22	the-rise-of-the-blood-moon	9c85d1c9ff5e30ad86e0f2e3fe93bba49b0192ba	The Rise of the Blood Moon	A prophecy that foretells the coming of a dark age, heralded by the appearance of a blood-red moon.	f	t	\N			A prophecy that foretells the coming of a dark age, heralded by the appearance of a blood-red moon.\n\n[the-great-exodus](/the-great-exodus)	<p>A prophecy that foretells the coming of a dark age, heralded by the appearance of a blood-red moon.</p>\n<p><a class="is-internal-link is-valid-page" href="/the-great-exodus">the-great-exodus</a></p>\n	[]	markdown	2025-03-13T21:59:23.659Z	2025-03-13T23:53:21.135Z	markdown	en	1	1	{"js":"","css":""}
25	the-arcane-arts	2767206d1bbc4ccae02feff0feab69d119ac2f7a	The Arcane Arts	The study and mastery of magical forces that govern the world.	f	t	\N			The study and mastery of magical forces that govern the world.	<p>The study and mastery of magical forces that govern the world.</p>\n	[]	markdown	2025-03-13T22:00:26.738Z	2025-03-13T22:45:00.351Z	markdown	en	1	1	{"js":"","css":""}
24	the-fall-of-valmara	8cead464725f7f5190eb9d4aaad787cf774da0c3	The Fall of Valmara	The mysterious event that led to the downfall of an ancient city, leaving only ruins behind.	f	t	\N			The mysterious event that led to the downfall of an ancient city, leaving only ruins behind.	<p>The mysterious event that led to the downfall of an ancient city, leaving only ruins behind.</p>\n	[]	markdown	2025-03-13T22:00:08.574Z	2025-03-13T23:21:34.158Z	markdown	en	1	1	{"js":"","css":""}
26	rune-magic	3769ff4eef4def578784a32cb8c8ef64e565c6ca	Rune Magic	A powerful form of magic that taps into the ancient runes of Arinthar.	f	t	\N			A powerful form of magic that taps into the ancient runes of Arinthar.	<p>A powerful form of magic that taps into the ancient runes of Arinthar.</p>\n	[]	markdown	2025-03-13T22:00:47.024Z	2025-03-13T22:48:23.884Z	markdown	en	1	1	{"js":"","css":""}
27	divination	a4d8c87c46cb09b42e4b1835b93c2dfbebf377e3	Divination	The art of foreseeing future events through mystical means.	f	t	\N			The art of foreseeing future events through mystical means.	<p>The art of foreseeing future events through mystical means.</p>\n	[]	markdown	2025-03-13T22:01:07.601Z	2025-03-13T22:46:05.372Z	markdown	en	1	1	{"js":"","css":""}
28	elemental-binding	44fbe07df39fa274d471ea9807d389a4ea0fe067	Elemental Binding	Elemental Binding: The practice of controlling the elemental forces of fire, water, air, and earth.	f	t	\N			Elemental Binding: The practice of controlling the elemental forces of fire, water, air, and earth.	<p>Elemental Binding: The practice of controlling the elemental forces of fire, water, air, and earth.</p>\n	[]	markdown	2025-03-13T22:01:30.626Z	2025-03-13T22:45:41.219Z	markdown	en	1	1	{"js":"","css":""}
1	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	Index	Categorization of other pages	f	t	\N			# Welcome to the World of Arinthar Wiki\n\nWelcome to the official wiki of Arinthar, a rich and mysterious fantasy world full of powerful beings, ancient histories, and legendary events. This wiki serves as a comprehensive guide to all that exists within this magical realm, from the farthest reaches of the Highlands to the deepest caverns of the Underdark.\n\n## Table of Contents\n\n### 1. **Places**\n- [The Kingdom of Eldrath](/the-kingdom-of-eldrath): A sprawling kingdom known for its towering castles and skilled knights.\n- [The Emerald Forest](/the-emerald-forest): A vast woodland home to elusive creatures and ancient trees.\n- [Shattered Isles](/shattered-isles): A cluster of islands believed to be remnants of a once mighty empire.\n- [Ruins of Valmara](/ruins-of-valmara): The lost city buried beneath shifting sands, said to be cursed.\n- [Tarnheim Peak](/tarnheim-peak): A dangerous mountain inhabited by dragons and other flying creatures.\n\n### 2. **Creatures**\n- [Drakes of the Highwind Mountains](/drakes-of-the-highwind-mountains): A breed of winged dragons that control the skies above Arinthar.\n- [Wyrmbeasts](/wyrmbeasts): Massive, earth-shaking creatures said to dwell beneath the surface of the world.\n- [Faerie Folk](/faerie-folk): A magical race of beings who dwell in the fae realm, known for their trickery and beauty.\n- [Elder Spirits](/elder-spirits): Ghostly entities that have transcended death, existing in a state between the physical and ethereal planes.\n\n### 3. **Races**\n- [Aelirian Elves](/aelirian-elves): A race of immortal beings who have mastered magic and the arts.\n- [Dwarves of Karak-Dur](/dwarves-of-karak-dur): Stout and resilient, these warriors thrive in the mountains and are expert craftsmen.\n- [Hurokin](/hurokin): A nomadic race of shape-shifters, known for their agility and adaptability.\n- [Orcs of the Wastes](/orcs-of-the-wastes): Fierce warriors from the arid deserts, often misunderstood but fiercely loyal.\n- [The Shadar](/the-shadar): A mysterious race that exists in the shadows, unseen by most but ever-present in the world.\n\n### 4. **People**\n- [King Alaric of Eldrath](/king-alaric-of-eldrath): The wise and just ruler of Eldrath, known for his diplomatic skills and military prowess.\n- [Sethrin the Bold](/sethrin-the-bold): A legendary warrior who led the charge against the Great Horde during the War of the Broken Sky.\n- [Lady Sylara Moonshadow](/lady-sylara-moonshadow): A powerful sorceress whose magic is feared across the lands.\n- [Gorruk the Eternal](/gorruk-the-eternal): An immortal being believed to be older than Arinthar itself, rumored to control time itself.\n- [Prince Anselm of the Shattered Isles](/prince-anselm-of-the-shattered-isles): The last surviving royal of the Shattered Isles, with ambitions to restore his kingdom.\n\n### 5. **Events**\n- [The War of the Broken Sky](/the-war-of-the-broken-sky): A cataclysmic war that nearly tore the world apart.\n- [The Rise of the Blood Moon](/the-rise-of-the-blood-moon): A prophecy that foretells the coming of a dark age, heralded by the appearance of a blood-red moon.\n- [The Great Exodus](/the-great-exodus): The migration of several races from the sinking continent of Vaelgrun.\n- [The Fall of Valmara](/the-fall-of-valmara): The mysterious event that led to the downfall of an ancient city, leaving only ruins behind.\n\n### 6. **Magic**\n- [The Arcane Arts](/the-arcane-arts): The study and mastery of magical forces that govern the world.\n- [Rune Magic](/rune-magic): A powerful form of magic that taps into the ancient runes of Arinthar.\n- [Divination](/divination): The art of foreseeing future events through mystical means.\n- [Elemental Binding](/elemental-binding): The practice of controlling the elemental forces of fire, water, air, and earth.\n\n---\n\nExplore the rich tapestry of Arinthar, from its vast landscapes to the intriguing lives of its inhabitants. This wiki is your portal to a world full of adventure, mystery, and wonder.\n\n	<h1 class="toc-header" id="welcome-to-the-world-of-arinthar-wiki"><a href="#welcome-to-the-world-of-arinthar-wiki" class="toc-anchor">¶</a> Welcome to the World of Arinthar Wiki</h1>\n<p>Welcome to the official wiki of Arinthar, a rich and mysterious fantasy world full of powerful beings, ancient histories, and legendary events. This wiki serves as a comprehensive guide to all that exists within this magical realm, from the farthest reaches of the Highlands to the deepest caverns of the Underdark.</p>\n<h2 class="toc-header" id="table-of-contents"><a href="#table-of-contents" class="toc-anchor">¶</a> Table of Contents</h2>\n<h3 class="toc-header" id="h-1-places"><a href="#h-1-places" class="toc-anchor">¶</a> 1. <strong>Places</strong></h3>\n<ul>\n<li><a class="is-internal-link is-valid-page" href="/the-kingdom-of-eldrath">The Kingdom of Eldrath</a>: A sprawling kingdom known for its towering castles and skilled knights.</li>\n<li><a class="is-internal-link is-valid-page" href="/the-emerald-forest">The Emerald Forest</a>: A vast woodland home to elusive creatures and ancient trees.</li>\n<li><a class="is-internal-link is-valid-page" href="/shattered-isles">Shattered Isles</a>: A cluster of islands believed to be remnants of a once mighty empire.</li>\n<li><a class="is-internal-link is-valid-page" href="/ruins-of-valmara">Ruins of Valmara</a>: The lost city buried beneath shifting sands, said to be cursed.</li>\n<li><a class="is-internal-link is-valid-page" href="/tarnheim-peak">Tarnheim Peak</a>: A dangerous mountain inhabited by dragons and other flying creatures.</li>\n</ul>\n<h3 class="toc-header" id="h-2-creatures"><a href="#h-2-creatures" class="toc-anchor">¶</a> 2. <strong>Creatures</strong></h3>\n<ul>\n<li><a class="is-internal-link is-valid-page" href="/drakes-of-the-highwind-mountains">Drakes of the Highwind Mountains</a>: A breed of winged dragons that control the skies above Arinthar.</li>\n<li><a class="is-internal-link is-valid-page" href="/wyrmbeasts">Wyrmbeasts</a>: Massive, earth-shaking creatures said to dwell beneath the surface of the world.</li>\n<li><a class="is-internal-link is-valid-page" href="/faerie-folk">Faerie Folk</a>: A magical race of beings who dwell in the fae realm, known for their trickery and beauty.</li>\n<li><a class="is-internal-link is-valid-page" href="/elder-spirits">Elder Spirits</a>: Ghostly entities that have transcended death, existing in a state between the physical and ethereal planes.</li>\n</ul>\n<h3 class="toc-header" id="h-3-races"><a href="#h-3-races" class="toc-anchor">¶</a> 3. <strong>Races</strong></h3>\n<ul>\n<li><a class="is-internal-link is-valid-page" href="/aelirian-elves">Aelirian Elves</a>: A race of immortal beings who have mastered magic and the arts.</li>\n<li><a class="is-internal-link is-valid-page" href="/dwarves-of-karak-dur">Dwarves of Karak-Dur</a>: Stout and resilient, these warriors thrive in the mountains and are expert craftsmen.</li>\n<li><a class="is-internal-link is-valid-page" href="/hurokin">Hurokin</a>: A nomadic race of shape-shifters, known for their agility and adaptability.</li>\n<li><a class="is-internal-link is-valid-page" href="/orcs-of-the-wastes">Orcs of the Wastes</a>: Fierce warriors from the arid deserts, often misunderstood but fiercely loyal.</li>\n<li><a class="is-internal-link is-valid-page" href="/the-shadar">The Shadar</a>: A mysterious race that exists in the shadows, unseen by most but ever-present in the world.</li>\n</ul>\n<h3 class="toc-header" id="h-4-people"><a href="#h-4-people" class="toc-anchor">¶</a> 4. <strong>People</strong></h3>\n<ul>\n<li><a class="is-internal-link is-valid-page" href="/king-alaric-of-eldrath">King Alaric of Eldrath</a>: The wise and just ruler of Eldrath, known for his diplomatic skills and military prowess.</li>\n<li><a class="is-internal-link is-valid-page" href="/sethrin-the-bold">Sethrin the Bold</a>: A legendary warrior who led the charge against the Great Horde during the War of the Broken Sky.</li>\n<li><a class="is-internal-link is-valid-page" href="/lady-sylara-moonshadow">Lady Sylara Moonshadow</a>: A powerful sorceress whose magic is feared across the lands.</li>\n<li><a class="is-internal-link is-valid-page" href="/gorruk-the-eternal">Gorruk the Eternal</a>: An immortal being believed to be older than Arinthar itself, rumored to control time itself.</li>\n<li><a class="is-internal-link is-valid-page" href="/prince-anselm-of-the-shattered-isles">Prince Anselm of the Shattered Isles</a>: The last surviving royal of the Shattered Isles, with ambitions to restore his kingdom.</li>\n</ul>\n<h3 class="toc-header" id="h-5-events"><a href="#h-5-events" class="toc-anchor">¶</a> 5. <strong>Events</strong></h3>\n<ul>\n<li><a class="is-internal-link is-valid-page" href="/the-war-of-the-broken-sky">The War of the Broken Sky</a>: A cataclysmic war that nearly tore the world apart.</li>\n<li><a class="is-internal-link is-valid-page" href="/the-rise-of-the-blood-moon">The Rise of the Blood Moon</a>: A prophecy that foretells the coming of a dark age, heralded by the appearance of a blood-red moon.</li>\n<li><a class="is-internal-link is-valid-page" href="/the-great-exodus">The Great Exodus</a>: The migration of several races from the sinking continent of Vaelgrun.</li>\n<li><a class="is-internal-link is-valid-page" href="/the-fall-of-valmara">The Fall of Valmara</a>: The mysterious event that led to the downfall of an ancient city, leaving only ruins behind.</li>\n</ul>\n<h3 class="toc-header" id="h-6-magic"><a href="#h-6-magic" class="toc-anchor">¶</a> 6. <strong>Magic</strong></h3>\n<ul>\n<li><a class="is-internal-link is-valid-page" href="/the-arcane-arts">The Arcane Arts</a>: The study and mastery of magical forces that govern the world.</li>\n<li><a class="is-internal-link is-valid-page" href="/rune-magic">Rune Magic</a>: A powerful form of magic that taps into the ancient runes of Arinthar.</li>\n<li><a class="is-internal-link is-valid-page" href="/divination">Divination</a>: The art of foreseeing future events through mystical means.</li>\n<li><a class="is-internal-link is-valid-page" href="/elemental-binding">Elemental Binding</a>: The practice of controlling the elemental forces of fire, water, air, and earth.</li>\n</ul>\n<hr>\n<p>Explore the rich tapestry of Arinthar, from its vast landscapes to the intriguing lives of its inhabitants. This wiki is your portal to a world full of adventure, mystery, and wonder.</p>\n	[{"title":"Welcome to the World of Arinthar Wiki","anchor":"#welcome-to-the-world-of-arinthar-wiki","children":[{"title":"Table of Contents","anchor":"#table-of-contents","children":[{"title":"1. Places","anchor":"#h-1-places","children":[]},{"title":"2. Creatures","anchor":"#h-2-creatures","children":[]},{"title":"3. Races","anchor":"#h-3-races","children":[]},{"title":"4. People","anchor":"#h-4-people","children":[]},{"title":"5. Events","anchor":"#h-5-events","children":[]},{"title":"6. Magic","anchor":"#h-6-magic","children":[]}]}]}]	markdown	2025-03-11T03:16:16.464Z	2025-03-13T23:19:07.320Z	markdown	en	1	1	{"js":"","css":""}
2	the-kingdom-of-eldrath	b664e6b885ecfbc50f7aa598cdb7f5ac7d1b799a	The Kingdom of Eldrath	A sprawling kingdom known for its towering castles and skilled knights.	f	t	\N			## The Kingdom of Eldrath  \n\nThe **Kingdom of Eldrath** is one of the most powerful and enduring realms in the world of Arinthar. A land of towering castles, rolling green fields, and bustling cities, Eldrath stands as a beacon of civilization and order. It is a kingdom steeped in tradition, ruled by a long line of monarchs who have defended its borders from countless threats, both mortal and mystical.  \n\n### **Geography & Landscape**  \nEldrath is a vast kingdom with diverse landscapes, including:  \n- **The Capital City of Elarion** – A grand city built around the magnificent Ivory Keep, home to the royal family and center of governance.  \n- **The Golden Plains** – Fertile lands that provide the kingdom with abundant crops and serve as the heart of trade.  \n- **The Frostveil Highlands** – A rugged, snow-covered region in the north, inhabited by hardy mountain clans.  \n- **The Eldenwood Forest** – A vast and ancient woodland, rumored to be home to mystical creatures and hidden elven enclaves.  \n- **The Silver Coast** – A stretch of coastline with bustling port towns that engage in trade with distant lands.  \n\n### **Government & Leadership**  \nEldrath is ruled by the **House of Valdris**, a noble bloodline that has governed the kingdom for over five centuries. The current ruler, **King Alaric Valdris**, is a wise and just leader known for his diplomatic prowess and military strategy. The kingdom follows a **feudal system**, with noble houses overseeing different regions in service to the crown.  \n\n### **Culture & Society**  \nThe people of Eldrath value honor, chivalry, and craftsmanship. The kingdom has a rich tradition of knightly orders, such as:  \n- **The Knights of the Silver Hawk** – An elite order dedicated to protecting the royal family and the realm.  \n- **The Order of the Dawnblade** – A sect of holy warriors sworn to eradicate dark magic and demonic threats.  \n\nThe **Eldran Academy of Magic** is a prestigious institution where gifted individuals learn the arcane arts. While magic is respected in Eldrath, its practice is strictly regulated to prevent misuse.  \n\n### **Military & Defense**  \nEldrath boasts a formidable army, known as the **Eldran Legions**, composed of well-trained soldiers, cavalry, and siege engineers. The kingdom has repelled numerous invasions from rival empires, marauding orcs, and even supernatural threats. The **Wall of Aegis**, a massive fortified structure in the north, stands as a testament to Eldrath’s vigilance against external threats.  \n\n### **Notable Events in Eldrath’s History**  \n- **[The War of the Broken Sky](/the-war-of-the-broken-sky)** – A devastating conflict where Eldrath led an alliance against the Great Horde, securing peace for the continent.  \n- **The Mage Rebellion** – A dark chapter where rogue sorcerers sought to overthrow the monarchy, resulting in the banishment of unregulated magic.  \n- **The Coronation of [King Alaric](/king-alaric-of-eldrath)** – Marked by prophecy, his rise to the throne was seen as the beginning of a golden era for Eldrath.  \n\n### **Legends & Myths**  \nEldrath is rich with folklore, including tales of the **Eldran Blade**, a mythical sword said to be forged by celestial beings, and the **Lost Heir**, a hidden descendant of the royal bloodline prophesied to return in times of great peril.  \n\n### **Current State**  \nWhile Eldrath enjoys relative peace, tensions stir on the horizon. Dark forces move in the shadows, and old enemies plot their return. As King Alaric strengthens alliances and fortifies his armies, the fate of the kingdom remains uncertain. Will it stand against the coming storm, or will Eldrath’s golden age fade into legend?  \n\n	<h2 class="toc-header" id="the-kingdom-of-eldrath"><a href="#the-kingdom-of-eldrath" class="toc-anchor">¶</a> The Kingdom of Eldrath</h2>\n<p>The <strong>Kingdom of Eldrath</strong> is one of the most powerful and enduring realms in the world of Arinthar. A land of towering castles, rolling green fields, and bustling cities, Eldrath stands as a beacon of civilization and order. It is a kingdom steeped in tradition, ruled by a long line of monarchs who have defended its borders from countless threats, both mortal and mystical.</p>\n<h3 class="toc-header" id="geography-landscape"><a href="#geography-landscape" class="toc-anchor">¶</a> <strong>Geography &amp; Landscape</strong></h3>\n<p>Eldrath is a vast kingdom with diverse landscapes, including:</p>\n<ul>\n<li><strong>The Capital City of Elarion</strong> – A grand city built around the magnificent Ivory Keep, home to the royal family and center of governance.</li>\n<li><strong>The Golden Plains</strong> – Fertile lands that provide the kingdom with abundant crops and serve as the heart of trade.</li>\n<li><strong>The Frostveil Highlands</strong> – A rugged, snow-covered region in the north, inhabited by hardy mountain clans.</li>\n<li><strong>The Eldenwood Forest</strong> – A vast and ancient woodland, rumored to be home to mystical creatures and hidden elven enclaves.</li>\n<li><strong>The Silver Coast</strong> – A stretch of coastline with bustling port towns that engage in trade with distant lands.</li>\n</ul>\n<h3 class="toc-header" id="government-leadership"><a href="#government-leadership" class="toc-anchor">¶</a> <strong>Government &amp; Leadership</strong></h3>\n<p>Eldrath is ruled by the <strong>House of Valdris</strong>, a noble bloodline that has governed the kingdom for over five centuries. The current ruler, <strong>King Alaric Valdris</strong>, is a wise and just leader known for his diplomatic prowess and military strategy. The kingdom follows a <strong>feudal system</strong>, with noble houses overseeing different regions in service to the crown.</p>\n<h3 class="toc-header" id="culture-society"><a href="#culture-society" class="toc-anchor">¶</a> <strong>Culture &amp; Society</strong></h3>\n<p>The people of Eldrath value honor, chivalry, and craftsmanship. The kingdom has a rich tradition of knightly orders, such as:</p>\n<ul>\n<li><strong>The Knights of the Silver Hawk</strong> – An elite order dedicated to protecting the royal family and the realm.</li>\n<li><strong>The Order of the Dawnblade</strong> – A sect of holy warriors sworn to eradicate dark magic and demonic threats.</li>\n</ul>\n<p>The <strong>Eldran Academy of Magic</strong> is a prestigious institution where gifted individuals learn the arcane arts. While magic is respected in Eldrath, its practice is strictly regulated to prevent misuse.</p>\n<h3 class="toc-header" id="military-defense"><a href="#military-defense" class="toc-anchor">¶</a> <strong>Military &amp; Defense</strong></h3>\n<p>Eldrath boasts a formidable army, known as the <strong>Eldran Legions</strong>, composed of well-trained soldiers, cavalry, and siege engineers. The kingdom has repelled numerous invasions from rival empires, marauding orcs, and even supernatural threats. The <strong>Wall of Aegis</strong>, a massive fortified structure in the north, stands as a testament to Eldrath’s vigilance against external threats.</p>\n<h3 class="toc-header" id="notable-events-in-eldraths-history"><a href="#notable-events-in-eldraths-history" class="toc-anchor">¶</a> <strong>Notable Events in Eldrath’s History</strong></h3>\n<ul>\n<li><strong><a class="is-internal-link is-valid-page" href="/the-war-of-the-broken-sky">The War of the Broken Sky</a></strong> – A devastating conflict where Eldrath led an alliance against the Great Horde, securing peace for the continent.</li>\n<li><strong>The Mage Rebellion</strong> – A dark chapter where rogue sorcerers sought to overthrow the monarchy, resulting in the banishment of unregulated magic.</li>\n<li><strong>The Coronation of <a class="is-internal-link is-valid-page" href="/king-alaric-of-eldrath">King Alaric</a></strong> – Marked by prophecy, his rise to the throne was seen as the beginning of a golden era for Eldrath.</li>\n</ul>\n<h3 class="toc-header" id="legends-myths"><a href="#legends-myths" class="toc-anchor">¶</a> <strong>Legends &amp; Myths</strong></h3>\n<p>Eldrath is rich with folklore, including tales of the <strong>Eldran Blade</strong>, a mythical sword said to be forged by celestial beings, and the <strong>Lost Heir</strong>, a hidden descendant of the royal bloodline prophesied to return in times of great peril.</p>\n<h3 class="toc-header" id="current-state"><a href="#current-state" class="toc-anchor">¶</a> <strong>Current State</strong></h3>\n<p>While Eldrath enjoys relative peace, tensions stir on the horizon. Dark forces move in the shadows, and old enemies plot their return. As King Alaric strengthens alliances and fortifies his armies, the fate of the kingdom remains uncertain. Will it stand against the coming storm, or will Eldrath’s golden age fade into legend?</p>\n	[{"title":"The Kingdom of Eldrath","anchor":"#the-kingdom-of-eldrath","children":[{"title":"Geography & Landscape","anchor":"#geography-landscape","children":[]},{"title":"Government & Leadership","anchor":"#government-leadership","children":[]},{"title":"Culture & Society","anchor":"#culture-society","children":[]},{"title":"Military & Defense","anchor":"#military-defense","children":[]},{"title":"Notable Events in Eldrath’s History","anchor":"#notable-events-in-eldraths-history","children":[]},{"title":"Legends & Myths","anchor":"#legends-myths","children":[]},{"title":"Current State","anchor":"#current-state","children":[]}]}]	markdown	2025-03-11T03:19:20.780Z	2025-03-13T23:34:32.284Z	markdown	en	1	1	{"js":"","css":""}
13	tarnheim-peak	7287396839641f637aff74a6aec973647e74c39a	Tarnheim Peak	A dangerous mountain inhabited by dragons and other flying creatures.	f	t	\N			A dangerous mountain inhabited by dragons and other flying creatures.\n\n[hurokin](/hurokin)\n\n[sethrin-the-bold](/sethrin-the-bold)\n\n[drakes-of-the-highwind-mountains](/drakes-of-the-highwind-mountains)\n\n[dwarves-of-karak-dur](/dwarves-of-karak-dur)	<p>A dangerous mountain inhabited by dragons and other flying creatures.</p>\n<p><a class="is-internal-link is-valid-page" href="/hurokin">hurokin</a></p>\n<p><a class="is-internal-link is-valid-page" href="/sethrin-the-bold">sethrin-the-bold</a></p>\n<p><a class="is-internal-link is-valid-page" href="/drakes-of-the-highwind-mountains">drakes-of-the-highwind-mountains</a></p>\n<p><a class="is-internal-link is-valid-page" href="/dwarves-of-karak-dur">dwarves-of-karak-dur</a></p>\n	[]	markdown	2025-03-13T21:54:36.827Z	2025-03-13T23:52:10.703Z	markdown	en	1	1	{"js":"","css":""}
\.


--
-- Data for Name: renderers; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.renderers (key, "isEnabled", config) FROM stdin;
asciidocCore	t	{"safeMode":"server"}
htmlAsciinema	f	{}
htmlBlockquotes	t	{}
htmlCodehighlighter	t	{}
htmlCore	t	{"absoluteLinks":false,"openExternalLinkNewTab":false,"relAttributeExternalLink":"noreferrer"}
htmlDiagram	t	{}
htmlImagePrefetch	f	{}
htmlMediaplayers	t	{}
htmlMermaid	t	{}
htmlSecurity	t	{"safeHTML":true,"allowDrawIoUnsafe":true,"allowIFrames":false}
htmlTabset	t	{}
htmlTwemoji	t	{}
markdownAbbr	t	{}
markdownCore	t	{"allowHTML":true,"linkify":true,"linebreaks":true,"underline":false,"typographer":false,"quotes":"English"}
markdownEmoji	t	{}
markdownExpandtabs	t	{"tabWidth":4}
markdownFootnotes	t	{}
markdownImsize	t	{}
markdownKatex	t	{"useInline":true,"useBlocks":true}
markdownKroki	f	{"server":"https://kroki.io","openMarker":"```kroki","closeMarker":"```"}
markdownMathjax	f	{"useInline":true,"useBlocks":true}
markdownMultiTable	f	{"multilineEnabled":true,"headerlessEnabled":true,"rowspanEnabled":true}
markdownPivotTable	f	{}
markdownPlantuml	t	{"server":"https://plantuml.requarks.io","openMarker":"```plantuml","closeMarker":"```","imageFormat":"svg"}
markdownSupsub	t	{"subEnabled":true,"supEnabled":true}
markdownTasklists	t	{}
openapiCore	t	{}
\.


--
-- Data for Name: searchEngines; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."searchEngines" (key, "isEnabled", config) FROM stdin;
algolia	f	{"appId":"","apiKey":"","indexName":"wiki"}
aws	f	{"domain":"","endpoint":"","region":"us-east-1","accessKeyId":"","secretAccessKey":"","AnalysisSchemeLang":"en"}
azure	f	{"serviceName":"","adminKey":"","indexName":"wiki"}
db	t	{}
elasticsearch	f	{"apiVersion":"7.x","hosts":"","verifyTLSCertificate":true,"tlsCertPath":"","indexName":"wiki","analyzer":"simple","sniffOnStart":false,"sniffInterval":0}
manticore	f	{}
postgres	f	{"dictLanguage":"english"}
solr	f	{"host":"solr","port":8983,"core":"wiki","protocol":"http"}
sphinx	f	{}
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.sessions (sid, sess, expired) FROM stdin;
\.


--
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.settings (key, value, "updatedAt") FROM stdin;
auth	{"audience":"urn:wiki.js","tokenExpiration":"30m","tokenRenewal":"14d"}	2025-03-11T03:11:18.189Z
certs	{"jwk":{"kty":"RSA","n":"q1cm19xntq_zqpt83RNUcisSyWGhuLs4doKxWoHpAV8GH3YKY_18bzXoIIE_-R-5V8QNDP7ZUSAr_FpkuJEx1Ya599VLHSq5ClRJWfL7V0y_389uFdupo05Gm7YA61jfnMsSp_gZNV3nVsDjakQtGYYBt6Uo74ZfO9R8qYCm2wNERkTCmlA5QTMCDw23gPYwaOOxPM0KlXoiswtkBaa9nStGTL3QJ6cgoZ3U--8PLw5AtHc6bW2uy_Y6L7P3hRj9US5fg0jXlkC1lla0jyDNP2HVMha6vGfi036pAxZ1t7CYYb4H8uXJDHlEKkMLiabaF49Etoy9cbGxDtXDAp-ePw","e":"AQAB"},"public":"-----BEGIN RSA PUBLIC KEY-----\\nMIIBCgKCAQEAq1cm19xntq/zqpt83RNUcisSyWGhuLs4doKxWoHpAV8GH3YKY/18\\nbzXoIIE/+R+5V8QNDP7ZUSAr/FpkuJEx1Ya599VLHSq5ClRJWfL7V0y/389uFdup\\no05Gm7YA61jfnMsSp/gZNV3nVsDjakQtGYYBt6Uo74ZfO9R8qYCm2wNERkTCmlA5\\nQTMCDw23gPYwaOOxPM0KlXoiswtkBaa9nStGTL3QJ6cgoZ3U++8PLw5AtHc6bW2u\\ny/Y6L7P3hRj9US5fg0jXlkC1lla0jyDNP2HVMha6vGfi036pAxZ1t7CYYb4H8uXJ\\nDHlEKkMLiabaF49Etoy9cbGxDtXDAp+ePwIDAQAB\\n-----END RSA PUBLIC KEY-----\\n","private":"-----BEGIN RSA PRIVATE KEY-----\\nProc-Type: 4,ENCRYPTED\\nDEK-Info: AES-256-CBC,5856CD932F1804DCC146C400E032003F\\n\\nALAbng2GEvLpHMdPDz/j/DmS2I8tGfu22yHaaVnsZ/Uba3TTITO+S+209wNa9UKx\\nwsC49f9XVq39nU5ZyVjZPwURuSBKP2qLjkmx/Cr5w8VWPLtcHsRDFMnUgbA5tjzi\\naUa/cIR3bbm4Y+ocWlfUlEL8+nrdbeRX8BgpxZGkpqSldevmPVIdxH5ca4+VnSI9\\n14V4BmDxOJTOz40H87p2VIPqlVJBDN+Wb67LUZ2Fe02KWD/UXcTq5dlxNvAQf0Hv\\nYZDFOkwjchL98OBK157EfJLAv2xA5GbGDchmAB2Aew/0+/lnnvjuyA/pfLfHg/oq\\nI+M+yEGc5Im4oX4mIcyv3GgLUDuZ6yCEtEX5p3wvqak7G7VU8buN6/7HrZf+KQWn\\nywIMERYlr+fnTqzxRagRMWzGF7Qva9/RvENBJ9p9RCNcn9wkgbJHkybdjCmh98nX\\n4aXXJbMrVvV5DJaFHR0FTsNE5v/VFJvluElpQI6bxjpe8lIAF9oB2nF+jmTb20bM\\nZj9b5HjHiWCAQ1MWDMz7bYYEmJrb0e/GyyIEzsS8oTLjZ3Mi+VzcwkvoZMeQnWsy\\nqgf1NPSXk3Ye/80DQRE4pkhluwB0FeuxsWeuHVycFUGVEE7dZRzpn1psHR8pFwJf\\nW0qKmZmC+wX7LXmgg5+XLLHK6cY6m5qusBxYWA5y45q5OzHdIGNzWLyxR8jHTpjf\\nLCRyFWAUm+s4iyF026jHVKFnUsBViZwiHsDq1/ZsymN985V1eeu49z5bYZrPEKsm\\nS5f5jBNHcu1F3oQ1jpRqH4qsRZtplwjtcDoceobeVvdCFPBwHejpG7qKq+yPD/hI\\n92nY0PgzUAyxv/FLjrw/qUUXrKDIazV3ujjhPTNbcyUTe5tT7+ym/KSekDn9CA2V\\nwX4WIn+wSYFjSPkwKayyMNG5eOkJPQmbr2SCTZzFM+OlXH5ZQU7CREa+PSeOXOrx\\nRRVNsEGzL7GKFq4yTGAnDCPUlk5OWgjwiSFLhGrlQidlivf0+7FH4JEc5mZJ8aCC\\nAdFz35flScJX3EUM8R6ydJw41U0+xX+MRfSEFv1Tvxohwgq4lSw2EgTyyeRQpG7I\\nRuTnfD+Kst/ckFqZrYG/8jXG/KQ8ZnA25JYyLbS5KCCoaEiIacdDgtrBrG8iJBtv\\nCtIRavP4gGFV+CJt2oGo66p8Ju9fb4nW0SwOTElLl+U4Vrc/VLpFydMhCvImjIce\\n+RjXTbWgxQGHVqXpP4DPEKyknawyd62bIEJT9anxEjyW47rBBusQXuFBFJzZ4ZBT\\nUIvbJHPeTG3t0DsXi62i81lIyJxVcTx1JYpvA+6B7BHxiaF7eX7gTVZZGOD5JjVg\\n+NV6nJSP8y9fFY5xZ1CTB1U1BE/8rHKgFOlHET8NYt8bO4Sez4noPFxEkc/1MJB+\\n9w4Z9TpayFJJhO9/TjXNW8P8h/OU+JP+ERj9k7RXsfFE7ZGP3B0dfNDMAnp32f7D\\nsz0QqtjBcyexdY+fSlMvN0ctbEf4J26Kj3vyt4GszlaC4n7B3NJWs+MPKrgZr55a\\nzRz7uBlZmrFKX5UHZ9K9QOuzQeSJgBFdTpFJ7iSL4xyk0YzPVTUPHTpWBhdbe2Gv\\n-----END RSA PRIVATE KEY-----\\n"}	2025-03-11T03:11:18.194Z
company	{"v":""}	2025-03-11T03:11:18.198Z
features	{"featurePageRatings":true,"featurePageComments":true,"featurePersonalWikis":true}	2025-03-11T03:11:18.201Z
graphEndpoint	{"v":"https://graph.requarks.io"}	2025-03-11T03:11:18.205Z
host	{"v":"http://localhost"}	2025-03-11T03:11:18.207Z
lang	{"code":"en","autoUpdate":true,"namespacing":false,"namespaces":[]}	2025-03-11T03:11:18.210Z
logo	{"hasLogo":false,"logoIsSquare":false}	2025-03-11T03:11:18.212Z
mail	{"senderName":"","senderEmail":"","host":"","port":465,"name":"","secure":true,"verifySSL":true,"user":"","pass":"","useDKIM":false,"dkimDomainName":"","dkimKeySelector":"","dkimPrivateKey":""}	2025-03-11T03:11:18.216Z
seo	{"description":"","robots":["index","follow"],"analyticsService":"","analyticsId":""}	2025-03-11T03:11:18.218Z
sessionSecret	{"v":"aad10a324f4f4e6304ae3e9b4ec8151d074f757a3a862a0f9f800c0748460305"}	2025-03-11T03:11:18.221Z
telemetry	{"isEnabled":false,"clientId":"5a99d078-1a03-41d8-b3bb-184efbe2664a"}	2025-03-11T03:11:18.223Z
theming	{"theme":"default","darkMode":false,"iconset":"mdi","injectCSS":"","injectHead":"","injectBody":""}	2025-03-11T03:11:18.225Z
uploads	{"maxFileSize":5242880,"maxFiles":10,"scanSVG":true,"forceDownload":true}	2025-03-11T03:11:18.228Z
title	{"v":"Wiki.js"}	2025-03-11T03:11:18.230Z
\.


--
-- Data for Name: storage; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.storage (key, "isEnabled", mode, config, "syncInterval", state) FROM stdin;
sftp	f	push	{"host":"","port":22,"authMode":"privateKey","username":"","privateKey":"","passphrase":"","password":"","basePath":"/root/wiki"}	P0D	{"status":"pending","message":"","lastAttempt":null}
azure	f	push	{"accountName":"","accountKey":"","containerName":"wiki","storageTier":"Cool"}	P0D	{"status":"pending","message":"","lastAttempt":null}
box	f	push	{"clientId":"","clientSecret":"","rootFolder":""}	P0D	{"status":"pending","message":"","lastAttempt":null}
digitalocean	f	push	{"endpoint":"nyc3.digitaloceanspaces.com","bucket":"","accessKeyId":"","secretAccessKey":""}	P0D	{"status":"pending","message":"","lastAttempt":null}
disk	f	push	{"path":"","createDailyBackups":false}	P0D	{"status":"pending","message":"","lastAttempt":null}
dropbox	f	push	{"appKey":"","appSecret":""}	P0D	{"status":"pending","message":"","lastAttempt":null}
gdrive	f	push	{"clientId":"","clientSecret":""}	P0D	{"status":"pending","message":"","lastAttempt":null}
git	f	sync	{"authType":"ssh","repoUrl":"","branch":"master","sshPrivateKeyMode":"path","sshPrivateKeyPath":"","sshPrivateKeyContent":"","verifySSL":true,"basicUsername":"","basicPassword":"","defaultEmail":"name@company.com","defaultName":"John Smith","localRepoPath":"./data/repo","alwaysNamespace":false,"gitBinaryPath":""}	PT5M	{"status":"pending","message":"","lastAttempt":null}
onedrive	f	push	{"clientId":"","clientSecret":""}	P0D	{"status":"pending","message":"","lastAttempt":null}
s3	f	push	{"region":"","bucket":"","accessKeyId":"","secretAccessKey":""}	P0D	{"status":"pending","message":"","lastAttempt":null}
s3generic	f	push	{"endpoint":"https://service.region.example.com","bucket":"","accessKeyId":"","secretAccessKey":"","sslEnabled":true,"s3ForcePathStyle":false,"s3BucketEndpoint":false}	P0D	{"status":"pending","message":"","lastAttempt":null}
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.tags (id, tag, title, "createdAt", "updatedAt") FROM stdin;
1	magic	magic	2025-03-13T22:44:59.531Z	2025-03-13T22:44:59.531Z
2	place	place	2025-03-13T22:49:23.133Z	2025-03-13T22:49:23.133Z
3	creature	creature	2025-03-13T23:13:06.023Z	2025-03-13T23:13:06.023Z
4	character	character	2025-03-13T23:14:29.397Z	2025-03-13T23:14:29.397Z
5	race	race	2025-03-13T23:16:15.598Z	2025-03-13T23:16:15.598Z
6	history	history	2025-03-13T23:21:32.982Z	2025-03-13T23:21:32.982Z
7	eldrath	eldrath	2025-03-13T23:28:39.332Z	2025-03-13T23:28:39.332Z
\.


--
-- Data for Name: userAvatars; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."userAvatars" (id, data) FROM stdin;
\.


--
-- Data for Name: userGroups; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."userGroups" (id, "userId", "groupId") FROM stdin;
1	1	1
2	2	2
\.


--
-- Data for Name: userKeys; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."userKeys" (id, kind, token, "createdAt", "validUntil", "userId") FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.users (id, email, name, "providerId", password, "tfaIsActive", "tfaSecret", "jobTitle", location, "pictureUrl", timezone, "isSystem", "isActive", "isVerified", "mustChangePwd", "createdAt", "updatedAt", "providerKey", "localeCode", "defaultEditor", "lastLoginAt", "dateFormat", appearance) FROM stdin;
2	guest@example.com	Guest	\N		f	\N			\N	America/New_York	t	t	t	f	2025-03-11T03:11:18.767Z	2025-03-11T03:11:18.767Z	local	en	markdown	\N		
1	motorcycle_mania@gmail.com	Administrator	\N	$2a$12$/MzB7Hb0uvzznkIMdXVoPOA5bXcDTmGiiEX1DYmoX/mI83.pFNFrq	f	\N			\N	America/New_York	f	t	t	f	2025-03-11T03:11:18.486Z	2025-03-11T03:11:18.486Z	local	en	markdown	2025-03-13T23:41:24.472Z		
\.


--
-- Name: apiKeys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."apiKeys_id_seq"', 1, false);


--
-- Name: assetFolders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."assetFolders_id_seq"', 1, false);


--
-- Name: assets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.assets_id_seq', 1, false);


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.comments_id_seq', 1, true);


--
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.groups_id_seq', 2, true);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.migrations_id_seq', 16, true);


--
-- Name: migrations_lock_index_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.migrations_lock_index_seq', 1, true);


--
-- Name: pageHistoryTags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."pageHistoryTags_id_seq"', 1, false);


--
-- Name: pageHistory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."pageHistory_id_seq"', 45, true);


--
-- Name: pageLinks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."pageLinks_id_seq"', 40, true);


--
-- Name: pageTags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."pageTags_id_seq"', 26, true);


--
-- Name: pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.pages_id_seq', 28, true);


--
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.tags_id_seq', 7, true);


--
-- Name: userGroups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."userGroups_id_seq"', 2, true);


--
-- Name: userKeys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."userKeys_id_seq"', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- Name: analytics analytics_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.analytics
    ADD CONSTRAINT analytics_pkey PRIMARY KEY (key);


--
-- Name: apiKeys apiKeys_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."apiKeys"
    ADD CONSTRAINT "apiKeys_pkey" PRIMARY KEY (id);


--
-- Name: assetData assetData_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."assetData"
    ADD CONSTRAINT "assetData_pkey" PRIMARY KEY (id);


--
-- Name: assetFolders assetFolders_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."assetFolders"
    ADD CONSTRAINT "assetFolders_pkey" PRIMARY KEY (id);


--
-- Name: assets assets_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_pkey PRIMARY KEY (id);


--
-- Name: authentication authentication_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.authentication
    ADD CONSTRAINT authentication_pkey PRIMARY KEY (key);


--
-- Name: commentProviders commentProviders_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."commentProviders"
    ADD CONSTRAINT "commentProviders_pkey" PRIMARY KEY (key);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: editors editors_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.editors
    ADD CONSTRAINT editors_pkey PRIMARY KEY (key);


--
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- Name: locales locales_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.locales
    ADD CONSTRAINT locales_pkey PRIMARY KEY (code);


--
-- Name: loggers loggers_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.loggers
    ADD CONSTRAINT loggers_pkey PRIMARY KEY (key);


--
-- Name: migrations_lock migrations_lock_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.migrations_lock
    ADD CONSTRAINT migrations_lock_pkey PRIMARY KEY (index);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: navigation navigation_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.navigation
    ADD CONSTRAINT navigation_pkey PRIMARY KEY (key);


--
-- Name: pageHistoryTags pageHistoryTags_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistoryTags"
    ADD CONSTRAINT "pageHistoryTags_pkey" PRIMARY KEY (id);


--
-- Name: pageHistory pageHistory_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistory"
    ADD CONSTRAINT "pageHistory_pkey" PRIMARY KEY (id);


--
-- Name: pageLinks pageLinks_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageLinks"
    ADD CONSTRAINT "pageLinks_pkey" PRIMARY KEY (id);


--
-- Name: pageTags pageTags_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTags"
    ADD CONSTRAINT "pageTags_pkey" PRIMARY KEY (id);


--
-- Name: pageTree pageTree_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTree"
    ADD CONSTRAINT "pageTree_pkey" PRIMARY KEY (id);


--
-- Name: pages pages_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: renderers renderers_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.renderers
    ADD CONSTRAINT renderers_pkey PRIMARY KEY (key);


--
-- Name: searchEngines searchEngines_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."searchEngines"
    ADD CONSTRAINT "searchEngines_pkey" PRIMARY KEY (key);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (sid);


--
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (key);


--
-- Name: storage storage_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.storage
    ADD CONSTRAINT storage_pkey PRIMARY KEY (key);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: tags tags_tag_unique; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_tag_unique UNIQUE (tag);


--
-- Name: userAvatars userAvatars_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userAvatars"
    ADD CONSTRAINT "userAvatars_pkey" PRIMARY KEY (id);


--
-- Name: userGroups userGroups_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userGroups"
    ADD CONSTRAINT "userGroups_pkey" PRIMARY KEY (id);


--
-- Name: userKeys userKeys_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userKeys"
    ADD CONSTRAINT "userKeys_pkey" PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_providerkey_email_unique; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_providerkey_email_unique UNIQUE ("providerKey", email);


--
-- Name: pagelinks_path_localecode_index; Type: INDEX; Schema: public; Owner: wikijs
--

CREATE INDEX pagelinks_path_localecode_index ON public."pageLinks" USING btree (path, "localeCode");


--
-- Name: sessions_expired_index; Type: INDEX; Schema: public; Owner: wikijs
--

CREATE INDEX sessions_expired_index ON public.sessions USING btree (expired);


--
-- Name: assetFolders assetfolders_parentid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."assetFolders"
    ADD CONSTRAINT assetfolders_parentid_foreign FOREIGN KEY ("parentId") REFERENCES public."assetFolders"(id);


--
-- Name: assets assets_authorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_authorid_foreign FOREIGN KEY ("authorId") REFERENCES public.users(id);


--
-- Name: assets assets_folderid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_folderid_foreign FOREIGN KEY ("folderId") REFERENCES public."assetFolders"(id);


--
-- Name: comments comments_authorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_authorid_foreign FOREIGN KEY ("authorId") REFERENCES public.users(id);


--
-- Name: comments comments_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public.pages(id);


--
-- Name: pageHistory pagehistory_authorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistory"
    ADD CONSTRAINT pagehistory_authorid_foreign FOREIGN KEY ("authorId") REFERENCES public.users(id);


--
-- Name: pageHistory pagehistory_editorkey_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistory"
    ADD CONSTRAINT pagehistory_editorkey_foreign FOREIGN KEY ("editorKey") REFERENCES public.editors(key);


--
-- Name: pageHistory pagehistory_localecode_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistory"
    ADD CONSTRAINT pagehistory_localecode_foreign FOREIGN KEY ("localeCode") REFERENCES public.locales(code);


--
-- Name: pageHistoryTags pagehistorytags_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistoryTags"
    ADD CONSTRAINT pagehistorytags_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public."pageHistory"(id) ON DELETE CASCADE;


--
-- Name: pageHistoryTags pagehistorytags_tagid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistoryTags"
    ADD CONSTRAINT pagehistorytags_tagid_foreign FOREIGN KEY ("tagId") REFERENCES public.tags(id) ON DELETE CASCADE;


--
-- Name: pageLinks pagelinks_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageLinks"
    ADD CONSTRAINT pagelinks_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public.pages(id) ON DELETE CASCADE;


--
-- Name: pages pages_authorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_authorid_foreign FOREIGN KEY ("authorId") REFERENCES public.users(id);


--
-- Name: pages pages_creatorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_creatorid_foreign FOREIGN KEY ("creatorId") REFERENCES public.users(id);


--
-- Name: pages pages_editorkey_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_editorkey_foreign FOREIGN KEY ("editorKey") REFERENCES public.editors(key);


--
-- Name: pages pages_localecode_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_localecode_foreign FOREIGN KEY ("localeCode") REFERENCES public.locales(code);


--
-- Name: pageTags pagetags_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTags"
    ADD CONSTRAINT pagetags_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public.pages(id) ON DELETE CASCADE;


--
-- Name: pageTags pagetags_tagid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTags"
    ADD CONSTRAINT pagetags_tagid_foreign FOREIGN KEY ("tagId") REFERENCES public.tags(id) ON DELETE CASCADE;


--
-- Name: pageTree pagetree_localecode_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTree"
    ADD CONSTRAINT pagetree_localecode_foreign FOREIGN KEY ("localeCode") REFERENCES public.locales(code);


--
-- Name: pageTree pagetree_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTree"
    ADD CONSTRAINT pagetree_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public.pages(id) ON DELETE CASCADE;


--
-- Name: pageTree pagetree_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTree"
    ADD CONSTRAINT pagetree_parent_foreign FOREIGN KEY (parent) REFERENCES public."pageTree"(id) ON DELETE CASCADE;


--
-- Name: userGroups usergroups_groupid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userGroups"
    ADD CONSTRAINT usergroups_groupid_foreign FOREIGN KEY ("groupId") REFERENCES public.groups(id) ON DELETE CASCADE;


--
-- Name: userGroups usergroups_userid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userGroups"
    ADD CONSTRAINT usergroups_userid_foreign FOREIGN KEY ("userId") REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: userKeys userkeys_userid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userKeys"
    ADD CONSTRAINT userkeys_userid_foreign FOREIGN KEY ("userId") REFERENCES public.users(id);


--
-- Name: users users_defaulteditor_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_defaulteditor_foreign FOREIGN KEY ("defaultEditor") REFERENCES public.editors(key);


--
-- Name: users users_localecode_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_localecode_foreign FOREIGN KEY ("localeCode") REFERENCES public.locales(code);


--
-- Name: users users_providerkey_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_providerkey_foreign FOREIGN KEY ("providerKey") REFERENCES public.authentication(key);


--
-- PostgreSQL database dump complete
--

