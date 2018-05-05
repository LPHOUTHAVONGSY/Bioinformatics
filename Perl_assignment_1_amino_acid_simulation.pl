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

my %mass = (H => 1.0079, O => 15.9994, N => 14.0067, C => 12.0107);
my %valence = (H => 1, O => (-2), N => (-3), C => (-4));
my %aminoAcid = (Ala => 89.0929, Asp => 133.1024, Glu => 147.1289, 
Phe => 165.1887, Gly => 75.0664, His => 155.1542,
Lys => 146.1870, Leu => 131.1724,
Asn => 132.1176, Pro => 115.1301,
Gln => 146.1441, Arg => 174.2004, Ser => 105.0923,
Thr => 119.1188, Val => 117.1459, Trp => 204.2247,
Tyr => 181.1881);
my %raminoAcid = reverse %aminoAcid;
my $limit = 4; #Generates one of four whole numbers (0,1,2,3)
my $i = 0; #10th molecule counter
my $j = 1; #main counter for molecule number from beginning
my $p = 0;
my @aa = (88.0929, 133.1024, 147.1289, 165.1887, 75.0664, 155.1542,
146.1870, 131.1724, 132.1176, 115.1301, 146.1441,
174.2004, 105.0923, 119.1188, 117.1459, 204.2247, 181.1881);
my @ala = ();
my @asp = ();
my @glu = ();
my @phe = ();
my @gly = ();
my @his = ();
my @lys = ();
my @leu = ();
my @asn = ();
my @pro = ();
my @gln = ();
my @arg = ();
my @ser = ();
my @thr = ();
my @val = ();
my @trp = ();
my @tyr = ();
my @history = ();
my $n=0;

