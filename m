Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJPQsgqSsyU9F8LNj0Jm/Hbf/xDkIyb1qqa7PtUw34s=;
 b=CGtiF6idCjcY2ISsyMtKq3cI+EfETdmz1cRiByUNMzLUA1gGQ+bqKy4lRMS44SMKJwO7PE/ixlSsp8BNGzJjgIHNzTbOlkq6ik+Qx5fIC2ioFoHGRFejTw6Uzzloq57z9KckbO0OacJEiVK0PXlxQCZmRv/7gFTkYoEeJ4n3h7bRB2MXzYJbv3aVv6t3ZszcQqEhdKvT4wMbXk/q9FHiKWDcCyQI+gaYTZV8Y0bnmjnbpPaEJy4d4tw+gaXTxoRY51d8M1SB5AcJjvzpoplnzAnw+OtQFMNovyk2bs6fi/sz8j5NYVKSLt5yOLnHkv6wxnLvgSAD+Qz9OSDtWf4ijA==
References: <20210504182259.5042-1-Joseph.Huang@garmin.com>
 <6fd5711c-8d53-d72b-995d-1caf77047ecf@nvidia.com>
 <685c25c2423c451480c0ad2cf78877be@garmin.com> <87v97ym8tc.fsf@waldekranz.com>
 <82693dbedd524f94b5a6223f0287525c@garmin.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <a610666e-c7e4-28cd-ab89-fa2e02ec31de@nvidia.com>
Date: Wed, 5 May 2021 09:59:04 +0300
In-Reply-To: <82693dbedd524f94b5a6223f0287525c@garmin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net 0/6] bridge: Fix snooping in multi-bridge
 config with switchdev
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Huang, Joseph" <Joseph.Huang@garmin.com>, Tobias Waldekranz <tobias@waldekranz.com>, Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ido Schimmel <idosch@idosch.org>

On 05/05/2021 02:26, Huang, Joseph wrote:
>> If I may make a suggestion: I also work with mv88e6xxx systems, and we
>> have the same issues with known multicast not being flooded to router
>> ports. Knowing that chipset, I see what you are trying to do.
>>
>> But other chips may work differently. Imagine for example a switch where
>> there is a separate vector of router ports that the hardware can OR in after
>> looking up the group in the ATU. This implementation would render the
>> performance gains possible on that device useless. As another example, you
>> could imagine a device where an ATU operation exists that sets a bit in the
>> vector of every group in a particular database; instead of having to update
>> each entry individually.
>>
>> I think we (mv88e6xxx) will have to accept that we need to add the proper
>> scaffolding to manage this on the driver side. That way the bridge can stay
>> generic. The bridge could just provide some MDB iterator to save us from
>> having to cache all the configured groups.
>>
>> So basically:
>>
>> - In mv88e6xxx, maintain a per-switch vector of router ports.
>>
>> - When a ports router state is toggled:
>>   1. Update the vector.
>>   2. Ask the bridge to iterate through all applicable groups and update
>>      the corresponding ATU entries.
>>
>> - When a new MDB entry is updated, make sure to also OR in the current
>>   vector of router ports in the DPV of the ATU entry.
>>
>>
>> I would be happy to help out with testing of this!
> 
> Thanks for the suggestion/offer!
> 
> What patch 0002 does is that:
> 
> - When an mrouter port is added/deleted, it iterates over the list of mdb's
>   to add/delete that port to/from the group in the hardware (I think this is
>   what your bullet #2 does as well, except that one is done in the bridge,
>   and the other is done in the driver)
> 
> - When a group is added/deleted, it iterates over the list of mrouter ports
>   to add/delete the switchdev programming
> 
> I think what Nik is objecting to is that with this approach, there's now
> a for-loop in the call paths (thus it "increases the complexity with 1 order
> of magnitude), however I can't think of a way to avoid the looping (whether
> done inside the bridge or in the driver) but still achieve the same result
> (for Marvell at least).
> 

Note that I did not say to avoid it in the switchdev driver. :)
I said it should be in the driver or in some user-space helper, but it mustn't
affect non-switchdev software use cases so much.

You can check how mlxsw[1] deals with mdbs and router ports.

[1] drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c

> I suspect that other SOHO switches might have this problem as well (Broadcom
> comes to mind).
> 
> Thanks,
> Joseph
> 

