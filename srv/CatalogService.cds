using { anubhav.db.master, anubhav.db.transaction } from '../db/datamodel';
using { cappo.cds } from '../db/CDSViews';
service CatalogService @(path: 'CatalogService') {
    //In odata service an entityset is used as end point to perform
    //CURDQ - Create Update Read Delete and Query operations
    entity BusinessPartnerSet as projection on master.businesspartner;
    entity BPAddress as projection on master.address;
    entity EmployeeSet as projection on master.employees;
    entity ProductSet as projection on master.product;
    entity POs @(
        odata.draft.enabled: true
    ) as projection on transaction.purchaseorder
    actions{
        @cds.odata.bindingparameter.name : '_anubhav'
        @Common.SideEffects : {
                TargetProperties : ['_anubhav/GROSS_AMOUNT']
        } 
        action boost();
        action setOrderProcessing();
        function largestOrder() returns array of POs;
    };
    entity POItems as projection on transaction.poitems;
}