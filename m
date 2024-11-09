Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02F8186E2E
	for <bridge@lists.linux.dev>; Sat,  9 Nov 2024 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731159651; cv=none; b=OWqxJ930olxngpJob0XBF80cZfqDEzMotWA8+5A+xRYaF54rPuwDrOZ06EdHR+/71uS2iMHu75lfM4Y8B5vS4phriVzdrVP8H/0ZNtKDFdPhlumPxrD3jjcdFmYkNRBGhevHuuiLYQa48iR9hKjds9Dc0ZrbgoIsNJDyIut/Xrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731159651; c=relaxed/simple;
	bh=DpuvVt7caLTKXKo/ZpTpfxwmYD5a5qfV0OjlFjgHRkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEJb7HE3eGu3JhSwTtVe9SkOaZmAKm79h57891zMrc5TGWyiFo2i75xZJTr7okT6yqzM/Aq//V8TajC/IzCkDArG9CjxFx5vbnntsQYy6H39X+llapW8ZPKjdE/PsR5iuV6JU61mZhcBgYPUF08gYqhVVtEJxwa2V6TM4zm+GrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=J0LVIePh; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="J0LVIePh"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so3646302e87.1
        for <bridge@lists.linux.dev>; Sat, 09 Nov 2024 05:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1731159647; x=1731764447; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nxB5gPoc3zzAhuEQiHf7da4pTtcAC3DNJzHv50OU/m4=;
        b=J0LVIePhtSKmWLlv35gek8p4Ysw4BWvfcTNDZfD7zyoC8JuQlmFvPUfm9w8Cu9Wqm5
         EY/DkfzgU51lPHZsBZRvpx24e+Pt3uGKshy45u7Kz1sQOfN2Lf7sSQzg1rquGK96mwd+
         CkHqsQvx1ncNFpfIbL/LnM9XzRiGaLgxl2Mk7OaY+KKtf+tdnmLs4W/pUGZKi2UdssX9
         /CUdI8SvmeSxayKmBYLNSw5YmW4RdCBZSLRXFcinPjIU2j/BGN7L2DpRXdhW1KGSvhHz
         yzbIlWVOgxJQUoAvWpLxSO2FkhQUbi6kFhtBQl2r89tWIDGO6TFt2yXZwMbxIQhPveiT
         XkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731159647; x=1731764447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxB5gPoc3zzAhuEQiHf7da4pTtcAC3DNJzHv50OU/m4=;
        b=chsZ8nooC7ym3/yv0ntieHm+yDPYgEI/HiU1rrZXkvRNXefGhy/IiPCyFxeMoT+DwA
         YDWk71TCKk+qXJ82gPxV6FTfVmox6sV4/mNblCeleEdn49v+KDdnhe6TlxqLjEfgbKzV
         O+cU76SgI5pTD3OgLgNkTaNUo78bvluMWOyNVt/57zAhynaAx2f5Etqm/pcRs0aAes9A
         TBYF1neovOOvNtZc53vkLtqOnyqjTZMajxDWTxwla7RUb+beKMaD50gBrRQv51IqUPbW
         zFP8yGXEY6fx9Kegn0C6hVKAjXXE49K4pfknN4VA6v0OXvB2lbKqyd0zSom42Vi6H5tF
         tByA==
X-Forwarded-Encrypted: i=1; AJvYcCWuRtWz3CkWHB1hPxDZWVCd6Om2zVbLESdV6odHtC4xlEmtELWUeGv98d0NEIoRKBqx14ctwFo=@lists.linux.dev
X-Gm-Message-State: AOJu0YwKmDORi7YyJEHRsmnCoQNUFka2J4VfewyXc8BeEdvBagDHyY1A
	DDBbuTm1sakIciS8m2KzAXtN87g3nDAfIlrvo9TN8DMePLm6xRF/Y8MhqHWqPho=
X-Google-Smtp-Source: AGHT+IE0JAECEIE2ksLs8Y2aggg+blpxzPCgZBIS2K0qt/fU9tDMt9/9JtHZZK89+t7cjZNI3BmPvA==
X-Received: by 2002:a05:6512:b83:b0:53c:7652:6c7a with SMTP id 2adb3069b0e04-53d862b45c8mr2870834e87.8.1731159646629;
        Sat, 09 Nov 2024 05:40:46 -0800 (PST)
Received: from localhost ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826a7248sm919292e87.127.2024.11.09.05.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 05:40:46 -0800 (PST)
Date: Sat, 9 Nov 2024 15:40:45 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
Cc: davem@davemloft.net, Roopa Prabhu <roopa@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [RFC net-next 2/4] net: bridge: send notification for roaming
 hosts
Message-ID: <Zy9mXda9diHR_Eh5@penguin>
References: <20241108032422.2011802-1-elliot.ayrey@alliedtelesis.co.nz>
 <20241108032422.2011802-3-elliot.ayrey@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108032422.2011802-3-elliot.ayrey@alliedtelesis.co.nz>

