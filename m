Message-ID: <1349.119.40.3.91.1236078245.squirrel@norman.zultron.com>
Date: Tue, 3 Mar 2009 19:04:05 +0800 (CST)
From: "John Morris" <jman@zultron.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Bridge] bridge dropping packets
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

We have about 20 IP phones connecting to a Xen-based PBX, and in the past
month or two, a problem has been popping up.

About once a week, some, but not all, of the phones lose their
registration with the PBX.  The PBX can ping the unregistered phones, and
the phone ARP requests for the PBX IP are answered.  However, the UDP 5060
registration traffic originating from those phones enters the dom0's
bridge and is then dropped; it is never forwarded onto the vif associated
with the pbx.

Rebooting the dom0 is the only way I've found to fix it so far.  Reloading
the bridge kernel module doesn't seem to solve the problem, though the set
of phones that are unable to register changes (I haven't looked closely to
see if there's a pattern to it).

There's no packet filtering going on here, and this problem seems to pop
up after random, infrequent intervals.  I've verified that there are no
hosts with duplicate MAC addresses.  I can't for the life of me think of
why some packets from some IPs would be forwarded correctly and others
would not.  Another post in the archives described some similar-sounding
symptoms, but the OP found it to be an MTU-related problem; these packets
are all 356 bytes long, too short to be the problem.

Thanks-

        John

