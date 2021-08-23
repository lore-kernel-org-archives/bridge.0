Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljBFLuXJ/cSUndGBlyeCHlEliS+JhIo5P/GMln0Iihc=;
 b=ul01kYNmnXb2fTXZivo1w9Ze1WSlD//UUkDJKn8vLopHZCvgstSWkV1pDphY4JjqbGPzjJDOdynqBJEEpOVsst3DPIgs5B5lQ8HJgIn55ilWyw7wvGRZDKd0A5I4HVP27EUoxfmbZvSItwfWrleyg7sTNS/tZXQI6HPAMfppDZkc7jqogyiMa03+0jDfLYcfMR+La7bh6VFxus7fepmMmOHzbfX4MDSUUuZESG25T1d/VKnasrE4Z8lcgzYuNpiHuOnSMmlGAv4ybFQgK/AyrJjuyJX4VJ+dU/U8kGztF7/k93gjDUEfa4LU190VTKssHEzUlrdcTDnmyoUNpqKIJA==
References: <20210823102118.17966-1-l4stpr0gr4m@gmail.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <d37ff915-6d94-2d22-9e93-46b374fc47d7@nvidia.com>
Date: Mon, 23 Aug 2021 13:25:20 +0300
In-Reply-To: <20210823102118.17966-1-l4stpr0gr4m@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v3 net-next] net: bridge: change return type of
 br_handle_ingress_vlan_tunnel
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Kangmin Park <l4stpr0gr4m@gmail.com>, Roopa Prabhu <roopa@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org

On 23/08/2021 13:21, Kangmin Park wrote:
> br_handle_ingress_vlan_tunnel() is only referenced in
> br_handle_frame(). If br_handle_ingress_vlan_tunnel() is called and
> return non-zero value, goto drop in br_handle_frame().
> 
> But, br_handle_ingress_vlan_tunnel() always return 0. So, the
> routines that check the return value and goto drop has no meaning.
> 
> Therefore, change return type of br_handle_ingress_vlan_tunnel() to
> void and remove if statement of br_handle_frame().
> 
> Signed-off-by: Kangmin Park <l4stpr0gr4m@gmail.com>
> ---
> v3:
>  - remove unnecessary return statement
> 
> v2:
>  - cleanup instead of modifying ingress function
>  - change prototype of ingress function
>  - cleanup br_handle_frame function
>  - change commit message accordingly
> 
>  net/bridge/br_input.c          |  7 ++-----
>  net/bridge/br_private_tunnel.h |  6 +++---
>  net/bridge/br_vlan_tunnel.c    | 14 ++++++--------
>  3 files changed, 11 insertions(+), 16 deletions(-)
> 

Looks good to me,
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

