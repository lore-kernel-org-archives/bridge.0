Message-ID: <001401c3dc66$520a7da0$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
Date: Fri, 16 Jan 2004 13:24:09 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [Bridge] received packet with  own address as source address
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Hello,

I manage a number of servers all running 2.4 (same problem exists with 2.6).  My
problem is that since a few bridge versions ago, I've had to modify
net/bridge/br_fdb.c in the br_fdb_insert() function -- to get rid of the checks
that produce this error:

Jan 16 10:35:31 host15 kernel: tap_0: received packet with  own address as source
address
Jan 16 10:35:33 host15 kernel: tap_0: received packet with  own address as source
address

My specific setup is: br0 assigned an IP, with eth0 added to the bridge with no
IP.  I create tap devices, assign them no IP address but a unique MAC.  On the
other end of each tap device is an UML virtual machine's eth0.   My machines are
SuperMicro 6013 dual xeon boxes with e1000, and a 5012 box with e100 NICs.  I
don't believe this is a checksum issue raised a while back.  STP is off.  Settings
for setfd and sethello make no difference.   As soon as UML brings up its eth0
interface, the messages appear.

I'm really not a kernel hacker, but I was able to look at previous versions of the
file and more or less just comment out the "if (unlikely(fdb->is_local))"
statement.  This is what I've been using for the past few months.  It seems to
work as it did before this new check was put in place.  But, I still have a
problem where showmacs displays this for each tap interface:

  2     fe:fd:45:38:ad:f1       no                 4.88
  2     fe:fd:45:38:ad:f1       yes                0.00

Two entries for the same interface -- a local, non-expiring fdb entry, and a
non-local expiring fdb entry.  Once the non-local fdb entry times out, the tap
loses connectivity from the world.  If I log into the host machine locally and
ping an IP on the TAP interface, it comes back alive.  Same goes for logging into
the UML's console and pinging the host.  I've had this problem even with the older
bridge code.  I think all this is related to the real problem.  Looks like
something isn't detecting traffic as local, or perhaps it needs special handling
for this case?

Others have been using the identical bridge setup, minus the e100/1000 cards, and
haven't reported either of these problems.  Any advice would be appreciated.

Regards,
-Chris

