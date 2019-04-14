#/usr/bin/perl -w

#use strict;
use warnings;
use utf8;
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use Getopt::Long qw(GetOptions);
use Data::Dumper;

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
my %words;
my $id = 0;
while (defined($file = shift @files)) {
open INFO, $file or die "Could not open $file: $!";
 while (<INFO>)
 {
 if (m/$label/) { 
   my $line = $_;
   my $right = undef;
   my $left = undef;
   if ($line =~ /\[=(.*)\]\[VRoot\]\[=(.*)\]\"/) {
     $right = $1;
     $left = $2;
   }

for my $leftelement (split /;{1,2}\s/, $left) {
   $id++;
   if ($leftelement =~ /to\.(.*)\s\(/) { $words{$1}{$right} = $id; }
   else { $leftelement =~ s/to\.//ig; $words{$leftelement}{$right} = $id; }
}

 }

 }
close(INFO);
}

foreach my $leftelement (sort keys %words) {
    my $left = $leftelement; 
    $left =~ s/\.sb\.$//ig;
    $left =~ s/\.sth\.$//ig;
    $left =~ s/\./_/ig;
    # listing elements 
    foreach my $right (keys %{ $words{$leftelement} }) {
      
      my $rightelementanalysis = "";
      for my $rightelement (split /\+|~/, $right) {
        if ($rightelement =~ /(.*)@(.*)/) {
          my $rightelementlabel = lc $1;
          my $rightelementvalue = $2;
          $rightelementvalue =~ s/\.$//ig; 
          if ($rightelementvalue =~ /^\//) {
            $rightelementvalue =~ s/\//\+/ig; $rightelementvalue =~ s/:/@/ig; 
          } else { $rightelementvalue = "+$rightelementvalue"; }
          $rightelementanalysis = "$rightelementanalysis<s n=\"$rightelementlabel\"/>$rightelementvalue";
        }
        else { $rightelementanalysis = $rightelement; }
      }
      print STDOUT "        <e><p><l>$left</l><r>$rightelementanalysis</r></p><par n=\"$section\"/></e>\n";
      #printf "%-8s %s\n", $leftelement, $words{$leftelement};
    }
}


