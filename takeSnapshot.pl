use Digest::MD5;
use File::stat;
use DateTime;
#use warning;

sub takeSnapshot(){
  my $dt = DateTime->now;
  my $now = join '-', $dt->ymd, $dt->hms;
  print 'snapshots/'.$now."\n";
  open(my $fh, '>' ,'snapshots/'.$now);
  # It should be replaced by the output from configuration module
  #my @listFiles = ('/etc/passwd','/etc/xtab','/etc/ttys','test/');
  my @listFiles = getConfig("folders");
  foreach (@listFiles){
    print "processing $_";
    if (-f $_){
      open (my $filetaking, '<', $_);
      binmode ($filetaking);
      my $hash = Digest::MD5->new->addfile($filetaking)->hexdigest;
      my $inf = stat($_);
      print $fh "$_:$hash:".$inf->ctime.":".$inf->mtime.":".$inf->size."\n";
      print "Snapshoting : $_\n";
    }
    if (-d $_){
      my $inf = stat($_);
      print $fh "$_:".$inf->ctime.":".$inf->mtime.":".$inf->size."\n";
      print "Snapshoting : $_\n";
    }
  }
  close $fh;
}
require 'checkConfig.pl';
print "Taking snapshot to ";
takeSnapshot();
print "[+] Done!";
