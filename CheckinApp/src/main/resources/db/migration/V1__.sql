CREATE TABLE public."user"
(
    id        BIGINT NOT NULL,
    user_name VARCHAR(255),
    password  VARCHAR(255),
    CONSTRAINT pk_user PRIMARY KEY (id)
);

CREATE TABLE public.user_history
(
    id        BIGINT NOT NULL,
    user_name VARCHAR(255),
    time      VARCHAR(255),
    location  VARCHAR(255),
    weather   VARCHAR(255),
    CONSTRAINT pk_user_history PRIMARY KEY (id)
);

ALTER TABLE public."user"
    ADD CONSTRAINT uc_user_user_name UNIQUE (user_name);
