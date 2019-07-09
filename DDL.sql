CREATE TABLE public.gnome_inventory
(
    gnomeid character varying(20) NOT NULL,
    gnometype character varying(45),
    gnomeprice numeric(11,2) DEFAULT NULL::numeric,
    gnometotal integer,
    gnomeavailable integer,
    CONSTRAINT gnome_inventory_pkey PRIMARY KEY (gnomeid)
);

CREATE TABLE public.user_info
(
    username character varying(20) NOT NULL,
    userpassword character varying(45),
    permitstatus character varying(45),
    onlinestatus character varying(45),
    userrole character varying(45),
    CONSTRAINT user_info_pkey PRIMARY KEY (username)
);

CREATE TABLE public.orders
(
    orderid character varying(20) NOT NULL,
    amount_to_buy integer,
    customerid character varying(20),
    gnomeid character varying(20),
    CONSTRAINT orders_pkey PRIMARY KEY (orderid),
    CONSTRAINT "F_KEY_GNOME" FOREIGN KEY (gnomeid)
        REFERENCES public.gnome_inventory (gnomeid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "F_KEY_USER" FOREIGN KEY (customerid)
        REFERENCES public.user_info (username) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE INDEX "fki_F_KEY_GNOME"
    ON public.orders USING btree
    (gnomeid COLLATE pg_catalog."default")
    TABLESPACE pg_default;

CREATE INDEX "fki_F_KEY_USER"
    ON public.orders USING btree
    (customerid COLLATE pg_catalog."default")
    TABLESPACE pg_default;