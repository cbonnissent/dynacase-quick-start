<?php

$app_desc = array(
    "name"        => "COGIP_AUDIT",
    "short_name"  => N_("Cogip_audit"),
    "description" => N_("Cogip_audit"),
    "access_free" => "N",
    "icon"        => "cogip_audit.png",
    "displayable" => "N",
    "with_frame"  => "Y",
    "childof"     => ""
);

/* ACLs for this application */
$app_acl = array();

/* Actions for this application */
$action_desc = array();



/***********
 * Samples *
 ***********/

/*
$app_acl = array(
    array(
        "name"               => "ZOO_MONEY",
        "description"        => N_("Access to ticket sales")
    )
);
*/

/*
$action_desc = array(
    array(
        "name"               => "ZOO_TEXTTICKETSALES",   //required
        "short_name"         => N_("text sum of sales"), //not required
        "script"             => "zoo_ticketsales.php",   //not required, defaults to lower(<name>).php
        "function"           => "zoo_ticketsales",       //not required, defaults to lower(<name>)
        "acl"                => "ZOO_MONEY"              //not required, defaults to null
    )
);
*/