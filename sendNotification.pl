#!/usr/bin/perl

sub sendNotification{
  $to = 'lbqthinh@vncert.vn'; #Get from config
  $from = 'WebWatch@attt.org'; #Get from Config
  $subject = '[Alert] Malicious activities detected';
  my $message = $_[0];

  open(MAIL, "|/usr/sbin/sendmail -t"); #Need to check the configuration of that server"

  # Email Header
  print MAIL "To: $to\n";
  print MAIL "From: $from\n";
  print MAIL "Subject: $subject\n\n";
  # Email Body
  print MAIL $message;

  close(MAIL);
  print "Email Sent Successfully with contnet\n$message---";
}

1;
