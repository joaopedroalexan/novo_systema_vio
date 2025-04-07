delimiter $$ 
create function calcula_idade(datanascimento date)
returns int 
deterministic
no sql 
begin
    declare idade int;
    set idade = timestampdiff(year, datanascimento, curdate());
    return idade;
end; $$
delimiter ;

-- funcional

DELIMITER $$ 
CREATE FUNCTION calcula_idade(datanascimento DATE)
RETURNS INT 
DETERMINISTIC
CONTAINS SQL
BEGIN
    DECLARE idade INT;
    SET idade = TIMESTAMPDIFF(YEAR, datanascimento, CURDATE());
    RETURN idade;
END $$ 
DELIMITER ;

show create function calcula_idade;

select name, calcula_idade(data_nascimento) as idade from usuario;

select name, calcula_idade(data_nascimento) from usuario;

delimiter $$
create function status_sistema()
returns varchar(50)
no sql
begin
return 'sistema operando normalmente';
end; $$
delimiter

select status_sistema();

delimiter $$
create function total_compras_usuario(id_usuario int)
returns int 
reads sql data
begin
declare total int;
select count(*) into total
from compra 
where id_usuario = compra.fk_id_usuario;

return total;
end; $$
delimiter ;

create table log_evento(
    id_log int auto_increment PRIMARY KEY,
    mensagem varchar (255),
    data_log datetime DEFAULT current_timestamp
);

delimiter $$
create  function registrar_log_evento(texto varchar (255))
returns varchar (50)
not deterministic
modifies sql data 
begin
insert into  log_evento(mensagem)
values(texto);
return 'log inserido com sucesso';
end; $$
delimiter ;

show create function registrar_log_evento;

drop function registrar_log_evento;

show variables like 'log_bin_trust_function_creators';

set global log_bin_trust_function_creators = 1;

select registrar_log_evento('evento') as log;

delimiter $$ 
create function mensagem_boas_vindas(nome_usuario varchar(100))
returns varchar(255)
deterministic
contains sql
begin
    declare msg varchar(255);
    set msg = concat('Olá, ', nome_usuario, '! Seja bem-vindo(a) ao sistema VIO.');
    return msg;
end; $$ 
delimiter ;

select mensagem_boas_vindas("seu nome");