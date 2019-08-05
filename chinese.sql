drop procedure chinese;

delimiter $$
create procedure chinese()
begin
    declare done int default false;
    declare tmp_fee int;
    declare tmp_tel varchar(20);
    declare tmp_dd datetime;

    declare word varchar(30) default '零壹貳叁肆伍陸柒捌玖';
    declare str varchar(20);
    declare tmp_word varchar(40);
    declare n int;

    declare c cursor for select tel, dd, fee from bill;
    declare continue handler for not found set done = true;

    open c;
    fetch c into tmp_tel, tmp_dd, tmp_fee;
    while not done do
        set str = convert(tmp_fee, varchar(20));
        select str;
        
        set tmp_word = '';
        set n = 1;
        while n <= length(str) do
            set tmp_word = concat(tmp_word, substring(word, convert(substring(str, n, 1), int) + 1, 1));
            set n = n + 1;
        end while;
        select tmp_word;
        update bill set chinese = tmp_word where tel = tmp_tel and dd = tmp_dd;

        fetch c into tmp_tel, tmp_dd, tmp_fee;
    end while;

    close c;
end$$

delimiter ;