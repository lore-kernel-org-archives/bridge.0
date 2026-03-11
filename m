Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45AC145A1F
	for <bridge@lists.linux.dev>; Wed, 11 Mar 2026 03:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773198151; cv=none; b=R84v3MdDFMKzCdWcwX3uMD0eOKpIRHPRPk3LVTmS2A7gO1/N+OVB5z65TNJrLT4T2+GY3nYbu4ntDUPSEJUAY5xwp5uATuWXWnEhILy9/2719ArDFDqP8dMWbKhW7R5LGoP7Dscdh/gXHdrTnDV6HOI0hkglVh7+3BSXoaI1Gi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773198151; c=relaxed/simple;
	bh=mPp/K2GhcYeb1+cWEjjfMUOOqDfykcclJnqOVh6Hx4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTbXhJEf9tfJDj/CIILg+j3PdR68iMHvZkGXnd76vTbk2pmKksN6AcLPoCZcS3vfXCiQegKjtGAQJu+P2CBVw1QP+yq9+Zp2FJ0+tUehvkj8Y+pADoq4Djrw3qMRn+P8fM5d98NNy7VcZMo4tKoqS2xvWbc1jGfzSZ95+58mwzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ax4yRbM6; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ax4yRbM6"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35691a231a7so8510133a91.3
        for <bridge@lists.linux.dev>; Tue, 10 Mar 2026 20:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773198150; x=1773802950; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Evom+iUYo6uZan7knSuRApLIlU//ZridbfvXdJv+L0=;
        b=Ax4yRbM6PAi9BkX+BREq/6hbLlrPz2KIEmWRMDwCKaMtQzSZqCbsJPCYEAfZ+iGSob
         xl7WugziZxRdeozw9dODip5oojo9QEZqRO8bmb5RhlsnnPttmYyVXel5+Xpa7UZQPL6j
         odV0RQHWXUTwqxn35pPSXRSoPuZh5fafZpu9JhrhTKXIP0eXbkvc7B4jhESapZZtuCYv
         j1rRYWnhG8jCF0sov84M4hr3ZHUuMAyQDE+qccQt0imQ8zGwB+W/vq1mOoUteUfXH5Mt
         2XdNo7700bjnD7SeKa1s69YAPN0Mv/K6GcCn9umAfnN6BgD/YHUhxi/oyZMQtY4HEnIy
         JKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773198150; x=1773802950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Evom+iUYo6uZan7knSuRApLIlU//ZridbfvXdJv+L0=;
        b=mNOshe/JqMaSla5i/lJKpm8UOpqWBHiWlXT/AXTUR8Z1hn3zpoXpxd1YsEf4H0tf6S
         sX6la/rdRc7qJgN6ouwxbInhytxVQ4GF6FUxIOLAun6AB3lnALkC1lF121+d85odinuD
         mbtUMBT1ddNY1mefF5/QJ3aWM3kvx27Tuw177uudqxuIsw84RKhXik0A256kyNbwUZcC
         sM97HHMsTxlgSLGcvAzJNB/VXOvI13T33xvVrXFSwTjs52qC+aASwLfkymZ3Koc91V/r
         LGKIJiqznxOQxYmX0Gi31IuHejKpun04kfsnA6sXcrirF/TdZmGiAoVI1dzYdZVlCXKj
         7Uwg==
X-Gm-Message-State: AOJu0YxgMZM945n1no5t9/7osW1c7vH/uESIi3QgcsYk/iLNhGZITAxz
	xAewg9+pxlAOmX4dzWlI/OEgpTtOSrrRJWnxreTR6BpUtyid1C5IXAcwKuXsgYWs
X-Gm-Gg: ATEYQzwgY0a5dNjvbypPr6cEIv21CR9YOeb+JKf+HT90YLI0PwmDZzo9CwZt8i9Z+E3
	MNwpFuEi8b202/JRS4c0NgeTBo1WWBZeQz9MqOeTwR4uHG9H46K1wxA3AVs7NTcZhbrWjfkiQ7q
	En+on6/aiC7Au80tWGnFm47Mp7ZmXSvcx+tXmdwq5Vhhq5AAJQYZ6X5ymKnzoguke9DTQjYS+7v
	hDOIRtptGYrP+hH6YNUVLAwLr0L1yT1WOeEoTIR6cjn7CWAj7rSmelC88VFRvAYHCEnIH+M/LEt
	wWJloGYycEOxpME9HWbBpQJuZzZTvVjlavAoNcZ5favYnwnbnGT2zr6+Fy4lWHNMUtGpYxnvf1i
	AIuIAegVCvo71o2PZExG4cPODIMIatWya9Ao4712O/1IndGz6fsCCQBE8tYOpIavl11qr7S8BXD
	QstfJJKf4siXIMM18b0BG6pgJumoL2JE1JqUE8qkC06xLplDfG+keI
