Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D17FB60FE6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1769560FE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a9Apa3uOHTaWpyI4d5WsN/NOtmRrJfK1jH1TKEd9eDA=;
 b=YcdOdKovc+PQRGX9VMh5p9K6mbx4EHAfko7hOFYFKl6CslLrtwYEQ1pHihMNi3IJpe
 2tNikG+7dxK2SPd/XzHhW2POiepzA7XTnqD5Dbp1W1DDtdQPIejXmCms+vJaoWrLznxF
 XCqEkT4DjUFXEbH9r6HqszNwWnIywAdhTyMnBjPlhYqnAcC4i/O3gdqoYEsNhYX79XWq
 5OtJwfLe2AGRASttWlhAu78qy7mhfPcB+lpxg4qhqrTCfLaFOr87MoESEoBT0KZQykuF
 CJqiM+w17KaiYYSueA46iBSDoqbx3SYgvQOc2YhH95ftL5FVOGxE/iMRCJJv8cpNUrXX
 2Q0g==
Message-ID: <d7f8d88a-531b-4ccf-0310-9e3f78356fac@blackwall.org>
Date: Tue, 6 Dec 2022 14:32:47 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20221206105809.363767-1-idosch@nvidia.com>
 <20221206105809.363767-10-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221206105809.363767-10-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 9/9] bridge: mcast: Constify
 'group' argument in br_multicast_new_port_group()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 06/12/2022 12:58, Ido Schimmel wrote:
> The 'group' argument is not modified, so mark it as 'const'. It will
> allow us to constify arguments of the callers of this function in future
> patches.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     * New patch.
> 
>  net/bridge/br_multicast.c | 2 +-
>  net/bridge/br_private.h   | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 

Nice, that's even less than I anticipated. :) 
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

