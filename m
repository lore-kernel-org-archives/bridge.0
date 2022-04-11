Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=fvLrmjGULh5PeO+698QVj9ZjZ1CYMCZHBP99ly4kD/A=;
 b=34csYC9WDohbsDYhUY9ZiLOG1OoQLGMc5ViVUEhy6OYmjO+LkV9jJE/I1MJZNU3W5I
 9/fA3rx0fhYE9SDD9J7IPmCd2cUwJ4aNT57QF2p/u3KPlt06Punp7WDgiHNcwC5fByOx
 I/lFSLPYMqD+NAtniR1JpgDe+ZS7eujWeEkdEdtRRcxHvSoEWkrAs1vojnLownJLnK+G
 uRV+GFPPLDvXmQdg1Yn/pyOLWw4GAYVo4D2IFZhCB18kNqtjxQzKg+tIx7Figw925RYG
 Pnh7+4nBMdKv3KaDByk11ULhpRYOxMkSm2BbpY/ZyWBzc02WQ/epu8MA4ySz7oWsroIV
 Ol8Q==
Message-ID: <3c25f674-d90b-7028-e591-e2248919cca9@blackwall.org>
Date: Mon, 11 Apr 2022 23:34:23 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20220411172934.1813604-1-razor@blackwall.org>
 <0d08b6ce-53bb-bffa-4f04-ede9bfc8ab63@nvidia.com>
 <c46ac324-34a2-ca0c-7c8c-35dc9c1aa0ab@blackwall.org>
 <92f578b7-347e-22c7-be83-cae4dce101f6@blackwall.org>
 <ca093c4f-d99c-d885-16cb-240b0ce4d8d8@nvidia.com>
 <20220411124910.772dc7a0@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220411124910.772dc7a0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 0/8] net: bridge: add flush
	filtering support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>, Roopa Prabhu <roopa@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, idosch@idosch.org

On 11/04/2022 22:49, Jakub Kicinski wrote:
> On Mon, 11 Apr 2022 12:22:24 -0700 Roopa Prabhu wrote:
>>>> I thought about that option, but I didn't like overloading delneigh like that.
>>>> del currently requires a mac address and we need to either signal the device supports> a null mac, or we should push that verification to ndo_fdb_del users. Also we'll have  
>>> that's the only thing, overloading delneigh with a flush-behaviour (multi-del or whatever)
>>> would require to push the mac check to ndo_fdb_del implementers
>>>
>>> I don't mind going that road if others agree that we should do it through delneigh
>>> + a bit/option to signal flush, instead of a new rtm type.
>>>  
>>>> attributes which are flush-specific and will work only when flushing as opposed to when
>>>> deleting a specific mac, so handling them in the different cases can become a pain.  
>>> scratch the specific attributes, those can be adapted for both cases
>>>  
>>>> MDBs will need DELMDB to be modified in a similar way.
>>>>
>>>> IMO a separate flush op is cleaner, but I don't have a strong preference.
>>>> This can very easily be adapted to delneigh with just a bit more mechanical changes
>>>> if the mac check is pushed to the ndo implementers.
>>>>
>>>> FLUSHNEIGH can easily work for neighs, just need another address family rtnl_register
>>>> that implements it, the new ndo is just for PF_BRIDGE. :)  
>>
>> all great points. My only reason to explore RTM_DELNEIGH is to see if we 
>> can find a recipe to support similar bulk deletes of other objects 
>> handled via rtm msgs in the future. Plus, it allows you to maintain 
>> symmetry between flush requests and object delete notification msg types.
>>
>> Lets see if there are other opinions.
> 
> I'd vote for reusing RTM_DELNEIGH, but that's purely based on

OK, I'll look into the delneigh solution. Note that for backwards compatibility
we won't be able to return proper error because rtnl_fdb_del will be called without
a mac address, so for old kernels with new iproute2 fdb flush will return "invalid
address" as an error.

> intuition, I don't know this code. I'd also lean towards core
> creating struct net_bridge_fdb_flush_desc rather than piping
> raw netlink attrs thru. Lastly feels like fdb ops should find 

I don't think the struct can really be centralized, at least for the
bridge case it contains private fields which parsed attributes get mapped to,
specifically the ndm flags and state, and their maps are all mapped into
bridge-private flags. Or did you mean pass the raw attribute vals through a
struct instead of a nlattr table?

> a new home rather than ndos, but that's largely unrelated..

I like separating the ops idea. I'll add that to my bridge todo list. :)

Thanks,
 Nik

