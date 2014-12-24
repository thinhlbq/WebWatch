#!/usr/bin/perl

sub sendNotification{
  my $to = getConfig("To_email"); #Get from config
  my $from = getConfig("From_email"); #Get from Config
  my $subject = '[Alert] Malicious activities detected';
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

require 'checkConfig.pl';

1;
