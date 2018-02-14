#!/usr/bin/perl

use IO::Socket::INET;
use IO::File;
use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);
use RPC::XML;
use RPC::XML::Client;
use Config::IniFiles;
use JSON::Parse 'parse_json';
binmode(STDOUT, ":utf8");
use Data::Dumper;

my $query = new CGI();
print $query -> header(
-type => 'application/json; charset=UTF-8',
);

my $configfile = '/usr/lib/cgi-bin/runasimi/ConfigFile.ini';
my $CONFIG = Config::IniFiles->new( -file => $configfile );
my $user = $CONFIG->val( 'XMLDATABASEHINANTIN', 'USER' );
my $password = $CONFIG->val( 'XMLDATABASEHINANTIN', 'PASSWORD' );

my $wordid = $query->param('wordid');
my $youtubeurl = $query->param('youtubeurl');
my $targetlang = $query->param('targetlang');
my $learnerlang = $query->param('learnerlang');
my $callback = $query->param('callback');

$URL = "http://$user:$password\@localhost:8080/exist/rest/db/apps/HNTE-Learning/queries/function_saveurl.xql?wordid=$wordid&youtubeurl=$youtubeurl&targetlang=$targetlang&learnerlang=$learnerlang";
# connecting to $URL...
$client = RPC::XML::Client->new($URL);
# Output options
my @options = ({
    'indent' => 'yes', 
    'encoding' => 'UTF-8',
    'highlight-matches' => 'none'});
$req = RPC::XML::request->new();
$response = $client->send_request('system.listMethods');
my $result = $response->value;
print "$callback('$result')";

