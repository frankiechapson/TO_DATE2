
create or replace function TO_DATE2( I_STRING  in varchar2  
                                   , I_FORMAT  in varchar2 := 'yyyymmddhh24miss'
                                   ) return date deterministic is

/********************************************************************************************************************

    The TO_DATE2 is a flexibe TO_DATE function.
    It is insensitve for the separators or any non numeric characters: space, -, ., /, etc.:
    The format must be a compact form, without any separator.
    Returns with null if the input is not a valid date and/or fit for the given format

    sample:
    -------
    TO_DATE2( '   2016/12/11 day after 12:45 maybe...' )

    result:
    -------
    2016.12.11 12:45:00  

    History of changes
    yyyy.mm.dd | Version | Author         | Changes
    -----------+---------+----------------+-------------------------
    2017.01.06 |  1.0    | Ferenc Toth    | Created 

********************************************************************************************************************/
    V_STRING      varchar( 100 ) := regexp_replace( I_STRING, '[^0-9]');
    V_FORMAT      varchar( 100 ) := nvl( trim( I_FORMAT ), 'yyyymmddhh24miss' );
    V_DATE        date;
begin
    if V_STRING is not null then
        V_STRING := substr ( V_STRING, 1, length( V_FORMAT ) );
        V_DATE   := to_date( V_STRING, V_FORMAT );
    end if;
    return V_DATE;
exception when others then
    return null;  -- It is not a date or wrong format
end;
/
