CLASS zadobe_test_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

    TYPES : BEGIN OF ty_header,
              cname(20)     TYPE c,
              Paddr(200)     TYPE c,
              irn(200)      TYPE c,
              gstin(20)     TYPE c,
*              invno         TYPE i_billingdocument-BillingDocument,
              invno(20)         TYPE c,
*              invdt         TYPE i_billingdocument-BillingDocumentDate,
              invdt(20)     TYPE c,
              vehno(20)     TYPE c,
              lrno(20)      TYPE c,
*              suppdt        TYPE i_billingdocument-BillingDocumentDate,
              trans(20)     TYPE c,
              suppdt(20)    TYPE C,
              psupply(40)   TYPE c,
              bname(20)     TYPE c,
              baddress1(20) TYPE c,
              baddress2(20) TYPE c,
              baddress3(20) TYPE c,
              baddress4(20) TYPE c,
              baddress5(20) TYPE c,
              sname(20)     TYPE c,
              saddress1(20) TYPE c,
              saddress2(20) TYPE c,
              saddress3(20) TYPE c,
              saddress4(20) TYPE c,
              saddress5(20) TYPE c,
              contno(20)    TYPE c,
              sealNo(20)    TYPE c,
              sshipNo(20)   TYPE c,
              POno(20)      TYPE c,
              POdate(20)    TYPE c,
              lutno(20)     TYPE c,
              erate(20)     TYPE c,
                END OF ty_header.


    TYPES : BEGIN OF ty_table,
             sr_no(4) TYPE c,
             maktx(50) TYPE c,
             matnr(50) TYPE c,
             hsn(10)   TYPE c,
             nopkg(4)  TYPE c,
             qty(10)   TYPE c,
             uom(4)    TYPE c,
             rate(20)  TYPE c,
             total(20) TYPE c,
             igst(20)  TYPE c,
          END OF ty_table.

    TYPES : BEGIN OF ty_footer,
             words(100)  TYPE c,
             freight(20) TYPE c,
             insuran(20) TYPE c,
             pcharge(20) TYPE c,
             other(20)   TYPE c,
             tamount(20) TYPE c,
             disamnt(20) TYPE c,
             taxable(20) TYPE c,
             taxinr(20)  TYPE c,
             tigst(20)   TYPE c,
             invtot(20)  TYPE c,
          END OF ty_footer.

    TYPES : BEGIN OF ty_final,
             add_struc TYPE ty_header,
             table     TYPE ty_table,
             footer    TYPE ty_footer.
*             INCLUDE TYPE I_BILLINGDOCUMENT.
*             INCLUDE TYPE I_SALESDOCUMENT.
       TYPES :  END OF ty_final.

    DATA : gt_final TYPE TABLE OF ty_final,
           gs_final TYPE ty_final,
           gs_header TYPE  ty_header,
           gs_table TYPE  ty_table,
           gs_footer TYPE ty_footer.

    DATA : lv_item TYPE string,
           lv_header TYPE string,
           lv_footer TYPE string,
           lv_xml TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZADOBE_TEST_CLASS IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

