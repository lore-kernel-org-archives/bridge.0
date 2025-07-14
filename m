Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219D72749E7
	for <bridge@lists.linux.dev>; Mon, 14 Jul 2025 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752519967; cv=none; b=k4Ny5O7aRQ8fXMcVg3+KKvpr9tXaitljYQK5gkp0VIStv2thL1B9DPHhSmIXWuRHAfdGgU1JMPzxCb6LoLg1dfo3LFtTXcJhk0J3OHEXk7Zl04sAsVjOvgrHLHAJazsW4GUafvHuQAHC3O6i4sUVBxlU2MMxb/yD0T/YuXsUfWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752519967; c=relaxed/simple;
	bh=36OXI6KdfNW5Azr1XrUS3aZkxv95IVhnKyZFnAzOoQc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=o5qe/TWoyFmjfPJgrsApY00/oMN6HldqeoEy9PeVdDxycKy619AK6Gl1MPTygo93/SFsZCNa3bHdhjj5jYye53qatk01siabUYvsVKlr5FGZKv1S3tPH0rCE5lZdzChF1HcvtUrAUAYW85cHWci7e84dM6JZHk6Yg9sgUiKwN48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZC4hqlyN; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZC4hqlyN"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-61594007beeso32871eaf.3
        for <bridge@lists.linux.dev>; Mon, 14 Jul 2025 12:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752519965; x=1753124765; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Kej+z2nwqH47H8syUxUZJZrrsTEp7h/K0YFhcC1+oo=;
        b=ZC4hqlyNwZJFrt6KYulz50jsDNS0y7jbc7YoVjJ0D4BGKzdsk0LaATM+T9EenJBQIC
         2+yJodKLPATOV5rADeB6ZZxIGN627DfmrC+JTG+J7kekY4vxVXsr0zz6MA2Oalw54T2V
         y2W3b7LAMKU0xuwqeJMekyu1o+3Gzf/63+Jo3mPRGEKbN3FBxtzVasQTVRbe+BT8qIWY
         Y0lMZXamro5yd0l+c/Q9QqmVPvHathTB7NdpgAp/jJKc1n35fm3kff7MmJON7rSbbQID
         0KnZGNob0+VaBDkHUMnfHJwsD1qdaAyxab8Lo7s3V6JIBF6DsrDa+4k5OjsAag8lL13h
         lS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752519965; x=1753124765;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Kej+z2nwqH47H8syUxUZJZrrsTEp7h/K0YFhcC1+oo=;
        b=qbvg+/0S3EnpbG6HZfzXK+R4SGWP6vlYRUrN0V9y0wIreul82ashC60PfNgGtFx8Dv
         7LjIcmISu5vqoMLqV90Ikg6oS+oB9CbEYJS82hEBMACatpC0wdm1rQt4Qzor8HcLoHqU
         1Im/x+slXvxuasoYL/STRBpVLB7zfswgRQY0sLnmT2fRWI3xJxq+6fmdYXPJ7Ia98BgT
         mbFf/2Y6LOX3PMX94ObFoOeavHzWyUlpEt4Nq71YYOG4Vjv9bt/5TUFasVzohv/RuPCf
         oWdutWLwep8LFt2utluGPDjrDjjjbgTMVdQEnxwd3dpXT9rchiJr0dS52wTP+H8JKi4C
         2yZg==
X-Forwarded-Encrypted: i=1; AJvYcCXsnuGTzF1MxvNq0qxn5pqLUs1RIdlVIEmKjteP9KJbqXnVNUo3L7wBc04RHEWWyw+O3MtRx8E=@lists.linux.dev
X-Gm-Message-State: AOJu0YzOpQUvA6vx1KdCuQ6risOn95yWTHVyTkLLFylVgKB54ZkU/rbp
	/ZKrshkrQ5mH79ESCfnaJwu5H0RezZ5ZozjaOO2EjyysxTnYWIw4FzxzHjt/vZfHTWQ=
