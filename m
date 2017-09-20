Return-Path: <dsahern@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=hqQal7+aMWkc/nxzTzNB1WavlQYjMaMMbnbPZX4z8VY=;
	b=YkgtkiMwDQ0ZQFPfc+L5KxohloYTl6dNYlU7csPVyD3Xme80FIhDLbqqqNRmwnSyU8
	3DDo2bhGmKqygms7QugUEw5XsjrudDcuj/WbSBwwjOPauzjfhrS99shO8Yy0eGEmK24V
	ILjzJ0AeP2ycDBoRg+jC6Syg+t+zHnbt7rDDxV7YczOIWNyMhIJ/Cq3VDZgTlnX/bKf/
	ZU/85xIab4tyNv+UJ1KXSpXCJBGNHfSmvdUojMNafuyh3pFB9J9Rq8BDYAMJ8m9lrSKY
	/gVj+z2lIeaGTLnGOe/UUTszoUnGW36iD9aRDoXxUNBibdWIWNoWCs0M6Ru/8tlH2eEJ
	QGnQ==
References: <m3zi9vbrfp.fsf@luffy.cx>
	<20170916141833.28344-1-vincent@bernat.im>
	<20170920.140956.781667692297467325.davem@davemloft.net>
From: David Ahern <dsahern@gmail.com>
Message-ID: <16e5566a-909d-ba83-7637-1fb6c93126bc@gmail.com>
Date: Wed, 20 Sep 2017 15:57:16 -0600
MIME-Version: 1.0
In-Reply-To: <20170920.140956.781667692297467325.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2] bridge: also trigger RTM_NEWLINK
 when interface is released from bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>, vincent@bernat.im
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On 9/20/17 3:09 PM, David Miller wrote:
> From: Vincent Bernat <vincent@bernat.im>
> Date: Sat, 16 Sep 2017 16:18:33 +0200
> 
> David, I am CC:'ing you because you've done work in this area over the
> past year.  I'm applying this patch, it's been sitting since the 16th
> and likes entirely correct to me.  But if you have objections just let
> me know.
> 
>> Currently, when an interface is released from a bridge via
>> ioctl(), we get a RTM_DELLINK event through netlink:
>>
>> Deleted 2: dummy0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>>     link/ether 6e:23:c2:54:3a:b3
>>
>> Userspace has to interpret that as a removal from the bridge, not as a
>> complete removal of the interface. When an bridged interface is
>> completely removed, we get two events:
>>
>> Deleted 2: dummy0: <BROADCAST,NOARP> mtu 1500 master bridge0 state DOWN
>>     link/ether 6e:23:c2:54:3a:b3
>> Deleted 2: dummy0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default
>>     link/ether 6e:23:c2:54:3a:b3 brd ff:ff:ff:ff:ff:ff
>>
>> In constrast, when an interface is released from a bond, we get a
>> RTM_NEWLINK with only the new characteristics (no master):
>>
>> 3: dummy1: <BROADCAST,NOARP,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UNKNOWN group default
>>     link/ether ae:dc:7a:8c:9a:3c brd ff:ff:ff:ff:ff:ff
>> 3: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default
>>     link/ether ae:dc:7a:8c:9a:3c brd ff:ff:ff:ff:ff:ff
>> 4: bond0: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
>>     link/ether ae:dc:7a:8c:9a:3c brd ff:ff:ff:ff:ff:ff
>> 3: dummy1: <BROADCAST,NOARP> mtu 1500 qdisc noqueue state DOWN group default
>>     link/ether ae:dc:7a:8c:9a:3c brd ff:ff:ff:ff:ff:ff
>> 3: dummy1: <BROADCAST,NOARP> mtu 1500 qdisc noqueue state DOWN group default
>>     link/ether ca:c8:7b:66:f8:25 brd ff:ff:ff:ff:ff:ff
>> 4: bond0: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
>>     link/ether ae:dc:7a:8c:9a:3c brd ff:ff:ff:ff:ff:ff
>>
>> Userland may be confused by the fact we say a link is deleted while
>> its characteristics are only modified. A first solution would have
>> been to turn the RTM_DELLINK event in del_nbp() into a RTM_NEWLINK
>> event. However, maybe some piece of userland is relying on this
>> RTM_DELLINK to detect when a bridged interface is released. Instead,
>> we also emit a RTM_NEWLINK event once the interface is
>> released (without master info).
>>
>> Deleted 2: dummy0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>>     link/ether 8a:bb:e7:94:b1:f8
>> 2: dummy0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default
>>     link/ether 8a:bb:e7:94:b1:f8 brd ff:ff:ff:ff:ff:ff
>>
>> This is done only when using ioctl(). When using Netlink, such an
>> event is already automatically emitted in do_setlink().

The DELLINK is for AF_BRIDGE family (ifi_family). Adding family to
print_linkinfo and running the monitor I get:


[LINK]family 0: 35: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc
noqueue master br0 state UNKNOWN group default
    link/ether d6:c3:73:86:3c:73 brd ff:ff:ff:ff:ff:ff

[LINK]family 7: 35: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500
master br0 state UNKNOWN
    link/ether d6:c3:73:86:3c:73

[LINK]Deleted family 7: 35: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu
1500 master br0 state UNKNOWN
    link/ether d6:c3:73:86:3c:73

[LINK]family 0: 35: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc
noqueue state UNKNOWN group default
    link/ether d6:c3:73:86:3c:73 brd ff:ff:ff:ff:ff:ff

And that seems correct. So I think the RTM_NEWLINK added by this patch
should not be needed.
