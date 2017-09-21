Return-Path: <roopa@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=w2SBXBfAh/AlgS43dT76iS8HWY+lQa+etAcWcNZJL2M=;
	b=b7qz1j9HAWNEcNSiegPs/vWX/QishHIHoyGcukOk2jWN1C97QmLcC8CFaY4aM2qpKn
	G2dh5D3Rc8U+MO3bOwhxoo67P4azU4iPZLa9OeaKmPGK9jTRFE1pWqLWO1/V2wuGg9bN
	wLDM6fjgTABYzMPOrcLvZ99Tnpln0d2WDEnLk=
MIME-Version: 1.0
In-Reply-To: <0cdf06b9-e67d-c035-e0f1-c4eb143bf631@gmail.com>
References: <20170920162140.369bb198@xeon-e3>
	<20170921100525.20395-1-vincent@bernat.im>
	<0cdf06b9-e67d-c035-e0f1-c4eb143bf631@gmail.com>
From: Roopa Prabhu <roopa@cumulusnetworks.com>
Date: Thu, 21 Sep 2017 10:20:12 -0700
Message-ID: <CAJieiUjqttMeC24CzDa8Y8g=opRKoa2hbG2Cb+78u632vA3uqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [net-next v3] bridge: trigger RTM_NEWLINK when
 interface is modified by bridge ioctl
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Ahern <dsahern@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, Vincent Bernat <vincent@bernat.im>, David Miller <davem@davemloft.net>

On Thu, Sep 21, 2017 at 9:43 AM, David Ahern <dsahern@gmail.com> wrote:
> On 9/21/17 4:05 AM, Vincent Bernat wrote:
>> Currently, there is a difference in netlink events received when an
>> interface is modified through bridge ioctl() or through netlink. This
>> patch generates additional events when an interface is added to or
>> removed from a bridge via ioctl().
>>
>> When adding then removing an interface from a bridge with netlink, we
>> get:
>>
>> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue master bridge0 state UNKNOWN group default
>>     link/ether 9e:da:60:ee:cf:c8 brd ff:ff:ff:ff:ff:ff
>> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>>     link/ether 9e:da:60:ee:cf:c8
>> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>>     link/ether 9e:da:60:ee:cf:c8
>> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>>     link/ether 9e:da:60:ee:cf:c8
>> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>>     link/ether 9e:da:60:ee:cf:c8
>> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue master bridge0 state UNKNOWN group default
>>     link/ether 9e:da:60:ee:cf:c8 brd ff:ff:ff:ff:ff:ff
>>
>> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue master bridge0 state UNKNOWN group default
>>     link/ether 9e:da:60:ee:cf:c8 brd ff:ff:ff:ff:ff:ff
>> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>>     link/ether 9e:da:60:ee:cf:c8
>> Deleted 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>>     link/ether 9e:da:60:ee:cf:c8
>> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default
>>     link/ether 9e:da:60:ee:cf:c8 brd ff:ff:ff:ff:ff:ff
>>
>> When using ioctl():
>>
>> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue master bridge0 state UNKNOWN group default
>>     link/ether 9e:da:60:ee:cf:c8 brd ff:ff:ff:ff:ff:ff
>> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>>     link/ether 9e:da:60:ee:cf:c8
>> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>>     link/ether 9e:da:60:ee:cf:c8
>> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>>     link/ether 9e:da:60:ee:cf:c8
>> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue master bridge0 state UNKNOWN group default
>>     link/ether 9e:da:60:ee:cf:c8 brd ff:ff:ff:ff:ff:ff
>>
>> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue master bridge0 state UNKNOWN group default
>>     link/ether 9e:da:60:ee:cf:c8 brd ff:ff:ff:ff:ff:ff
>> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>>     link/ether 9e:da:60:ee:cf:c8
>> Deleted 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>>     link/ether 9e:da:60:ee:cf:c8
>> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default
>>     link/ether 9e:da:60:ee:cf:c8 brd ff:ff:ff:ff:ff:ff
>>
>> Without this patch, the last netlink notification is not sent.
>>
>> Signed-off-by: Vincent Bernat <vincent@bernat.im>
>> ---
>>  net/bridge/br_ioctl.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
>> index 7970f8540cbb..66cd98772051 100644
>> --- a/net/bridge/br_ioctl.c
>> +++ b/net/bridge/br_ioctl.c
>> @@ -102,6 +102,9 @@ static int add_del_if(struct net_bridge *br, int ifindex, int isadd)
>>       else
>>               ret = br_del_if(br, dev);
>>
>> +     if (!ret)
>> +             rtmsg_ifinfo(RTM_NEWLINK, dev, IFF_MASTER, GFP_KERNEL);
>> +
>>       return ret;
>>  }
>>
>>
>
> Agreed that this is needed for userspace to know about the master change
> when done through ioctl. The bridge code is emitting a lot of what
> appears to be redundant messages for both paths (netlink and ioctl).
>
> Reviewed-by: David Ahern <dsahern@gmail.com>
>


this patch seems fine...but ideally I would have assumed
netdev_upper_dev_unlink which
is eventually called in both paths would generate the RTN_NEWLINK
IFF_MASTER in response
to the NETDEV_CHANGEUPPER notifier. If we add it there now, it might
need some more fixes
to not generate redundant notifications for the netlink case.
