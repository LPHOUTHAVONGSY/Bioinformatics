#!/usr/bin/perl

#Oath:
#Student Assignment Submission Form
#==================================
#I declare that the attached assignment is wholly my/our
#own work in accordance with Seneca Academic Policy. No part of this
#assignment has been copied manually or electronically from any
#other source (including web sites) or distributed to other students.
#Name: Larry Phouthavongsy
#Student ID: 150171163
#---------------------------------------------------------------

use strict;
use warnings;
use CGI ":standard";
use LWP::Simple;
my $cgi = new CGI;

print $cgi->header( );

my @attributes  = $cgi->param('attributes');
my $viruses  = $cgi->param('viruses');
my @accession = split('/', $viruses); #splits virus name and accession number
my $info; #all information from NCBI
my $output;
my $bc;

print $cgi->start_html( );
print "<pre>"; #maintains original formatting

$viruses = $accession[1];# re-assigns accession number only for get

#downloading file that matches accession number
if ($viruses eq "NC_002549.gbk"){
$info = 
get("ftp://ftp.ncbi.nlm.nih.gov/genomes/Viruses/zaire_ebolavirus_uid14703/NC_002549.gbk");
die "Error" unless defined($info);
   		open(FD, "> $viruses") || die("Error\n");
   		print FD "$info";
   		close(FD);
}if ($viruses eq "NC_001781.gbk"){
$info = 
get("ftp://ftp.ncbi.nlm.nih.gov/genomes/Viruses/human_orthopneumovirus_uid15003/NC_001781.gbk");
die "Error" unless defined($info);
   		open(FD, "> $viruses") || die("Error\n");
   		print FD "$info";
   		close(FD);
}if ($viruses eq "NC_004763.gbk"){   
$info =
get("ftp://ftp.ncbi.nlm.nih.gov/genomes/Viruses/african_green_monkey_polyomavirus_uid15320/NC_004763.gbk");
die "Error" unless defined($info);
                open(FD, "> $viruses") || die("Error\n");
                print FD "$info";
                close(FD);
}if ($viruses eq "NC_004679.gbk"){
$info =
get("ftp://ftp.ncbi.nlm.nih.gov/genomes/Viruses/staphylococcus_phage_p68_uid14269/NC_004679.gbk");
die "Error" unless defined($info);
                open(FD, "> $viruses") || die("Error\n");
                print FD "$info";
                close(FD);
}if ($viruses eq "NC_004777.gbk"){
$info =
get("ftp://ftp.ncbi.nlm.nih.gov/genomes/Viruses/yersinia_phage_phia1122_uid14332/NC_004777.gbk");         
die "Error" unless defined($info);
                open(FD, "> $viruses") || die("Error\n");
                print FD "$info";
                close(FD);
}

#loop through each attribute obtained from form 
#check to see if attribute matches one found in info
#check to see if info matches search pattern
#append match to output string 
#(.) match inbetween
#/s multiple lines
#(.*?) match first instance

foreach (@attributes){

	if ($_ eq "LOCUS"){
		if ($info =~ /^(.*)DEFINITION/s){
		$output .= ($1);
		}
	}if ($_ eq "DEFINITION"){
		if ($info =~ /DEFINITION(.*)ACCESSION/s){
        	$output .= ("DEFINITION".$1);
		}
	}if ($_ eq "ACCESSION"){
		if ($info =~ /ACCESSION(.*)VERSION/s){
        	$output .= ("ACCESSION".$1); 
		}
	}if ($_ eq "VERSION"){
		if ($info =~ /VERSION(.*)KEYWORDS/s){   
        	$output .= ("VERSION".$1); 
		}
	}if ($_ eq "KEYWORDS"){
		if ($info =~ /KEYWORDS(.*)SOURCE/s){ 
        	$output .= ("KEYWORDS".$1);  
		}
	}if ($_ eq "SOURCE"){
		if ($info =~ /SOURCE(.*)ORGANISM/s){  
        	$output .= ("SOURCE".$1);
		}
	}if ($_ eq "ORGANISM"){
		if ($info =~ /ORGANISM(.*?)REFERENCE/s){
        	$output .= ("ORGANISM".$1);  
		}
	}if ($_ eq "REFERENCE"){
		if ($info =~ /REFERENCE(.*?)AUTHORS/s){
        	$output .= ("REFERENCE".$1);
		}
	}if ($_ eq "AUTHORS"){
		if ($info =~ /AUTHORS(.*?)TITLE/s){  
        	$output .= ("AUTHORS".$1);
		}
	}if ($_ eq "TITLE"){
		if ($info =~ /TITLE(.*?)JOURNAL/s){  
        	$output .= ("TITLE".$1);
		}
	}if ($_ eq "JOURNAL"){
		if ($info =~ /JOURNAL(.*?)PUBMED/s){  
        	$output .= ("JOURNAL".$1);
		}
	}if ($_ eq "FEATURES"){
		if ($info =~ /FEATURES(.*)ORIGIN/s){  
        	$output .= ("FEATURES".$1);
		}
	}if ($_ eq "ORIGIN"){
		if ($info =~ /ORIGIN(.*)/s){  
        	$output .= ("ORIGIN".$1); 
		}
	}
}

print "$output\n";

#method to find basecount
#loop through attributes

foreach (@attributes){

	if ($_  eq  "BASECOUNT"){
	my $i = 0;
	my @code = split (' ',$info); #puts information into array 
        	foreach(@code){ #loop through to find origin
                	if($_ =~ m/^ORIGIN/){
                		$i++;   
                	}if ($i ==1){#append dna code to string
                		$bc .= "$_ ";
                	}
		}
	basecount(); #calls subroutine to print base counts
	}      
}

sub basecount {
	my $countA = $bc =~ tr/a//; #transliteration operator to match for single nucleotides
	my $countG = $bc =~ tr/g//;
	my $countC = $bc =~ tr/c//;
	my $countT = $bc =~ tr/t//;

	print "BASE COUNT";
	print "\nA: $countA"; #prints total number of specific nucleotide
	print "\nG: $countG";
	print "\nC: $countC";
	print "\nT: $countT";
}

print "</pre>";

print $cgi->end_html( );

