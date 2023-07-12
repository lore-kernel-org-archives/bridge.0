Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AC51F60A91
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 48B8560A5E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1689143903; x=1691735903;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tw6o+RiD3xsjf8AwbB7vgQei7f5cIWP68DUtUmS4mTI=;
 b=eKyatQ3esvy/Br++K/ZWzafOnodEk4cb1aY/mG6E84uxtNIAJ4VGVvMrDYaONeNr02
 8PZsdb0Y3LJVkq5iKxZIyZm6N8YriQ5AHGrIstSu5YXcW2wAmTwsb3riI5ZnwxlfLBUb
 3XWey52p+EEUnY65pGla/nqlwWXkH5BIo/6/vv9hvyNwkycdsnA0u1R00nSXgMYMbYCp
 QJoZRFMCG5seYz5oHzp/9WQk2OGEH0cphmXklRUUQD6br/ohNUBuot8pFU5f4da8ZkHX
 XliKyzfX0WiJrOaMwAofZG7b35soOyfOrDw2Qf5L1i3uaLTAzT2xY3RJ4Bx8AcNfvs0D
 fl5A==
Message-ID: <18cfa70a-35b6-da02-3dd4-0c8ab6639b9b@blackwall.org>
Date: Wed, 12 Jul 2023 09:38:21 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230711235415.92166-1-kuniyu@amazon.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230711235415.92166-1-kuniyu@amazon.com>
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
To: Kuniyuki Iwashima <kuniyu@amazon.com>, Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Harry Coin <hcoin@quietfountain.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "Eric W. Biederman" <ebiederm@xmission.com>, Kuniyuki Iwashima <kuni1840@gmail.com>

On 12/07/2023 02:54, Kuniyuki Iwashima wrote:
> When we create an L2 loop on a bridge in netns, we will see packets storm
> even if STP is enabled.
> 
>   # unshare -n
>   # ip link add br0 type bridge
>   # ip link add veth0 type veth peer name veth1
>   # ip link set veth0 master br0 up
>   # ip link set veth1 master br0 up
>   # ip link set br0 type bridge stp_state 1
>   # ip link set br0 up
>   # sleep 30
>   # ip -s link show br0
>   2: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
>       link/ether b6:61:98:1c:1c:b5 brd ff:ff:ff:ff:ff:ff
>       RX: bytes  packets  errors  dropped missed  mcast
>       956553768  12861249 0       0       0       12861249  <-. Keep
>       TX: bytes  packets  errors  dropped carrier collsns     |  increasing
>       1027834    11951    0       0       0       0         <-'   rapidly
> 
> This is because llc_rcv() drops all packets in non-root netns and BPDU
> is dropped.
> 
> Let's show an error when enabling STP in netns.
> 
>   # unshare -n
>   # ip link add br0 type bridge
>   # ip link set br0 type bridge stp_state 1
>   Error: bridge: STP can't be enabled in non-root netns.
> 
> Note this commit will be reverted later when we namespacify the whole LLC
> infra.
> 
> Fixes: e730c15519d0 ("[NET]: Make packet reception network namespace safe")
> Suggested-by: Harry Coin <hcoin@quietfountain.com>
> Link: https://lore.kernel.org/netdev/0f531295-e289-022d-5add-5ceffa0df9bc@quietfountain.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/bridge/br_stp_if.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
> index 75204d36d7f9..a807996ac56b 100644
> --- a/net/bridge/br_stp_if.c
> +++ b/net/bridge/br_stp_if.c
> @@ -201,6 +201,11 @@ int br_stp_set_enabled(struct net_bridge *br, unsigned long val,
>  {
>  	ASSERT_RTNL();
>  
> +	if (!net_eq(dev_net(br->dev), &init_net)) {
> +		NL_SET_ERR_MSG_MOD(extack, "STP can't be enabled in non-root netns");
> +		return -EINVAL;
> +	}
> +
>  	if (br_mrp_enabled(br)) {
>  		NL_SET_ERR_MSG_MOD(extack,
>  				   "STP can't be enabled if MRP is already enabled");

Oh well, I guess this should do for now. Hopefully we don't break scripts that rely
on configuring the bridge without any errors. Thanks for the patch,

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



