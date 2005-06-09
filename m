Date: Thu, 9 Jun 2005 11:17:33 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Multicast
Message-ID: <20050609111733.79523dd0@unknown-215.office.pdx.osdl.net>
In-Reply-To: <046c01c56d00$52945e90$825810ac@amon>
References: <42A8058C.2060408@ya.com>
	<046c01c56d00$52945e90$825810ac@amon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Tomo Ceferin <tomo@activetools.si>
Cc: bridge@lists.osdl.org

On Thu, 9 Jun 2005 16:33:44 +0200
"Tomo Ceferin" <tomo@activetools.si> wrote:

> True. However, allow me to make two assumptions (true in our case):
> 1) Bridge implements set_multicast_list() and uses it to learn multicast
> groups.
> 2) IPv4 or IPv6 is attached to bridge - both provide IGMP snooping which in
> turn feeds bridge with multicast lists through set_multicast_list().
> 
> With both above assumptions true, bridge now has awareness of which ports
> belong to which multicast groups, hence removing the need to flood all ports.
> 
> Am I getting something wrong?

1. Bridge does more than IP and so it knows nothing about IP protocols. Many
   times a bridge has no IP address at all.

2. The bridge machine itself may not be listening the multicast traffic but
   needs to forward it.

3. If you need to do some filtering of multicast, than use netfilter (ebtables)
   to restrict the traffic.
