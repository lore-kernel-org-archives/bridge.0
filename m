Date: Sun, 10 May 2009 11:50:12 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20090510115012.4c842f87@nehalam>
In-Reply-To: <a62fd16c0905100637n1107c9degd8212e9e649cba4e@mail.gmail.com>
References: <a62fd16c0905100637n1107c9degd8212e9e649cba4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Linux Bridge Forward STP?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Steven Williamson <steven43126@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Sun, 10 May 2009 14:37:56 +0100
Steven Williamson <steven43126@gmail.com> wrote:

> Hi,
> 
> If I have 2 switches already using RSTP with only a single link between
> them. Then add a redundant link using a Linux bridge with STP turned off.
> Will the Linux bridging code forward the RSTP BPDU's so the other switches
> realize there is a new path to the root bridge, and hopefully block one of
> the ports ?
> 
> 
> The exact secnario is an ethernet segment spanning 2 datacenter's via a
> fibre link. We'd like to add redundancy using a linux bridge (bridging to a
> VPN tap device and routing over the net) but have since discoverd the Linux
> code does not support RSTP yet.
> 
> p.s
> 
> Many thanks to the developers of the Linux briding code!
> 
> Regards
> Steven Williamson.

Turn on STP in Linux bridge in your case. Otherwise Linux bridge will
eat the RSTP BPDU's

-- 
