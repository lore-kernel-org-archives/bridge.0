Message-ID: <49F8C4C3.9020504@gmail.com>
Date: Wed, 29 Apr 2009 23:21:07 +0200
From: Jochen Hebbrecht <jochenhebbrecht@gmail.com>
MIME-Version: 1.0
References: <20090428124009.GA26387@kallisti.us>
	<db99f77d0904280552n5717cd86x6cc045a9f64e5a45@mail.gmail.com>
	<20090428133702.GA26738@kallisti.us> <49F73E9A.7090706@gmail.com>
	<2e59e6970904281200u44e3ebbfga0f074dfaa78c1ab@mail.gmail.com>
	<49F77248.1050800@gmail.com>
	<2e59e6970904281600u42142392vb8e0eb45c4ede15c@mail.gmail.com>
	<49F87D4E.4060705@gmail.com> <20090429162651.GA9455@kallisti.us>
	<49F882F9.4010100@gmail.com> <20090429165329.GA9893@kallisti.us>
In-Reply-To: <20090429165329.GA9893@kallisti.us>
Content-Type: multipart/alternative;
	boundary="------------050104010705090903030504"
Subject: Re: [Bridge] Ubuntu: network bridging between wireless and wired
 connection fails
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ross Vandegrift <ross@kallisti.us>
Cc: bridge@lists.linux-foundation.org

This is a multi-part message in MIME format.
--------------050104010705090903030504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ross Vandegrift schreef:
> On Wed, Apr 29, 2009 at 06:40:25PM +0200, Jochen Hebbrecht wrote:
>   
>> Yes, it is plugged in ( Ubuntu says: link is ready ).
>> I also tried statically, but no improvements :-( ...
>>     
>
> Is your wireless access point also bridging between the wired and the
> wireless?  If so, then you have two bridges circulating packets
> between the wired and wireless networks.
>   
What do you mean with "wireless access point"? My eth1? I think the 
bridge is ok. In one of my previous mails, you see the sniffer logging 
DHCP discovers on eth0 AND eth1
>
>     You should either turn on STP so loops can be detected and prevented
>     or unplug eth0 to simulate that scenario.
>
If I unplug eth0, the situation stays the same. Bridge is ok. But no IP 
received  ...

--------------050104010705090903030504
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Ross Vandegrift schreef:
<blockquote cite="mid:20090429165329.GA9893@kallisti.us" type="cite">
  <pre wrap="">On Wed, Apr 29, 2009 at 06:40:25PM +0200, Jochen Hebbrecht wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Yes, it is plugged in ( Ubuntu says: link is ready ).
I also tried statically, but no improvements :-( ...
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Is your wireless access point also bridging between the wired and the
wireless?  If so, then you have two bridges circulating packets
between the wired and wireless networks.
  </pre>
</blockquote>
What do you mean with "wireless access point"? My eth1? I think the
bridge is ok. In one of my previous mails, you see the sniffer logging
DHCP discovers on eth0 AND eth1<br>
<blockquote cite="mid:20090429165329.GA9893@kallisti.us" type="cite">
  <blockquote
 style="border-left: 2px solid rgb(0, 0, 255); padding-left: 5px; margin-left: 5px; margin-right: 0px;">You
should either turn on STP so loops can be detected and prevented<br>
or unplug eth0 to simulate that scenario.</blockquote>
</blockquote>
If I unplug eth0, the situation stays the same. Bridge is ok. But no IP
received&nbsp; ...
</body>
</html>

--------------050104010705090903030504--
