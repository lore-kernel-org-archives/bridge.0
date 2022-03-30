Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=wvcJ0kbG7fzM0+XeGFxiUHTL6MCcu+q18zHDXJW5yos=;
 b=DjzmS7pHnROcTaKdexi/iWo7fVkbtNGhniTdoIGJ0t6qo7krnmU2sgexTjdJvC0z8y
 kR9K2KlD1of3sFw17MvPvqgpwI+z8Zbx+GFSq6QmSoldGQ/WKYQkVOy2UTTAx+uSGOFI
 D4cnj/jWykSuQOwsfmK9EkXpR9QT+YjNvckx/QUvPFKdShah1RihkENhXzsHx7ehcuYx
 bBm2U3UyLgT2Mp6hdfiRyYdf911KmccuCZVZmrbHwtGU7M9UisqoS0RLHuNDXVOK/8R6
 gLF94hUr2XzDwT6NLBQCHF1OCxrzqJsCOZX8Pewl1qrdQYK1EP1yNO5ztv12mYLCqSSz
 NeNw==
Message-ID: <c512e765-f411-9305-013b-471a07e7f3ff@blackwall.org>
Date: Wed, 30 Mar 2022 19:16:42 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20220329114052.237572-1-wintera@linux.ibm.com>
 <20220329175421.4a6325d9@kernel.org>
 <d2e45c4a-ed34-10d3-58cd-01b1c19bd004@blackwall.org>
 <c1ec0612-063b-dbfa-e10a-986786178c93@linux.ibm.com>
 <20220330085154.34440715@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220330085154.34440715@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2] veth: Support bonding events
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>, Alexandra Winter <wintera@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Hangbin Liu <liuhangbin@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jiri Pirko <jiri@nvidia.com>

On 30/03/2022 18:51, Jakub Kicinski wrote:
> On Wed, 30 Mar 2022 13:14:12 +0200 Alexandra Winter wrote:
>>>> This patch in no way addresses (2). But then, again, if we put 
>>>> a macvlan on top of a bridge master it will shotgun its GARPS all 
>>>> the same. So it's not like veth would be special in that regard.
>>>>
>>>> Nik, what am I missing?
>>>
>>> If we're talking about macvlan -> bridge -> bond then the bond flap's
>>> notify peers shouldn't reach the macvlan.
> 
> Hm, right. I'm missing a step in my understanding. As you say bridge
> does not seem to be re-broadcasting the event to its master. So how
> does Alexandra catch this kind of an event? :S
> 
> 	case NETDEV_NOTIFY_PEERS:
> 		/* propagate to peer of a bridge attached veth */
> 		if (netif_is_bridge_master(dev)) {  
> 
> IIUC bond will notify with dev == bond netdev. Where is the event with
> dev == br generated?
> 

Good question. :)

>>> Generally broadcast traffic
>>> is quite expensive for the bridge, I have patches that improve on the
>>> technical side (consider ports only for the same bcast domain), but you also
>>> wouldn't want unnecessary bcast packets being sent around. :)
>>> There are setups with tens of bond devices and propagating that to all would be
>>> very expensive, but most of all unnecessary. It would also hurt setups with
>>> a lot of vlan devices on the bridge. There are setups with hundreds of vlans
>>> and hundreds of macvlans on top, propagating it up would send it to all of
>>> them and that wouldn't scale at all, these mostly have IP addresses too.
> 
> Ack.
> 
>>> Perhaps we can enable propagation on a per-port or per-bridge basis, then we
>>> can avoid these walks. That is, make it opt-in.
> 
> Maybe opt-out? But assuming the event is only generated on
> active/backup switch over - when would it be okay to ignore
> the notification?
> 

Let me just clarify, so I'm sure I've not misunderstood you. Do you mean opt-out as in
make it default on? IMO that would be a problem, large scale setups would suddenly
start propagating it to upper devices which would cause a lot of unnecessary bcast.
I meant enable it only if needed, and only on specific ports (second part is not
necessary, could be global, I think it's ok either way). I don't think any setup
which has many upper vlans/macvlans would ever enable this.

>>>>> It also seems difficult to avoid re-bouncing the notifier.  
>>>>
>>>> syzbot will make short work of this patch, I think the potential
>>>> for infinite loops has to be addressed somehow. IIUC this is the 
>>>> first instance of forwarding those notifiers to a peer rather
>>>> than within a upper <> lower device hierarchy which is a DAG.  
>>
>> My concern was about the Hangbin's alternative proposal to notify all
>> bridge ports. I hope in my porposal I was able to avoid infinite loops.
> 
> Possibly I'm confused as to where the notification for bridge master
> gets sent..

IIUC it bypasses the bridge and sends a notify peers for the veth peer so it would
generate a grat arp (inetdev_event -> NETDEV_NOTIFY_PEERS).
