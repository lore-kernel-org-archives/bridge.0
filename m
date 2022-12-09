Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3D7B981CE9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7BD8E81C93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e8ok8dp6S7YvgkcFRjV3Iy77BKsNsOh23uWLYPjfni4=;
 b=HqdUkj4Sr3Sjf0oIj/n7uWMxpYgSghv876bfGCbd0v/QlQobwmMHTLVqR8Y+geJER9
 Peno6DmUNhOXOEayXlJmxNoUFRTJpM2fwAuJzljCg6KaDJ6lWQ37Th+FrqZWBlNWBZu6
 Px301IalmUidhxrEna0DytuK2nt0ozmzIL7NkIqsUEoCf8B6NjKPeDdIz+lWH4Gkf8sX
 9N50Jx0dfFp6wJlanN6iC9TXlZAK7AEjO6MC17Q5xjOGqc2qak1Rv5FdUuBvHyvIYrfm
 zHsQiJg3QmFj3vh+JxBdrP8eidG+5y6deGD815Di6RhwAdmrccjCcyDYCFXNcYc/rRMu
 8NYw==
Message-ID: <2fa88776-fc7e-564c-18d9-83c75414b838@blackwall.org>
Date: Fri, 9 Dec 2022 09:30:21 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20221208152839.1016350-1-idosch@nvidia.com>
 <20221208152839.1016350-5-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221208152839.1016350-5-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 04/14] bridge: mcast: Add a
 centralized error path
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

On 08/12/2022 17:28, Ido Schimmel wrote:
> Subsequent patches will add memory allocations in br_mdb_config_init()
> as the MDB configuration structure will include a linked list of source
> entries. This memory will need to be freed regardless if br_mdb_add()
> succeeded or failed.
> 
> As a preparation for this change, add a centralized error path where the
> memory will be freed.
> 
> Note that br_mdb_del() already has one error path and therefore does not
> require any changes.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_mdb.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


