Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6490572623;
	Sun, 29 Mar 2026 17:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774805247; cv=none; b=izPPmgRa8MngBawxVvl4lj15cRzeyAorZ+TuA91Mkt6ISM6S3Rpyr7742Tfb5Yf4Fo0lmMCbtFrsSajBG2anK/hxPAUNstrfC8VhjsuHQIfWQ2Tk827kVOacRuuvW9LhzvKZ35gMKsrLMZmGV1JYPsW1UKPw9ls3pGPLEm4d7GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774805247; c=relaxed/simple;
	bh=oRo9AfWD0ibf1zkOrI0Ku+/mzW8yApTc/cIMV3R1Alk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6qGt4Ea0sWkH5jPx3Gy0gBmgan3M84Xpyv9PbZUAt8CKIS1A4fAJ3siCRNq8Vj8f7VaM3p1e2K99AfS3EpCEB6gNHVI30eaUxc0mpovehJuKCw+2cF4XKbYyeFpdQoMpTER9GaKVRk2LBpj38IQVJryExBnihhFFWxn4YFgTGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mQPJH8Lc; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mQPJH8Lc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774805244; x=1806341244;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oRo9AfWD0ibf1zkOrI0Ku+/mzW8yApTc/cIMV3R1Alk=;
  b=mQPJH8LcovFKr24whCfLGae7jISzXzJAVO1kO6xAF4vLhr1//GEq8/us
   tN03hmQIVX3j0u4zI/rm/6G2BL/LFi7yJVkEqatlgMx1yH6doPQTd/IKy
   kztDJOHyzkmOApEwioFaSKkuqvGzeHc5jtts/TRt4VyAEe0qdvVAddKOx
   GFEnDfinP3uDPp0YiM4QyGUEC1u8+XHbPDI8M6Rz8wyZe1SV6zjPmofDC
   lfBoa3JimzL5MKTrVGWX+/6kRXSndqT2UBIEOJFiOejm/qH5lZbE08wdA
   KBKcSmy0hJJpqDHReZ5lqdBvzBoqlrBqheExpMX9y+Yx46yaE4DXcsxqR
   Q==;
X-CSE-ConnectionGUID: XfT2BcFvTbqdPBcugkvtSw==
X-CSE-MsgGUID: WJMhDMQ/SUeDTSM3CaoXTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="78404907"
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="78404907"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 10:27:24 -0700
X-CSE-ConnectionGUID: xIstTLZTSVK5nsGGqHCrVA==
X-CSE-MsgGUID: qIyfDA3HRYWSkvZBpAJ9bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="256342706"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa002.jf.intel.com with ESMTP; 29 Mar 2026 10:27:20 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6tuu-000000007wf-2i8K;
	Sun, 29 Mar 2026 17:27:16 +0000
Date: Sun, 29 Mar 2026 19:26:20 +0200
From: kernel test robot <lkp@intel.com>
To: Andy Roulin <aroulin@nvidia.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Petr Machata <petrm@nvidia.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonas Gorski <jonas.gorski@gmail.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andy Roulin <aroulin@nvidia.com>
Subject: Re: [PATCH net-next v2 1/3] net: bridge: add stp_mode attribute for
 STP mode selection
Message-ID: <202603291905.TUiTIocs-lkp@intel.com>
References: <20260329025858.330620-2-aroulin@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329025858.330620-2-aroulin@nvidia.com>

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Roulin/net-bridge-add-stp_mode-attribute-for-STP-mode-selection/20260329-191152
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260329025858.330620-2-aroulin%40nvidia.com
patch subject: [PATCH net-next v2 1/3] net: bridge: add stp_mode attribute for STP mode selection
config: s390-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260329/202603291905.TUiTIocs-lkp@intel.com/config)
compiler: s390x-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260329/202603291905.TUiTIocs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603291905.TUiTIocs-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from rt-link-user.c:9:
>> rt-link-user.h:38:42: warning: 'enum rt_link_br_stp_mode' declared inside parameter list will not be visible outside of this definition or declaration
      38 | const char *rt_link_br_stp_mode_str(enum rt_link_br_stp_mode value);
         |                                          ^~~~~~~~~~~~~~~~~~~
>> rt-link-user.h:245:34: error: field 'stp_mode' has incomplete type
     245 |         enum rt_link_br_stp_mode stp_mode;
         |                                  ^~~~~~~~
>> rt-link-user.h:2164:80: error: parameter 2 ('stp_mode') has incomplete type
    2164 |                                                       enum rt_link_br_stp_mode stp_mode)
         |                                                       ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~
   rt-link-user.h:6234:85: error: parameter 2 ('stp_mode') has incomplete type
    6234 |                                                            enum rt_link_br_stp_mode stp_mode)
         |                                                            ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~
   rt-link-user.h:10089:80: error: parameter 2 ('stp_mode') has incomplete type
   10089 |                                                       enum rt_link_br_stp_mode stp_mode)
         |                                                       ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~
>> rt-link-user.c:352:62: error: parameter 1 ('value') has incomplete type
     352 | const char *rt_link_br_stp_mode_str(enum rt_link_br_stp_mode value)
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   rt-link-user.c: In function 'rt_link_br_stp_mode_str':
>> rt-link-user.c:357:1: warning: control reaches end of non-void function [-Wreturn-type]
     357 | }
         | ^

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