do{

do{
my $c = 0; #carbon
my $h = 0; #hydrogen
my $n = 0; #nitrogen
my $o = 0; #oxygen
my $cc = 0; #carbon molecule counter
my $ac = 0; #molecule atom counter
my $molWt = 0; #molecular weight
my $v = 0; #valence

do{

my $randomNum = int(rand($limit));

	#Assign random number generated to a atom
	if ($randomNum == 0){
		$h++;
		$molWt = $molWt + 1.0079;
		$v++;
		$ac++;
		print "H generated\n";
		}elsif ($randomNum == 1){
		$o++;
		$molWt = $molWt + 15.9994;
		$v--;
		$v--;
		$ac++;
		print "O generated\n";
		}elsif ($randomNum == 2){
		$n++;
		$molWt = $molWt + 14.0067;
		$v--;
		$v--;
		$v--;
		$ac++;
		print "N generated\n";
		}else{
		$c++;
		$molWt = $molWt + 12.0107;
		$v--;
		$v--;
		$v--;
		$v--;
		$cc++;
		$ac++;
		print "C generated\n";
		}
	
	#Adjusts valence if -ve valence and C/O/N is added
	if ($v < 0 && $ac > 1 && ($randomNum == 1 || $randomNum == 2 || $randomNum == 3 )){
		$v++;
		$v++;
		}
	
	#Adjusts valence if thrid carbon added to -ve valence or +ve valence
	if (($cc%3) == 0 && $cc != 0 && $randomNum == 3 && $v <= -1){
		$v++;
		$v++;
		$v++;
		$v++;
		}
		
	if (($cc%3) == 0 && $cc != 0 && $randomNum == 3 && $v >= 1){
		$v++;
		$v++;
		}
		
	#Adding Hydrogens	
	if ($v <= -5){
		$h++;
		$h++;
		$h++;
		$v++;
		$v++;
		$v++;
		$ac++;
		$ac++;
		$ac++;
		}
		
print "Molecule $j : C$c-H$h-N$n-O$o\n";
print "Mol Wt: $molWt\n";
print "Net Valence: $v\n\n";

my $m=0; #variable that holds values of aminoacids to compare molecular weight to

	foreach $m (%raminoAcid){
		if ($molWt eq $m){
		print "You generated an amino acid $raminoAcid{$m}!\n";
		print "Press <enter> to continue or Ctrl-c to exit.";
		my $enter = <STDIN>;
		}
		}
			#sleep 1;

}while(!($molWt >= $aminoAcid{Trp}|| $v == 0 ));
		
$i++; #adds to 10th molecule counter
$j++; #adds to main counter
my $diff = 0;
	
	#finds the difference between molecular weight of molecule generated and aa
	foreach $n (@aa){
		if ($molWt != $n){
			$diff = $n - $molWt;
		}if($diff <= 0){
			$diff = $diff * (-1);
			}
	
	#stores the difference in a separate arrays
	if ($n == 88.0929){
	push (@ala,$diff);
	push (@history,$diff);
	}elsif ($n == 133.1024){
	push (@asp,$diff);
	push (@history,$diff);
	}elsif ($n == 147.1289){
	push (@glu,$diff);
	push (@history,$diff);
	}elsif ($n == 165.1887){
	push (@phe,$diff);
	push (@history,$diff);
	}elsif ($n == 75.0664){
	push (@gly,$diff);
	push (@history,$diff);
	}elsif ($n == 155.1542){
	push (@his,$diff);
	push (@history,$diff);
	}elsif ($n == 146.1870){
	push (@lys,$diff);
	push (@history,$diff);
	}elsif ($n == 131.1724){
	push (@leu,$diff);
	push (@history,$diff);
	}elsif ($n == 132.1176){
	push (@asn,$diff);
	push (@history,$diff);
	}elsif ($n == 115.1301){
	push (@pro,$diff);
	push (@history,$diff);
	}elsif ($n == 146.1441){
	push (@gln,$diff);
	push (@history,$diff);
	}elsif ($n == 174.2004){
	push (@arg,$diff);
	push (@history,$diff);
	}elsif ($n == 105.0923){
	push (@ser,$diff);
	push (@history,$diff);
	}elsif ($n == 119.1188){
	push (@thr,$diff);
	push (@history,$diff);
	}elsif ($n == 117.1459){
	push (@val,$diff);
	push (@history,$diff);
	}elsif ($n == 204.2247){
	push (@trp,$diff);
	push (@history,$diff);
	}elsif ($n == 181.1881){
	push (@tyr,$diff);
	push (@history,$diff);
	}

}
	
}while($i<=9);

#sorts the arrays numerically in ascending order
my @sortedHistory = sort {$a <=> $b} @history;
my @sortedala = sort {$a <=> $b} @ala;
my @sortedasp = sort {$a <=> $b} @asp;
my @sortedglu = sort {$a <=> $b} @glu;
my @sortedphe = sort {$a <=> $b} @phe;
my @sortedgly = sort {$a <=> $b} @gly;
my @sortedhis = sort {$a <=> $b} @his;
my @sortedlys = sort {$a <=> $b} @lys;
my @sortedleu = sort {$a <=> $b} @leu;
my @sortedasn = sort {$a <=> $b} @asn;
my @sortedpro = sort {$a <=> $b} @pro;
my @sortedgln = sort {$a <=> $b} @gln;
my @sortedarg = sort {$a <=> $b} @arg;
my @sortedser = sort {$a <=> $b} @ser;
my @sortedthr = sort {$a <=> $b} @thr;
my @sortedval = sort {$a <=> $b} @val;
my @sortedtrp = sort {$a <=> $b} @trp;
my @sortedtyr = sort {$a <=> $b} @tyr;

#printing out first value in sorted arrays
printf "The closest molecule to date = %.4f g/mol difference.\n\n", $sortedHistory[0];
printf "Of Last 10, closest molecule to Ala had a %.4f g/mol difference.\n", $sortedala[0];
printf "Of Last 10, closest molecule to Asp had a %.4f g/mol difference.\n", $sortedasp[0];
printf "Of Last 10, closest molecule to Glu had a %.4f g/mol difference.\n", $sortedglu[0];
printf "Of Last 10, closest molecule to Phe had a %.4f g/mol difference.\n", $sortedphe[0];
printf "Of Last 10, closest molecule to Gly had a %.4f g/mol difference.\n", $sortedgly[0];
printf "Of Last 10, closest molecule to His had a %.4f g/mol difference.\n", $sortedhis[0];
printf "Of Last 10, closest molecule to Lys had a %.4f g/mol difference.\n", $sortedlys[0];
printf "Of Last 10, closest molecule to Leu had a %.4f g/mol difference.\n", $sortedleu[0];
printf "Of Last 10, closest molecule to Asn had a %.4f g/mol difference.\n", $sortedasn[0];
printf "Of Last 10, closest molecule to Pro had a %.4f g/mol difference.\n", $sortedpro[0];
printf "Of Last 10, closest molecule to Gln had a %.4f g/mol difference.\n", $sortedgln[0];
printf "Of Last 10, closest molecule to Arg had a %.4f g/mol difference.\n", $sortedarg[0];
printf "Of Last 10, closest molecule to Ser had a %.4f g/mol difference.\n", $sortedser[0];
printf "Of Last 10, Closest molecule to Thr had a %.4f g/mol difference.\n", $sortedthr[0];
printf "Of Last 10, closest molecule to Val had a %.4f g/mol difference.\n", $sortedval[0];
printf "Of Last 10, closest molecule to Trp had a %.4f g/mol difference.\n", $sortedtrp[0];
printf "Of Last 10, closest molecule to Tyr had a %.4f g/mol difference.\n\n", $sortedtyr[0];

#emptying arrays after 10 molecules
@ala = ();
@asp = ();
@glu = ();
@phe = ();
@gly = ();
@his = ();
@lys = ();
@leu = ();
@asn = ();
@pro = ();
@gln = ();
@arg = ();
@ser = ();
@thr = ();
@val = ();
@trp = ();
@tyr = ();

#clearing counter for 10th molecule
$i = 0;

}while(!$j==0);
