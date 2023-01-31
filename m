Return-Path: <leon@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3A6BB60B10
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5B69960B01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675171959;
 bh=d+6BT8JVSgEFjcy1nrHUrWL1dja7eV7LU+hE8XcgdKc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pes9sHnLghuyBq1lbURcdB7zDnGTSwRDZB0+EKBLqNBJDecx1Cu/zl4o8EY0/Uiuv
 WKhq36iRnN6nSXRZ2D6GioT3mL1abMVkS2QWeFWW4FQ5B7ivByXinVfjUUjUmPodO2
 B8W7wPuWnl8qIkhQV5nTb9Xrrw4SJo1pKmfA+Ae4kAhnnd9FEGj6qt1eR8ahXbCI6P
 E/vqHZoF/3IbFvS66BdgoNX139/lYg3nsLblW/d/TD+f/9gOUZjCDk5Pxb9wCOKpM7
 kv+KIuRw3xZExMXpAzDm9LIKwSPiNIyEQSFTPwIcA6kKjQK01t9K3B6vgUFRs0Uagf
 zLPzlAW+BnFAg==
Date: Tue, 31 Jan 2023 15:32:35 +0200
From: Leon Romanovsky <leon@kernel.org>
Message-ID: <Y9kYcwSm8X0mP5gR@unreal>
References: <c1a88f471a8aa6d780dde690e76b73ba15618b6d.1675010984.git.leon@kernel.org>
 <801a4a44f0fb6e37f79037eae9a3db50191cdb12.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <801a4a44f0fb6e37f79037eae9a3db50191cdb12.camel@redhat.com>
Subject: Re: [Bridge] [PATCH net-next v2] netlink: provide an ability to set
 default extack message
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Vladimir Oltean <olteanv@gmail.com>, "David S . Miller" <davem@davemloft.net>

On Tue, Jan 31, 2023 at 12:47:03PM +0100, Paolo Abeni wrote:
> Hello,
> 
> On Sun, 2023-01-29 at 18:51 +0200, Leon Romanovsky wrote:
> > In netdev common pattern, extack pointer is forwarded to the drivers
> > to be filled with error message. However, the caller can easily
> > overwrite the filled message.
> > 
> > Instead of adding multiple "if (!extack->_msg)" checks before any
> > NL_SET_ERR_MSG() call, which appears after call to the driver, let's
> > add new macro to common code.
> > 
> > [1] https://lore.kernel.org/all/Y9Irgrgf3uxOjwUm@unreal
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> 
> I'm sorry for nit-picking, but checkpatch complains the author
> (leon@kernel.org) does not match the SoB tag. A v3 with a suitable
> From: tag should fix that.

Sure, will resend.

> 
> Thanks,
> 
> Paolo
> 
