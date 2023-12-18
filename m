Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34774101C8
	for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 08:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DI/ht/Q+"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D00B381F4E
	for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 08:22:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D00B381F4E
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DI/ht/Q+
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ohZTVNmrV5NK for <bridge@lists.linux-foundation.org>;
	Mon, 18 Dec 2023 08:22:40 +0000 (UTC)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 880D081BFA
	for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 08:22:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 880D081BFA
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5cd8e2988ddso87068a12.3
        for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 00:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702887760; x=1703492560; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zau/JatSH7MN7K5B/zm+elLYDg0JQrNA93ntWIyNs+M=;
        b=DI/ht/Q+7uZ+dKaXIC9kPhUHSYLZJI5VI7wcQWKYpuQxv2u3P3OXQl+FazA/nQRfld
         6gmzPPWO+BMma3e2//EXgEgUJ1juMwrd2KifgPpSpMYgXsSqHlJXYBKvPtQyEyuLTCd4
         P/W+jYZg5O84oHSGWQHpICuzTFxDp3FQuwnTDsHQMsZSRusF/Q9N2l5mg6l7Il6D9z/0
         O7+8XrrR+b73Rv/TM8PnbIJ28FfI5bOYQHNvus9fAjLT1Jb8SnbFJpAK1qJvbcsI6Dru
         wirLj5n+0+e2Dou57pAB2/C3FzP07at/tFtlxK8TPg97GUEYQe1w/DhMTgY0jw9l04qW
         Uuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702887760; x=1703492560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zau/JatSH7MN7K5B/zm+elLYDg0JQrNA93ntWIyNs+M=;
        b=EZqQhjz4zXAWKEiGAVHk7vofI0VuRKuIgncGtgH6tvAgH7Toh5lfcodDb3eDL9CzLY
         dorvi0rUkpWsygdjHex0MzCqs+1RUXGAryJ/ljpu5slf9lbShi3yGwZDMDkCLbBQuXY9
         h/ng4QvbuxAy87sKOnAspl0asES90HNNsL/aAt6ay+AgoLDyauAIxGHV7QH5G2YSRa9M
         6Zfh76nr3aO5XsFjUmauXL5yMQn0c1NO3eXAJeuXqJVFWgQCPaYk+HN9xN6mJ6kdOCnf
         2UDBehJPeURgpiUoIsoLJC2D20ukLvgVDWdUnT8/skgLMdTaAZk8Yx54aBJ5PebpxvGS
         U0Sw==
X-Gm-Message-State: AOJu0YyK64KPzlEuH6l+uRi1li9CPq2RWUKtO4jfG/Gnpv3j561dRBmj
	zRHpoJiQd+tOL0qr4ZaUH3U=
X-Google-Smtp-Source: AGHT+IFtxMYhQV216xRWzeecnxjuJ1IXbRBR9KiR/zpjaVw9kuZsaIhxJNXGSx6ZWolu7j/0EWv3dA==
X-Received: by 2002:a05:6a20:7fa6:b0:18f:fbe4:ca80 with SMTP id d38-20020a056a207fa600b0018ffbe4ca80mr6955083pzj.63.1702887759720;
        Mon, 18 Dec 2023 00:22:39 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902c40900b001bc676df6a9sm18416562plk.132.2023.12.18.00.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 00:22:39 -0800 (PST)
Date: Mon, 18 Dec 2023 16:22:29 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, roopa@nvidia.com, razor@blackwall.org,
	petrm@nvidia.com
Subject: Re: [PATCH net-next 8/9] selftests: bridge_mdb: Add MDB bulk
 deletion test
Message-ID: <ZYABRWdw798FbaTf@Laptop-X1>
References: <20231217083244.4076193-1-idosch@nvidia.com>
 <20231217083244.4076193-9-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231217083244.4076193-9-idosch@nvidia.com>

On Sun, Dec 17, 2023 at 10:32:43AM +0200, Ido Schimmel wrote:
> Add test cases to verify the behavior of the MDB bulk deletion
> functionality in the bridge driver.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Acked-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

