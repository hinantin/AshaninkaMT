#/usr/bin/perl -w

#use strict;
use warnings;
use utf8;
binmode STDIN, ':utf-8';
binmode STDOUT, ':utf-8';
use Getopt::Long qw(GetOptions);
use Data::Dumper;

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
  my %wordsES;
  my %wordsPT;
  my %wordsQU;
  my $idES = 0;
  my $idPT = 0;
  my $idQU = 0;

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
# BEGIN: SPLITING LEFT SET INTO ELEMENTS
if ($left =~ /(.*)\s\((.*)\)/) { 
  $left = $1;
  # $2 NOT ENGLISH 
  #print "$2\n";
  parseentries(\%wordsES, \%wordsPT, \%wordsQU, $2, $right, $idES, $idPT, $idQU);
}

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
  parseentries(\%wordsES, \%wordsPT, \%wordsQU, $2, $right, $idES, $idPT, $idQU);
 } else {
  for my $leftelement (split /,\s/, $leftset) {
   $id++;
   if ($leftelement =~ /to\.(.*)\s\(/) { $words{$1}{$right} = $id; }
   else { $leftelement =~ s/to\.//ig; $words{$leftelement}{$right} = $id; }
  }
 }
}

# END: SPLITING LEFT SET INTO ELEMENTS

 }

 }
close(INFO);
}


# SECOND PART 
sortprintelements(\%words);
sortprintelements(\%wordsES);
sortprintelements(\%wordsPT);
sortprintelements(\%wordsQU);

my $count = scalar keys %words;
print STDERR "EN: $count\n";
$count = scalar keys %wordsES;
print STDERR "ES: $count\n";
$count = scalar keys %wordsPT;
print STDERR "PT: $count\n";
$count = scalar keys %wordsQU;
print STDERR "QU: $count\n";

sub sortprintelements {
 my $wordsref = $_[0];
 my %words = %$wordsref;
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

    $left =~ s/\.sp\.$//ig;
    # replacements 
    $left =~ s/\./_/ig;
    # listing elements 
    # right element treatment 
    foreach my $right (keys %{ $words{$leftelement} }) {
      
      my $rightelementanalysis = extractlabels($right);
      # printing the result to STDOUT 
      print STDOUT "        <e><p><l>$left</l><r>$rightelementanalysis</r></p><par n=\"$section\"/></e>\n";
      #printf "%-8s %s\n", $leftelement, $words{$leftelement};
    }
 }
}

sub getelements {
  my $wordsref = $_[0];
  my $e = $_[1];
  my $right = $_[2];
  my $id = $_[3];

  for my $p (split /,{1,2}\s/, $e) {
  #binmode (STDOUT, ":utf-8");
  #my $analysis = extractlabels($right);
  #print "--$p --$analysis\n";
   $id++;
   $wordsref->{$p}{$right} = $id;
  }
}

sub parseentries {
  my $wordsESref = $_[0];
  my $wordsPTref = $_[1];
  my $wordsQUref = $_[2];
  my $e = $_[3];
  my $right = $_[4];
  my $idES = $_[5];
  my $idPT = $_[6];
  my $idQU = $_[7];

  #my %wordsES = %$wordsESref;
  #my %wordsPT = %$wordsPTref;
  #my %wordsQU = %$wordsQUref;

  for my $p (split /;\s/, $e) {
   if ($p =~ /ES:\s(.*)/) { 

    #for my $eES (split /,{1,2}\s/, $1) {
    # $idES++;
    # $wordsESref->{$eES}{$right} = $idES;
    #}
    getelements($wordsESref, $1, $right, $idES); 

   }
   elsif ($p =~ /PT:\s(.*)/) { getelements($wordsPTref, $1, $right, $idPT); }
   elsif ($p =~ /QU:\s(.*)/) { getelements($wordsQUref, $1, $right, $idQU); }
   elsif ($p =~ /sci.nm.:\s(.*)/) { return $1; }
  }
  return $e;

}

sub extractlabels {
  my $right = $_[0];
      my $rightelementanalysis = "";
      for my $rightelement (split /\+|~/, $right) {
        # EXTRACTING LABELS 
        if ($rightelement =~ /(.*)@(.*)/) {
          my $rightelementlabel = lc $1;
          my $rightelementvalue = $2;
          if ($rightelementlabel !~ /gndr/) { $rightelementvalue =~ s/\.$//ig; } # deleting last dot (.) 
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
  return $rightelementanalysis;
}
