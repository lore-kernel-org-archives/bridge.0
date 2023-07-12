Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2875760BE4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BE4AE60AE2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1689176793; x=1691768793;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/qsNwSJj66luchpZzX75OoZLSwHVbA5Pm9qid51Ei6Y=;
 b=PF6fmNqjZ/AYqva8v3NNTKu8eEoKH35QAaW5y9va6R7Ux8tb4vtt4fnEqofuxyvjZn
 a0qMZq/JAmWMPbOGYXnJcmQacubZOqKSeNKCmAbvSBNzJdQtuv4yS6Kk+rnWfmfClGBS
 cXP7+SuGhDwzNxvL+iujWDLk0SH2CMgt5PRsdZmx5C+WmX8GF34Se4puFXLXJd2HUjHo
 WUMkEMnuHq2blfogwHyG3OFdUk+EkXNWRaQON2Und7zDQ6c3MKwO483lZw1WfgJ4ShdM
 ga7iF5l42KYLzIqwup5geQ4ilZb0dKAHrextos3SS0y2+nKawPQyy4UD4jy1CfNyZRM5
 Jm0g==
Message-ID: <28f857c9-2ee9-6a20-ecd2-b4e63307cd89@blackwall.org>
Date: Wed, 12 Jul 2023 18:46:31 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230712154449.6093-1-kuniyu@amazon.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230712154449.6093-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v2 net] bridge: Add extack warning when
 enabling STP in netns.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Harry Coin <hcoin@quietfountain.com>, Kuniyuki Iwashima <kuni1840@gmail.com>

On 12/07/2023 18:44, Kuniyuki Iwashima wrote:
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
> Let's add extack warning when enabling STP in netns.
> 
>   # unshare -n
>   # ip link add br0 type bridge
>   # ip link set br0 type bridge stp_state 1
>   Warning: bridge: STP does not work in non-root netns.
> 
> Note this commit will be reverted later when we namespacify the whole LLC
> infra.
> 
> Fixes: e730c15519d0 ("[NET]: Make packet reception network namespace safe")
> Suggested-by: Harry Coin <hcoin@quietfountain.com>
> Link: https://lore.kernel.org/netdev/0f531295-e289-022d-5add-5ceffa0df9bc@quietfountain.com/
> Suggested-by: Ido Schimmel <idosch@idosch.org>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> v2:
>   - Just add extack instead of returning error (Ido Schimmel)
> 
> v1: https://lore.kernel.org/netdev/20230711235415.92166-1-kuniyu@amazon.com/
> ---
>  net/bridge/br_stp_if.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
> index 75204d36d7f9..b65962682771 100644
> --- a/net/bridge/br_stp_if.c
> +++ b/net/bridge/br_stp_if.c
> @@ -201,6 +201,9 @@ int br_stp_set_enabled(struct net_bridge *br, unsigned long val,
>  {
>  	ASSERT_RTNL();
>  
> +	if (!net_eq(dev_net(br->dev), &init_net))
> +		NL_SET_ERR_MSG_MOD(extack, "STP does not work in non-root netns");
> +
>  	if (br_mrp_enabled(br)) {
>  		NL_SET_ERR_MSG_MOD(extack,
>  				   "STP can't be enabled if MRP is already enabled");

Thanks,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
