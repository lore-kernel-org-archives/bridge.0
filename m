Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Om6Xdu6efzJkvDii/Uho6oEszK60ztBViYxGce2kdbc=;
 b=q8mOAXEiZUgX7ehN/fY0MLU0niCLiCrpmK100N+SgX5irM42Jz3aa60dACR9v6TxZ0N1uTzOnZ25qV2VjQ8EWgQoy9gCeZSyFd6rTSj1cKYQN0CEu4cUJW0WNzwhZ9fbwZew8iqy1NtF3dkviR1Hq44IBpprDYcLLE81GO50TpbrrmVr2auLK/0FhTv+lYAN//MsT1tj/+8TAbRxA6nGwqJMdUVfBtu7v11p60y3OdY5B4dBMP3Xa4fv/T4XHlYZtINshctIoylM5mq//Pb1S4gYoqYmGjk503NnQiYojGaWM6j7kYQ33hYruSehuaU+FI1LUGEiUhMD0hAMlZnPlA==
References: <20210512231941.19211-1-linus.luessing@c0d3.blue>
 <20210512231941.19211-8-linus.luessing@c0d3.blue>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <a75668ae-ad62-81e1-217f-76e9bbc6fa96@nvidia.com>
Date: Thu, 13 May 2021 14:35:19 +0300
In-Reply-To: <20210512231941.19211-8-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Subject: Re: [Bridge] [net-next v3 07/11] net: bridge: mcast: prepare
 add-router function for mcast router split
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
> their IPv4 and IPv6 variants move the protocol specific router list
> access to an ip4 wrapper function.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---
>  net/bridge/br_multicast.c | 59 +++++++++++++++++++++++++++------------
>  1 file changed, 41 insertions(+), 18 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

