Date: Tue, 4 Jan 2005 15:30:53 -0500 (EST)
From: "Christopher E. Cramer" <chris.cramer@duke.edu>
Subject: Re: [Bridge] Neighbour table overflow
In-Reply-To: <41DAD4CD.7040606@softhome.net>
Message-ID: <Pine.LNX.4.58.0501041528580.8716@zen.oit.duke.edu>
References: <41DAD4CD.7040606@softhome.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: WL Siew <wlsiew@softhome.net>
Cc: bridge@lists.osdl.org


we've had similar issues on a large scanning machine.  nothing like trying 
to keep 100,000 entries in your arp cache.

try the following (at least under redhat w/ 2.4 kernels):

echo 100000 > /proc/sys/net/ipv4/neigh/default/gc_thresh3

this will increase the max size of the neighbor table to 100000

-c

--
Christopher E. Cramer, Ph.D.
Information Technology Security Officer
Duke University,  Office of Information Technology


On Wed, 5 Jan 2005, WL Siew wrote:

> Hi,
> 
> I had successfully setup my bridge (br0) but after few minutes the br0 
> interface seems not working.
> 
> ifconfig eth0 0.0.0.0
> ifconfig eth5 0.0.0.0
> 
> brctl addbr br0
> 
> brctl addif br0 eth0
> brctl addif br0 eth5
> 
> brctl stp br0 on
> 
> I check on my system's /var/log/syslog file.  It shows something strange 
> messages as below: -
> 
> Jan  2 10:44:22 fw01 kernel: ipt_tcpmss_target: bad length (64 bytes)
> Jan  2 10:44:32 fw01 last message repeated 11 times
> Jan  2 12:27:08 fw01 kernel: Neighbour table overflow.
> Jan  2 12:27:11 fw01 last message repeated 9 times
> Jan  2 12:27:13 fw01 kernel: NET: 10 messages suppressed.
> 
> I unplug the network cable connected to the eth5 and run a ping to my 
> router...the network is up again...I am able to ping my router.
> 
> Then, I plug the network cable to the eth5 interface again...I run the 
> ping to my router and suddenly I can't ping my router.  The same error 
> messages pops out in the /var/log/syslog file.
> 
> How can I solve this issue?
> 
> Regards,
> ro0ot
> 
> 
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> http://lists.osdl.org/mailman/listinfo/bridge
> 