On Fri, Nov 08, 2024 at 04:24:19PM +1300, Elliot Ayrey wrote:
> When an fdb entry is configured as static and sticky it should never
> roam. However there are times where it would be useful to know when
> this happens so a user application can act on it. For this reason,
> extend the fdb notification mechanism to send a notification when the
> bridge detects a host that is attempting to roam when it has been
> configured not to.
> 
> This is achieved by temporarily updating the fdb entry with the new
> port, setting a new notify roaming bit, firing off a notification, and
> restoring the original port immediately afterwards. The port remains
> unchanged, respecting the sticky flag, but userspace is now notified
> of the new port the host was seen on.
> 
> The roaming bit is cleared if the entry becomes inactive or if it is
> replaced by a user entry.
> 
> Signed-off-by: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
> ---
>  include/uapi/linux/neighbour.h |  4 ++-
>  net/bridge/br_fdb.c            | 64 +++++++++++++++++++++++-----------
>  net/bridge/br_input.c          | 10 ++++--
>  net/bridge/br_private.h        |  3 ++
>  4 files changed, 58 insertions(+), 23 deletions(-)
> 

No way, this is ridiculous. Changing the port like that for a notification is not
ok at all. It is also not the bridge's job to notify user-space for sticky fdbs
that are trying to roam, you already have some user-space app and you can catch
such fdbs by other means (sniffing, ebpf hooks, netfilter matching etc). Such
change can also lead to DDoS attacks with many notifications.

Nacked-by: Nikolay Aleksandrov <razor@blackwall.org>

