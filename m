Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmOsTMYoPyt+EMa6/G7D2cBX0asmGes7MTGnDcub4SY=;
 b=kpxnpZ2fPtPQnQ1cqaqBBX8je9MOc9WFGeG9tF0SgAGZ+wyO/+TkxmyotMUXFtfnnNI3/qkG+m+CIYvpPH+aajiefVC98makLT+XaBQZiiqjWGiUXnmEPq3rh+1gfrMe+i+2vuhQtWclyP29VsA0g+/zINS9fERTHRltR+sL9b6QQrDCbJoUtQJoJ/9V2P8uS5RV8Q8i9hg4ugn5iB0gdb88IRrH08BPEdaJdWb+mdTkwoF6a7G5yAZInWXUDPCYmOvBoLZ3FVtog+9SvxjgyqMeRMptS2+0mP6r66wfdjJGKiFJQSu9v+/jt6kHHhF65IMKZizLe7fa9579D7t9kg==
Message-ID: <af122e70-d073-cd83-541c-b3a0125c7cfb@nvidia.com>
Date: Mon, 7 Feb 2022 12:51:05 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220207100742.15087-1-schultz.hans+netdev@gmail.com>
 <20220207100742.15087-3-schultz.hans+netdev@gmail.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
In-Reply-To: <20220207100742.15087-3-schultz.hans+netdev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 2/4] net: bridge: dsa: Add support for
 offloading of locked port flag
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <schultz.hans@gmail.com>, davem@davemloft.net, kuba@kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Hans Schultz <schultz.hans+netdev@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, Vladimir Oltean <olteanv@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>

On 07/02/2022 12:07, Hans Schultz wrote:
> Various switchcores support setting ports in locked mode, so that
> clients behind locked ports cannot send traffic through the port
> unless a fdb entry is added with the clients MAC address.
> 
> Among the switchcores that support this feature is the Marvell
> mv88e6xxx family.
> 
> Signed-off-by: Hans Schultz <schultz.hans+netdev@gmail.com>
> ---
>  net/bridge/br_switchdev.c | 2 +-
>  net/dsa/port.c            | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 

Hi,
For some reason I still haven't received patch 01 which adds this new flag,
so I'll comment on this patch first.

These should be 2 separate patches, there is no bridge: dsa:.
Please break them into a bridge: and dsa: parts that add the flag, it also
makes it easier for people who have to backport patches and fixes later.

In addition please mention in the commit message why the flag is
added there, i.e. in order to allow to be offloaded.

Thanks,
 Nik

