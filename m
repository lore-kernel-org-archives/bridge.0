Message-ID: <002a01c48b58$1eb27010$7901a8c0@hpmatt>
From: "matt" <matt@iazone.net>
References: <562736197.20040817182800@rbcmail.ru>
Subject: [Bridge] bridge's STP problem about topology change
Date: Thu, 26 Aug 2004 18:33:25 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi, All:

    I am tring to use STP function on bridge device that refer the
BRIDGE-STP-HOWTO. And I use PING program to test it from PC1 to
PC2. But the forward function is become too long when bridge topology
change.

How can I tuning the STP to make client connect to another again faster?

I have been use follow command. But it seen not this issue. Bcause, if I run
" arp -d " on PC1 and the reply will be immediately.  Or if I run one ping
from
PC3 to PC2 (PC3 didn't have PC2 arp entry). The PC1 will also get reply
 immediately.

Does any one know what's problem?

/usr/sbin/brctl setbridgeprio mybr 0
/usr/sbin/brctl sethello mybr 1
/usr/sbin/brctl setmaxage mybr 4
/usr/sbin/brctl setfd mybr 4
/usr/sbin/brctl stp mybr on

Two bridge machines are install with linux-2.4.26 and use the ebtables patch
(ebtables-brnf-6-vs-2.4.26).

Network environment:

PC1 --------- Bridge 1 ----  PC2
             |----- Bridge 2 ---|
PC3 ----

Very thank for your help

Regards,
Matt.




