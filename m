Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:from:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=ozCVlj+EGkPpAY1tihUf+9wDD7FbL5BN8IcSEqHCAj8=;
	b=P3VdiwBDvZVDboke+ShIMiJ508vKoMe/mHqCKjnuW2bJz37hc5n9OYYz67rjeUoRBL
	/1B90FYtShyNeVTVHvuS257eZm4eMS69k9al8oBqQb6daRQfQftm0YZzZP3OG+lYXyO1
	QvcjSelI9DDcM+jG6HGibC35jzzdxv/v6p93U=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
References: <f6c0da96-77f0-db19-7a9a-13b246d83d39@cumulusnetworks.com>
	<1508971954-3567-1-git-send-email-nikolay@cumulusnetworks.com>
	<1508971954-3567-3-git-send-email-nikolay@cumulusnetworks.com>
	<622bf4ff-e493-58f0-bedf-8183a82e8772@lab.ntt.co.jp>
	<3ad411f5-72fe-db6c-aa13-385dd1c10f36@cumulusnetworks.com>
Message-ID: <0f1e8fb5-b9a8-b363-c080-65c23f76b25e@cumulusnetworks.com>
Date: Thu, 26 Oct 2017 14:08:02 +0300
MIME-Version: 1.0
In-Reply-To: <3ad411f5-72fe-db6c-aa13-385dd1c10f36@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v4 2/2] bridge: vlan: signal if
 anything changed on vlan add
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>, netdev@vger.kernel.org
Cc: dsa@cumulusnetworks.com, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, mrv@mojatatu.com, davem@davemloft.net

On 26/10/17 14:02, Nikolay Aleksandrov wrote:
> On 26/10/17 13:16, Toshiaki Makita wrote:
>> On 2017/10/26 7:52, Nikolay Aleksandrov wrote:
>> ...
>>> @@ -559,6 +574,7 @@ int br_vlan_add(struct net_bridge *br, u16 vid, u16 flags)
>>>  
>>>  	ASSERT_RTNL();
>>>  
>>> +	*changed = false;
>>>  	vg = br_vlan_group(br);
>>>  	vlan = br_vlan_find(vg, vid);
>>>  	if (vlan) {
>>> @@ -576,9 +592,12 @@ int br_vlan_add(struct net_bridge *br, u16 vid, u16 flags)
>>>  			refcount_inc(&vlan->refcnt);
>>>  			vlan->flags |= BRIDGE_VLAN_INFO_BRENTRY;
>>>  			vg->num_vlans++;
>>> +			*changed = true;
>>>  		}
>>> -		__vlan_add_flags(vlan, flags);
>>> -		return 0;
>>> +		if (__vlan_add_flags(vlan, flags))
>>> +			*changed = true;
>>> +
>>> +		return ret;
>>
>> "ret" isn't always initialized here, is it?
>>
>>
>> Toshiaki Makita
> 
> Oh, good catch! Right you are, weird that there was no warning even with W=1 as
> I always check that before sending a set.
> 
> Thanks,
>  Nik
> 

Unfortunately that was a leftover from v0 of this set where I always initialized ret.
Will fix and send v5, thanks again.


