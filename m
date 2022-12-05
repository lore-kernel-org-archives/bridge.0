Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 198B060B30
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A6AD8607B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nq/qiZ4kHuJyfTha/rmI50ZFco+CixoW93NZbxAckHE=;
 b=NHKFcuVc8bLzu0js9axZp84zVm4uj8ElmTmkZW5qt0pHWnr70eBt/L5b8kEVPxNnu7
 79pe7PzngBP9EyDHtXrbw037t6mUsINpZIFyI+jmcFnr2c7JzNy47zT3f8yCDLpgRdiy
 ahOL4MwFW57kHxSTVg8X/obBLW1i0ioSu7grsBoYPSeDabST5PDjLAEAtMyTIT0yx62Z
 yOooM8j9LYBFBlEu2Riy48lsvMiTwOjtcrebLexrwXiS9AZQNj0s6GdeZmQ0V/+SWHEg
 p1Bm3pbIFzozydzO6eDIIjpUbJV3xrzmHHxomO/aI0NaixfGMqyZZ6KrbtOKOVQ13336
 pu9Q==
Message-ID: <f9e8a036-245f-a77b-095c-d1ae709bfb6d@blackwall.org>
Date: Mon, 5 Dec 2022 13:43:44 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20221205074251.4049275-1-idosch@nvidia.com>
 <20221205074251.4049275-9-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221205074251.4049275-9-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 8/8] bridge: mcast: Remove redundant
 function arguments
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

On 05/12/2022 09:42, Ido Schimmel wrote:
> Drop the first three arguments and instead extract them from the MDB
> configuration structure.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_mdb.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


