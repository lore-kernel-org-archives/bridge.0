MIME-Version: 1.0
Date: Thu, 8 Sep 2011 15:54:46 +0545
Message-ID: <CAJ8tRG_N0wQTUtMLNxpyTYG-hM+y=kwG-6Bs=WgSakiO6WBaYQ@mail.gmail.com>
From: Tek Bahadur Limbu <teklimbu@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bridge] Bonding 2 interfaces and channeling the output to a bridge
	interface
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi all,

I have a Debian Linux machine having 3 network interfaces (eth1, eth2, eth3).
What I want to do is to make eth1 and eth2 as bonded interface (bond0)
with Active Fail-over.

Next I want to add eth3 and bond0 (eth1 and eth2) interfaces as a bridge.

The reason for the above config is because I have 2 physical links in
layer 2 (Trunkports). Only 1 of the physical links can be used at the
same time.
These links are connected to my Access Points but only 1 link can be
used at a given time.

Link1 ------> eth1 (bond0)
                                     eth3 (br0)  -------------> Wifi
Access Point
Link2 ------> eth2 (bond0)


eth1 and eth2 -->bond0
br0 will bridge eth3 and bond0

Can Active Fail-over with the 2 physical links be achieved using the
setup above?

Any suggestions will be great.

Thanks,
Tek
