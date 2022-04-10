Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=cuyUckZywUZIygZ8ZXPDDXCDGhQWLlczqmeYcUsJb
 28=; b=Y2sjtjMKmcZN+iFCh6tUH9R8b1YIFSMf47MxY2GFUEI/LzkJm4YgQ7xRW
 8Cz7sAaGDTn/I+kaN8xJae6Zqz0402CY/Y4AYqxdrQDOD+eYKMF8dNfbkLdq3h3C
 w5b/qnHKtUOMmpykk/SsUXHiJ5VD1/K5x9vWzDvjGpnpyvIBu2/M76F3qaXMgVKc
 wNkj9SVI8LbQMsS/Ucn43FOzmkE7JAOr9ZctrwysezMQAryXu7SnGAzcsmjkR+u6
 avT5xcQ87Pvh0E3MRRg/jX5DCjz702OeF70yA1NCuVhPs9bUEA3UByXOrrk/cCXU
 S/fP1Yq79etHPpSGyAaxoo3hDa+wQ==
Date: Sun, 10 Apr 2022 20:19:48 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <YlMRtBR3+b4dKjC/@shredder>
References: <20220410134227.18810-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220410134227.18810-1-arinc.unal@arinc9.com>
Subject: Re: [Bridge] [PATCH net-next] net: bridge: offload BR_HAIRPIN_MODE,
 BR_ISOLATED, BR_MULTICAST_TO_UNICAST
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>

On Sun, Apr 10, 2022 at 04:42:27PM +0300, Arınç ÜNAL wrote:
> Add BR_HAIRPIN_MODE, BR_ISOLATED and BR_MULTICAST_TO_UNICAST port flags to
> BR_PORT_FLAGS_HW_OFFLOAD so that switchdev drivers which have an offloaded
> data plane have a chance to reject these bridge port flags if they don't
> support them yet.
> 
> It makes the code path go through the
> SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS driver handlers, which return
> -EINVAL for everything they don't recognize.
> 
> For drivers that don't catch SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS at
> all, switchdev will return -EOPNOTSUPP for those which is then ignored, but
> those are in the minority.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

> ---
> Let me know if this is netdev/net material instead.

I prefer net-next
