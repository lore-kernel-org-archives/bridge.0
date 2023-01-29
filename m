Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C122781BC6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1BF4F81BBD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ME2PdeGInkXM+3g9j7aQWR1xp7lA94fP3xofwv1Necc=;
 b=77HUeHrM1uiM1r7VcC24466iV7eBJUjFbnVCZ43EG1qSi652M0YPNBGu51BMoN44G9
 JQtFcEn55+C3rZD2DRq2TNQ+KkeMATbVoHXdP4PLvVSQxo3YTu94lXGPsTzYGV2WD0id
 azJkBo4KxDAwQSsY+73bkhFey1xiiz+CnQgi95FVOfXujsh6hgP4J/kDTFNNUp+/ATM6
 pUsZbG3vigaoxQJpV9ODQXi2ddxkzO3SEixGLvMlOK+eweGKJ2v+Iw2Ut4XvltldZo0u
 L44UiNmjTL+44Rim7jOn85a3kw60Pij3uduhj3gSGtVrvi7Ad52nOkHyLLGuBj7p98SU
 m3yg==
Message-ID: <3430cc65-03f6-c2a7-fd6e-2611f084b434@blackwall.org>
Date: Sun, 29 Jan 2023 11:09:45 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <cover.1674752051.git.petrm@nvidia.com>
 <e22dda1dc7f1211428f6504c86ba2cedb8fdcca0.1674752051.git.petrm@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <e22dda1dc7f1211428f6504c86ba2cedb8fdcca0.1674752051.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 02/16] net: bridge: Add extack to
 br_multicast_new_port_group()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org

On 26/01/2023 19:01, Petr Machata wrote:
> Make it possible to set an extack in br_multicast_new_port_group().
> Eventually, this function will check for per-port and per-port-vlan
> MDB maximums, and will use the extack to communicate the reason for
> the bounce.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_mdb.c       | 5 +++--
>  net/bridge/br_multicast.c | 5 +++--
>  net/bridge/br_private.h   | 3 ++-
>  3 files changed, 8 insertions(+), 5 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

