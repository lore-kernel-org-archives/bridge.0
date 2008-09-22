Message-ID: <5e1183fa0809220417m6df4bf95mab2612caf36094fb@mail.gmail.com>
Date: Mon, 22 Sep 2008 13:17:01 +0200
From: "Sebastien Douche" <sdouche@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Bridge] Best strategy for forward all packets (simulate
	promiscuous mode)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@linuxfoundation.org

Hi there :)
I would like to submit a use case we are here: our company make
network probes with 1 administravia interface and the rest in
promiscuous mode to listen traffic. I've made virtualized server with
Qemu. All Qemu instances (with 2 tap) listen on:

br0 (admin int)
br1 (receive traffic)

The need is each tap on br1 must listen *all* traffic (unicast,
multicast...). For this, I sets maximum message age to 0. Do you think
is the best approach? I surprised I didn't find the same parameter on
FreeBSD, so my solution is good?


Thanks for your idea :)

-- 
Seb
