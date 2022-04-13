Return-Path: <dsahern@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649815481;
 bh=Vu+KgFouk8ANRuvIxUVioi8TD5dzKVTLxlfZyOyStr0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=oMWCA75tVI/a3DU0b4D8ROEQAnmjNK/m1j0epJam9eyCkHPdJfBkq+VniG4iML3kg
 BoKVDAljU/Pe/GNNEGd7BPLrb/C+LIRLdpRAzrH4sbabmkuqPNXhO+afe4r+yvBs3S
 GisDnceTSgUH/esU7j3XaZR9P6Z7nTI8itdEnWBJCUyAqdcvNQ2qxSM0vkwe7nxH2B
 eQN8f5KXRCVISg6D9yAup2eeOJVULPDOuk3Kl0zePcli439cSOdpi7JbrkLXhWlXJG
 XmxnrIxIQ06FKPqMiooKCqQvx0S3JaJFQnHjZbkG3RD+oIIVB/ZYyfhDFK1h+6OLMZ
 Q5fNsgwfKJhdQ==
Message-ID: <c418e95e-440e-0502-58f2-63179f370a98@kernel.org>
Date: Tue, 12 Apr 2022 20:04:40 -0600
MIME-Version: 1.0
Content-Language: en-US
References: <20220412132245.2148794-1-razor@blackwall.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20220412132245.2148794-1-razor@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 0/8] net: bridge: add flush
	filtering support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org
Cc: idosch@idosch.org, bridge@lists.linux-foundation.org, davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com

On 4/12/22 7:22 AM, Nikolay Aleksandrov wrote:
> Hi,
> This patch-set adds support to specify filtering conditions for a bulk
> delete (flush) operation. This version uses a new nlmsghdr delete flag
> called NLM_F_BULK in combination with a new ndo_fdb_del_bulk op which is
> used to signal that the driver supports bulk deletes (that avoids
> pushing common mac address checks to ndo_fdb_del implementations and
> also has a different prototype and parsed attribute expectations, more
> info in patch 03). The new delete flag can be used for any RTM_DEL*
> type, implementations just need to be careful with older kernels which
> are doing non-strict attribute parses. Here I use the fact that mac

overall it looks fine to me. The rollout of BULK delete for other
commands will be slow so we need a way to reject the BULK flag if the
handler does not support it. One thought is to add another flag to
rtnl_link_flags (e.g., RTNL_FLAG_BULK_DEL_SUPPORTED) and pass that flag
in for handlers that handle bulk delete and reject it for others in core
rtnetlink code.
