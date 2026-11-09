#--- ZADANIE 1 ---
#create table pracownik(id_pracownika int primary key auto_increment, imie varchar(40) not null, nazwisko varchar(60) not null, data_urodzenia date not null)

#insert into pracownik values(1, "Bartosz", "Psikuta", "2002-03-03"); 
#insert into pracownik values(2, "Radoslaw", "Kokosz", "2004-02-07"); 
#insert into pracownik values(3, "Jedrek", "Lalak", "2005-01-04");
#insert into pracownik values(4, "Filip", "Psikuta", "2000-03-03"); 

#delete from pracownik where id_pracownika = 4;

#update pracownik set data_urodzenia = "2006-01-04" where id_pracownika = 3;
#select * from pracownik;

#--- ZADANIE 2 ---
create table zadanie(id_zadania int primary key auto_increment,
nazwa_zadania varchar(150) not null,
priorytet enum("normalny","wysoki","niski"),
opis text,
pracownik int,
foreign key(pracownik) references pracownik(id_pracownika));

alter table zadanie alter column priorytet set default "normalny";

insert into zadanie values(1, "Sprzatanie kibla", "wysoki", "Brudny kibel - trzeba sprzatnac", 1);
insert into zadanie values(2, "Sprzatanie kibla", "normalny", "Brudny kibel - trzeba sprzatnac", 2);
insert into zadanie values(3, "Sprzatanie kibla", "niski", "Brudny kibel - trzeba sprzatnac", 3);

select * from zadanie;


#--- ZADANIE 3 ---
create table projekt(id_projektu int primary key auto_increment,
nazwa_projektu varchar(150),
data_rozpoczecia date,
data_zakonczenia date null);

alter table projekt add menadzer_projektu int,
add constraint menadzer_projektu
foreign key(menadzer_projektu) references pracownik(id_pracownika);

insert into projekt values(1, "Czysty_kibelek","2026.11.07", null, 1);
insert into projekt values(2, "Czysty_kibelek2","2026.10.07", null, 3);
insert into projekt values(3, "Czysty_kibelek3","2023.11.07", "2024.12.13", 2);

alter table zadanie add projekt int,
add constraint projekt
foreign key(projekt) references projekt(id_projektu)
on delete cascade;

update zadanie set projekt = 1 where id_zadania = 1;
update zadanie set projekt = 2 where id_zadania = 3;
update zadanie set projekt = 3 where id_zadania = 2;

select * from projekt;


#--- ZADANIE 4 ---
create table sprint(id_sprintu int primary key auto_increment, numer_sprintu int unsigned, data_rozpoczecia date, data_zakonczenia date);

alter table zadanie add sprint int null,
add constraint sprint
foreign key (sprint) references sprint(id_sprintu)
on delete set null;

insert into sprint values (1, 1, "2026-11.09", "2026-11-11");
update zadanie set sprint = 1 where id_zadania = 1;
update zadanie set sprint = 1 where id_zadania = 2;
update zadanie set sprint = 1 where id_zadania = 3;

select * from sprint;

#--- ZADANIE 5 ---
create table status(id_statusu int primary key auto_increment, nazwa_statusu varchar(20));

insert into status values(1,"Nierozpoczete");
insert into status values(2,"W trakcie");
insert into status values(3,"Zakonczone");

select * from status;

create table zadanie_has_status(id_zdarzenia int primary key auto_increment,
id_zadania int, foreign key(id_zadania) references zadanie(id_zadania),
id_statusu int, foreign key(id_statusu) references status(id_statusu),
data_zdarzenia timestamp default current_timestamp);

insert into zadanie_has_status values(1,1,1,now());
insert into zadanie_has_status values(2,2,2,now());
insert into zadanie_has_status values(3,3,3,now());

delete from projekt where id_projektu = 3;

drop table sprint;

select * from zadanie_has_status;