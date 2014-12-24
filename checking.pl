use Digest::MD5;
use File::stat;
use DateTime;
#use warning;

sub checking(){
  my $dt = DateTime->now(time_zone => "local");
  my $log_text = "-----------".$dt->ymd."|".$dt->hms."------------\n";
  my $ok = true;
  open(my $f_log, '>>' ,'logs/'.$dt->ymd);
  open(my $f_snapshot,'<',getConfig("snapshot"))
    or die "Could not open file";
  @snapshots = <$f_snapshot>;
  # Compare from snapshot with current files.
  foreach (@snapshots){
  #  print "Processing ".$_."\n";
    my @part= split /:/,$_;
    my $filename = shift || $part[0];

    # check if file or folder !!!
    if (-f $filename){
      open (my $fh, '<', $filename);# or die "Can't open '$filename': $!";
      binmode ($fh);
      $hash = Digest::MD5->new->addfile($fh)->hexdigest;
      if ($hash == $part[1]){
    #    print " same ; $hash = $part[1]\n";
      }else{
        $log_text .= "$part[0] = changed ; ".$hash." = ".$part[1]."\n";
      }
    }
    if (-d $filename){
      my $inf = stat($filename);
      if ($inf->mtime != $part[2]){
        $log_text .= "$part[0] = changed ; ".$inf->mtime." = ".$part[2]."\n";
      }
    }
  }


  if ($ok){
    print $f_log $log_text;
  #  sendNotification($log_text);
  }

  close $f_snapshot;
  close $f_log;
}

require 'sendNotification.pl';
require 'checkConfig.pl';

print "Checking snapshot \n";
checking();
print "[+] Done!";
