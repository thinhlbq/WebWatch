use Digest::MD5;
use File::stat;
use DateTime;
#use warning;

sub checking(){
  my $dt = DateTime->now;
  my $now = join '-', $dt->ymd;

  #open(my $fh, '>>' ,'logs/'.$now);
  open(my $f_snapshot,'<','snapshots/2014-12-06-04:16:14')
    or die "Could not open file";
  @snapshots = <$f_snapshot>;
  # It should be replaced by the output from configuration module
  foreach (@snapshots){

    my @part= split /:/,$_;
    print ">>> $part[0] =";

    my $filename = shift || $part[0];
    open (my $fh, '<', $filename) or die "Can't open '$filename': $!";
    binmode ($fh);
    $hash = Digest::MD5->new->addfile($fh)->hexdigest;


    if ($hash == $part[1]){
      print " same ; $hash = $part[1]\n";
    }else{
      print " changed ; $hash = $part[1]\n";
    }
  }
  close $f_snapshot;
}

print "Checking snapshot \n";
checking();
print "[+] Done!";
