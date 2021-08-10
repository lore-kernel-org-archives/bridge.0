Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVzNtu2QXU8lmc9mizTVY1B13xdizkdC/1812TUsFJQ=;
 b=bJmwxYn1FM4rqc3VOAG3RrfK7blCgGfbeW4rt0pwEryfj7HnG1nB/4pGVqxkT9ZQBxLWAkAyTmhSdfHp5K2FUXCxUxtEBtza1OvnmGIjEdkFRMrfWVP17E9tyocTbypv6NyMOoP00xyCTiK8hcPT7x6xNpj9LqdA3P5ahCz2jwVPkl8zKKm0h6r6RnT1ol0xp2hUPiT7TuKKdmuutZuvt5tnwyMJcf2gCdYOc82zA5z8Y71K9iHCqYnF7I4vDAD5aD2Ed6aqifzwq2dby+cbhmjoFDDc7hdNrsWmxwa0vc+N57suMjkBQZU3++i2uDiWsB/qVqCdXsP4VOOXUTVaJg==
References: <20210801231730.7493-1-vladimir.oltean@nxp.com>
 <YREcqAdU+6IpT0+w@shredder> <20210809160521.audhnv7o2tugwtmp@skbuf>
 <YRIgynudgTsOpe5q@shredder> <20210810100928.uk7dfstrnts2may4@skbuf>
 <c6d91ec7-6081-85d0-9bc8-569838d8f9a4@nvidia.com>
 <20210810103840.oequsjeg5be2jkkz@skbuf>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <bd891cb9-a5d8-1341-15cd-cba3c118f76a@nvidia.com>
Date: Tue, 10 Aug 2021 13:43:41 +0300
In-Reply-To: <20210810103840.oequsjeg5be2jkkz@skbuf>
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

On 10/08/2021 13:38, Vladimir Oltean wrote:
> On Tue, Aug 10, 2021 at 01:15:32PM +0300, Nikolay Aleksandrov wrote:
>> On 10/08/2021 13:09, Vladimir Oltean wrote:
>>> On Tue, Aug 10, 2021 at 09:46:34AM +0300, Ido Schimmel wrote:
>>>> On Mon, Aug 09, 2021 at 04:05:22PM +0000, Vladimir Oltean wrote:
>>>>> On Mon, Aug 09, 2021 at 03:16:40PM +0300, Ido Schimmel wrote:
>>>>>> I have at least once selftest where I forgot the 'static' keyword:
>>>>>>
>>>>>> bridge fdb add de:ad:be:ef:13:37 dev $swp1 master extern_learn vlan 1
>>>>>>
>>>>>> This patch breaks the test when run against both the kernel and hardware
>>>>>> data paths. I don't mind patching these tests, but we might get more
>>>>>> reports in the future.
>>>>>
>>>>> Is it the 'static' keyword that you forgot, or 'dynamic'? The
>>>>> tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh selftest
>>>>> looks to me like it's testing the behavior of an FDB entry which should
>>>>> roam, and which without the extern_learn flag would be ageable.
>>>>
>>>> static - no aging, no roaming
>>>> dynamic - aging, roaming
>>>> extern_learn - no aging, roaming
>>>>
>>>> So these combinations do not make any sense and the kernel will ignore
>>>> static/dynamic when extern_learn is specified. It's needed to work
>>>> around iproute2 behavior of "assume permanent"
>>>
>>> Since NTF_EXT_LEARNED is part of ndm->ndm_flags and NUD_REACHABLE/NUD_NOARP
>>> are part of ndm->ndm_state, it is not at all clear to me that 'extern_learn'
>>> belongs to the same class of bridge neighbor attributes as 'static'/'dynamic',
>>> and that it is invalid to have the full degree of freedom. If it isn't,
>>> shouldn't the kernel validate that, instead of just ignoring the ndm->ndm_state?
>>> If it's too late to validate, shouldn't we at least document somewhere
>>> that the ndm_state is ignored in the presence of ndm_flags & NTF_EXT_LEARNED?
>>> It is user API after all, easter eggs like this aren't very enjoyable.
>>>
>>
>> It's too late unfortunately, ignoring other flags in that case has been the standard
>> behaviour for a long time (it has never made sense to specify flags for extern_learn
>> entries). I'll send a separate patch that adds a comment to document it or if you have
>> another thing in mind feel free to send a patch.
> 
> No, I don't have anything else in mind, but since the topic is the same
> as the "net: bridge: fix flags interpretation for extern learn fdb entries"
> patch you already sent, you could as well just send a v2 for that and
> add an extra phrase in a comment somewhere near a NTF_EXT_LEARNED uapi
> definition, or perhaps extend this comment right here:
> 
> /* NUD_NOARP & NUD_PERMANENT are pseudostates, they never change
>    and make no address resolution or NUD.
>    NUD_PERMANENT also cannot be deleted by garbage collectors.
>  */
> 

sure, I was going to send it for net-next, but I might as well do it in -net.

