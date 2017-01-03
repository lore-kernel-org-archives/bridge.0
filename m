Return-Path: <nbd@nbd.name>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; 
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject;
	bh=77Rhzu1KaVJXSxzWhIfCS+pbnohx8ZgIKVdqHfkRQO8=; 
	b=QWnOV/g5gBntRKZrfTbpmYurKq67jUGWK/y8yjJjSMv/QgS2pMu0K9wVCKqD16Ds4C/Keb8ygACG5ZZE1GS+XQGS9/ams1FaZTogZnuTC9ChB21dDuPyMRGclYEVPc6GtByPnZpDOB7JlZAHs9lquIhiDauXHwzDYqFwxhuuyMg=;
References: <20170102193214.31723-1-linus.luessing@c0d3.blue>
From: Felix Fietkau <nbd@nbd.name>
Message-ID: <8db3f67d-a767-d61e-b101-9b78c1f59569@nbd.name>
Date: Tue, 3 Jan 2017 14:15:29 +0100
MIME-Version: 1.0
In-Reply-To: <20170102193214.31723-1-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next] bridge: multicast to unicast
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>, netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, linux-wireless@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

On 2017-01-02 20:32, Linus Lüssing wrote:
> Implements an optional, per bridge port flag and feature to deliver
> multicast packets to any host on the according port via unicast
> individually. This is done by copying the packet per host and
> changing the multicast destination MAC to a unicast one accordingly.
> 
> multicast-to-unicast works on top of the multicast snooping feature of
> the bridge. Which means unicast copies are only delivered to hosts which
> are interested in it and signalized this via IGMP/MLD reports
> previously.
> 
> This feature is intended for interface types which have a more reliable
> and/or efficient way to deliver unicast packets than broadcast ones
> (e.g. wifi).
> 
> However, it should only be enabled on interfaces where no IGMPv2/MLDv1
> report suppression takes place. This feature is disabled by default.
> 
> The initial patch and idea is from Felix Fietkau.
> 
> Cc: Felix Fietkau <nbd@nbd.name>
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Please add Signed-off-by: Felix Fietkau <nbd@nbd.name>
in the next version, and maybe also From:

Thanks,

- Felix
