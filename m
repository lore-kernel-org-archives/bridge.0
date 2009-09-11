MIME-Version: 1.0
Date: Fri, 11 Sep 2009 19:52:02 +0530
Message-ID: <cfeab66d0909110722v504f13ccv230309e2599ab723@mail.gmail.com>
From: ratheesh k <ratheesh.ksz@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bridge] qos queue on bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

i bridged eth0 (ethernet ) and ap0 (wireless )  using  brctl command .
The bridge interface is br0 . i connected a linux desktop (Machine A
) to eth0 and  Machine B to ap0 .

I have ingress qdisc and egress qdisc on br0 .

if i ping MAchine A from Machine B , will the icmp pkts will go thru
any of the qdisc ( egress or ingress ) ??????
