Return-Path: <dsahern@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JSHVC83f9zQxL2ofrrqfIzwQKPtC6+odZmbyX4hFo0Q=;
 b=Aw2v6owuj3vvapFlLLv+r6JrXHf/uZvq6rsxgA25XH6VSNSj1BaIA9hg+9N1iWLUbm
 OqkJEc7OVpmNMAAT83FNmceMbsTrYCj/S674rq37GQFrqz+n9XWlwAeWaUmYkMt4LMo3
 0O+JBNVJFGnKvSsA6Myvux8hluxcCuCynKNO15dOyKWQA/TPY3LF3u+/8uA1ARqJ/nMP
 K9Yp4I51Nt2gUmUf24Tgh1DxNCn72cke81Be7TiI4ucDlyXvWUMP/EeY/sCbDEt12jLT
 Pqd1pklpVQCscPw1gXz2u6ziqU3W84pWkY1Cj6fZoLPE02oOjzNtU04mGNxuQSMcR5j6
 7Ykg==
References: <20201125143639.3587854-1-vladimir.oltean@nxp.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <5b4172c8-33a2-49d8-fd9f-17174242a384@gmail.com>
Date: Sun, 29 Nov 2020 13:58:56 -0700
MIME-Version: 1.0
In-Reply-To: <20201125143639.3587854-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v3 iproute2] bridge: add support for L2
	multicast groups
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, "David S. Miller" <davem@davemloft.net>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: andrew@lunn.ch, f.fainelli@gmail.com, jiri@resnulli.us, idosch@idosch.org, Jakub Kicinski <kuba@kernel.org>, vivien.didelot@gmail.com

On 11/25/20 7:36 AM, Vladimir Oltean wrote:
> Extend the 'bridge mdb' command for the following syntax:
> bridge mdb add dev br0 port swp0 grp 01:02:03:04:05:06 permanent
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> Changes in v3:
> - Using rt_addr_n2a_r instead of inet_ntop/ll_addr_n2a directly.
> - Updated the bridge manpage.
> 
> Changes in v2:
> - Removed the const void casts.
> - Removed MDB_FLAGS_L2 from the UAPI to be in sync with the latest
>   kernel patch:
>   https://patchwork.ozlabs.org/project/netdev/patch/20201028233831.610076-1-vladimir.oltean@nxp.com/
> 
>  bridge/mdb.c                   | 54 ++++++++++++++++++++++++++--------
>  include/uapi/linux/if_bridge.h |  1 +
>  man/man8/bridge.8              |  8 ++---
>  3 files changed, 46 insertions(+), 17 deletions(-)
> 

applied to iproute2-next

