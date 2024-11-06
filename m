Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D5F20CCC8
	for <bridge@lists.linux.dev>; Wed,  6 Nov 2024 21:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730929064; cv=none; b=BgzaMpNMYE0DP+RWxh+8k39RndFCSOsJkPBlXJlwPi2YyWpk73fEb7WTRET75q2op1IVKy6I0CaIf3ih3CDEGsgMBA7rrKG+KD0c4OUm/Jxl7GndaLvyBQSbLSMQ3n3DBM/XavWqOzs/8Fy8Z7RcGiGXWXlqFXM6sZt+MsEWU/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730929064; c=relaxed/simple;
	bh=ns67C/BQnqLU+rMKxn2lZJhID9Ubh/mo990c7FfSSd8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P6DYK2TeSKTVoTak18Kb39F58zZ+2m2wAvXO1N6HFF/o+/tWN6LlWHd5eCOwBJ9XAnS8dnNa8TdDT7tJyok0kyugGuCc4T6LrjXHfrJEvufcNE4dxbdC4Hg1XiB/LF8wZwZ9L1eJcdWL5PQUpm/if8w6Rldr6mZdZXpdkKoqvB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CCwYEMYr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CCwYEMYr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730929060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=YV3axQsGEJ50qpHJdWfIL4Kylk3egm3V/oNR8O82ej0=;
	b=CCwYEMYrXYl64P1tLV0yCUWk4DBrSqdjX76ZByMvzYK77818BKrwdkIQl7FVUVumbqfQRY
	DfrTQJeDwTs1P7mnQDFw1O7OtNJNl2a8AxuQDxXNP4vSykprclYd6jdFvEDvBMz7MaE8CN
	eu68+4qtNy4uh+xkCSY/0Mlz8zo6708=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-VgkXL5KvMyK0pwFXpy89Kg-1; Wed, 06 Nov 2024 16:37:37 -0500
X-MC-Unique: VgkXL5KvMyK0pwFXpy89Kg-1
X-Mimecast-MFC-AGG-ID: VgkXL5KvMyK0pwFXpy89Kg
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d5ca5bfc8so107074f8f.0
        for <bridge@lists.linux.dev>; Wed, 06 Nov 2024 13:37:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730929056; x=1731533856;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YV3axQsGEJ50qpHJdWfIL4Kylk3egm3V/oNR8O82ej0=;
        b=m50KvZ0CsT2QBW3Jhadk90Ue1qNufrxzGgPXiEqzFHr2jbe5yHs+TNnT2Dgi0REGz2
         z5NHRWrRMhLauhDlcI3OEnr0Oic4sQy/aAhR8jXN79zbdS2OBbq7Iu8dQ3hV2fev5Rx+
         /4Pc3s119P51y38O/brTO4syOUUD+EeadA9kwma7mutaC8W5cSigVBLpXF/BPz3KiWtg
         6cA8G2os8zknbUSPBfLYaakCaZ4+dVQvKHkwUpu+nwzJ+TOmY+C5/Nn2aVnuy3yoPXAc
         sxn9ftAscJiIW1iY0Rz9A9fSTZKcY639pFbJOH2NvvwUlN1CV+C/3hOH9/2FI4e8shly
         me6g==
X-Forwarded-Encrypted: i=1; AJvYcCUekJ+n15lB6uHIfRkOlnMTSRqP3zkZ195zoqjJLpwdpe5OpyQD3EG01harhGXBLitYog/Hmjs=@lists.linux.dev
X-Gm-Message-State: AOJu0YyvMGDcNERHOVDSJ19aKwE88YhH8qsbQiXuKv2l2FgRMHsA8SIm
	HrXn1BpRB0QjaDiZrUGNHW/0HZsWHP8AJdCqE5JgG07pp3v0Kre9U53HnEY1t4drl4sl3V+Dlef
	2mKwwVrIOX0kNYQ91+s3u61CE9DxFjAZN7mPT4tJjDtCOCxosa49yyg==
X-Received: by 2002:a5d:64ae:0:b0:37c:d11f:c591 with SMTP id ffacd0b85a97d-381be776602mr20876080f8f.17.1730929056510;
        Wed, 06 Nov 2024 13:37:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbkpQFHUZRdXmo+dnhte4YYrdw5L2sWqP9Fq7zpQvehKn9Ej9pPuiDg3MYJtL7c++nP6QDCg==
X-Received: by 2002:a5d:64ae:0:b0:37c:d11f:c591 with SMTP id ffacd0b85a97d-381be776602mr20876057f8f.17.1730929056046;
        Wed, 06 Nov 2024 13:37:36 -0800 (PST)
Received: from debian (2a01cb058d23d60051d26877cf512a7d.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:51d2:6877:cf51:2a7d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e747csm20226026f8f.64.2024.11.06.13.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 13:37:35 -0800 (PST)
Date: Wed, 6 Nov 2024 22:37:32 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	bridge@lists.linux.dev, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next] ipv4: Prepare ip_route_output() to future
 .flowi4_tos conversion.
Message-ID: <0f10d031dd44c70aae9bc6e19391cb30d5c2fe71.1730928699.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jKDIxzWcFhPCimxo-4Sm17PcM1VNvPLiBW_dryZ3EbU_1730929056
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert the "tos" parameter of ip_route_output() to dscp_t. This way
we'll have a dscp_t value directly available when .flowi4_tos will
eventually be converted to dscp_t.

All ip_route_output() callers but one set this "tos" parameter to 0 and
therefore don't need to be adapted to the new prototype.

Only br_nf_pre_routing_finish() needs conversion. It can just use
ip4h_dscp() to get the DSCP field from the IPv4 header.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 include/net/route.h             | 6 +++---
 net/bridge/br_netfilter_hooks.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index 586e59f7ed8a..0a690adfdff5 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -156,12 +156,12 @@ static inline struct rtable *ip_route_output_key(struct net *net, struct flowi4
  * structure is only partially set, it may bypass some fib-rules.
  */
 static inline struct rtable *ip_route_output(struct net *net, __be32 daddr,
-					     __be32 saddr, u8 tos, int oif,
-					     __u8 scope)
+					     __be32 saddr, dscp_t dscp,
+					     int oif, __u8 scope)
 {
 	struct flowi4 fl4 = {
 		.flowi4_oif = oif,
-		.flowi4_tos = tos,
+		.flowi4_tos = inet_dscp_to_dsfield(dscp),
 		.flowi4_scope = scope,
 		.daddr = daddr,
 		.saddr = saddr,
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 17a5f5923d61..7f2f40cef5fe 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -406,7 +406,7 @@ static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_
 				goto free_skb;
 
 			rt = ip_route_output(net, iph->daddr, 0,
-					     iph->tos & INET_DSCP_MASK, 0,
+					     ip4h_dscp(iph), 0,
 					     RT_SCOPE_UNIVERSE);
 			if (!IS_ERR(rt)) {
 				/* - Bridged-and-DNAT'ed traffic doesn't
-- 
2.39.2

