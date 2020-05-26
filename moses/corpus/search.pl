#!/usr/bin/env perl

binmode STDOUT, ":utf8";
use XML::LibXML;
require LWP::UserAgent;

$URL = 'http://localhost:8080/exist/rest/db/';
$QUERY = <<END;
<?xml version="1.0" encoding="UTF-8"?>
<query xmlns="http://exist.sourceforge.net/NS/exist"
    start="1" max="20">
    <text><![CDATA[
let \$documents := doc('/db/HNTAshaninka/ParallelCorpus/parallel_texts_20180624_mihastransformador11.xml')
let \$result := \$documents//parallel//text//sentence[matches(\@lang,'prq') and matches(\@normalizationlevel, 'normalized-alphabet')]
let \$result := string-join(\$result, '\n')
return lower-case(\$result)
    ]]></text>
    <properties>
        <property name="indent" value="yes"/>
    </properties>
</query>
END

$ua = LWP::UserAgent->new();
$req = HTTP::Request->new(POST => $URL);
$req->content_type('application/xml');
$req->content($QUERY);

$res = $ua->request($req);
if($res->is_success) {
    my $xml_string = $res->content;
    my $dom = XML::LibXML->load_xml(string => $xml_string);
    foreach my $value ($dom->findnodes('/exist:result/exist:value')) {
       print $value->to_literal();
    }
    #print $xml_string . "\n";
} else {
    print "Error:\n\n" . $res->status_line . "\n";
}
