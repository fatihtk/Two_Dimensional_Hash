use strict;
use warnings;
use Data::Dumper;
use List::Util 'sum';



my $filename_1 = shift;
my $filename_2 = shift;

#  I read a file for most modern systems, UTF-8

open( my $file1, '<:encoding(UTF-8)', $filename_1)
    or die "Can't open file: $filename_1";

open( my $file2, '<:encoding(UTF-8)', $filename_2)
    or die "Can't open file: $filename_2";

# create the (empty) data structure
#
my %sums_and_names;
my %sums_and_namess;
# the % in perl means I'm  talking about a hash,


# read line by line
while ( my $line = <$file1> ) {

    chomp $line; 
    my ($name, @grades) = split ' ', $line;
    
    
    # split on ' ', a space character, splits on any asmount of (white) space
    # there is one space.
    # strictly, we could should split on / /, the regular expression
    #
    #chomp $line;
    #my ($name, $grade_1, $grade_2, $grade_3) = split / /, $line;
    #$sum = $grade_1 + $grade_2 + $grade_3;
    #$sums_and_names{$sum}{$name} = [ $grade_1, $grade_2, $grade_3 ];
    #
    # the first part will go into the variable $name, the rest in array @grades
    # strictly I have only three grades so the following would do
    # my ($name, $grade_1, $grade_2, $grade_3) = split / /, $line;

    my $sum = sum(@grades) // 'no grades';
    #
    # since we now can handle any number of grades, not just three, we could
    # have no grades at all and thus result in `undef`
    #
    # using the function sum0 would return the value 0 instead
    #
    # I'll get away with the `undef` using in a hash assignment,
    # it will turn it into an empty string `''`

=pod

    $sums_and_names{name}{sum} = [ 'fatih', '50' ];

=cut

    #
    # here is where my task doesn't make sense
    # i am guessing:
    #
    $sums_and_names{$sum}{$name} = \@grades;
    #
    # at least we have all the data from filename_1, and the sum of the grades

}



while ( my $line = <$file2> ) {

    chomp $line; 
    my ($name, @grades) = split ' ', $line;
    

    my $sum = sum(@grades) // 'no grades';
    

=pod

    

=cut

    
    $sums_and_namess{$sum}{$name} = \@grades;
    

}

use Data::Dumper;
print Dumper \%sums_and_names;#printing data1.txt file hash table
print Dumper \%sums_and_namess;#printing data2.txt file hash table
my %intersection;

for my $key (sort {$a <=> $b} keys %sums_and_names,%sums_and_namess)
{
    $intersection{$key} = [ $sums_and_names{$key}, $sums_and_namess{$key} ]
        
}

print  Dumper \%intersection;#printing both data1.txt and data2.txt file hash table

 


