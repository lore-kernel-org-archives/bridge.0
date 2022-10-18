Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CCFDD82F39
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 21DB681434
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WaPR/tmqWGcHhxRlM7SpojtLJcPC5mdHh5MXF3Ewvbk=;
 b=8OGa01prAdF0y4D0Uz44tSzzEmmgbLu8CCpNNBZ6LdpI+YoIkpNtWrWYfRKDEh8KCB
 bk5oGQ0yMsZ4GjqybOadty3vUndpWRk4khXdCoW85w3dsFUkL4SsZYCIGkIWqqChHoAF
 gcxmXW7THu8+MfWd3fM/GJZM1cm6coTRJ2cquKCiGo+Iv4Sex9ILtXRqWEcRKBFxePCT
 IPslvfR70QjRWwRZE7Q5E780gFbWIOXJ53O2q4IYJao76liUR26wlylXfFepiM6Fu8LG
 H9xa7DGpnweWEnBPTmk545PZgJdzWtP8PwuL8u2juBJnE4bfPAuJ6xtUbA17/0L6VnbX
 ijGg==
Message-ID: <8d1c7a93-6189-dd93-f4ee-bb76282bd2c0@blackwall.org>
Date: Tue, 18 Oct 2022 11:37:42 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20221018064001.518841-1-idosch@nvidia.com>
 <20221018064001.518841-5-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221018064001.518841-5-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 4/4] bridge: mcast: Simplify MDB entry
	creation
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

On 18/10/2022 09:40, Ido Schimmel wrote:
> Before creating a new MDB entry, br_multicast_new_group() will call
> br_mdb_ip_get() to see if one exists and return it if so.
> 
> Therefore, simply call br_multicast_new_group() and omit the call to
> br_mdb_ip_get().
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_mdb.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

