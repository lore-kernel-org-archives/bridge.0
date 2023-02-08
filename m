Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 939E540B5A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 63AA6400F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bghcBSVVjOnDSTu4fI5Fr851/TGgxU6OXRrvvQvz/M8=;
 b=vsG6o0+N006tv5j5AVuAR9PdyHfVEk7j/0/wj2XKjodhe4nFVNeA+CleK3E0rN4D/R
 iWcVumwXa5V3cxpg2fw6SzUH2dj3TPAyXz06UqOaVR2MJ4RAChiSIDUC3wZfKDw7uauD
 pVlutxhJIDu/9s3AYCxnRFcW0N0xg7I5/7D0r14o4JKHmOTK0IQLHBpEPi+CJMaJ9uaP
 DhFOQ4Q4t8HY44yv0xvu+fjCMcSb38w/B0poS+i6xOGpyFVSNNII0Gco8/HKvXBSDMoG
 eqAYskyI9EK01cc3mgND4cfHVk6zj4qJhukbL1bjZtTn7IgyGJH57p02pPDYCuWVgLSr
 u+7g==
Message-ID: <1a71f6f8-09f6-9208-7368-6b2e3bb4af87@blackwall.org>
Date: Wed, 8 Feb 2023 14:30:43 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20230208005626.56847-1-yang.lee@linux.alibaba.com>
 <Y+OdyiQpz7lIBfh3@corigine.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <Y+OdyiQpz7lIBfh3@corigine.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH -next] net: bridge: clean up one inconsistent
	indenting
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Simon Horman <simon.horman@corigine.com>, Yang Li <yang.lee@linux.alibaba.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Abaci Robot <abaci@linux.alibaba.com>, linux-kernel@vger.kernel.org, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 2/8/23 15:04, Simon Horman wrote:
> On Wed, Feb 08, 2023 at 08:56:26AM +0800, Yang Li wrote:
>> ./net/bridge/br_netlink_tunnel.c:317:4-27: code aligned with following code on line 318
>>
>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3977
>> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> 
> As you may need to respin this:
> 
> Assuming this is targeting net-next, which seems likely to me,
> the subject should denote that. Something like this:
> 
> [PATCH net-next] net: bridge: clean up one inconsistent indenting
> 
>> ---
>>   net/bridge/br_netlink_tunnel.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/bridge/br_netlink_tunnel.c b/net/bridge/br_netlink_tunnel.c
>> index 17abf092f7ca..eff949bfdd83 100644
>> --- a/net/bridge/br_netlink_tunnel.c
>> +++ b/net/bridge/br_netlink_tunnel.c
>> @@ -315,7 +315,7 @@ int br_process_vlan_tunnel_info(const struct net_bridge *br,
>>   
>>   			if (curr_change)
>>   				*changed = curr_change;
>> -			 __vlan_tunnel_handle_range(p, &v_start, &v_end, v,
>> +			__vlan_tunnel_handle_range(p, &v_start, &v_end, v,
>>   						    curr_change);
> 
> I think you also need to adjust the line immediately above.

You meant below, right? :) i.e. "curr_change)", that seems to get
misaligned after the change and needs to be adjusted as well.

> 
>>   		}
>>   		if (v_start && v_end)
>> -- 
>> 2.20.1.7.g153144c
>>

