
CREATE TABLE #Sales(
custnum varchar(10),
saledate date,
EquipSales float )

DELETE #Sales

Insert into #Sales


select a.custnum,marketing.dbo.CreateDate(month,year) as saledate,sum(totalamt) as EquipSales
from Marketing.dbo.CODSKUSales A
inner join (select custnum from marketing.dbo.codskusales where year>=17 group by custnum having sum(totalamt)>50000) B on a.custnum=B.custnum

where year>=14 and CustType in ('NA','CD')
group by a.custnum,month,year



select a.*,(case when EquipSales is null or EquipSales<=0 then 1 else EquipSales end) as EquipSales

FROM (
			select distinct a.custnum, b.date as saledate from #sales A
			cross join (select date from Marketing.dbo.DateRange
			where date <= DATEADD(MONTH, DATEDIFF(MONTH, -1, GETDATE())-1, -1)) B
	 ) A

left join #sales B on a.CustNum=b.CustNum and a.saledate=b.saledate
order by custnum,saledate









--select * from Marketing.dbo.DateRange