Return-Path: <advax@triumf.ca>
Date: Fri, 20 Jan 2012 19:20:08 -0800 (PST)
From: Andrew Daviel <advax@triumf.ca>
Message-ID: <Pine.LNX.4.64.1201201916170.5507@andrew.triumf.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Bridge] Packet loss in bridging firewall
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org


We have a machine running Scientific Linux 6.1 (RHEL recompile)
with 2.6.32-131.21.1.el6.x86_64 kernel and bridge-utils-1.2-9.el6.x86_64

It's a 12-core Xeon.
It has a Mellanox Technologies MT26448 10g NIC and
an Emulex Corporation OneConnect 10Gb NIC and bridges between them.

We see occasional packet loss through the bridge in production, which 
appears to get worse when the link is busy, though it is nowhere near the 
10g capacity.

If I do a flood ping through the bridge, there is no significant loss
for about 10-30 seconds, then bursts of packets are lost every second

I have adjusted kernel tuning in accordance with e.g.
http://fasterdata.es.net/fasterdata/host-tuning/linux/
and the Mellanox and Emulex user guides. It seems to make no difference to the 
behaviour.

Any suggestions ?
Has anyone seen anything similar ?

-- 
Andrew Daviel, TRIUMF, Canada
Tel. +1 (604) 222-7376  (Pacific Time)
Network Security Manager
