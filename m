Date: Thu, 5 Aug 2004 09:55:36 +0200 (CEST)
From: Henrik Nordstrom <hno@marasystems.com>
In-Reply-To: <200408050812.45887.bdschuym@pandora.be>
Message-ID: <Pine.LNX.4.61.0408050953440.30895@filer.marasystems.com>
References: <200408042254.41978.bdschuym@pandora.be>
	<Pine.LNX.4.44.0408042300540.18907-100000@filer.marasystems.com>
	<33159.199.107.159.238.1091683285.squirrel@www.osdl.org>
	<200408050812.45887.bdschuym@pandora.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Bridge] Re: Any way of knowing a packet's been defragmented
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Bart De Schuymer <bdschuym@pandora.be>
Cc: netfilter-devel <netfilter-devel@lists.netfilter.org>, bridge <bridge@osdl.org>, shemminger@osdl.org

On Thu, 5 Aug 2004, Bart De Schuymer wrote:

> It has nothing to do with ebtables. It's all about connection tracking of ipv4
> packets on a transparent bridging firewall. Ct defragments packets, on the
> ipv4 PREROUTING hook, because it makes things easier. Ct on a transparent
> bridge is something people need.

The question on why the bridge needs to drop oversized fragments instead 
of simply letting iptables fragment them remains...

Regards
Henrik
