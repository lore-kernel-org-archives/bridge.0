Message-ID: <41DAD768.8020800@phreaker.net>
Date: Wed, 05 Jan 2005 01:50:32 +0800
From: ro0ot <ro0ot@phreaker.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Neighbour table overflow.
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

I had setup my bridge (br0) as below: -

ifconfig eth0 0.0.0.0
ifconfig eth5 0.0.0.0

brctl addbr br0

brctl addif br0 eth0
brctl addif br0 eth5

brctl stp br0 on

Once I connect both the interface (eth0 and eth5) to my network.  I 
can't ping to my router (connect to eth0) or ping to my other IP 
addresses (connect to eth5).  I check around and found out some messages 
pops up in /var/log/syslog file as below: -

Jan  2 10:44:22 fw01 kernel: ipt_tcpmss_target: bad length (64 bytes)
Jan  2 10:44:32 fw01 last message repeated 11 times
Jan  2 12:27:08 fw01 kernel: Neighbour table overflow.
Jan  2 12:27:11 fw01 last message repeated 9 times
Jan  2 12:27:13 fw01 kernel: NET: 10 messages suppressed.
Jan  2 12:27:13 fw01 kernel: Neighbour table overflow.
Jan  2 12:27:18 fw01 kernel: NET: 27 messages suppressed.
Jan  2 12:27:18 fw01 kernel: Neighbour table overflow.

Once I disconnect the cable from the eth5 interface, I can ping to my 
router.  I try to reconnect the cable back to the eth5 interface and run 
a ping to my router.  As the result, I can't ping the router and the 
similar messages pops up in the /var/log/syslog file.

How can I resolve this issue?

Regards,
ro0ot



