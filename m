Message-ID: <41DAD4CD.7040606@softhome.net>
Date: Wed, 05 Jan 2005 01:39:25 +0800
From: WL Siew <wlsiew@softhome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Neighbour table overflow
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi,

I had successfully setup my bridge (br0) but after few minutes the br0 
interface seems not working.

ifconfig eth0 0.0.0.0
ifconfig eth5 0.0.0.0

brctl addbr br0

brctl addif br0 eth0
brctl addif br0 eth5

brctl stp br0 on

I check on my system's /var/log/syslog file.  It shows something strange 
messages as below: -

Jan  2 10:44:22 fw01 kernel: ipt_tcpmss_target: bad length (64 bytes)
Jan  2 10:44:32 fw01 last message repeated 11 times
Jan  2 12:27:08 fw01 kernel: Neighbour table overflow.
Jan  2 12:27:11 fw01 last message repeated 9 times
Jan  2 12:27:13 fw01 kernel: NET: 10 messages suppressed.

I unplug the network cable connected to the eth5 and run a ping to my 
router...the network is up again...I am able to ping my router.

Then, I plug the network cable to the eth5 interface again...I run the 
ping to my router and suddenly I can't ping my router.  The same error 
messages pops out in the /var/log/syslog file.

How can I solve this issue?

Regards,
ro0ot


