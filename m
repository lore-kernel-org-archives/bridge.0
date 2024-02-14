Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1687B60B9C
	for <bridge@lists.linux.dev>; Wed, 14 Feb 2024 16:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929279; cv=none; b=ubINI9PHX6yQoF7rAoanDxjuSl9nSDNeAqpDDQa3UJK7587WFKJ2J7DUqLcysDBXUksDQmlY8IcFZPI/EqLJaayY88HsA+Khqvi4eTyMLHwk9fDI7VsuUldrvRGGi9cMGlf01KcbrQv08JYe1S84chzffuuZClHbE0u03LgFUEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929279; c=relaxed/simple;
	bh=XwJoR7TTLG4MhprZasOKMxLMrkCbF9FIzUucdvqZnQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vm02Tg3q5lURMQS/wOTN5b5ubeoMa1ynxEvPP/yCmuvZ+vFKvPEtIFqOywzucxKdHfWKQTADsRB0mRkIIBcekSofxs6I5bGPELQy3Gk5eXJQFrZ2/QlUHcqwgLIpEcHnug82iJ/xYPHfhgrDlruBDGcJ0ozXhud1pOugtQNFuMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bY+apcIt; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bY+apcIt"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5639c8cc449so172983a12.2
        for <bridge@lists.linux.dev>; Wed, 14 Feb 2024 08:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707929276; x=1708534076; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7vGriv4qu9uDXvdDYwIBv5PlmXymEIEo1vLNuMltzEs=;
        b=bY+apcItekjVxQAeOI01jxEu0JwZaa/HbsAmsAC6OgAORWkv/qAUJtxQNFKI+9+yB4
         K2m2GAsUMOKGKJtkmq6e3QOgQyahvgwElb8AaaBlvOSxvo9iYsj11UGBdOnNvvOToZU1
         BDbn4QvRfbJDL7P0yRXmMxHLFK0MpSu5TJDeKd4Y/wnOONP8YAml7u9VQi0WxPHzWJ2w
         1hM9MQ86QRY2VvRx5VyAc4+5QOqBwMFFZ67HP+n2ZHVaqxLqr57yb7ODhWJBMrrVyoGy
         V0I+tuz5nBsb+YaoG6rrs8W4yjy+xuXhwxAKSV7CkkWsiGaPlm6UqBMDA40vcX/R324s
         1wxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707929276; x=1708534076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vGriv4qu9uDXvdDYwIBv5PlmXymEIEo1vLNuMltzEs=;
        b=fMo1uyT7J6kieM8zfSMmIRlfiYqb02Yp5rvA3Kc0tKfqb9CeFP75TIdhUv+4BRz740
         hX/nzy0AN1nwkEo047zSvYACpgD/2E0TVe+oFdy/JfsNdVhlQjVdAWieoxPRJ3djldxP
         dDAMmxXvNCziCWFhaGSa63W8w5E4WOynUKirgnPS5SvsJVdaI7jlqNt5vPBgIPIsuOqP
         DhiKBiOQeo5yLpiZLvFyietLQLNehQl/U8YrHltodyJJCPSznRR4P6d3G/w7RHn40nNp
         /IQX7wcLZMn983nRhAbgG43Bs8z3JSryAx4oJFQXbCYq1K3EIgMIj4FJGSlyKLzRTik+
         lXZA==
X-Forwarded-Encrypted: i=1; AJvYcCUBooYtfQ6Ai8bkVhmaqBHSfoGbjnIsb2xTjLXGH3RhXgpkmoH0+g2l4MoVWSpSXAfcN/gPuZGah9rZ1lH9M9IAOhDbIxK+
X-Gm-Message-State: AOJu0Yy/ZlOMvkWUN2RvbXg7GkYotZuf2RSdZbhm1k9EVVRF4LHc6+Xr
	70XLyj4hztMOVw8q7uGKFoH+4wuwHciiGK77OweIBP6JEep7aiYl
X-Google-Smtp-Source: AGHT+IEMXax9TzmzcnyStu4w1MT7WsccQURF7KPvDKKN8gNAYkxWqTVPxY20pbi2VoURpx2/JU0sxA==
X-Received: by 2002:a17:906:f158:b0:a3d:1458:5e58 with SMTP id gw24-20020a170906f15800b00a3d14585e58mr2228545ejb.46.1707929275854;
        Wed, 14 Feb 2024 08:47:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU8YtrNjenuTOuCM0oYZNDFSvWMlZ6YQjarJ2gF5TliS4Qgjctw4QduMUlCoWU7dJhd8CdrkKy9HPUCm9o3fasEigbgh97goEvxkvy00IZ+g/1ZJyyEmMY0HAUijumHgg9/WDDWCcAjr29Io5fUHXYlCCqd6vO03S/X5oKKYxigrRm+tqhkrqRY3oqLL2Gt3RBJJV0TQhtmwI9M6I2ZnegWDovLoQm6RosE/sO/mx2YmWkW8a07vqwwdFfj6lCZG+5wTbFr7+bGes9AeRzxp8T+
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id vi16-20020a170907d41000b00a3ce31d3ffdsm2327431ejc.93.2024.02.14.08.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 08:47:55 -0800 (PST)
Date: Wed, 14 Feb 2024 18:47:53 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, atenart@kernel.org,
	roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
	netdev@vger.kernel.org, jiri@resnulli.us, ivecera@redhat.com
Subject: Re: [PATCH v4 net 2/2] net: bridge: switchdev: Ensure deferred event
 delivery on unoffload
Message-ID: <20240214164753.6ij6ksdgz5ailemv@skbuf>
References: <20240212191844.1055186-1-tobias@waldekranz.com>
 <20240212191844.1055186-1-tobias@waldekranz.com>
 <20240212191844.1055186-3-tobias@waldekranz.com>
 <20240212191844.1055186-3-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212191844.1055186-3-tobias@waldekranz.com>
 <20240212191844.1055186-3-tobias@waldekranz.com>

On Mon, Feb 12, 2024 at 08:18:44PM +0100, Tobias Waldekranz wrote:
> When unoffloading a device, it is important to ensure that all
> relevant deferred events are delivered to it before it disassociates
> itself from the bridge.
> 
> Before this change, this was true for the normal case when a device
> maps 1:1 to a net_bridge_port, i.e.
> 
>    br0
>    /
> swp0
> 
> When swp0 leaves br0, the call to switchdev_deferred_process() in
> del_nbp() makes sure to process any outstanding events while the
> device is still associated with the bridge.
> 
> In the case when the association is indirect though, i.e. when the
> device is attached to the bridge via an intermediate device, like a
> LAG...
> 
>     br0
>     /
>   lag0
>   /
> swp0
> 
> ...then detaching swp0 from lag0 does not cause any net_bridge_port to
> be deleted, so there was no guarantee that all events had been
> processed before the device disassociated itself from the bridge.
> 
> Fix this by always synchronously processing all deferred events before
> signaling completion of unoffloading back to the driver.
> 
> Fixes: 4e51bf44a03a ("net: bridge: move the switchdev object replay helpers to "push" mode")
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
