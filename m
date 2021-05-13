Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqw89t/M2amB8SM1NnWj1eHg5nIHze4lql2eXRdnFXE=;
 b=Oq1eobls9WCOlI5DntjoVqsp45in985ctRgF7lkFOJa8WcxwCf+ovK48Cvs9MgVCrJfbKA4q92aqZ0tp45Ck5G1T4Ksdp3vpSSkQEEqeVjbqNQPmeLI2ePw61zo/BcaOC4wFLO1DSuf5qUQ9qxK35x4tAAz4BYHXLMg5euDL8s2DktnA78Kz5BDhRG9oCV4vZPdeh/VvmOU+xGTTseW9rKz17gFQyDJ0woAzTPVG2lKXcSwOezYRzVQB//QiEIavZaW/16arkW0CGG8IK1d9d9QX5l4M1MfNwqysfOzMKNXJB21O48+vh+UPUvZVdPsyqGGdZ0inKwvw8gfdtwc4/g==
References: <20210512231941.19211-1-linus.luessing@c0d3.blue>
 <20210512231941.19211-3-linus.luessing@c0d3.blue>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <bade919c-8535-aa53-4fac-6532ca140c03@nvidia.com>
Date: Thu, 13 May 2021 14:29:33 +0300
In-Reply-To: <20210512231941.19211-3-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Subject: Re: [Bridge] [net-next v3 02/11] net: bridge: mcast: add wrappers
 for router node retrieval
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
> their IPv4 and IPv6 variants and to avoid IPv6 #ifdef clutter later add
> two wrapper functions for router node retrieval in the payload
> forwarding code.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---
>  net/bridge/br_forward.c |  5 +++--
>  net/bridge/br_private.h | 10 ++++++++++
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

