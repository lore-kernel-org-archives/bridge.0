Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=pzY1vCiZmEqAse2lE+G5++xec0AKafFGF1DRamFDl44=;
	b=Oecp+hUUqj6R2U1onHEFPm1a5BKHR1hn2JKZneX7B2h+wqXMijv5iAvgCnHThBPf6j
	fmjgHkfAuq84kkUgx8DT5biMnYCCanLdXTdevD+yb0nPouL0jNBekecaxY8Te1aKjClf
	oJK8dAWa/bjeMuD0S2hlr+6kvnIjKRk23nL5o=
References: <1465215613-3468-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
	<20160610.223512.206489271156278288.davem@davemloft.net>
	<575C39B1.3010300@cumulusnetworks.com> <575D02AB.6040008@gmail.com>
	<af1a5db5-fb9a-f3d9-f94c-b987c70f02da@lab.ntt.co.jp>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <575E97B3.1060704@cumulusnetworks.com>
Date: Mon, 13 Jun 2016 13:23:31 +0200
MIME-Version: 1.0
In-Reply-To: <af1a5db5-fb9a-f3d9-f94c-b987c70f02da@lab.ntt.co.jp>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next v2] bridge: Synchronize unicast
 filtering with FDB
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>, David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, netdev@bof.de, bridge@lists.linux-foundation.org

On 13/06/16 13:13, Toshiaki Makita wrote:
> On 2016/06/12 15:35, Toshiaki Makita wrote:
>> On 16/06/12 (日) 1:17, Nikolay Aleksandrov via Bridge wrote:
>>> On 06/11/2016 07:35 AM, David Miller wrote:
>>>> From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
>>>> Date: Mon,  6 Jun 2016 21:20:13 +0900
>>>>
>>>>> Patrick Schaaf reported that flooding due to a missing fdb entry of
>>>>> the address of macvlan on the bridge device caused high CPU
>>>>> consumption of an openvpn process behind a tap bridge port.
>>>>> Adding an fdb entry of the macvlan address can suppress flooding
>>>>> and avoid this problem.
>>>>>
>>>>> This change makes bridge able to synchronize unicast filtering with
>>>>> fdb automatically so admin do not need to manually add an fdb entry.
>>>>> This effectively supports IFF_UNICAST_FLT in bridge, thus adding an
>>>>> macvlan device would not place bridge into promiscuous mode as well.
>>>>>
>>>>> v2:
>>>>> - Test vlan with br_vlan_should_use() in br_fdb_sync_uc() as per
>>>>>     Nikolay Aleksandrov.
>>>>>
>>>>> Reported-by: Patrick Schaaf <netdev@bof.de>
>>>>> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
>>>>
>>>> I really need bridging experts to review and ACK/NACK this.
>>>>
>>>> Thanks.
>>>>
>>>
>>> Oops, I almost missed the v2, sorry about that. So, technically it
>>> looks correct, but
>>> I only fear the scalability impact of the change. If there're a large
>>> number of vlans
>>> adding a macvlan (or any device that syncs uc addr) might become very
>>> slow and every
>>> flag change will become very slow too without an option to revert to
>>> the original
>>> behaviour so we'll have to wait for the entries to be added in order
>>> to delete them.
>>> Another common scenario is having 8021q interfaces on top of the
>>> bridge with different
>>> mac addresses for some of the configured vlans (or with macvlans on
>>> top of them for VRR),
>>> that use case would suffer as well because their macs need to be local
>>> only for those vlans,
>>> and not the 2000+ other vlans that might exist.
>>> On every sync_uc() call all the fdb entries get deleted and added
>>> again, so even after deleting
>>> some manually they can come back unexpectedly after some operation and
>>> also the message storm from
>>> all the deletes and adds could be problematic as well.
>>>
>>> E.g. 2000 br0 vlans, 25 macvlans on br0 (adding them took more than 5
>>> minutes, 53k fdb entries):
>>> $ bridge fdb del de:8e:9f:16:c5:71 dev br0 vlan 289
>>> $ ip l set br0 multicast on
>>> $ bridge fdb | grep 289 | grep de:8e:9f:16:c5:71
>>> de:8e:9f:16:c5:71 dev br0 vlan 1289 master br0 permanent
>>> de:8e:9f:16:c5:71 dev br0 vlan 289 master br0 permanent
>>>
>>> In fact you can't escape the slow performance even if you delete all
>>> entries because on the
>>> next flag change or interface add, they will be added back.
>>
>> I still think this auto-sync should be done, otherwise macvlan imposes
>> promiscuous mode on bridge even if you manually add such fdb entries.
>> I believe most of your concern would disappear by making use of
>> __dev_uc_sync() instead.
>> Indeed it seems that there is no easy way to propagate the combination
>> of uc addr and vlan from upper device, so local entries for unneeded
>> vlan can still be created even if using __dev_uc_sync(). In case you
>> worry about those unneeded entries, I can add a knob to disable this
>> feature.
>> Are you comfortable with this change?
>
> Tested performance using __dev_uc_sync() and got expected results.
> (Add 3000 br0 vlans, 50 macvlans on br0)
>
> * Without patch
>   1.8s
>
> * Patch v2
>   2m42s
Your machine is much faster apparently. :-) It took me ~5 minutes for 25 macvlans
in my VM.

>
> * Patch using __dev_uc_sync()
>   3.5s
>   Also, a manually deleted entry is not restored by flag change.
>
>
> Nikolay, David, I'd like to hear your feedback.
> I'm thinking the performance implication now looks reasonable.
> If you don't have objection, I'll work on v3 (using __dev_uc_sync() and
> knob to disable the feature).
>
> Thanks,
> Toshiaki Makita
>

The numbers sound okay, but I'd have to see the patch to be able to comment
further. I wonder why the push for this change when this can be currently
"fixed" by adding the macs manually as local (pointing to the bridge) ?
Anyway I don't mind having it automated if the change doesn't break anything
or introduce any performance regressions.

Cheers,
  Nik





