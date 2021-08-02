Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdfBQiRbvEzTKLWAMACT49YLZktqfP+SfDTnzt0zsCA=;
 b=tbLlMp8zlhCFLshlg+1gBNXncn3waPQXIGhV+MaedmMq5GGEzgAixW0jY73P8R6V3gpGCExxguQNzE+142JABVDj6NgJQIMuvfIs0s96HR7YSYJ2nRpSm63VuwzTSEyPWfiI68lEoM6zDXgKwnDok+c+CaXNIHQBji06GG+a3+gtXO6yzmfkC5qlo1aD2dIZb3ff/Mh3jXypbhqlEglF4kdft9t9Fxp4Q/NPRMymWj+6H5oii5pLVjh0foBF+HObABcUhhAWZn3nag3Euk8p9RthjdxHeUiqlIjdoxAvbi8SyW2NGDDy0qBHvfDtDnKFNchVpsw400TBUHHWz0sy6g==
References: <20210801231730.7493-1-vladimir.oltean@nxp.com>
 <ff6d11a2-2931-714a-7301-f624160a2d48@nvidia.com>
 <20210802092053.qyfkuhhqzxjyqf24@skbuf>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <451c4538-eb77-2865-af74-777e51cd5c31@nvidia.com>
Date: Mon, 2 Aug 2021 12:42:17 +0300
In-Reply-To: <20210802092053.qyfkuhhqzxjyqf24@skbuf>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net] net: bridge: validate the NUD_PERMANENT
 bit when adding an extern_learn FDB entry
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "syzbot+9ba1174359adba5a5b7c@syzkaller.appspotmail.com" <syzbot+9ba1174359adba5a5b7c@syzkaller.appspotmail.com>, Jiri Pirko <jiri@resnulli.us>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Ido Schimmel <idosch@idosch.org>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

On 02/08/2021 12:20, Vladimir Oltean wrote:
> On Mon, Aug 02, 2021 at 10:42:41AM +0300, Nikolay Aleksandrov wrote:
>> On 02/08/2021 02:17, Vladimir Oltean wrote:
>>> Currently it is possible to add broken extern_learn FDB entries to the
>>> bridge in two ways:
>>>
>>> 1. Entries pointing towards the bridge device that are not local/permanent:
>>>
>>> ip link add br0 type bridge
>>> bridge fdb add 00:01:02:03:04:05 dev br0 self extern_learn static
>>>
>>> 2. Entries pointing towards the bridge device or towards a port that
>>> are marked as local/permanent, however the bridge does not process the
>>> 'permanent' bit in any way, therefore they are recorded as though they
>>> aren't permanent:
>>>
>>> ip link add br0 type bridge
>>> bridge fdb add 00:01:02:03:04:05 dev br0 self extern_learn permanent
>>>
>>> Since commit 52e4bec15546 ("net: bridge: switchdev: treat local FDBs the
>>> same as entries towards the bridge"), these incorrect FDB entries can
>>> even trigger NULL pointer dereferences inside the kernel.
>>>
>>> This is because that commit made the assumption that all FDB entries
>>> that are not local/permanent have a valid destination port. For context,
>>> local / permanent FDB entries either have fdb->dst == NULL, and these
>>> point towards the bridge device and are therefore local and not to be
>>> used for forwarding, or have fdb->dst == a net_bridge_port structure
>>> (but are to be treated in the same way, i.e. not for forwarding).
>>>
>>> That assumption _is_ correct as long as things are working correctly in
>>> the bridge driver, i.e. we cannot logically have fdb->dst == NULL under
>>> any circumstance for FDB entries that are not local. However, the
>>> extern_learn code path where FDB entries are managed by a user space
>>> controller show that it is possible for the bridge kernel driver to
>>> misinterpret the NUD flags of an entry transmitted by user space, and
>>> end up having fdb->dst == NULL while not being a local entry. This is
>>> invalid and should be rejected.
>>>
>>> Before, the two commands listed above both crashed the kernel in this
>>> check from br_switchdev_fdb_notify:
>>>
>>
>> Not before 52e4bec15546 though, the check used to be:
>> struct net_device *dev = dst ? dst->dev : br->dev;
> 
> "Before", as in "before this patch, on net-next/linux-next".
> 

We still need that check, more below.

>> which wouldn't crash. So the fixes tag below is incorrect, you could
>> add a weird extern learn entry, but it wouldn't crash the kernel.
> 
> :)
> 
> Is our only criterion whether a patch is buggy or not that it causes a
> NULL pointer dereference inside the kernel?
> 
> I thought I'd mention the interaction with the net-next work for the
> sake of being thorough, and because this is how the syzcaller caught it
> by coincidence, but "kernel does not treat an FDB entry with the
> 'permanent' flag as permanent" is enough of a reason to submit this as a

Not exactly right, you may add it as permanent but it doesn't get "permanent" flag set.
The actual bug is that it points to the bridge device, e.g. null dst without the flag.

> bug fix for the commit that I pointed to. Granted, I don't have any use
> case with extern_learn, so probably your user space programs simply
> don't add permanent FDB entries, but as this is the kernel UAPI, it
> should nevertheless do whatever the user space is allowed to say. For a
> permanent FDB entry, that behavior is to stop forwarding for that MAC
> DA, and that behavior obviously was not taking place even before any
> change in br_switchdev_fdb_notify(), or even with CONFIG_NET_SWITCHDEV=n.
> 

Actually I believe there is still a bug in 52e4bec15546 even with this fix.
The flag can change after the dst has been read in br_switchdev_fdb_notify()
so in theory you could still do a null pointer dereference. fdb_notify()
can be called from a few places without locking. The code shouldn't dereference
the dst based on the flag.

I'm okay with this change due to the null dst without permanent flag fix, but
it doesn't fully fix the null pointer dereference.



