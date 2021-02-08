Return-Path: <gustavo@embeddedor.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FR3dzdCJXZtGtQhMPh0GQhHIQAP6vViQ98y1V5VUhF0=; b=spsxCBhlPp5aQvYpIBT2CUijc2
 G4k4UWocIDQJZHr5Ua8ZOWQOUZgXGOIXkqoaWX29hLvYz31wkLG15V45xZyIV+2CxHuA+it0PrHj2
 IXSNhUG1tuANyXMfuvuN182VQdIPfEzaWDkJYTiyMRAx1Tp0rXr1oytlg88F2rLi8FmG2wSLu96pc
 ZNjnxkgygylUleUySN+mA6T88Axj8gkfjHvDFGjgAb8fVIjRWZHSlHHIhDrPShORFkXVJwQFdJqVW
 ir6ROnHQ408MLG7XXpjPdT3z0toAvetQq40vDPE3yHBU7lJROG6dKlVxRdzHzl6FA5lduGZ1Oum9m
 Cs3P7uow==;
References: <cover.1605896059.git.gustavoars@kernel.org>
 <44b2e50d345f1319071a53fb191ac0a0cf3fcf37.1605896060.git.gustavoars@kernel.org>
 <143dd4a9-b0b7-36a6-ee33-0b5cb024c1e6@nvidia.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <a62c2a91-8e94-0731-a4b9-98d83f0e2ed4@embeddedor.com>
Date: Mon, 8 Feb 2021 08:43:39 -0600
MIME-Version: 1.0
In-Reply-To: <143dd4a9-b0b7-36a6-ee33-0b5cb024c1e6@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 106/141] net: bridge: Fix fall-through warnings
	for Clang
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org



On 2/2/21 08:16, Nikolay Aleksandrov wrote:
> On 20/11/2020 20:37, Gustavo A. R. Silva wrote:
>> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
>> by explicitly adding a break statement instead of letting the code fall
>> through to the next case.
>>
>> Link: https://github.com/KSPP/linux/issues/115
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>  net/bridge/br_input.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
>> index 59a318b9f646..8db219d979c5 100644
>> --- a/net/bridge/br_input.c
>> +++ b/net/bridge/br_input.c
>> @@ -148,6 +148,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>>  		break;
>>  	case BR_PKT_UNICAST:
>>  		dst = br_fdb_find_rcu(br, eth_hdr(skb)->h_dest, vid);
>> +		break;
>>  	default:
>>  		break;
>>  	}
>>
> 
> Somehow this hasn't hit my inbox, good thing I just got the reply and saw the
> patch. Anyway, thanks!

A lot of e-mails have been bouncing, recently. :/

I think I'll resend all the net patches in this series.

> Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

Thanks!
--
Gustavo
