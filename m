Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=HtsX7xXS5KyrSdS4F8RNS0VhDr01GCN2iAGgDFc6qBs=;
 b=Bk78u/NaLlBh/+udP1b42wGjGXL+P807SEn3bt4RGvsZ6lVNKA9vUhLUIDtJu4SHO9
 T9/5Z7yK5+CdL++dKToG8H03+Ijpr644TnAzeuf9hCa+Ky3DfQxmNbQ5argOSQrrIU3U
 GtLq73xG7eQILwhJGkUrnG9H1nHp9VbOLtGWDH+J8duVnfd4noatHsIok+vlhVQxcBwV
 fU1Niw1hMc/3HNwc+i2lL1L6woChrXpSTZvUa1Z58wx1w8zInanQQoj7M88+ZRlDn2Dj
 PAvZYWy4uvkiXgYhKbE7+XzaWRy0A+uRrdNZTwRRDs7joSr1nBCKZ/TZFLMqIaVXcRHo
 le3Q==
Message-ID: <0f1e1250-920a-c7d1-900c-98ef3e0456d8@blackwall.org>
Date: Mon, 25 Apr 2022 00:52:39 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <cover.1650800975.git.eng.alaamohamedsoliman.am@gmail.com>
 <c3a882e4fb6f9228f704ebe3c1fcace14ee6cdf2.1650800975.git.eng.alaamohamedsoliman.am@gmail.com>
 <7c8367b6-95c7-ea39-fafe-72495f343625@blackwall.org>
 <d89eefc2-664f-8537-d10e-6fdfbb6823ed@gmail.com>
 <4bf69eef-7444-1238-0f4a-fb0fccda080c@blackwall.org>
 <3bcb2d3d-8b8b-8a8f-1285-7277394b4e6b@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <3bcb2d3d-8b8b-8a8f-1285-7277394b4e6b@gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next v3 1/2] rtnetlink: add extack support
 in fdb del handlers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>, netdev@vger.kernel.org
Cc: shshaikh@marvell.com, jdenham@redhat.com, GR-Linux-NIC-Dev@marvell.com, manishc@marvell.com, alexandre.belloni@bootlin.com, outreachy@lists.linux.dev, vladimir.oltean@nxp.com, bridge@lists.linux-foundation.org, jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org, sbrivio@redhat.com, claudiu.manoil@nxp.com, anthony.l.nguyen@intel.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, UNGLinuxDriver@microchip.com, intel-wired-lan@lists.osuosl.org

On 4/25/22 00:09, Alaa Mohamed wrote:
> 
> On ٢٤‏/٤‏/٢٠٢٢ ٢١:٥٥, Nikolay Aleksandrov wrote:
>> On 24/04/2022 22:49, Alaa Mohamed wrote:
>>> On ٢٤‏/٤‏/٢٠٢٢ ٢١:٠٢, Nikolay Aleksandrov wrote:
>>>> On 24/04/2022 15:09, Alaa Mohamed wrote:
>>>>> Add extack support to .ndo_fdb_del in netdevice.h and
>>>>> all related methods.
>>>>>
>>>>> Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
>>>>> ---
>>>>> changes in V3:
>>>>>           fix errors reported by checkpatch.pl
>>>>> ---
>>>>>    drivers/net/ethernet/intel/ice/ice_main.c        | 4 ++--
>>>>>    drivers/net/ethernet/mscc/ocelot_net.c           | 4 ++--
>>>>>    drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c | 2 +-
>>>>>    drivers/net/macvlan.c                            | 2 +-
>>>>>    drivers/net/vxlan/vxlan_core.c                   | 2 +-
>>>>>    include/linux/netdevice.h                        | 2 +-
>>>>>    net/bridge/br_fdb.c                              | 2 +-
>>>>>    net/bridge/br_private.h                          | 2 +-
>>>>>    net/core/rtnetlink.c                             | 4 ++--
>>>>>    9 files changed, 12 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c 
>>>>> b/drivers/net/ethernet/intel/ice/ice_main.c
>>>>> index d768925785ca..7b55d8d94803 100644
>>>>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>>>>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>>>>> @@ -5678,10 +5678,10 @@ ice_fdb_add(struct ndmsg *ndm, struct 
>>>>> nlattr __always_unused *tb[],
>>>>>    static int
>>>>>    ice_fdb_del(struct ndmsg *ndm, __always_unused struct nlattr *tb[],
>>>>>            struct net_device *dev, const unsigned char *addr,
>>>>> -        __always_unused u16 vid)
>>>>> +        __always_unused u16 vid, struct netlink_ext_ack *extack)
>>>>>    {
>>>>>        int err;
>>>>> -
>>>>> +
>>>> What's changed here?
>>> In the previous version, I removed the blank line after "int err;" 
>>> and you said I shouldn't so I added blank line.
>>>
>> Yeah, my question is are you fixing a dos ending or something else?
>> The blank line is already there, what's wrong with it?
> No, I didn't.
>>
>> The point is it's not nice to mix style fixes and other changes, more so
>> if nothing is mentioned in the commit message.
> Got it, So, what should I do to fix it?

Don't change that line? I mean I'm even surprised this made it in the 
patch. As I mentioned above, there is already a new line there so I'm 
not sure how you're removing it and adding it again. :)

Cheers,
  Nik
