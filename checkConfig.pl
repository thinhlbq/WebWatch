use strict;
use warnings;

sub getConfig{

  #  (my $file_name, my $key) = @_;
    my $file_name = "config.ini";
    my $key = $_[0];
    open (my $file,'<', $file_name) or die "Could not open $file_name: $!";
    my @result;
    my $ok = 0;
    while(<$file>)  {
        my $config_line = $_;
#      chop ($config_line);          # Get rid of the trailling \n
        $config_line =~ s/^\s*//;     # Remove spaces at the start of the line
        $config_line =~ s/\s*$//;     # Remove spaces at the end of the line
      #  print "\nprocessing $config_line:".($config_line eq "[$key]")."*";
        if ($ok){
          if ($config_line !~ /^\[/){
            if (($config_line !~ /^#/) && ($config_line ne "")){
              push @result,$config_line;
            }
          }else{
            return @result;
          }
        }

        if ($config_line eq "[$key]"){
          $ok = 1;
        }

    }
    return @result;
}
1;
# Call the subroutine
#my @a = getConfig("white_list");
#foreach (@a){
#  print $_."\n";
#}
