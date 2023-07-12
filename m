Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4FE7582B53
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A9C5782909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1689173530; x=1691765530;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HEsEZqyAF5CV0dX25sFVpwrns2MDngxAFs4im1HqwqU=;
 b=0z7yFLyItiNDp711koXJJ4aTbp0rdLle37fAYe0YhbMjdP27PHf9jHKIU52BRdt4z2
 hjAZKjoiQEHb5q5kz+Ek1+hdx3sUZdmaBzLtd89DL13lBjOw9wQQV+yoKrvbfNXFmxfh
 Jk4kH6P2eN1yneoCJAHHFwoND1FkGzXiiEU1o1QnW6/LB/zzonyGfvK5OU+sVptxz0EW
 OCmTYqsqNvVF+VSL4YU8wooryaVmfUbHdxEdoexMojQ50mDYJVRIJ4W6CSi86DBrxHQE
 asx8W9vjMFRahGC7446wCZAdcdOkCOXORgLMHMiPJlyP03Sj8I+XdE+hALWVkO7AYGtc
 6WKw==
Message-ID: <caf5bc87-0b5f-cd44-3c1c-5842549c8c6e@blackwall.org>
Date: Wed, 12 Jul 2023 17:52:09 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230711235415.92166-1-kuniyu@amazon.com>
 <ZK69NDM60+N0TTFh@shredder>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZK69NDM60+N0TTFh@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v1 net] bridge: Return an error when enabling
 STP in netns.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Kuniyuki Iwashima <kuni1840@gmail.com>, Harry Coin <hcoin@quietfountain.com>, Eric Dumazet <edumazet@google.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On 12/07/2023 17:48, Ido Schimmel wrote:
> On Tue, Jul 11, 2023 at 04:54:15PM -0700, Kuniyuki Iwashima wrote:
>> When we create an L2 loop on a bridge in netns, we will see packets storm
>> even if STP is enabled.
>>
>>   # unshare -n
>>   # ip link add br0 type bridge
>>   # ip link add veth0 type veth peer name veth1
>>   # ip link set veth0 master br0 up
>>   # ip link set veth1 master br0 up
>>   # ip link set br0 type bridge stp_state 1
>>   # ip link set br0 up
>>   # sleep 30
>>   # ip -s link show br0
>>   2: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
>>       link/ether b6:61:98:1c:1c:b5 brd ff:ff:ff:ff:ff:ff
>>       RX: bytes  packets  errors  dropped missed  mcast
>>       956553768  12861249 0       0       0       12861249  <-. Keep
>>       TX: bytes  packets  errors  dropped carrier collsns     |  increasing
>>       1027834    11951    0       0       0       0         <-'   rapidly
>>
>> This is because llc_rcv() drops all packets in non-root netns and BPDU
>> is dropped.
>>
>> Let's show an error when enabling STP in netns.
>>
>>   # unshare -n
>>   # ip link add br0 type bridge
>>   # ip link set br0 type bridge stp_state 1
>>   Error: bridge: STP can't be enabled in non-root netns.
>>
>> Note this commit will be reverted later when we namespacify the whole LLC
>> infra.
>>
>> Fixes: e730c15519d0 ("[NET]: Make packet reception network namespace safe")
>> Suggested-by: Harry Coin <hcoin@quietfountain.com>
> 
> I'm not sure that's accurate. I read his response in the link below and
> he says "I'd rather be warned than blocked" and "But better warned and
> awaiting a fix than blocked", which I agree with. The patch has the
> potential to cause a lot of regressions, but without actually fixing the
> problem.
> 
> How about simply removing the error [1]? Since iproute2 commit
> 844c37b42373 ("libnetlink: Handle extack messages for non-error case"),
> it can print extack warnings and not only errors. With the diff below:
> 
>  # unshare -n 
>  # ip link add name br0 type bridge
>  # ip link set dev br0 type bridge stp_state 1
>  Warning: bridge: STP can't be enabled in non-root netns.
>  # echo $?
>  0
> 
> [1]
> diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
> index a807996ac56b..b5143de37938 100644
> --- a/net/bridge/br_stp_if.c
> +++ b/net/bridge/br_stp_if.c
> @@ -201,10 +201,8 @@ int br_stp_set_enabled(struct net_bridge *br, unsigned long val,
>  {
>         ASSERT_RTNL();
>  
> -       if (!net_eq(dev_net(br->dev), &init_net)) {
> +       if (!net_eq(dev_net(br->dev), &init_net))
>                 NL_SET_ERR_MSG_MOD(extack, "STP can't be enabled in non-root netns");
> -               return -EINVAL;
> -       }
>  
>         if (br_mrp_enabled(br)) {
>                 NL_SET_ERR_MSG_MOD(extack,
> 

I'd prefer this approach to changing user-visible behaviour and potential regressions.
Just change the warning message.

Thanks,
 Nik

