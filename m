Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634157212;
 bh=JUi6Yrt6b3RrzaP0GICRbOBRuJGs4INzI/hs1Pv1ynA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=SourJ8TlnOofBWndt0Z4Ov7zJeXmPKK9QVPLhT0bssGWje0ZQeexHPnzQKnfRe20G
 Et06r+zv79HlJn9pahoeu0mQQEvzBCOsMq6wSt/RAOyiBdj9t5eFqZGbOKPVsPlNrh
 Uena4duOKbT1zt4511C45BmlHC4cg3Tf/isiq7COiQNWqOCd1lmjAGuuNpApID921j
 RUdLd+8PJ9TW9pIkAW0iXym+eC69E6Dyfd63gjEtJxMyc22yCQBIVCacnXIvo29FkV
 tIDTmp5ZaUm44LQU+4uIfISb1y9wyrJ3LGIh5DggEmob0XAxjra7jfsa7SLAAsarOl
 Md98WOalFav3w==
Date: Wed, 13 Oct 2021 13:33:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20211013133331.0b846cd5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20211012141810.30661-1-acadx0@gmail.com>
References: <20211012141810.30661-1-acadx0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: make use of helper
 netif_is_bridge_master()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Kyungrok Chung <acadx0@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, Jozsef Kadlecsik <kadlec@netfilter.org>, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Pablo Neira Ayuso <pablo@netfilter.org>

On Tue, 12 Oct 2021 23:18:09 +0900 Kyungrok Chung wrote:
> Make use of netdev helper functions to improve code readability.
> Replace 'dev->priv_flags & IFF_EBRIDGE' with netif_is_bridge_master(dev).
> 
> Signed-off-by: Kyungrok Chung <acadx0@gmail.com>

Why leave these out?

net/batman-adv/multicast.c:     } while (upper && !(upper->priv_flags & IFF_EBRIDGE));
net/core/rtnetlink.c:                               !(dev->priv_flags & IFF_EBRIDGE))
