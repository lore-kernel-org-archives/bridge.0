Return-Path: <bdschuym@pandora.be>
Message-ID: <4F8722D4.5090203@pandora.be>
Date: Thu, 12 Apr 2012 20:45:40 +0200
From: Bart De Schuymer <bdschuym@pandora.be>
MIME-Version: 1.0
References: <1334183679.3337.14.camel@synlap.andoburg.net>
In-Reply-To: <1334183679.3337.14.camel@synlap.andoburg.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] ebtables on mac80211
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Wilco Baan Hofman <wilco@baanhofman.nl>
Cc: linux-wireless@vger.kernel.org, bridge@lists.linuxfoundation.org

Op 12/04/2012 0:34, Wilco Baan Hofman schreef:
> Hi,
>
> I'm looking to implement hooks to ebtables in the mac80211 wireless
> stack.
>
> I'm trying to find the best approach for doing this.. basically what I
> want to be able to have is clients being able to communicate, but not
> ARP spoofing the gateway or setting up a rogue DHCP.
>
> As it's currently implemented, there's some sort of internal bridge
> functionality within the wireless stack in net/mac80211/rx.c at around
> ieee802_deliver_skb(), where every ethernet packet essentially gets
> routed among wireless clients.
>
> If I understand ebtables correctly, an forward event is triggered for
> every packet to every interface, right? So essentially, this should do
> the same, except that for every wireless client would be a forward from
> the wireless interface to the wireless interface.
>
> What would be the best way to implement this and in what way would it be
> acceptable upstream?
You can add a new ebtables table, requiring minimal changes to the 
userland tool. You can start by adding a table called something like 
"filter-wireless" with a built-in chain on NF_BR_FORWARD. See 
net/bridge/netfilter/ebtable_broute.c: it contains the code that adds 
the broute table with a built-in chain on NF_BR_BROUTING. This approach 
has minimal impact since it doesn't use netfilter hooks (no call to 
nf_register_hooks) and uses a built-in chain that ebtables understands.
If you want to use the netfilter infrastructure, you'll probably need a 
new protocol family. See net/bridge/netfilter/ebtable_filter.c in that case.

cheers,
Bart


-- 
Bart De Schuymer
www.artinalgorithms.be

