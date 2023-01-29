Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BEB9481318
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 137A581317
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3NvzYniCjUdMvNLayLfXu1w44hZFmfdEq8cdlL/KaMc=;
 b=oWv2J6p4QX5lN/Lfv1wTpQskHVa3yKBDoOKnyIy9dS93hwW4eMp/iXjePewFqcCHmh
 pRlGBzQX8f2/88ao1YuDUJyr+phImdkiyGcXbq4pbs4GUVqNI4BPPvwlSPYprrQVHJi0
 y8S/9+IG0uSYdajht1k2wtdlaIDQR6KwvCzFX0Y+3Z0AsjSldAaYFtG13z7z3d/PFPJa
 xi3LLe9vRZAR1SQWTPna13qMH/LSWNgYrktpNGpfhjbkRXpkat6oDi/RTOtxwLioRGsF
 kIRWQ+n22wDbIpRBJ/JVY8L/LrmiHeNsP1Olub4Os3WORCbjA++JdYfdMR9qLpgKTyUJ
 Oa5A==
Message-ID: <bc462159-78bc-fe7e-2f58-9e02ccefdd54@blackwall.org>
Date: Sun, 29 Jan 2023 12:09:01 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <cover.1674752051.git.petrm@nvidia.com>
 <064ee17ac1c20603b3530a23e0ca533d57450cfc.1674752051.git.petrm@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <064ee17ac1c20603b3530a23e0ca533d57450cfc.1674752051.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 10/16] selftests: forwarding:
 bridge_mdb: Fix a typo
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
> Add the letter missing from the word "INCLUDE".
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  tools/testing/selftests/net/forwarding/bridge_mdb.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
> index 51f2b0d77067..4e16677f02ba 100755
> --- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
> +++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
> @@ -1054,7 +1054,7 @@ ctrl_igmpv3_is_in_test()
>  
>  	bridge mdb del dev br0 port $swp1 grp 239.1.1.1 vid 10
>  
> -	log_test "IGMPv3 MODE_IS_INCLUE tests"
> +	log_test "IGMPv3 MODE_IS_INCLUDE tests"
>  }
>  
>  ctrl_mldv2_is_in_test()


Oops :)

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

