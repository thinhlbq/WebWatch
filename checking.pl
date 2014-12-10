use Digest::MD5;
use File::stat;
use DateTime;
#use warning;

sub checking(){
  my $dt = DateTime->now(time_zone => "local");
  my $log_text = "-----------".$dt->ymd."|".$dt->hms."------------\n";
  my $ok = true;
  open(my $f_log, '>>' ,'logs/'.$dt->ymd);
  #open(my $fh, '>>' ,'logs/'.$now);
  open(my $f_snapshot,'<','snapshots/2014-12-06-04:16:14')
    or die "Could not open file";
  @snapshots = <$f_snapshot>;
  # It should be replaced by the output from configuration module
  foreach (@snapshots){
    my @part= split /:/,$_;
    my $filename = shift || $part[0];
    open (my $fh, '<', $filename);# or die "Can't open '$filename': $!";
    binmode ($fh);
    $hash = Digest::MD5->new->addfile($fh)->hexdigest;
    if ($hash == $part[1]){
  #    print " same ; $hash = $part[1]\n";
    }else{
      $log_text .= "$part[0] = changed ; ".$hash." = ".$part[1]."\n";
    }
  }


  if ($ok){
    print $f_log $log_text;
    sendNotification($log_text);
  }

  close $f_snapshot;
  close $f_log;
}

require 'sendNotification.pl';

print "Checking snapshot \n";
checking();
print "[+] Done!";