**    DATA template TYPE string.
**
***    DATA(lv_xml) = |<form1>| &&
***                   |<Name>Ganesh Tate</Name>| &&
***                   |<Id>000001</Id>| &&
***                   |<Desg>sap ABAP Consultant</Desg>| &&
***                   |</form1>|.
***
***    CALL METHOD zadobe_test=>getpdf
***      EXPORTING
***        template = 'ZTEST/ZTEMPLATE'
***        xmldata  = lv_xml
***      RECEIVING
***        result   = DATA(lv_result).
**
***        cl_address_format=>get_instance( )->printform_postal_addr(
***              EXPORTING
****                iv_address_type              = '1'
***                iv_address_number            = wa_kna1-AddressID
****                iv_person_number             =
***                iv_language_of_country_field = sy-langu
****                iv_number_of_lines           = 99
****                iv_sender_country            = space
***              IMPORTING
***                ev_formatted_to_one_line     = DATA(one_line)
***                et_formatted_all_lines       = DATA(all_lines)
***            ).
**
***DATA: lt_response   TYPE TABLE OF zce_inv_form_print,
***          ls_response   TYPE zce_inv_form_print,
***          lt_response_i TYPE TABLE OF zce_inv_form_print_item,
***          ls_response_i TYPE zce_inv_form_print_item,
**DATA:          lv_roundoff_amount TYPE I_BillingDocItemPrcgElmntBasic-ConditionAmount,
**          LV_STATE_CD(2) TYPE C.
**
**    TYPES: BEGIN OF ty_items,
**            BillingDocument     type I_BillingDocumentItemTP-BillingDocument,
**            billingdocumentitem type I_BillingDocumentItemTP-billingdocumentitem,
**            Product             type I_BillingDocumentItemTP-Product,
**            BillingDocumentItemText type I_BillingDocumentItemTP-BillingDocumentItemText,
**            BillingQuantityUnit type I_BillingDocumentItemTP-BillingQuantityUnit,
**            billingquantity     type I_BillingDocumentItemTP-billingquantity,
**            transactioncurrency type I_BillingDocumentItemTP-transactioncurrency,
**            plant               type I_BillingDocumentItemTP-plant,
**            netamount           type I_BillingDocumentItemTP-netamount,
**            acc_ass_grp         type I_ProductSalesDelivery-AccountDetnProductGroup,
**           END OF ty_items.
**     data : it_items type STANDARD TABLE OF ty_items,
**            it_items1 type STANDARD TABLE OF ty_items,
**            it_items2 type STANDARD TABLE OF ty_items,
**            wa_items type ty_items.
**
**
**    READ ENTITY i_billingdocumenttp
***      ALL FIELDS WITH VALUE #( ( billingdocument = '0090000001' ) )
**      ALL FIELDS WITH VALUE #( ( billingdocument = '0090000005' ) )
**       RESULT FINAL(billingheader)
**       FAILED FINAL(failed_data1).
**
**    READ ENTITY i_billingdocumenttp
**    BY \_item
**      ALL FIELDS WITH VALUE #( ( billingdocument = '0090000005' ) )
**      RESULT FINAL(billingdata)
**      FAILED FINAL(failed_data).
**
**    SELECT SINGLE *
**     FROM i_billingdocument
**    WHERE BillingDocument = '0090000005'
**     INTO @data(wa_billing).
**
**    SELECT *
**      FROM I_BILLINGDOCUMENTITEM
**     WHERE BillingDocument = @wa_billing-BillingDocument
**     INTO TABLE @DATA(it_item).
**
**    SELECT plant,
**           plantname,
**           addressid
***           b~addressname
**           FROM i_plant
***           INNER JOIN  AS b
***           ON a~AddressID EQ b~
**           FOR ALL ENTRIES IN @it_item
**          WHERE Plant = @it_item-Plant
**         INTO TABLE @DATA(it_plant).
**
**    READ TABLE it_plant INTO DATA(wa_plant) INDEX 1.
**      IF sy-subrc = 0.
**        cl_address_format=>get_instance( )->printform_postal_addr(
**              EXPORTING
***                iv_address_type              = '1'
**                iv_address_number            = wa_plant-AddressID
***                iv_person_number             =
**                iv_language_of_country_field = sy-langu
***                iv_number_of_lines           = 99
***                iv_sender_country            = space
**              IMPORTING
**                ev_formatted_to_one_line     = DATA(one_plant)
**                et_formatted_all_lines       = DATA(all_lines_p)
**            ).
**
**          LOOP AT all_lines_p INTO DATA(LS_all_lines_p).
**          CASE SY-TABIX.
**           WHEN 1.
**               gs_header-paddr = |{ gs_header-paddr }{ LS_all_lines_p }|.
**           WHEN 2.
**               gs_header-paddr = |{ gs_header-paddr }{ LS_all_lines_p }|.
**           WHEN 3.
**               gs_header-paddr = |{ gs_header-paddr }{ LS_all_lines_p }|.
**           WHEN 4.
**               gs_header-paddr = |{ gs_header-paddr }{ LS_all_lines_p }|.
**           WHEN 5.
**               gs_header-paddr = |{ gs_header-paddr }{ LS_all_lines_p }|.
**          ENDCASE.
**          ENDLOOP.
**
**       ENDIF.
**
**    SELECT SINGLE *
**          FROM I_CompanyCode
**          WHERE CompanyCode = @wa_billing-CompanyCode
**          INTO @DATA(wa_bukrs).
**
**           gs_header-cname = wa_bukrs-CompanyCodeName.
**
**    SELECT  *
**      FROM I_SALESDOCUMENT
**      FOR ALL ENTRIES IN @it_item
**     WHERE SalesDocument = @it_item-SalesDocument
**       INTO TABLE @DATA(i_salesdocument).
**
**    SELECT  *    "#EC CI_FAE_LINES_ENSURED
**      FROM I_SALESDOCUMENTitem
**      FOR ALL ENTRIES IN @it_item
**     WHERE SalesDocument = @it_item-SalesDocument
**       AND SalesDocumentItem    = @it_item-SalesDocumentItem
**       INTO TABLE @DATA(i_salesdocumentitem).
**
**
**    SELECT  *
***      FROM C_SALESDOCUMENTITEMDEX_1
**      FROM C_SALESDOCUMENTITEMDEX
**      FOR ALL ENTRIES IN @it_item
**     WHERE SalesDocument = @it_item-SalesDocument
**       AND SalesDocumentItem    = @it_item-SalesDocumentItem
**       INTO TABLE @DATA(i_salesdocumentitemdex).
**
**    SELECT *
**      FROM I_DELIVERYDOCUMENT
**      FOR ALL ENTRIES IN @it_item
**      WHERE DeliveryDocument = @it_item-ReferenceSDDocument
**      INTO TABLE @DATA(it_delivery).
**
**    SELECT billingdocument, billingdocumentitem, conditiontype,
**           conditionrateamount, conditionamount, conditionratevalue
**     FROM i_billingdocitemprcgelmntbasic
**    FOR ALL ENTRIES IN @billingdata
**    WHERE billingdocument  = @billingdata-billingdocument
**      AND billingdocumentitem = @billingdata-billingdocumentitem
**      INTO TABLE @DATA(pricingdata).
**
**    SELECT partnerfunction, customer FROM i_salesorderpartner "i_salesorderitempartner "
**    FOR ALL ENTRIES IN @billingdata
**      WHERE salesorder = @billingdata-salesdocument
***      AND   salesorderitem = @billingdata-salesdocumentitem
**      INTO TABLE @DATA(it_vbpa).
**
**    SELECT partnerfunction, customer FROM I_CreditMemoReqPartner
**        FOR ALL ENTRIES IN @billingdata
**        WHERE CreditMemoRequest = @billingdata-referencesddocument
**        appending TABLE @it_vbpa.
**
**    READ TABLE billingheader INTO DATA(wa_head) INDEX 1.
**       if  sy-subrc = 0.
**
**          SELECT SINGLE customer, AddressID, CustomerName, TaxNumber3, COUNTRY, Region
**           FROM i_customer
**            WHERE customer = @WA_HEAD-PayerParty
**            INTO @DATA(wa_kna1).
**        cl_address_format=>get_instance( )->printform_postal_addr(
**              EXPORTING
***                iv_address_type              = '1'
**                iv_address_number            = wa_kna1-AddressID
***                iv_person_number             =
**                iv_language_of_country_field = sy-langu
***                iv_number_of_lines           = 99
***                iv_sender_country            = space
**              IMPORTING
**                ev_formatted_to_one_line     = DATA(one_line)
**                et_formatted_all_lines       = DATA(all_lines)
**            ).
**
**       ENDIF.
**
**          LOOP AT all_lines INTO DATA(LS_all_lines).
**          CASE SY-TABIX.
**           WHEN 1.
**              gs_header-baddress1 = LS_all_lines.
**           WHEN 2.
**              gs_header-baddress2 = LS_all_lines.
**           WHEN 3.
**              gs_header-baddress3 = LS_all_lines.
**           WHEN 4.
**              gs_header-baddress4 = LS_all_lines.
**           WHEN 5.
**              gs_header-baddress5 = LS_all_lines.
**           WHEN 6.
***              gs_header-baddress = LS_all_lines.
**          ENDCASE.
**          ENDLOOP.
**
*** Ship-to-address
**
**      READ TABLE it_vbpa INTO DATA(wa_vbpa) WITH  KEY partnerfunction = 'WE'. "SHIP TO PARTY
**      IF sy-subrc = 0.
**
**          SELECT SINGLE customer, AddressID, CustomerName, TaxNumber3, COUNTRY, Region
**           FROM i_customer
**            WHERE customer = @wa_vbpa-Customer
**            INTO @data(wa_kna1_s).
**
**        CLEAR : one_line, all_lines[].
**        cl_address_format=>get_instance( )->printform_postal_addr(
**              EXPORTING
***                iv_address_type              = '1'
**                iv_address_number            = wa_kna1-AddressID
***                iv_person_number             =
**                iv_language_of_country_field = sy-langu
***                iv_number_of_lines           = 99
***                iv_sender_country            = space
**              IMPORTING
**                ev_formatted_to_one_line     = one_line
**                et_formatted_all_lines       = all_lines
**            ).
**
**
**          LOOP AT all_lines INTO LS_all_lines.
**          CASE SY-TABIX.
**           WHEN 1.
**              gs_header-saddress1 = LS_all_lines.
**           WHEN 2.
**              gs_header-saddress2 = LS_all_lines.
**           WHEN 3.
**              gs_header-saddress3 = LS_all_lines.
**           WHEN 4.
**              gs_header-saddress4 = LS_all_lines.
**           WHEN 5.
**              gs_header-saddress5 = LS_all_lines.
**          ENDCASE.
**          ENDLOOP.
**
**        ENDIF.
**
**         gs_header-invno = wa_billing-BillingDocument.
**         gs_header-invdt = |{ wa_billing-CreationDate+6(2) }.{ wa_billing-CreationDate+4(2) }.{ wa_billing-CreationDate+0(4) }|.
**         gs_header-bname = wa_kna1-CustomerName.
**         gs_header-sname = wa_kna1_s-CustomerName.
**         gs_header-suppdt =
**         |{ wa_billing-CreationDate+6(2) }.{ wa_billing-CreationDate+4(2) }.{ wa_billing-CreationDate+0(4) } : { wa_billing-CreationTime+0(2) }:{ wa_billing-CreationTime+2(2) }:{ wa_billing-CreationTime+4(2) }|.
**
**        TRY.
**          DATA(lv_salesdoc) =
**                         it_item[ BillingDocument = wa_billing-BillingDocument ]-SalesDocument.
**        CATCH CX_SY_ITAB_LINE_NOT_FOUND.
**        ENDTRY.
**
**        TRY.
**          DATA(lv_refdoc) =
**                         it_item[ BillingDocument = wa_billing-BillingDocument ]-ReferenceSDDocument.
**        CATCH CX_SY_ITAB_LINE_NOT_FOUND.
**        ENDTRY.
**
**
**        TRY.
**          gs_header-trans =
**                         i_salesdocumentitem[ SalesDocument = lv_salesdoc  ]-ShippingType.
**        CATCH CX_SY_ITAB_LINE_NOT_FOUND.
**        ENDTRY.
**
**         gs_header-erate = wa_billing-AccountingExchangeRate.
**
****        TRY.
****          gs_header-vehno =
****                         it_delivery[ DeliveryDocument = lv_refdoc  ]-YY1_Vehicleno_DLH.
****        CATCH CX_SY_ITAB_LINE_NOT_FOUND.
****        ENDTRY.
****
****        TRY.
****          gs_header-contno =
****                         it_delivery[ DeliveryDocument = lv_refdoc  ]-YY1_ContainerNo_DLH.
****        CATCH CX_SY_ITAB_LINE_NOT_FOUND.
****        ENDTRY.
****
****        TRY.
****          gs_header-sealno =
****                         it_delivery[ DeliveryDocument = lv_refdoc  ]-YY1_SealNo_DLH.
****        CATCH CX_SY_ITAB_LINE_NOT_FOUND.
****        ENDTRY.
****
****        TRY.
****          gs_header-sshipno =
****                         it_delivery[ DeliveryDocument = lv_refdoc  ]-YY1_ShipperSealNo_DLH.
****        CATCH CX_SY_ITAB_LINE_NOT_FOUND.
****        ENDTRY.
**
****        TRY.
****          gs_header-lutno =
****                         it_delivery[ DeliveryDocument = lv_refdoc  ]-YY1_LUTNo_DLH.
****        CATCH CX_SY_ITAB_LINE_NOT_FOUND.
****        ENDTRY.
**
**        TRY.
**          gs_header-pono =
**                         i_salesdocument[ SalesDocument = lv_salesdoc ]-PurchaseOrderByCustomer.
**        CATCH CX_SY_ITAB_LINE_NOT_FOUND.
**        ENDTRY.
**
**        TRY.
**          gs_header-podate =
**                         i_salesdocument[ SalesDocument = lv_salesdoc ]-CustomerPurchaseOrderDate.
**        CATCH CX_SY_ITAB_LINE_NOT_FOUND.
**        ENDTRY.
**
**          gs_header-podate = |{ gs_header-podate+6(2) }.{ gs_header-podate+4(2) }.{ gs_header-podate+0(4) }|.
**
**    lv_header    =   |<form1>| &&
**                     |  <Main>| &&
**                     |    <Paddress>{ gs_header-paddr }</Paddress>| &&
**                     |    <IRN>{ gs_header-irn }</IRN>| &&
**                     |    <Company_Name>{ gs_header-cname }</Company_Name>| &&
**                     |    <GST_IN>| &&
**                     |      <GST_IN></GST_IN>| &&
**                     |      <Invoice_no>{ gs_header-invno }</Invoice_no>| &&
**                     |      <Invoice_Date>{ gs_header-invdt }</Invoice_Date>| &&
**                     |    </GST_IN>| &&
**                     |    <Transportation_Mode>| &&
**                     |      <Trans_Mode>{ gs_header-trans }</Trans_Mode>| &&
**                     |      <Veh_No>{ gs_header-vehno }</Veh_No>| &&
**                     |      <LR_No></LR_No>| &&
**                     |      <Date_Time_Supply>{ gs_header-suppdt }</Date_Time_Supply>| &&
**                     |      <Place></Place>| &&
**                     |    </Transportation_Mode>| &&
**                     |    <Details>| &&
**                     |      <Billed>| &&
**                     |        <Billed_Name>{ gs_header-bname }</Billed_Name>| &&
**                     |        <Billed_Address>{ gs_header-baddress1 }</Billed_Address>| &&
**                     |        <Container_No>{ gs_header-contno }</Container_No>| &&
**                     |        <Shipper_No>{ gs_header-sshipno }</Shipper_No>| &&
**                     |        <Seal_No>{ gs_header-sealno }</Seal_No>| &&
**                     |        <PO_Date>{ gs_header-podate }</PO_Date>| &&
**                     |        <PO_No>{ gs_header-pono }</PO_No>| &&
**                     |        <Baddress1>{ gs_header-baddress2 }</Baddress1>| &&
**                     |        <Baddress2>{ gs_header-baddress3 }</Baddress2>| &&
**                     |        <Baddress3>{ gs_header-baddress4 }</Baddress3>| &&
**                     |      </Billed>| &&
**                     |      <Shipped>| &&
**                     |        <Shipped_Name>{ gs_header-sname }</Shipped_Name>| &&
**                     |        <Shipped_Address>{ gs_header-saddress1 }</Shipped_Address>| &&
**                     |        <Block></Block>| &&
**                     |        <Lut_No>{ gs_header-lutno }</Lut_No>| &&
**                     |        <Exchange_Rate>{ gs_header-erate }</Exchange_Rate>| &&
**                     |        <Saddress1>{ gs_header-saddress2 }</Saddress1>| &&
**                     |        <Saddress2>{ gs_header-saddress3 }</Saddress2>| &&
**                     |        <Saddress3>{ gs_header-saddress4 }</Saddress3>| &&
**                     |      </Shipped>| &&
**                     |    </Details>| &&
**                     |    <Body>| &&
**                     |      <Table>| &&
**                     |        <Items>| &&
**                     |          <I_Header/>|. "&&
**
**         LOOP AT it_item INTO DATA(wa_item).
**
**            wa_item-Product = |{ wa_item-Product ALPHA = OUT }|.
**
**            TRY.
**              gs_table-rate =
**                             pricingdata[ billingdocument = wa_item-BillingDocument
**                                          billingdocumentitem = wa_item-BillingDocumentItem
**                                          conditiontype = 'ZPR0' ]-ConditionRateAmount.
**            CATCH CX_SY_ITAB_LINE_NOT_FOUND.
**            ENDTRY.
**
**            TRY.
**              gs_table-igst =
**                             pricingdata[ billingdocument = wa_item-BillingDocument
**                                          billingdocumentitem = wa_item-BillingDocumentItem
**                                          conditiontype = 'JOIG' ]-ConditionRateAmount.
**            CATCH CX_SY_ITAB_LINE_NOT_FOUND.
**            ENDTRY.
**
****            TRY.
****              gs_table-nopkg =
****                             i_salesdocumentitemdex[ SalesDocument = wa_item-SalesDocument
****                                                     SalesDocumentItem    = wa_item-SalesDocumentItem ]-YY1_TotalNumberofPacka_SDI.
****            CATCH CX_SY_ITAB_LINE_NOT_FOUND.
****            ENDTRY.
**
**
**
**                lv_item = lv_item &&
**                     |          <BillingDocumentItemNode>| &&
**                     |            <Sr>{ wa_item-SalesDocumentItem }</Sr>| &&
**                     |            <Description>{ wa_item-BillingDocumentItemText }</Description>| &&
**                     |            <Material>{ wa_item-Product }</Material>| &&
**                     |            <Hsn></Hsn>| &&
**                     |            <Pkt>{ gs_table-nopkg }</Pkt>| &&
**                     |            <Quantity>{ wa_item-MRPRequiredQuantityInBaseUnit }</Quantity>| &&
**                     |            <Uom>{ wa_item-ItemWeightUnit }</Uom>| &&
**                     |            <Rate>{ gs_table-rate }</Rate>| &&
**                     |            <Ttotal>{ wa_item-CostAmount }</Ttotal>| &&
**                     |            <Igst>{ gs_table-igst }</Igst>| &&
**                     |          </BillingDocumentItemNode>|. "&&
**        ENDLOOP.
**
**        gs_footer-freight = REDUCE dmbtr( INIT sum = CONV dmbtr( 0 ) FOR gs IN pricingdata
**                   WHERE ( ( BillingDocument = wa_billing-BillingDocument ) AND (  conditiontype = 'ZFRE' ) )
**                   NEXT sum = sum + gs-ConditionAmount ).
**
**        gs_footer-insuran = REDUCE dmbtr( INIT sum = CONV dmbtr( 0 ) FOR gs IN pricingdata
**                   WHERE ( ( BillingDocument = wa_billing-BillingDocument ) AND (  conditiontype = 'ZINS' ) )
**                   NEXT sum = sum + gs-ConditionAmount ).
**
**        gs_footer-pcharge = REDUCE dmbtr( INIT sum = CONV dmbtr( 0 ) FOR gs IN pricingdata
**                   WHERE ( ( BillingDocument = wa_billing-BillingDocument ) AND (  conditiontype = 'ZPAC' ) )
**                   NEXT sum = sum + gs-ConditionAmount ).
**
**        gs_footer-other = REDUCE dmbtr( INIT sum = CONV dmbtr( 0 ) FOR gs IN pricingdata
**                   WHERE ( ( BillingDocument = wa_billing-BillingDocument ) AND (  conditiontype = 'ZOTH' ) )
**                   NEXT sum = sum + gs-ConditionAmount ).
**
**        gs_footer-disamnt = REDUCE dmbtr( INIT sum = CONV dmbtr( 0 ) FOR gs IN pricingdata
**                   WHERE ( ( BillingDocument = wa_billing-BillingDocument ) AND (  conditiontype = 'ZDIS' ) )
**                   NEXT sum = sum + gs-ConditionAmount ).
**
**        IF gs_footer-disamnt IS NOT INITIAL.
**          gs_footer-taxable = gs_footer-tamount - gs_footer-disamnt.
**         ELSE.
**          gs_footer-taxable = gs_footer-tamount.
**        ENDIF.
**
**        gs_footer-tigst = REDUCE dmbtr( INIT sum = CONV dmbtr( 0 ) FOR gs IN pricingdata
**                   WHERE ( ( BillingDocument = wa_billing-BillingDocument ) AND (  conditiontype = 'JOIG' ) )
**                   NEXT sum = sum + gs-ConditionAmount ).
**
**
**    lv_footer =      |        </Items>| &&
**                     |      </Table>| &&
**                     |    <Footer>| &&
**                     |        <Words></Words>| &&
**                     |        <Freight>{ gs_footer-freight }</Freight>| &&
**                     |        <Insurance>{ gs_footer-insuran }</Insurance>| &&
**                     |        <Packing_Charges>{ gs_footer-pcharge }</Packing_Charges>| &&
**                     |        <Other>{ gs_footer-other }</Other>| &&
**                     |        <Total>{ gs_footer-tamount }</Total>| &&
**                     |        <Discount>{ gs_footer-disamnt }</Discount>| &&
**                     |        <Taxable>{ gs_footer-taxable }</Taxable>| &&
**                     |        <Taxable_Inr>{ gs_footer-taxinr }</Taxable_Inr>| &&
**                     |        <Total_Igst>{ gs_footer-tigst }</Total_Igst>| &&
**                     |      </Footer>| &&
**                     |      <Signature>| &&
**                     |        <Terms />| &&
**                     |        <Authorized>| &&
**                     |          <Invoice></Invoice>| &&
**                     |        </Authorized>| &&
**                     |      </Signature>| &&
**                     |    </Body>| &&
**                     |  </Main>| &&
**                     |</form1>|.
**
**    lv_xml = |{ lv_header }{ lv_item }{ lv_footer }|.
**
**
**    CALL METHOD zadobe_ads_class=>getpdf
**      EXPORTING
**        template = 'ZTEST1/ZTEST1'
**        xmldata  = lv_xml
**      RECEIVING
**        result   = DATA(lv_result).

  ENDMETHOD.
ENDCLASS.
