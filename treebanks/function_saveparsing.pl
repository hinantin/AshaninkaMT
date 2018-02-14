#!/usr/bin/perl

use warnings;
use utf8;
use IO::Socket::INET;
use IO::File;
use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);
use RPC::XML;
use RPC::XML::Client;
use Config::IniFiles;
use JSON::Parse 'parse_json';
binmode STDIN, ':utf8';
binmode(STDOUT, ":utf8");
use Data::Dumper;
use Getopt::Long qw(GetOptions);

my $configfile = '/usr/lib/cgi-bin/runasimi/ConfigFile.ini';
my $CONFIG = Config::IniFiles->new( -file => $configfile );
my $user = $CONFIG->val( 'XMLDATABASEHINANTIN', 'USER' );
my $password = $CONFIG->val( 'XMLDATABASEHINANTIN', 'PASSWORD' );

my $parsing = undef;
my $document = undef;
my $lang = undef;
my $textid = undef;
my $paralleltext = undef;

GetOptions (
'parsing=s' => \$parsing,
'lang=s' => \$lang, 
'textid=s' => \$textid, 
'paralleltext=s' => \$paralleltext, 
) or die " Usage:  $0 $options\n";

{
  local $/;
  open(FILE, $parsing) or die "Can't read file '$parsing' [$!]\n";  
  $document = <FILE>; 
  close (FILE);  
  $document = "\n<![CDATA[\n$document\n]]>";
}

$URL = "http://$user:$password\@localhost:8080/exist/rest/db/HNTAshaninka/ParallelCorpus/query/function_saveparsing.xql?pasing=$document&lang=$lang&textid=$textid&paralleltext=$paralleltext";
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

