Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywcs/tl2tzJDict3NJJ63MkaBh5wAKFE8bXjr1SIXGw=;
 b=idOmZRcn2fGXGxUrbmJU0oXOEKPUx1LlwTtviA+D0Ixa5NDRqJzCIf6htwQa2SaLfOq5NkoiMTAzeOtTrYDSDCVcPKlBfpCvgIVdOBTWiUyTaqVPGVOcVrfdpqK8T37ybpWwuQr876IgguQrymW7F91uks1wBG1iL3K4IrCUFI9vE2BK83eJ4sYwDrIMN4sAIk3CIIAriNJ0ko5N0jikCNJkBWwwVJGSj4jlD/fYxys6FRVhjUObTDSwuH1uESGgnqFh0q5erJmsyJua/+9y49Y7DW+59hwXe0xGZyukX7owevvxzop/Vbfz7ysuFl+qzdspwc4nSkK5R91J/J6KCw==
References: <20210801231730.7493-1-vladimir.oltean@nxp.com>
 <ff6d11a2-2931-714a-7301-f624160a2d48@nvidia.com>
 <20210802092053.qyfkuhhqzxjyqf24@skbuf>
 <451c4538-eb77-2865-af74-777e51cd5c31@nvidia.com>
 <20210802105233.64r23kucu4mjnjsu@skbuf>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <4d85eacb-152e-8e4e-bb18-ad2814d249c1@nvidia.com>
Date: Mon, 2 Aug 2021 14:02:36 +0300
In-Reply-To: <20210802105233.64r23kucu4mjnjsu@skbuf>
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

On 02/08/2021 13:52, Vladimir Oltean wrote:
> On Mon, Aug 02, 2021 at 12:42:17PM +0300, Nikolay Aleksandrov wrote:
>>>>> Before, the two commands listed above both crashed the kernel in this
>>>>> check from br_switchdev_fdb_notify:
>>>>>
>>>>
>>>> Not before 52e4bec15546 though, the check used to be:
>>>> struct net_device *dev = dst ? dst->dev : br->dev;
>>>
>>> "Before", as in "before this patch, on net-next/linux-next".
>>>
>>
>> We still need that check, more below.
>>
>>>> which wouldn't crash. So the fixes tag below is incorrect, you could
>>>> add a weird extern learn entry, but it wouldn't crash the kernel.
>>>
>>> :)
>>>
>>> Is our only criterion whether a patch is buggy or not that it causes a
>>> NULL pointer dereference inside the kernel?
>>>
>>> I thought I'd mention the interaction with the net-next work for the
>>> sake of being thorough, and because this is how the syzcaller caught it
>>> by coincidence, but "kernel does not treat an FDB entry with the
>>> 'permanent' flag as permanent" is enough of a reason to submit this as a
>>
>> Not exactly right, you may add it as permanent but it doesn't get "permanent" flag set.
> 
> And that is the bug I am addressing here, no?
> 

Obviously I pointed to the statement above, I don't get the question here.

>> The actual bug is that it points to the bridge device, e.g. null dst without the flag.
>>
>>> bug fix for the commit that I pointed to. Granted, I don't have any use
>>> case with extern_learn, so probably your user space programs simply
>>> don't add permanent FDB entries, but as this is the kernel UAPI, it
>>> should nevertheless do whatever the user space is allowed to say. For a
>>> permanent FDB entry, that behavior is to stop forwarding for that MAC
>>> DA, and that behavior obviously was not taking place even before any
>>> change in br_switchdev_fdb_notify(), or even with CONFIG_NET_SWITCHDEV=n.
>>>
>>
>> Actually I believe there is still a bug in 52e4bec15546 even with this fix.
>> The flag can change after the dst has been read in br_switchdev_fdb_notify()
>> so in theory you could still do a null pointer dereference. fdb_notify()
>> can be called from a few places without locking. The code shouldn't dereference
>> the dst based on the flag.
> 
> Are you thinking of a specific code path that triggers a race between
> (a) a writer side doing WRITE_ONCE(fdb->dst, NULL) and then
>     set_bit(BR_FDB_LOCAL, &fdb->flags), exactly in this order, and

Visible order is not guaranteed, there are no barriers neither at writer nor reader
sides, especially when used without locking. So we cannot make any assumptions
about the order visibility of these writes.

> (b) a reader side catching that fdb exactly in between the above 2
>     statements, through fdb_notify or otherwise (br_fdb_replay)?
> 
> Because I don't see any.
> 
> Plus, I am a bit nervous about protecting against theoretical/unproven
> races in a way that masks real bugs, as we would be doing if I add an
> extra check in br_fdb_replay_one and br_switchdev_fdb_notify against the
> case where an entry has fdb->dst == NULL but not BR_FDB_LOCAL.
> 

The bits are _not_ visible atomically with the setting of ->dst. It is obvious
you must not dereference anything based on them, they are only indications when used
outside of locked regions and code must be able to deal with inconsistencies as that
is implied by the way they're used. It is a clear and obvious bug dereferencing based
on a bit that can change in parallel without any memory ordering guarantees.

You are not "masking" anything, but fixing what is currently buggy use of fdb bits.
As I already said - this doesn't fix the null deref bug completely, in fact it fixes a different
inconsistency, before at worst you'd get blackholed traffic for such entries now
you get a null pointer dereference.

>>
>> I'm okay with this change due to the null dst without permanent flag fix, but
>> it doesn't fully fix the null pointer dereference.
> 
> So is there any change that I should make to this patch?
> 

No, this patch is fine as-is.
