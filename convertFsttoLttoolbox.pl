#/usr/bin/perl -w

#use strict;
use warnings;
use utf8;
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use Getopt::Long qw(GetOptions);
use Data::Dumper;

sub volume {
  my $height = shift;
  my $width = shift;
  my $depth = shift;

  return $height * $width * $depth;
}

my $outputfilename = '.dix';
my $section = 'Verb';
my $label = '@section:verb@';
my $rootlabel = 'VRoot';

my @files;
my $options = "--file file_1 --file file_2 ... ";
GetOptions (
'file=s' => \@files,
'outputfilename=s' => \$outputfilename, 
'section=s' => \$section, 
'label=s' => \$label, 
'rootlabel=s' => \$rootlabel, 
) or die " Usage:  $0 $options\n"; 

# FIRST PART 
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
   if ($line =~ /\[=(.*)\]\[$rootlabel\]\[=(.*)\]\"/) {
     $right = $1;
     $left = $2;
   }
#print "$left\n";
# SPLITING LEFT SET INTO ELEMENTS
for my $leftset (split /;{1,2}\s/, $left) {
 if ($leftset =~ /(.*)\s\((.*)\)/) {
  # ENGLISH 
  for my $leftelement (split /,\s/, $1) {
   $id++;
   # Noun
   if ($leftelement =~ /(.*)\s\(/) { $words{$1}{$right} = $id; }
   # Verb
   elsif ($leftelement =~ /to\.(.*)\s\(/) { $words{$1}{$right} = $id; } # extract only left side 
   else { $leftelement =~ s/^to\.//ig; $words{$leftelement}{$right} = $id; }
  }
  #NOT ENGLISH
 } else {
  for my $leftelement (split /,\s/, $leftset) {
   $id++;
   if ($leftelement =~ /to\.(.*)\s\(/) { $words{$1}{$right} = $id; }
   else { $leftelement =~ s/to\.//ig; $words{$leftelement}{$right} = $id; }
  }
 }
}

 }

 }
close(INFO);
}


# SECOND PART 
foreach my $leftelement (sort keys %words) { # SORTING ALPHABETICALLY 
    # left element treatment 
    #print "$leftelement\n";
    my $left = $leftelement; 
    # deletions 
    $left =~ s/\.sb\.$//ig;
    $left =~ s/\.sth\.$//ig;
    $left =~ s/\.sb\.\/sth\.$//ig;
    $left =~ s/^NEG.EXIST:\s//ig;
    $left =~ s/^EXIST:\s//ig;
    $left =~ s/^CONT.EXIST:\s//ig;
    # replacements 
    $left =~ s/\./_/ig;
    # listing elements 
    # right element treatment 
    foreach my $right (keys %{ $words{$leftelement} }) {
      
      my $rightelementanalysis = "";
      for my $rightelement (split /\+|~/, $right) {
        # EXTRACTING LABELS 
        if ($rightelement =~ /(.*)@(.*)/) {
          my $rightelementlabel = lc $1;
          my $rightelementvalue = $2;
          $rightelementvalue =~ s/\.$//ig; 
          if ($rightelementvalue =~ /^\//) {
            $rightelementvalue =~ s/\//\+/ig; $rightelementvalue =~ s/:/@/ig; 
          } else { $rightelementvalue = "+$rightelementvalue"; }
          $rightelementanalysis = "$rightelementanalysis<s n=\"$rightelementlabel\"/>$rightelementvalue";
        }
        # RIGHT ROOT TREATMENT 
        else {
          #print "$rightelement\n"; 
          if ($rightelement =~ /(.*)\/(.*)/) {
            $rightelementanalysis = $1; 
          }
          elsif ($rightelement =~ /(.*)_(.*)/) {
            $rightelementanalysis = "$2<s n=\"preform\"/>#$1"; 
          }
          else {
            $rightelementanalysis = $rightelement; 
          }
        }
      }
      # printing the result to STDOUT 
      print STDOUT "        <e><p><l>$left</l><r>$rightelementanalysis</r></p><par n=\"$section\"/></e>\n";
      #printf "%-8s %s\n", $leftelement, $words{$leftelement};
    }
}


