Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8C4F740273
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D1CA64021C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2KOkOgucQ711ynKTqc+6IMM+flOlcUVE7g4ZI5EOrFw=;
 b=woHSTtiIrAj78Rz3ZxZG+nd8ruRPitAPzXWV9EoJUF7uMNH+n6vjPpQ2JgkV+9Rz1f
 iFoeq3gaEzCYhjEIxQtuTr7CPcqeNIgCwAO4D7zTjDNkPOjpr2omaZ0kbUNfLX+47BGK
 nBK6X1eYH4sSe+B+Des5qIuLPiv1DqCo5AwuQmho7n6y+ksnMba3bWnQtfkW80Z+20mT
 +347qMWNPFeXmg8+/GSweKdbo6QYTGctQ/tsMuQ9ZFMKhlfTM4UTDM12fALJHwEWFHPy
 qF/oBdGWDV9sQhC+SKkY5OLWUC9xtNAMq9gZybbzJEFsna5rW1okZxy234QExtSIKObY
 1a0w==
Message-ID: <fabadfa4-b914-96b6-992e-dcebac1c0ef0@blackwall.org>
Date: Fri, 9 Dec 2022 10:09:11 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20221208152839.1016350-1-idosch@nvidia.com>
 <20221208152839.1016350-14-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221208152839.1016350-14-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 13/14] selftests: forwarding: Rename
 bridge_mdb test
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
> The test is only concerned with host MDB entries and not with MDB
> entries as a whole. Rename the test to reflect that.
> 
> Subsequent patches will add a more general test that will contain the
> test cases for host MDB entries and remove the current test.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  tools/testing/selftests/net/forwarding/Makefile                 | 2 +-
>  .../net/forwarding/{bridge_mdb.sh => bridge_mdb_host.sh}        | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename tools/testing/selftests/net/forwarding/{bridge_mdb.sh => bridge_mdb_host.sh} (100%)
> 
> diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
> index a9c5c1be5088..f2df81ca3179 100644
> --- a/tools/testing/selftests/net/forwarding/Makefile
> +++ b/tools/testing/selftests/net/forwarding/Makefile
> @@ -2,7 +2,7 @@
>  
>  TEST_PROGS = bridge_igmp.sh \
>  	bridge_locked_port.sh \
> -	bridge_mdb.sh \
> +	bridge_mdb_host.sh \
>  	bridge_mdb_port_down.sh \
>  	bridge_mld.sh \
>  	bridge_port_isolation.sh \
> diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb_host.sh
> similarity index 100%
> rename from tools/testing/selftests/net/forwarding/bridge_mdb.sh
> rename to tools/testing/selftests/net/forwarding/bridge_mdb_host.sh

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
