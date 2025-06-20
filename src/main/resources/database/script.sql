create table users
(
    userId   varchar(100) not null
        primary key,
    userName varchar(100) not null,
    email    varchar(100) not null,
    password varchar(200) not null
);

create table complains
(
    complain_id      varchar(50)  not null
        primary key,
    userId           varchar(50)  null,
    subject          varchar(500) not null,
    category         varchar(100) not null,
    description      varchar(500) not null,
    Date             date         not null,
    last_update_date date         null,
    comment          varchar(500) null,
    imagePath        varchar(100) null,
    status           varchar(100) null,
    reviewed_by      varchar(50)  null,
    constraint complains_users_userId_fk
        foreign key (userId) references users (userId)
);