X-Gm-Gg: ASbGncukTkvfZYJuOtUpkjUQURyPl+Pf9ViN5nD8RrSnDP/bxC5CdRQcO7zYbaHgAD5
	eTMtXFyYS53E1RPwQFQ5jBig5+ELk5m9KzNOqj7MYXBOzalNEhoPPNhL4BXZYsrcCP/591LWgj6
	t4D/i+6OZ9CGft/1KKXn4pwuWpclnAYkcnOUccfWXNPiCkahWZGLhLZV5c9J069TF4Xk+MrP50q
	ISwLrur/jcmwS1cRmUZw0Y1S8hxJHfshlKlZHrxmOgJ9NmaBZS4LdGCYfYET7lPTKzXw8c5K5qG
	Bp6x8gBPQ5O6i5w5JfkyeKr6srFHRKc8WjoEgyrGf4YDra85u8dAw378S6qVoXBt0jiONVrjzsV
	3VT3NlH7Qcvnxy+41mZCzSahwcJw6ZQ==
X-Google-Smtp-Source: AGHT+IGZFgkatUwd5pWgCV0TZaCErLH8Y+F35AINecBPyk3TXs9Ccww4XoxGRNH0aYE4YRF/Gl4C2A==
X-Received: by 2002:a05:6820:c85:b0:613:cb90:21c with SMTP id 006d021491bc7-613e6015f92mr9732936eaf.8.1752519965067;
        Mon, 14 Jul 2025 12:06:05 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:6bb2:d90f:e5da:befc])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-613d9d6d51bsm1169531eaf.5.2025.07.14.12.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 12:06:03 -0700 (PDT)
Date: Mon, 14 Jul 2025 22:06:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Eric Woudstra <ericwouds@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: Re: [PATCH v13 nf-next 1/3] netfilter: utils: nf_checksum(_partial)
 correct data!=networkheader
Message-ID: <e70e50e8-9419-4ca0-b65d-dbf4869a5d89@suswa.mountain>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704191135.1815969-2-ericwouds@gmail.com>

