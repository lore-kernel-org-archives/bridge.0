Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qj+idjaX0Iz73ZO0iuV16GW98NGx46EosyA5C19uKeY=;
 b=XZNwF+iczITK5TcGksNCsH4HrJncIpHS5+R1VBSK1YAB5c6bz5MssA9OWiRDOAmSXYi8uOdxZdZPWK+52r6rgADdXD7XIgaURPQNMcp7g461qCB9AkZAx4vR+guybLvcqgaDx24seO5g52qM2pkEJIHE2F+CI8R218h/c6JVQqs73FgZ70dVgMK8b2zfP4qoPKRlgHbjishrcEkeGwc2TedlVnfcLf9a5QAg+Dy1c/czaUDMQr0QOjGdiWeLRR4lWev0tQfSe2Dhc6CPeT6WrOmpYqfDzV4v7VSkgGi4mDe2XuMCwyweK700W4sWOP/Czhe9yDQmHaAXflDBzlRpkg==
References: <20210512231941.19211-1-linus.luessing@c0d3.blue>
 <20210512231941.19211-7-linus.luessing@c0d3.blue>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <7b47a9d8-104a-ca57-6550-df0105c72993@nvidia.com>
Date: Thu, 13 May 2021 14:33:14 +0300
In-Reply-To: <20210512231941.19211-7-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Subject: Re: [Bridge] [net-next v3 06/11] net: bridge: mcast: prepare expiry
 functions for mcast router split
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>, netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, bridge@lists.linux-foundation.org, "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>

On 13/05/2021 02:19, Linus Lüssing wrote:
> In preparation for the upcoming split of multicast router state into
> their IPv4 and IPv6 variants move the protocol specific timer access to
> an ip4 wrapper function.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---
>  net/bridge/br_multicast.c | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

