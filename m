Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E8AAA400FE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AC84E40022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1684847001; x=1687439001;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MtuLbrEh7BlwROWf1pslTcmB5/eMhxKXbbO35Rej/2A=;
 b=BSWx4ZvSHeFN3DVRK4aPNDwO3q2sJVjboIeFA/r8O6w07EFv30YTG8Ynp68+I/WQkf
 Gx4xRUGOb+SO4u1QHszLxatyHvrZD438hI4gXE7lcpVAm2BI5LbyNcZatltsTqYW+jcq
 oWoMSihVGsRBUobDkxJDyscUSCJEyoW/9SP50bOwqwpmTa9WIKDBQnezE7aRfBysAtP1
 NQit3JYQOZZW9DCgm1dcH+o5QGEr7MnfXFPTU/B5uymQhfnZjNu3JrjTQnLOCX8R+Q6V
 GaCb0fz4aJT5gXbJ5kF/EfYQXqbLT976Fmt6x7g1x/cXO0T7yhxyr5gra9vpcTrsGtyt
 kgsw==
Message-ID: <af356b89-ff7f-a562-2859-e8edeae5f23c@blackwall.org>
Date: Tue, 23 May 2023 16:03:19 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230518113328.1952135-1-idosch@nvidia.com>
 <20230518113328.1952135-2-idosch@nvidia.com>
 <1ed139d5-6cb9-90c7-323c-22cf916e96a0@blackwall.org>
 <ZGd+9CUBM+eWG5FR@shredder> <20230519145218.659b0104@kernel.org>
 <ZGx0/hwPmFFN2ivS@shredder>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZGx0/hwPmFFN2ivS@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 1/5] skbuff: bridge: Add layer 2 miss
	indication
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
Cc: taras.chornyi@plvision.eu, petrm@nvidia.com, alexandre.belloni@bootlin.com, jiri@resnulli.us, taspelund@nvidia.com, leon@kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, claudiu.manoil@nxp.com, UNGLinuxDriver@microchip.com, vladimir.oltean@nxp.com, edumazet@google.com, jhs@mojatatu.com, roopa@nvidia.com, xiyou.wangcong@gmail.com, pabeni@redhat.com, saeedm@nvidia.com, davem@davemloft.net

On 23/05/2023 11:10, Ido Schimmel wrote:
> On Fri, May 19, 2023 at 02:52:18PM -0700, Jakub Kicinski wrote:
>> On Fri, 19 May 2023 16:51:48 +0300 Ido Schimmel wrote:
>>> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
>>> index fc17b9fd93e6..274e55455b15 100644
>>> --- a/net/bridge/br_input.c
>>> +++ b/net/bridge/br_input.c
>>> @@ -46,6 +46,8 @@ static int br_pass_frame_up(struct sk_buff *skb)
>>>          */
>>>         br_switchdev_frame_unmark(skb);
>>>  
>>> +       skb->l2_miss = BR_INPUT_SKB_CB(skb)->miss;
>>> +
>>>         /* Bridge is just like any other port.  Make sure the
>>>          * packet is allowed except in promisc mode when someone
>>>          * may be running packet capture.
>>>
>>> Ran these changes through the selftest and it seems to work.
>>
>> Can we possibly put the new field at the end of the CB and then have TC
>> look at it in the CB? We already do a bit of such CB juggling in strp
>> (first member of struct sk_skb_cb).
> 
> Using the CB between different layers is very fragile and I would like
> to avoid it. Note that the skb can pass various layers until hitting the
> classifier, each of which can decide to memset() the CB.
> 
> Anyway, I think I have a better alternative. I added the 'l2_miss' bit
> to the tc skb extension and adjusted the bridge to mark packets via this
> extension. The entire thing is protected by the existing 'tc_skb_ext_tc'
> static key, so overhead is kept to a minimum when feature is disabled.
> Extended flower to enable / disable this key when filters that match on
> 'l2_miss' are added / removed.
> 
> bridge change to mark the packet:
> https://github.com/idosch/linux/commit/3fab206492fcad9177f2340680f02ced1b9a0dec.patch
> 
> flow_dissector change to dissect the info from the extension:
> https://github.com/idosch/linux/commit/1533c078b02586547817a4e63989a0db62aa5315.patch
> 
> flower change to enable / disable the key:
> https://github.com/idosch/linux/commit/cf84b277511ec80fe565c41271abc6b2e2f629af.patch
> 
> Advantages compared to the previous approach are that we do not need a
> new bit in the skb and that overhead is kept to a minimum when feature
> is disabled. Disadvantage is that overhead is higher when feature is
> enabled.
> 
> WDYT?
> 
> To be clear, merely asking for feedback on the general approach, not
> code review.
> 
> Thanks

TBH, I like this approach much better for obvious reasons. :)
Thanks for working on it.
