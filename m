Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611336801;
 bh=Zz7/sBdhG8IGiogtBKk0mTY8NegdDfBFJuOqnDNcMLA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=RuJ+Df5lfmrPNDJ51PkcEYxRr+jpqXQweQhIQPESSUJFK0m1FLcTJcs5Q7UA7sZnF
 XK3A8YbaQIIAYHnH3igiGNR77G9IqJFjs1mARPv4qLPjSPXGN0QolPVyxGJ9WEv/u8
 Y/d9zwQtM+OKDg0GvUpb52T12cai/I+pyL/1NLce+tvUsGWlHPv+pPWCFpbhhgjqFO
 CAfQgtPaeed/fEFusGweDk+j3JPGtmdm5Vma2BXVOFOV0KOg+EZDAu3aDH14bf9Lqz
 zBMx1SGbfXMLA13aAyZqRImtyFqsubrdcHxpfC3+eBRet3kWN+UrTzHxNAzq14f1cD
 MpQYrozyRdepQ==
Date: Fri, 22 Jan 2021 09:33:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20210122093320.6fbb5f11@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <1611307933-115887-1-git-send-email-abaci-bugfix@linux.alibaba.com>
References: <1611307933-115887-1-git-send-email-abaci-bugfix@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: Use PTR_ERR_OR_ZERO instead
 if(IS_ERR(...)) + PTR_ERR
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Cc: bridge@lists.linux-foundation.org, ndesaulniers@google.com, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, nikolay@nvidia.com, roopa@nvidia.com, natechancellor@gmail.com, davem@davemloft.net

On Fri, 22 Jan 2021 17:32:13 +0800 Jiapeng Zhong wrote:
> coccicheck suggested using PTR_ERR_OR_ZERO() and looking at the code.
> 
> Fix the following coccicheck warnings:
> 
> ./net/bridge/br_multicast.c:1295:7-13: WARNING: PTR_ERR_OR_ZERO can be
> used.
> 
> Reported-by: Abaci <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>

You need to CC netdev
