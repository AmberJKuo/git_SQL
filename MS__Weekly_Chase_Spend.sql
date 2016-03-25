SELECT qqq.base_week_offset, qqq.dt_year, qqq.op_id, coalesce(sum(zzz.card_spnd),0) as card_spnd

FROM ( SELECT DISTINCT base_week_offset, dt_year,op_id  --QQQ
                              FROM [Ref].[dbo] .[date_dimension] D
                              LEFT OUTER JOIN (select distinct spend_yr, op_id  --XXX
                                                            from [Loyalty].[dbo].[ak_prtcpnt_pgm_spend_hist] P
                                                           WHERE op_id = ( 'JV028393')  
                                                            ) XXX
                                                            on d.dt_year = xxx.spend_yr
                              WHERE calendar_dt between '2014-01-01' and GETDATE() )  QQQ

LEFT OUTER JOIN (SELECT   --ZZZ 
                              base_week_offset
                              ,op_id
                              ,coalesce(arn_spend_amt-max (arn_spend_amt)  over (Partition by op_id, acct_ref_id, spend_yr Order by active_dt rows between 1 preceding and 1 preceding), arn_spend_amt) as card_spnd
                              FROM [Loyalty].[dbo].[ak_prtcpnt_pgm_spend_hist] P
                              INNER JOIN [Ref].[dbo] .[date_dimension] D
                              on d.calendar_dt = p.active_dt
                            WHERE 
                            op_id = ( 'JV028393') 
                            and calendar_dt between '2014-01-01' and GETDATE() 
                              ) ZZZ
                              on qqq.base_week_offset = zzz.base_week_offset
                              and qqq.op_id = zzz.op_id

group by qqq.base_week_offset, qqq.dt_year, qqq.op_id

ORDER BY Base_Week_Offset

