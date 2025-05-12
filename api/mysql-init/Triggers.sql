delimiter // 

create trigger verify_date_event
before insert on ingresso_compra
for each row
begin
    declare data_evento datetime;

    select e.data_hora into data_evento from ingresso i join evento e on i.fk_id_evento = e.id_evento where i.id_ingresso = new.fk_id_ingresso;
    if date(data_evento) < curdate() then
        signal sqlstate '45000'
        set message_text = 'Evento já ocorreu, não é possivel compra-lo.';
    end if; 
end; //

delimiter ;

delimiter //

create trigger ImpediraAlteraçãodeDatasdeEventosPassados
before update on evento
for each row
begin   
    if old.data_hora < curdate() then  
        signal sqlstate '45000'
        set message_text = 'Não é permitido alteração de eventos ja ocorridos.';
    end if;
end; //
 delimiter ;