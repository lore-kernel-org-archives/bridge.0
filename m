Message-ID: <8135BF451955D5119DE200203567D82A060ED71E@ge-muc-exch-01.azlan.ger>
From: Josef Brunner <Josef.Brunner@azlan.com>
Subject: RE: [Bridge] Bridge benchmarks?
Date: Thu, 29 Sep 2005 08:17:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: 'Ben Greear ' <greearb@candelatech.com>, "'bridge@lists.osdl.org '" <bridge@lists.osdl.org>

same thing with me.

hw setup, x86 pentium driven box, 512 ram and other standard things (benhur
box). but i was not able to have more than 900mbps (but with some VERY basic
firewalling activated), 900 was even the peak. kernel is stack protected
(pax) with some basic rules for grsec submitted. kernel flags
(/proc/sys/net/ipv4/..... almost standard, just routing enabled)

would also love to hear some configuration tuning tips, as i thing hw tuning
is the easier way ;)

test was performed using a trunk port (between two cisco boxes. cisco -
bridge - cisco)

brgds
josef

-----Original Message-----
From: Ben Greear
To: bridge@lists.osdl.org
Sent: 28.09.2005 19:15
Subject: [Bridge] Bridge benchmarks?

I am curious if anyone has benchmarks for bridging GigE networks.

On my hardware, I am unable to go much beyound about 920Mbps
(bi-directional).  I was hoping for 970+ Mbps (MTU sized pkts).

If anyone has been able to get these sorts of numbers, I'd love
to hear the hardware setup and/or tuning parameters.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

 <<ATT222785.txt>> 

_______________________________________________________________________________
Disclaimer

This message may contain confidential information solely for its
intended recipients and others may not distribute, copy or use it. If
you have received this communication in error please tell us either by
return e-mail or at the numbers above and delete it, and any copies of
it.

