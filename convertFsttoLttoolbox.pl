#/usr/bin/perl -w

#use strict;
use warnings;
use utf8;
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use Getopt::Long qw(GetOptions);

my $outputfilename = '.dix';
my $section = 'Verb';
my $label = '@section:verb@';

my @files;
my $options = "--file file_1 --file file_2 ... ";
GetOptions (
'file=s' => \@files,
'outputfilename=s' => \$outputfilename, 
'section=s' => \$section, 
'label=s' => \$label, 
) or die " Usage:  $0 $options\n"; 

my $file;
while (defined($file = shift @files)) {
open INFO, $file or die "Could not open $file: $!";
 while (<INFO>)
 {
 if (m/$label/) { 
   my $line = $_;
   if ($line =~ /\[=(.*)\]\[VRoot/) {
     print STDERR "        <e><p><l>advise</l><r>$1</r></p><par n="Verb"/></e>\n";
   }
 }
 }
close(INFO);
}