X-Received: by 2002:a17:90a:d2c8:b0:359:974a:b73d with SMTP id 98e67ed59e1d1-35a01a99cbcmr981954a91.35.1773198149923;
        Tue, 10 Mar 2026 20:02:29 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02e7a2edsm488911a91.7.2026.03.10.20.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 20:02:29 -0700 (PDT)
Date: Wed, 11 Mar 2026 12:02:20 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: razor@blackwall.org, idosch@nvidia.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org, v4bel@gmail.com,
	henrik.bjoernlund@microchip.com, horatiu.vultur@microchip.com,
	nikolay@nvidia.com, sd@queasysnail.net
Subject: Re: [PATCH net] bridge: cfm: Fix race condition in peer_mep deletion
Message-ID: <abDbPJ5nZ1u9fZRi@v4bel>
References: <abBgYT5K_FI9rD1a@v4bel>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abBgYT5K_FI9rD1a@v4bel>

On Wed, Mar 11, 2026 at 03:18:09AM +0900, Hyunwoo Kim wrote:
> When a peer MEP is being deleted, cancel_delayed_work_sync() is called
> on ccm_rx_dwork before freeing. However, br_cfm_frame_rx() runs in
> softirq context under rcu_read_lock (without RTNL) and can re-schedule
> ccm_rx_dwork via ccm_rx_timer_start() between cancel_delayed_work_sync()
> returning and kfree_rcu() being called.
> 
> The following is a simple race scenario:
> 
>            cpu0                                     cpu1
> 
> mep_delete_implementation()
>   cancel_delayed_work_sync(ccm_rx_dwork);
>                                            br_cfm_frame_rx()
>                                              // peer_mep still in hlist
>                                              if (peer_mep->ccm_defect)
>                                                ccm_rx_timer_start()
>                                                  queue_delayed_work(ccm_rx_dwork)
>   hlist_del_rcu(&peer_mep->head);
>   kfree_rcu(peer_mep, rcu);
>                                            ccm_rx_work_expired()
>                                              // on freed peer_mep
> 
> To prevent this, cancel_delayed_work_sync() is replaced with
> disable_delayed_work_sync() in both peer MEP deletion paths, so
> that subsequent queue_delayed_work() calls from br_cfm_frame_rx()
> are silently rejected.
> 
> The cc_peer_disable() helper retains cancel_delayed_work_sync()
> because it is also used for the CC enable/disable toggle path where
> the work must remain re-schedulable.
> 
> Fixes: dc32cbb3dbd7 ("bridge: cfm: Kernel space implementation of CFM. CCM frame RX added.")
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  net/bridge/br_cfm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
> index 2c70fe47de38..118c7ea48c35 100644
> --- a/net/bridge/br_cfm.c
> +++ b/net/bridge/br_cfm.c
> @@ -576,7 +576,7 @@ static void mep_delete_implementation(struct net_bridge *br,
>  
>  	/* Empty and free peer MEP list */
>  	hlist_for_each_entry_safe(peer_mep, n_store, &mep->peer_mep_list, head) {
> -		cancel_delayed_work_sync(&peer_mep->ccm_rx_dwork);
> +		disable_delayed_work_sync(&peer_mep->ccm_rx_dwork);
>  		hlist_del_rcu(&peer_mep->head);
>  		kfree_rcu(peer_mep, rcu);
>  	}
> @@ -732,7 +732,7 @@ int br_cfm_cc_peer_mep_remove(struct net_bridge *br, const u32 instance,
>  		return -ENOENT;
>  	}
>  
> -	cc_peer_disable(peer_mep);
> +	disable_delayed_work_sync(&peer_mep->ccm_rx_dwork);
>  
>  	hlist_del_rcu(&peer_mep->head);
>  	kfree_rcu(peer_mep, rcu);
> -- 
> 2.43.0
> 

CC'ing the Fixes patch authors and Sabrina, who is familiar with this bug pattern.


Best regards,
Hyunwoo Kim