> diff --git a/include/uapi/linux/neighbour.h b/include/uapi/linux/neighbour.h
> index 5e67a7eaf4a7..e1c686268808 100644
> --- a/include/uapi/linux/neighbour.h
> +++ b/include/uapi/linux/neighbour.h
> @@ -201,10 +201,12 @@ enum {
>   /* FDB activity notification bits used in NFEA_ACTIVITY_NOTIFY:
>    * - FDB_NOTIFY_BIT - notify on activity/expire for any entry
>    * - FDB_NOTIFY_INACTIVE_BIT - mark as inactive to avoid multiple notifications
> +  * - FDB_NOTIFY_ROAMING_BIT - mark as attempting to roam
>    */
>  enum {
>  	FDB_NOTIFY_BIT		= (1 << 0),
> -	FDB_NOTIFY_INACTIVE_BIT	= (1 << 1)
> +	FDB_NOTIFY_INACTIVE_BIT	= (1 << 1),
> +	FDB_NOTIFY_ROAMING_BIT	= (1 << 2)
>  };
>  
>  /* embedded into NDA_FDB_EXT_ATTRS:
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index d0eeedc03390..a8b841e74e15 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -145,6 +145,8 @@ static int fdb_fill_info(struct sk_buff *skb, const struct net_bridge *br,
>  			goto nla_put_failure;
>  		if (test_bit(BR_FDB_NOTIFY_INACTIVE, &fdb->flags))
>  			notify_bits |= FDB_NOTIFY_INACTIVE_BIT;
> +		if (test_bit(BR_FDB_NOTIFY_ROAMING, &fdb->flags))
> +			notify_bits |= FDB_NOTIFY_ROAMING_BIT;
>  
>  		if (nla_put_u8(skb, NFEA_ACTIVITY_NOTIFY, notify_bits)) {
>  			nla_nest_cancel(skb, nest);
> @@ -554,8 +556,10 @@ void br_fdb_cleanup(struct work_struct *work)
>  					work_delay = min(work_delay,
>  							 this_timer - now);
>  				else if (!test_and_set_bit(BR_FDB_NOTIFY_INACTIVE,
> -							   &f->flags))
> +							   &f->flags)) {
> +					clear_bit(BR_FDB_NOTIFY_ROAMING, &f->flags);
>  					fdb_notify(br, f, RTM_NEWNEIGH, false);
> +				}
>  			}
>  			continue;
>  		}
> @@ -880,6 +884,19 @@ static bool __fdb_mark_active(struct net_bridge_fdb_entry *fdb)
>  		  test_and_clear_bit(BR_FDB_NOTIFY_INACTIVE, &fdb->flags));
>  }
>  
> +void br_fdb_notify_roaming(struct net_bridge *br, struct net_bridge_port *p,
> +			   struct net_bridge_fdb_entry *fdb)
> +{
> +	struct net_bridge_port *old_p = READ_ONCE(fdb->dst);
> +
> +	if (test_bit(BR_FDB_NOTIFY, &fdb->flags) &&
> +	    !test_and_set_bit(BR_FDB_NOTIFY_ROAMING, &fdb->flags)) {
> +		WRITE_ONCE(fdb->dst, p);
> +		fdb_notify(br, fdb, RTM_NEWNEIGH, false);
> +		WRITE_ONCE(fdb->dst, old_p);
> +	}
> +}
> +
>  void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
>  		   const unsigned char *addr, u16 vid, unsigned long flags)
>  {
> @@ -906,21 +923,24 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
>  			}
>  
>  			/* fastpath: update of existing entry */
> -			if (unlikely(source != READ_ONCE(fdb->dst) &&
> -				     !test_bit(BR_FDB_STICKY, &fdb->flags))) {
> -				br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);
> -				WRITE_ONCE(fdb->dst, source);
> -				fdb_modified = true;
> -				/* Take over HW learned entry */
> -				if (unlikely(test_bit(BR_FDB_ADDED_BY_EXT_LEARN,
> -						      &fdb->flags)))
> -					clear_bit(BR_FDB_ADDED_BY_EXT_LEARN,
> -						  &fdb->flags);
> -				/* Clear locked flag when roaming to an
> -				 * unlocked port.
> -				 */
> -				if (unlikely(test_bit(BR_FDB_LOCKED, &fdb->flags)))
> -					clear_bit(BR_FDB_LOCKED, &fdb->flags);
> +			if (unlikely(source != READ_ONCE(fdb->dst))) {
> +				if (unlikely(test_bit(BR_FDB_STICKY, &fdb->flags))) {
> +					br_fdb_notify_roaming(br, source, fdb);
> +				} else {
> +					br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);
> +					WRITE_ONCE(fdb->dst, source);
> +					fdb_modified = true;
> +					/* Take over HW learned entry */
> +					if (unlikely(test_bit(BR_FDB_ADDED_BY_EXT_LEARN,
> +							      &fdb->flags)))
> +						clear_bit(BR_FDB_ADDED_BY_EXT_LEARN,
> +							  &fdb->flags);
> +					/* Clear locked flag when roaming to an
> +					 * unlocked port.
> +					 */
> +					if (unlikely(test_bit(BR_FDB_LOCKED, &fdb->flags)))
> +						clear_bit(BR_FDB_LOCKED, &fdb->flags);
> +				}
>  			}
>  
>  			if (unlikely(test_bit(BR_FDB_ADDED_BY_USER, &flags))) {
> @@ -1045,6 +1065,7 @@ static bool fdb_handle_notify(struct net_bridge_fdb_entry *fdb, u8 notify)
>  		   test_and_clear_bit(BR_FDB_NOTIFY, &fdb->flags)) {
>  		/* disabled activity tracking, clear notify state */
>  		clear_bit(BR_FDB_NOTIFY_INACTIVE, &fdb->flags);
> +		clear_bit(BR_FDB_NOTIFY_ROAMING, &fdb->flags);
>  		modified = true;
>  	}
>  
> @@ -1457,10 +1478,13 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
>  
>  		fdb->updated = jiffies;
>  
> -		if (READ_ONCE(fdb->dst) != p &&
> -		    !test_bit(BR_FDB_STICK, &fdb->flags)) {
> -			WRITE_ONCE(fdb->dst, p);
> -			modified = true;
> +		if (READ_ONCE(fdb->dst) != p) {
> +			if (test_bit(BR_FDB_STICKY, &fdb->flags)) {
> +				br_fdb_notify_roaming(br, p, fdb);
> +			} else {
> +				WRITE_ONCE(fdb->dst, p);
> +				modified = true;
> +			}
>  		}
>  
>  		if (test_and_set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index ceaa5a89b947..512ffab16f5d 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -120,8 +120,14 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>  				br_fdb_update(br, p, eth_hdr(skb)->h_source,
>  					      vid, BIT(BR_FDB_LOCKED));
>  			goto drop;
> -		} else if (READ_ONCE(fdb_src->dst) != p ||
> -			   test_bit(BR_FDB_LOCAL, &fdb_src->flags)) {
> +		} else if (READ_ONCE(fdb_src->dst) != p) {
> +			/* FDB is trying to roam. Notify userspace and drop
> +			 * the packet
> +			 */
> +			if (test_bit(BR_FDB_STICKY, &fdb_src->flags))
> +				br_fdb_notify_roaming(br, p, fdb_src);
> +			goto drop;
> +		} else if (test_bit(BR_FDB_LOCAL, &fdb_src->flags)) {
>  			/* FDB mismatch. Drop the packet without roaming. */
>  			goto drop;
>  		} else if (test_bit(BR_FDB_LOCKED, &fdb_src->flags)) {
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 041f6e571a20..18d3cb5fec0e 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -277,6 +277,7 @@ enum {
>  	BR_FDB_NOTIFY_INACTIVE,
>  	BR_FDB_LOCKED,
>  	BR_FDB_DYNAMIC_LEARNED,
> +	BR_FDB_NOTIFY_ROAMING,
>  };
>  
>  struct net_bridge_fdb_key {
> @@ -874,6 +875,8 @@ int br_fdb_external_learn_del(struct net_bridge *br, struct net_bridge_port *p,
>  			      bool swdev_notify);
>  void br_fdb_offloaded_set(struct net_bridge *br, struct net_bridge_port *p,
>  			  const unsigned char *addr, u16 vid, bool offloaded);
> +void br_fdb_notify_roaming(struct net_bridge *br, struct net_bridge_port *p,
> +			   struct net_bridge_fdb_entry *fdb);
>  
>  /* br_forward.c */
>  enum br_pkt_type {
