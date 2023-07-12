Return-Path: <idosch@idosch.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F0656418BB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C7412417D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; t=1689178491; x=1689264891; bh=65HYPJVnC3Dun
 dRznANcrTpdyqqmDNHjpqvmQrnP+nU=; b=cWdEMFNEqC8Au0EfKRNw7JCCLNGo0
 IvgSyrZ68knCNfzf5s0OnoYgH1jvBXnbDnjKaxA6sqqMeUu8WmngXq0qXixXAxyV
 X/NVxydIWUYgLwQpJaIk1ReSJAvfEEnTClrSAz2lBw15tOgk3xe0dEQaPhQj2Pgs
 C6fICBpUsh5Yjx1bOXiUVcxZKdGKM/I1cGZijtaRvBZGA3vT9XNBVy5FEXnZsKow
 hM0DkO0xgIL+4fpyed6xXIohcyyRTnGECwA2+VS7NEAPxHvAHUSqnY8+s3WF5E8b
 nCTjiDyue5KbagHo4iXnpuTTfJWxjU+luGOSZ+mkeEc2s9qpXGxtpBMhA==
Date: Wed, 12 Jul 2023 19:14:46 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <ZK7RdhQ6fBkOY/F+@shredder>
References: <20230712154449.6093-1-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712154449.6093-1-kuniyu@amazon.com>
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
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Kuniyuki Iwashima <kuni1840@gmail.com>, Harry Coin <hcoin@quietfountain.com>, Eric Dumazet <edumazet@google.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Wed, Jul 12, 2023 at 08:44:49AM -0700, Kuniyuki Iwashima wrote:
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

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
