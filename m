Return-Path: <kuba@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 746AD60E11
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C2BE860A79
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1681264194;
 bh=aKG+1zNkh2FK/EvUu9fFjD33/8YFSQKUso17chrT7tM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=MJJOzLaykGHYDe6d3WiKIwp66YlU3rDUomUj46ePjS+In4YTtE8XBrSzn7Xdg7jaq
 22CL5P9d8jx3ZDMk5Gd8II+kPUWnmG8cI/fVQzcprfpghMKvI/dDHRK3qC71nQSlKV
 wowvNJemYSPgXEqScRHsUZh/c7i/xhgKVlEN+WmoR+xtM7lTcwDvKaoMvr4AmNrWt3
 j3y+ewmrxwyJU5w8/YHWSbznXvc1e+/lpSfQG4WwgPeKeH9Aqs2B1I3H7emhzX2De8
 UPvPpr04kQyBHqo+EOtS/mm85gU7NNuMVRtEZJq4lt+yhQSeyU5TnskThUmaBtq+o9
 rpOKS6ogeLaKw==
Date: Tue, 11 Apr 2023 18:49:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20230411184952.1657b8c9@kernel.org>
In-Reply-To: <20230412013310.174561-1-xu.xin16@zte.com.cn>
References: <20230407200319.72fd763f@kernel.org>
 <20230412013310.174561-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net/bridge: add drop reasons for
 bridge forwarding
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: xu xin <xu.xin.sc@gmail.com>
Cc: netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, yang.yang29@zte.com.cn, edumazet@google.com, zhang.yunkai@zte.com.cn, xu.xin16@zte.com.cn, jiang.xuexin@zte.com.cn, roopa@nvidia.com, pabeni@redhat.com, davem@davemloft.net

On Wed, 12 Apr 2023 09:33:10 +0800 xu xin wrote:
> >You can return the reason from this function. That's the whole point of
> >SKB_NOT_DROPPED_YET existing and being equal to 0.
> 
> If returning the reasons, then the funtion will have to be renamed because
> 'should_deliever()' is expected to return a non-zero value  when it's ok to
> deliever. I don't want to change the name here, and it's better to keep its
> name and use the pointer to store the reasons.

Sure. You have to touch all callers, anyway, you can as well adjust 
the name.
