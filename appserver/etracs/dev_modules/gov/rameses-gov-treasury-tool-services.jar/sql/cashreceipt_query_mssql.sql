[getList]
select 
	c.objid, c.state, c.txndate, c.receiptno, c.receiptdate, c.txnmode, c.paidby, c.paidbyaddress, c.amount, 
	c.collector_objid, c.collector_name, c.collectiontype_objid, c.collectiontype_name, 
	c.controlid, c.series, c.formno, c.formtype, 
	(case when v.objid is null then 0 else 1 end) as voided, 
	(case when r.objid is null then 0 else 1 end) as remitted, 
	(case when r.collectionvoucherid is null then 0 else 1 end) as liquidated 
from ( 
	select top 500 c.objid 
	from cashreceipt c 
	where ${filter} 
)t1 
	inner join cashreceipt c on c.objid = t1.objid 
	left join cashreceipt_void v on v.receiptid = c.objid 
	left join remittance r on r.objid = c.remittanceid 
order by ${orderby} 


[getUnremittedCashReceipts]
select 
	c.objid, c.formno, c.receiptno, c.receiptdate, c.txndate, 
	c.txnmode, c.paidby, c.amount, c.totalnoncash, (c.amount-c.totalnoncash) as totalcash, 
	c.collectiontype_objid, c.collectiontype_name, c.collector_objid, c.collector_name, 
	c.subcollector_objid, c.subcollector_name, c.state, 
	case when v.objid is null then 0 else 1 end as voided 
from ( 
	select cr.objid 
	from cashreceipt cr 
	where cr.remittanceid is null 
		and cr.state = 'POSTED' 
		and cr.collector_objid like $P{userid} 
		and ${filter} 
	union  
	select cr.objid 
	from cashreceipt cr 
	where cr.remittanceid is null 
		and cr.state = 'DELEGATED' 
		and cr.subcollector_objid like $P{userid} 
		and ${filter} 
)t1 
	inner join cashreceipt c on c.objid = t1.objid 
	left join cashreceipt_void v on v.receiptid = c.objid 
order by c.receiptdate, c.txndate 
