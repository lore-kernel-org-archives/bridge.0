Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zL48a7kmtmLk6usN932oMzweoz48ciHE2mkqawibyg=;
 b=rVx9VZz6saJ8swyG4p55stwnr3Dir6PmHUU70KKMCxtYlpYcbQCewPRYXCjM1j8WtW4Spvx+2SIn6mLRG+wzJAG1tj8ELi/n7FyT9neZj98W376B1eRXFSH/NJc8BaciyPeYA6xLW8GARF2n44H3f4tgvv70dduTpdtnu+5m33ADiBxNGD0q0ztYDeI/Kf4zZ2LM1BvDF7IdYV4Ub5MG2c8VV875OpnDmB8DdBVXgjpqjOfknZF1/eflcVbeAER2ZYNl7FaHXscoPMSWOK3j32uMPNqVyQNqfHL/YDt0aGlFPrxZ1BFIMdsFse1JMVZE1/WWs1ht9z15mrV0pWvy2A==
References: <20210823061938.28240-1-l4stpr0gr4m@gmail.com>
 <13c1df91-be22-f4e0-cd61-7c99eb4e45f4@nvidia.com>
 <CAKW4uUyPdQ9hXeyjnC+5VS7zDaw+3sxy53HwOv2AxEZ7tngT=Q@mail.gmail.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <5e721a04-0be5-af91-055a-caf023cf6437@nvidia.com>
Date: Mon, 23 Aug 2021 12:15:58 +0300
In-Reply-To: <CAKW4uUyPdQ9hXeyjnC+5VS7zDaw+3sxy53HwOv2AxEZ7tngT=Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next] net: bridge: replace
 __vlan_hwaccel_put_tag with skb_vlan_push
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Kangmin Park <l4stpr0gr4m@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

On 23/08/2021 12:12, Kangmin Park wrote:
> 2021년 8월 23일 (월) 오후 6:00, Nikolay Aleksandrov <nikolay@nvidia.com>님이 작성:
>>
>> On 23/08/2021 09:19, Kangmin Park wrote:
>>
>> This changes behaviour though, I don't like changing code just for the sake of it.
>> Perhaps the author had a reason to use hwaccel_put_tag instead. Before we would
>> just put hwaccel tag, now if there already is hwaccel tag we'll push it inside
>> the skb and then push the new tag in hwaccel. In fact I think you can even trigger
>> the warning inside skb_vlan_push, so:
>>
>> Nacked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
>>
>>
> 
> Thanks for the review. I got it.
> Then, how about cleanup by changing return type of
> br_handle_ingress_vlan_tunnel()?
> This function is only referenced in br_handle_frame(), and goto drop
> when it return
> non-zero. But, the ingress function always return 0, there is no
> meaning for now.
> If you think the cleanup is worth it, I'll send you a v2 patch.
> 
> Regards.
> 

Sure, I don't mind that cleanup.

Cheers,
 Nik

