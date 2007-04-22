Message-ID: <60846.193.196.136.17.1177202163.squirrel@sleon.dyndns.org>
Date: Sun, 22 Apr 2007 00:36:03 -0000 (UTC)
From: "Roman Glebov" <sleon@sleon.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Bridge] linux bridge does not bridge bpdu packets 
Reply-To: sleon@sleon.dyndns.org
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hallo,

i have here transparent linux based bridge.

The problem is : all stp packets which come to one side of the Bridge are
not forwarded to the other side. Which distrubs stp when this device is
put inbetween of two stp capable devices.
It forwards all traffik through it.
Normal udp/tcp traffik is forwarded.

I switched stp on it "off" so it does not participate in Spanning tree
communications.

It is a very simple setup :
br0 with eth0 and eht1 as ports. without any additional firewall rules.


I am using 2.6.18-4-686 debian kernel(testing).

i even did setfd br0 0.


What am i doing wrong ?

Do i need to use ebtables to explicitely forward the traffic?


With regards,
Roman Glebov