Hi Eric,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Woudstra/netfilter-utils-nf_checksum-_partial-correct-data-networkheader/20250705-031418
base:   https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git main
patch link:    https://lore.kernel.org/r/20250704191135.1815969-2-ericwouds%40gmail.com
patch subject: [PATCH v13 nf-next 1/3] netfilter: utils: nf_checksum(_partial) correct data!=networkheader
config: x86_64-randconfig-r071-20250706 (https://download.01.org/0day-ci/archive/20250706/202507061710.RCwA4Kjw-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202507061710.RCwA4Kjw-lkp@intel.com/

smatch warnings:
net/netfilter/utils.c:131 nf_checksum() warn: signedness bug returning '(-12)'
net/netfilter/utils.c:155 nf_checksum_partial() warn: signedness bug returning '(-12)'

vim +131 net/netfilter/utils.c

ef71fe27ec2f16 Pablo Neira Ayuso 2017-11-27  123  __sum16 nf_checksum(struct sk_buff *skb, unsigned int hook,
                                                  ^^^^^^^
ebee5a50d0b7cd Florian Westphal  2018-06-25  124  		    unsigned int dataoff, u8 protocol,
ef71fe27ec2f16 Pablo Neira Ayuso 2017-11-27  125  		    unsigned short family)
ef71fe27ec2f16 Pablo Neira Ayuso 2017-11-27  126  {
39644744ee13d9 Eric Woudstra     2025-07-04  127  	unsigned int nhpull = skb_network_header(skb) - skb->data;
ef71fe27ec2f16 Pablo Neira Ayuso 2017-11-27  128  	__sum16 csum = 0;
ef71fe27ec2f16 Pablo Neira Ayuso 2017-11-27  129  
39644744ee13d9 Eric Woudstra     2025-07-04  130  	if (!pskb_may_pull(skb, nhpull))
39644744ee13d9 Eric Woudstra     2025-07-04 @131  		return -ENOMEM;

This -ENOMEM doesn't work because the return type is u16.

39644744ee13d9 Eric Woudstra     2025-07-04  132  	__skb_pull(skb, nhpull);
ef71fe27ec2f16 Pablo Neira Ayuso 2017-11-27  133  	switch (family) {
ef71fe27ec2f16 Pablo Neira Ayuso 2017-11-27  134  	case AF_INET:
39644744ee13d9 Eric Woudstra     2025-07-04  135  		csum = nf_ip_checksum(skb, hook, dataoff - nhpull, protocol);
ef71fe27ec2f16 Pablo Neira Ayuso 2017-11-27  136  		break;
ef71fe27ec2f16 Pablo Neira Ayuso 2017-11-27  137  	case AF_INET6:
39644744ee13d9 Eric Woudstra     2025-07-04  138  		csum = nf_ip6_checksum(skb, hook, dataoff - nhpull, protocol);
ef71fe27ec2f16 Pablo Neira Ayuso 2017-11-27  139  		break;
ef71fe27ec2f16 Pablo Neira Ayuso 2017-11-27  140  	}
39644744ee13d9 Eric Woudstra     2025-07-04  141  	__skb_push(skb, nhpull);
ef71fe27ec2f16 Pablo Neira Ayuso 2017-11-27  142  
ef71fe27ec2f16 Pablo Neira Ayuso 2017-11-27  143  	return csum;
ef71fe27ec2f16 Pablo Neira Ayuso 2017-11-27  144  }
ef71fe27ec2f16 Pablo Neira Ayuso 2017-11-27  145  EXPORT_SYMBOL_GPL(nf_checksum);
f7dcbe2f36a660 Pablo Neira Ayuso 2017-12-20  146  
f7dcbe2f36a660 Pablo Neira Ayuso 2017-12-20  147  __sum16 nf_checksum_partial(struct sk_buff *skb, unsigned int hook,
f7dcbe2f36a660 Pablo Neira Ayuso 2017-12-20  148  			    unsigned int dataoff, unsigned int len,
ebee5a50d0b7cd Florian Westphal  2018-06-25  149  			    u8 protocol, unsigned short family)
f7dcbe2f36a660 Pablo Neira Ayuso 2017-12-20  150  {
39644744ee13d9 Eric Woudstra     2025-07-04  151  	unsigned int nhpull = skb_network_header(skb) - skb->data;
f7dcbe2f36a660 Pablo Neira Ayuso 2017-12-20  152  	__sum16 csum = 0;
f7dcbe2f36a660 Pablo Neira Ayuso 2017-12-20  153  
39644744ee13d9 Eric Woudstra     2025-07-04  154  	if (!pskb_may_pull(skb, nhpull))
39644744ee13d9 Eric Woudstra     2025-07-04 @155  		return -ENOMEM;

Same.

39644744ee13d9 Eric Woudstra     2025-07-04  156  	__skb_pull(skb, nhpull);
f7dcbe2f36a660 Pablo Neira Ayuso 2017-12-20  157  	switch (family) {
f7dcbe2f36a660 Pablo Neira Ayuso 2017-12-20  158  	case AF_INET:
39644744ee13d9 Eric Woudstra     2025-07-04  159  		csum = nf_ip_checksum_partial(skb, hook, dataoff - nhpull,
39644744ee13d9 Eric Woudstra     2025-07-04  160  					      len, protocol);
f7dcbe2f36a660 Pablo Neira Ayuso 2017-12-20  161  		break;
f7dcbe2f36a660 Pablo Neira Ayuso 2017-12-20  162  	case AF_INET6:
39644744ee13d9 Eric Woudstra     2025-07-04  163  		csum = nf_ip6_checksum_partial(skb, hook, dataoff - nhpull,
39644744ee13d9 Eric Woudstra     2025-07-04  164  					       len, protocol);
f7dcbe2f36a660 Pablo Neira Ayuso 2017-12-20  165  		break;
f7dcbe2f36a660 Pablo Neira Ayuso 2017-12-20  166  	}
39644744ee13d9 Eric Woudstra     2025-07-04  167  	__skb_push(skb, nhpull);
f7dcbe2f36a660 Pablo Neira Ayuso 2017-12-20  168  
f7dcbe2f36a660 Pablo Neira Ayuso 2017-12-20  169  	return csum;
f7dcbe2f36a660 Pablo Neira Ayuso 2017-12-20  170  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

