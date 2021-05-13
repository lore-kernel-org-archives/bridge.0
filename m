Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1E/lC5Sf5SIPVMoorqPSt74xMA/vuk13tqjIEYp1Ao=;
 b=lcRgzbgUtgWm8bViz1d3Obhh05CCRTNiFsUD4uDgR0mHtpAUF8xWOLN9r3dQFHvrDDtdXOJzCT9GVI5NxD6hFqJaXsXWntl9UCHAnD3n7koyIFqa8TPfnn9r6/H3VmHVGafU0ALwmJpP02yyRQuio9+GCOgiUdHS/hCH6tSorUUOvgI1R2sMZTRyBgRTxTVFDb3HkJ4y3nodr7Jv0oiGE3tE8yowtWNZTys46wQC09Nrm7IdLZxyMqDj9xUkJ0oCdVCVQz8AHunmdSJ2cYTUtr3QJj3dtEdmheJEoD3/De4ozOPM4fQlU/ptRAGASnDTegIvkosOLAjfhlU3BnzL8Q==
References: <20210512231941.19211-1-linus.luessing@c0d3.blue>
 <20210512231941.19211-2-linus.luessing@c0d3.blue>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <2e58a4ab-1e40-d11c-d84e-798dd36ad679@nvidia.com>
Date: Thu, 13 May 2021 14:29:19 +0300
In-Reply-To: <20210512231941.19211-2-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Subject: Re: [Bridge] [net-next v3 01/11] net: bridge: mcast: rename
 multicast router lists and timers
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
> their IPv4 and IPv6 variants, rename the affected variable to the IPv4
> version first to avoid some renames in later commits.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---
>  net/bridge/br_forward.c   |  4 ++--
>  net/bridge/br_mdb.c       |  6 ++---
>  net/bridge/br_multicast.c | 48 +++++++++++++++++++--------------------
>  net/bridge/br_private.h   | 10 ++++----
>  4 files changed, 34 insertions(+), 34 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>