> ---
>  .../selftests/net/forwarding/bridge_mdb.sh    | 191 +++++++++++++++++-
>  1 file changed, 189 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
> index e4e3e9405056..61348f71728c 100755
> --- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
> +++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
> @@ -803,11 +803,198 @@ cfg_test_dump()
>  	cfg_test_dump_common "L2" l2_grps_get
>  }
>  
> +# Check flush functionality with different parameters.
> +cfg_test_flush()
> +{
> +	local num_entries
> +
> +	# Add entries with different attributes and check that they are all
> +	# flushed when the flush command is given with no parameters.
> +
> +	# Different port.
> +	bridge mdb add dev br0 port $swp1 grp 239.1.1.1 vid 10
> +	bridge mdb add dev br0 port $swp2 grp 239.1.1.2 vid 10
> +
> +	# Different VLAN ID.
> +	bridge mdb add dev br0 port $swp1 grp 239.1.1.3 vid 10
> +	bridge mdb add dev br0 port $swp1 grp 239.1.1.4 vid 20
> +
> +	# Different routing protocol.
> +	bridge mdb add dev br0 port $swp1 grp 239.1.1.5 vid 10 proto bgp
> +	bridge mdb add dev br0 port $swp1 grp 239.1.1.6 vid 10 proto zebra
> +
> +	# Different state.
> +	bridge mdb add dev br0 port $swp1 grp 239.1.1.7 vid 10 permanent
> +	bridge mdb add dev br0 port $swp1 grp 239.1.1.8 vid 10 temp
> +
> +	bridge mdb flush dev br0
> +	num_entries=$(bridge mdb show dev br0 | wc -l)
> +	[[ $num_entries -eq 0 ]]
> +	check_err $? 0 "Not all entries flushed after flush all"
> +
> +	# Check that when flushing by port only entries programmed with the
> +	# specified port are flushed and the rest are not.
> +
> +	bridge mdb add dev br0 port $swp1 grp 239.1.1.1 vid 10
> +	bridge mdb add dev br0 port $swp2 grp 239.1.1.1 vid 10
> +	bridge mdb add dev br0 port br0 grp 239.1.1.1 vid 10
> +
> +	bridge mdb flush dev br0 port $swp1
> +
> +	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port $swp1"
> +	check_fail $? "Entry not flushed by specified port"
> +	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port $swp2"
> +	check_err $? "Entry flushed by wrong port"
> +	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port br0"
> +	check_err $? "Host entry flushed by wrong port"
> +
> +	bridge mdb flush dev br0 port br0
> +
> +	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port br0"
> +	check_fail $? "Host entry not flushed by specified port"
> +
> +	bridge mdb flush dev br0
> +
> +	# Check that when flushing by VLAN ID only entries programmed with the
> +	# specified VLAN ID are flushed and the rest are not.
> +
> +	bridge mdb add dev br0 port $swp1 grp 239.1.1.1 vid 10
> +	bridge mdb add dev br0 port $swp2 grp 239.1.1.1 vid 10
> +	bridge mdb add dev br0 port $swp1 grp 239.1.1.1 vid 20
> +	bridge mdb add dev br0 port $swp2 grp 239.1.1.1 vid 20
> +
> +	bridge mdb flush dev br0 vid 10
> +
> +	bridge mdb get dev br0 grp 239.1.1.1 vid 10 &> /dev/null
> +	check_fail $? "Entry not flushed by specified VLAN ID"
> +	bridge mdb get dev br0 grp 239.1.1.1 vid 20 &> /dev/null
> +	check_err $? "Entry flushed by wrong VLAN ID"
> +
> +	bridge mdb flush dev br0
> +
> +	# Check that all permanent entries are flushed when "permanent" is
> +	# specified and that temporary entries are not.
> +
> +	bridge mdb add dev br0 port $swp1 grp 239.1.1.1 permanent vid 10
> +	bridge mdb add dev br0 port $swp2 grp 239.1.1.1 temp vid 10
> +
> +	bridge mdb flush dev br0 permanent
> +
> +	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port $swp1"
> +	check_fail $? "Entry not flushed by \"permanent\" state"
> +	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port $swp2"
> +	check_err $? "Entry flushed by wrong state (\"permanent\")"
> +
> +	bridge mdb flush dev br0
> +
> +	# Check that all temporary entries are flushed when "nopermanent" is
> +	# specified and that permanent entries are not.
> +
> +	bridge mdb add dev br0 port $swp1 grp 239.1.1.1 permanent vid 10
> +	bridge mdb add dev br0 port $swp2 grp 239.1.1.1 temp vid 10
> +
> +	bridge mdb flush dev br0 nopermanent
> +
> +	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port $swp1"
> +	check_err $? "Entry flushed by wrong state (\"nopermanent\")"
> +	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port $swp2"
> +	check_fail $? "Entry not flushed by \"nopermanent\" state"
> +
> +	bridge mdb flush dev br0
> +
> +	# Check that L2 host entries are not flushed when "nopermanent" is
> +	# specified, but flushed when "permanent" is specified.
> +
> +	bridge mdb add dev br0 port br0 grp 01:02:03:04:05:06 permanent vid 10
> +
> +	bridge mdb flush dev br0 nopermanent
> +
> +	bridge mdb get dev br0 grp 01:02:03:04:05:06 vid 10 &> /dev/null
> +	check_err $? "L2 host entry flushed by wrong state (\"nopermanent\")"
> +
> +	bridge mdb flush dev br0 permanent
> +
> +	bridge mdb get dev br0 grp 01:02:03:04:05:06 vid 10 &> /dev/null
> +	check_fail $? "L2 host entry not flushed by \"permanent\" state"
> +
> +	bridge mdb flush dev br0
> +
> +	# Check that IPv4 host entries are not flushed when "permanent" is
> +	# specified, but flushed when "nopermanent" is specified.
> +
> +	bridge mdb add dev br0 port br0 grp 239.1.1.1 temp vid 10
> +
> +	bridge mdb flush dev br0 permanent
> +
> +	bridge mdb get dev br0 grp 239.1.1.1 vid 10 &> /dev/null
> +	check_err $? "IPv4 host entry flushed by wrong state (\"permanent\")"
> +
> +	bridge mdb flush dev br0 nopermanent
> +
> +	bridge mdb get dev br0 grp 239.1.1.1 vid 10 &> /dev/null
> +	check_fail $? "IPv4 host entry not flushed by \"nopermanent\" state"
> +
> +	bridge mdb flush dev br0
> +
> +	# Check that IPv6 host entries are not flushed when "permanent" is
> +	# specified, but flushed when "nopermanent" is specified.
> +
> +	bridge mdb add dev br0 port br0 grp ff0e::1 temp vid 10
> +
> +	bridge mdb flush dev br0 permanent
> +
> +	bridge mdb get dev br0 grp ff0e::1 vid 10 &> /dev/null
> +	check_err $? "IPv6 host entry flushed by wrong state (\"permanent\")"
> +
> +	bridge mdb flush dev br0 nopermanent
> +
> +	bridge mdb get dev br0 grp ff0e::1 vid 10 &> /dev/null
> +	check_fail $? "IPv6 host entry not flushed by \"nopermanent\" state"
> +
> +	bridge mdb flush dev br0
> +
> +	# Check that when flushing by routing protocol only entries programmed
> +	# with the specified routing protocol are flushed and the rest are not.
> +
> +	bridge mdb add dev br0 port $swp1 grp 239.1.1.1 vid 10 proto bgp
> +	bridge mdb add dev br0 port $swp2 grp 239.1.1.1 vid 10 proto zebra
> +	bridge mdb add dev br0 port br0 grp 239.1.1.1 vid 10
> +
> +	bridge mdb flush dev br0 proto bgp
> +
> +	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port $swp1"
> +	check_fail $? "Entry not flushed by specified routing protocol"
> +	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port $swp2"
> +	check_err $? "Entry flushed by wrong routing protocol"
> +	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port br0"
> +	check_err $? "Host entry flushed by wrong routing protocol"
> +
> +	bridge mdb flush dev br0
> +
> +	# Test that an error is returned when trying to flush using unsupported
> +	# parameters.
> +
> +	bridge mdb flush dev br0 src_vni 10 &> /dev/null
> +	check_fail $? "Managed to flush by source VNI"
> +
> +	bridge mdb flush dev br0 dst 198.51.100.1 &> /dev/null
> +	check_fail $? "Managed to flush by destination IP"
> +
> +	bridge mdb flush dev br0 dst_port 4789 &> /dev/null
> +	check_fail $? "Managed to flush by UDP destination port"
> +
> +	bridge mdb flush dev br0 vni 10 &> /dev/null
> +	check_fail $? "Managed to flush by destination VNI"
> +
> +	log_test "Flush tests"
> +}
> +
>  cfg_test()
>  {
>  	cfg_test_host
>  	cfg_test_port
>  	cfg_test_dump
> +	cfg_test_flush
>  }
>  
>  __fwd_test_host_ip()
> @@ -1166,8 +1353,8 @@ ctrl_test()
>  	ctrl_mldv2_is_in_test
>  }
>  
> -if ! bridge mdb help 2>&1 | grep -q "get"; then
> -	echo "SKIP: iproute2 too old, missing bridge mdb get support"
> +if ! bridge mdb help 2>&1 | grep -q "flush"; then
> +	echo "SKIP: iproute2 too old, missing bridge mdb flush support"
>  	exit $ksft_skip
>  fi
>  
> -- 
> 2.40.1
> 
