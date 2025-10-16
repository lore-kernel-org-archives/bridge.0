Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2EF7263B
	for <bridge@lists.linux.dev>; Thu, 16 Oct 2025 11:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614028; cv=none; b=jwnkPqAYBOLNR82VI/h7dUR3KicN1ABm9Kd8PqRc2LE42mtkL0NkSw9LYM4CpAE3GeCQYdSFtNO6BUFgnODLgCjo2LI62BvCWtQOBGfmBP09g7tiZDdPhW9YBR/7Ekz2Q6v5wW9Ebxolf/soa9dY/4TPhtHnQsy8Cav3OULzp0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614028; c=relaxed/simple;
	bh=rOYcDSrhRWLgtnzpoeHuge7O06Ip2GR7UW51Bh01bCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWQPSMP+33xmgobIJBj8me3XIf5TUdjvFNlpJG6MLtBdNiEePC2Jn/9Vki6SOHiwPAC35mUBjdmR895rpRhZEf982YLRbPjjn6YWa1/ZWeFw3FyzWL0FFKAqwMULPs5dkujBO9D61CbvAitTUtwAvAFouY2dnLhFkh1q0NPhfp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=MsBW0kGB; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="MsBW0kGB"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47114a40161so4242435e9.3
        for <bridge@lists.linux.dev>; Thu, 16 Oct 2025 04:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1760614024; x=1761218824; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S9hYzjpUktnCETUL8826o3/CkmCIwf0/rTKQ/FR1f+M=;
        b=MsBW0kGBdM601QnI5Q0HWilAMZPQhogy9XeqKNHeU9sGRMN5hfU8/VWslpj4Lu60qQ
         +FlClaM5h55SpB3bsX1yibMYXeE/CEyTkCO+B9n34zqtO8ccw9LhoSdIpvS0nOnHBke0
         0mH1bY+9wW+1w2RXiq1dswFh5jZnGdUd09ukKN7ISX73zYH/02q32Kge4fjkWNnvpLk5
         1d7tT3tOPCA5zcDjw8G39B1BILztZ3PHEmCtTUj2ypFHw+EZei8CaVv0KfUaeM4Cu7P1
         u4dHzAdx/enifydC5w9aS663uejBmP5hHeFIhH85BpFJSivV0PN2egC1Q2GxYx4LWNhH
         2ONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760614024; x=1761218824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9hYzjpUktnCETUL8826o3/CkmCIwf0/rTKQ/FR1f+M=;
        b=sQiRcAXmf+7Q0N9eJmhiyCBeXarmIzXhS8vHUuoK2pc8ys+IyWBQHp6y6I4470klK1
         wHX5encK1af5DqOmiFaH+Vbdfy6lY4DoEWQnNxDKQbI9bY7Vj0WmjSXGdIjyVXXsQeDO
         39bNpbm1scx+zhPpr4ukZ4VAbVKS0VEnYC3Y17eq9FsF9cz0WBR59JtuoCKHjwPtnJe5
         4lkWSCG/KVOS317dRpUN8H0itfRcTKymsHkHBgB4BmVUtiiAJFUBL7/cGiAx/xjMJf+J
         ATeZmX0ll6FZONQVi8fG8X1Id3bw/8sQm0MQp7XgQ+8q52BvBuGy6yTnIxbwKf06zzLw
         yiUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWeS9PSTSg4W0BEg0SFSJ76X5FzxT3f6GLxyNBE98doBVQ9uMpyJ2VsRY6qAU9b5mAbyjwvTw=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxt7geT2B4MSQlx+nJJ1o6C/CMSCpZW3hijiQ8h8TA5FqHCORBB
	L2+NZmCAaNU1F1qylpIcUGLTCwOWGgpebqAxsuFf7caWRgrITJ/cqQexZs1WdM+6f6A=
X-Gm-Gg: ASbGncstm/SoTVx5mb8g5+JLK4xUAA66cbIi3RPD+XJJQXiSK4yEPs/c+EvbcPOKRj9
	gvUkCSrmdD4fSE31DCYTa2YZ7R85CH0+ddhCnOquCXWJzXj7MwGVvE08g7508+O2+mHlUS3kw6F
	UinqObcvrEZeHoaBvYPygwiqB7LBA2DdJjSQvaafgBeWKhuK2jBBa221dnf5RdbKbDtYtd+YQFM
	+YLoJY3v/3OvD18q9xaZwqeB5E4Tj+lafZVyFK6yt2nU/5d5LPFml4kxk7GHqbn709ifXBms+UR
	o4DHcWKPp/1G3vGPMkL0y0aJdsjRL92eijaMrHzkGUMLf3CL6dKauKXM7UdXWMbPiRHUIFZHyS6
	mM7H8jKH5Lkec91gFPJECETcfv5wg71yvLe1uhrRz/G6CIhIrvEz45ag1C184HeBKqIqB70u5G+
	GN2XWZz2FkNO9u/YQg4zOfB+9Ps0fxKHnKPpuhUg==
X-Google-Smtp-Source: AGHT+IFb112ZtZLsO+hoNYz2HxlsdyYfC7JZQ7Gax5FlERbPuY4E7182eA14h+MSwUZXQUmyS7FO8A==
X-Received: by 2002:a05:600c:8719:b0:45d:d97c:235e with SMTP id 5b1f17b1804b1-46fa9aa0edfmr226344305e9.12.1760614023765;
        Thu, 16 Oct 2025 04:27:03 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144d17cdsm20097575e9.18.2025.10.16.04.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 04:27:03 -0700 (PDT)
Date: Thu, 16 Oct 2025 13:27:00 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca <sdubroca@redhat.com>, 
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Stanislav Fomichev <stfomichev@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv4 net-next 1/4] net: add a common function to compute
 features from lowers devices
Message-ID: <to4zjjo5wfd5suootcy2v7n7kuc6rym3ld4jov26nunnarji2u@2hr7jyiq36pj>
References: <20251014080217.47988-1-liuhangbin@gmail.com>
 <20251014080217.47988-2-liuhangbin@gmail.com>
 <sfjjkeub7fmvsktzrx6mmv6zvilno3un665tbqe2punw4azefo@jwuhk23763gc>
 <aO74J20k16L7jS15@fedora>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO74J20k16L7jS15@fedora>

Wed, Oct 15, 2025 at 03:25:59AM +0200, liuhangbin@gmail.com wrote:
>Hi Jiri,
>On Tue, Oct 14, 2025 at 11:40:12AM +0200, Jiri Pirko wrote:
>> >+#define VIRTUAL_DEV_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
>> 
>> I don't like the "virtual" naming. In the past, we always tried to avoid
>> that for lower-upper devices like bond/team/bridge/others. Soft-device
>> was the used term. Please let the "virtual" term for vitrualization,
>> would that be possible?
>
>Sure
>> 
>> How about "master_upper"? This is already widely used to refer to
>> bond/team/bridge/other master soft devices.
>> 
>> MASTER_UPPER_DEV_VLAN_FEATURES?
>
>I'm not sure if we should avoid using "master" now. Maybe just UPPER_DEV_VLAN_FEATURES?

Why? We have "master_upper" to point exactly at this kind of device.


>
>> [..]
>> 
>> 
>> >+void netdev_compute_features_from_lowers(struct net_device *dev, bool update_header)
>> 
>> netdev_compute_master_upper_features?
>
>netdev_compute_upper_features?
>
>Thanks
>Hangbin
